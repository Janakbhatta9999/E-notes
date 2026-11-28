create table if not exists public.curriculum_editions (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name_en text not null,
  name_ne text,
  status text not null default 'draft' check (status in ('draft', 'current', 'superseded')),
  effective_from date,
  effective_to date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (effective_to is null or effective_from is null or effective_to >= effective_from)
);

alter table public.subjects
  add column if not exists curriculum_edition_id uuid references public.curriculum_editions(id) on delete restrict;

alter table public.subjects
  drop constraint if exists subjects_stream_id_grade_id_slug_key;

create unique index if not exists subjects_unversioned_scope_slug_uidx
  on public.subjects (stream_id, grade_id, slug)
  where curriculum_edition_id is null;
create unique index if not exists subjects_versioned_scope_slug_uidx
  on public.subjects (stream_id, grade_id, curriculum_edition_id, slug)
  where curriculum_edition_id is not null;
create index if not exists subjects_curriculum_edition_idx
  on public.subjects (curriculum_edition_id);

create table if not exists public.curriculum_sources (
  id uuid primary key default gen_random_uuid(),
  curriculum_edition_id uuid references public.curriculum_editions(id) on delete restrict,
  subject_id uuid references public.subjects(id) on delete restrict,
  source_name text not null,
  source_url text not null,
  verification_status text not null default 'pending_verification'
    check (verification_status in ('pending_verification', 'verified', 'unavailable')),
  checked_at timestamptz,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (source_url ~ '^https?://'),
  check (verification_status <> 'verified' or checked_at is not null)
);

create unique index if not exists curriculum_sources_url_uidx
  on public.curriculum_sources (source_url);
create index if not exists curriculum_sources_status_idx
  on public.curriculum_sources (verification_status);

create table if not exists public.units (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete restrict,
  title_en text not null,
  title_ne text,
  slug text not null,
  unit_number integer check (unit_number is null or unit_number > 0),
  source_id uuid references public.curriculum_sources(id) on delete restrict,
  verification_status text not null default 'pending_verification'
    check (verification_status in ('pending_verification', 'verified')),
  is_active boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (subject_id, slug),
  unique (id, subject_id),
  check (verification_status <> 'verified' or source_id is not null)
);

alter table public.chapters
  add column if not exists unit_id uuid,
  add column if not exists source_id uuid references public.curriculum_sources(id) on delete restrict,
  add column if not exists verification_status text not null default 'legacy_unverified';

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'chapters_verification_status_check'
      and conrelid = 'public.chapters'::regclass
  ) then
    alter table public.chapters
      add constraint chapters_verification_status_check
      check (verification_status in ('legacy_unverified', 'pending_verification', 'verified'));
  end if;

  if not exists (
    select 1
    from pg_constraint
    where conname = 'chapters_unit_subject_fkey'
      and conrelid = 'public.chapters'::regclass
  ) then
    alter table public.chapters
      add constraint chapters_unit_subject_fkey
      foreign key (unit_id, subject_id)
      references public.units (id, subject_id)
      on delete restrict;
  end if;

  if not exists (
    select 1
    from pg_constraint
    where conname = 'chapters_verified_hierarchy_check'
      and conrelid = 'public.chapters'::regclass
  ) then
    alter table public.chapters
      add constraint chapters_verified_hierarchy_check
      check (verification_status <> 'verified' or (source_id is not null and unit_id is not null));
  end if;
end
$$;

alter table public.chapters
  alter column verification_status set default 'pending_verification';

create index if not exists units_subject_active_sort_idx
  on public.units (subject_id, is_active, sort_order);
create index if not exists chapters_unit_active_sort_idx
  on public.chapters (unit_id, is_active, sort_order);

create table if not exists public.curriculum_review_items (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete restrict,
  curriculum_edition_id uuid references public.curriculum_editions(id) on delete restrict,
  source_id uuid references public.curriculum_sources(id) on delete restrict,
  candidate_type text not null
    check (candidate_type in ('unit_candidate', 'chapter_candidate', 'topic_group_candidate')),
  candidate_number integer not null check (candidate_number > 0),
  candidate_unit_title text,
  title_en text not null,
  verification_status text not null default 'pending_verification'
    check (verification_status in ('pending_verification', 'verified', 'rejected')),
  verification_note text not null,
  created_at timestamptz not null default now(),
  unique (subject_id, candidate_type, candidate_number),
  check (verification_status <> 'verified' or source_id is not null)
);

create index if not exists curriculum_review_items_subject_status_idx
  on public.curriculum_review_items (subject_id, verification_status, candidate_type);
create unique index if not exists curriculum_review_items_candidate_dedupe_uidx
  on public.curriculum_review_items (
    subject_id,
    candidate_type,
    lower(title_en),
    (coalesce(candidate_unit_title, ''))
  );

drop trigger if exists curriculum_editions_set_updated_at on public.curriculum_editions;
create trigger curriculum_editions_set_updated_at before update on public.curriculum_editions
  for each row execute function public.set_updated_at();
drop trigger if exists curriculum_sources_set_updated_at on public.curriculum_sources;
create trigger curriculum_sources_set_updated_at before update on public.curriculum_sources
  for each row execute function public.set_updated_at();
drop trigger if exists units_set_updated_at on public.units;
create trigger units_set_updated_at before update on public.units
  for each row execute function public.set_updated_at();

alter table public.curriculum_editions enable row level security;
alter table public.curriculum_sources enable row level security;
alter table public.units enable row level security;
alter table public.curriculum_review_items enable row level security;
alter table public.chapters enable row level security;

grant select on public.units to anon, authenticated;
grant select on public.curriculum_sources to anon, authenticated;

drop policy if exists "Public can read verified curriculum sources" on public.curriculum_sources;
create policy "Public can read verified curriculum sources"
  on public.curriculum_sources for select to anon, authenticated
  using (verification_status = 'verified');

drop policy if exists "Public can read active chapters" on public.chapters;
drop policy if exists "Public can read verified active chapters" on public.chapters;
create policy "Public can read verified active chapters"
  on public.chapters for select to anon, authenticated
  using (
    is_active
    and verification_status in ('verified', 'legacy_unverified')
    and (
      verification_status = 'legacy_unverified'
      or exists (
        select 1
        from public.curriculum_sources
        where curriculum_sources.id = chapters.source_id
          and curriculum_sources.verification_status = 'verified'
      )
    )
    and (
      unit_id is null
      or exists (
        select 1
        from public.units
        where units.id = chapters.unit_id
          and units.subject_id = chapters.subject_id
          and units.is_active
          and units.verification_status = 'verified'
      )
    )
  );

drop policy if exists "Public can read verified active units" on public.units;
create policy "Public can read verified active units"
  on public.units for select to anon, authenticated
  using (
    is_active
    and verification_status = 'verified'
    and exists (
      select 1
      from public.curriculum_sources
      where curriculum_sources.id = units.source_id
        and curriculum_sources.verification_status = 'verified'
    )
  );
