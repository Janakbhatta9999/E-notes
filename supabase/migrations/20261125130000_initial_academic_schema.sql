create table public.streams (
  id uuid primary key default gen_random_uuid(),
  name_en text not null,
  name_ne text,
  slug text not null unique,
  description_en text,
  description_ne text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.grades (
  id uuid primary key default gen_random_uuid(),
  number integer not null unique check (number between 1 and 12),
  label_en text not null,
  label_ne text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.subjects (
  id uuid primary key default gen_random_uuid(),
  stream_id uuid not null references public.streams(id) on delete restrict,
  grade_id uuid not null references public.grades(id) on delete restrict,
  name_en text not null,
  name_ne text,
  slug text not null,
  description_en text,
  description_ne text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (stream_id, grade_id, slug)
);

create table public.chapters (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete restrict,
  title_en text not null,
  title_ne text,
  slug text not null,
  chapter_number integer check (chapter_number is null or chapter_number > 0),
  description_en text,
  description_ne text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (subject_id, slug)
);

create table public.resources (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text not null unique,
  description text,
  language text not null check (language in ('en', 'ne')),
  resource_type text not null check (
    resource_type in ('notes', 'past_paper', 'model_question', 'practice', 'reference')
  ),
  format text not null check (format in ('web', 'pdf')),
  stream_id uuid references public.streams(id) on delete restrict,
  grade_id uuid references public.grades(id) on delete restrict,
  subject_id uuid references public.subjects(id) on delete restrict,
  chapter_id uuid references public.chapters(id) on delete restrict,
  content text,
  storage_path text,
  external_url text,
  file_size_bytes bigint check (file_size_bytes is null or file_size_bytes >= 0),
  exam_year integer check (exam_year is null or exam_year between 1950 and 2200),
  source_name text,
  source_url text,
  rights_status text not null default 'needs_review' check (
    rights_status in ('original', 'permission_confirmed', 'public_domain', 'external_link', 'needs_review')
  ),
  status text not null default 'draft' check (status in ('draft', 'published', 'archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  published_at timestamptz,
  check (
    (format = 'web' and content is not null and length(trim(content)) > 0
      and storage_path is null and external_url is null)
    or
    (format = 'pdf' and ((storage_path is not null) <> (external_url is not null)))
  ),
  check (status <> 'published' or rights_status <> 'needs_review')
);

create index subjects_stream_grade_active_sort_idx
  on public.subjects (stream_id, grade_id, is_active, sort_order);
create index chapters_subject_active_sort_idx
  on public.chapters (subject_id, is_active, sort_order);
create index resources_public_filters_idx
  on public.resources (status, stream_id, grade_id, subject_id, chapter_id, resource_type, language);

create function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger streams_set_updated_at before update on public.streams
  for each row execute function public.set_updated_at();
create trigger grades_set_updated_at before update on public.grades
  for each row execute function public.set_updated_at();
create trigger subjects_set_updated_at before update on public.subjects
  for each row execute function public.set_updated_at();
create trigger chapters_set_updated_at before update on public.chapters
  for each row execute function public.set_updated_at();
create trigger resources_set_updated_at before update on public.resources
  for each row execute function public.set_updated_at();

alter table public.streams enable row level security;
alter table public.grades enable row level security;
alter table public.subjects enable row level security;
alter table public.chapters enable row level security;
alter table public.resources enable row level security;

grant select on public.streams, public.grades, public.subjects, public.chapters, public.resources
  to anon, authenticated;
grant usage on schema public to anon, authenticated;

create policy "Public can read active streams"
  on public.streams for select to anon, authenticated
  using (is_active);
create policy "Public can read active grades"
  on public.grades for select to anon, authenticated
  using (is_active);
create policy "Public can read active subjects"
  on public.subjects for select to anon, authenticated
  using (is_active);
create policy "Public can read active chapters"
  on public.chapters for select to anon, authenticated
  using (is_active);
create policy "Public can read published resources"
  on public.resources for select to anon, authenticated
  using (status = 'published');

insert into public.streams (name_en, name_ne, slug, description_en, description_ne, sort_order)
values
  ('Science', 'विज्ञान', 'science',
    'Science stream study resources.', 'विज्ञान धाराका अध्ययन स्रोतहरू।', 1),
  ('Management', 'व्यवस्थापन', 'management',
    'Management stream study resources.', 'व्यवस्थापन धाराका अध्ययन स्रोतहरू।', 2)
on conflict (slug) do update set
  name_en = excluded.name_en,
  name_ne = excluded.name_ne,
  description_en = excluded.description_en,
  description_ne = excluded.description_ne,
  sort_order = excluded.sort_order;

insert into public.grades (number, label_en, label_ne, sort_order)
values
  (11, 'Grade 11', 'कक्षा ११', 1),
  (12, 'Grade 12', 'कक्षा १२', 2)
on conflict (number) do update set
  label_en = excluded.label_en,
  label_ne = excluded.label_ne,
  sort_order = excluded.sort_order;
