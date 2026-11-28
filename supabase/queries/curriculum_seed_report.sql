with scope_subjects as (
  select subjects.id
  from public.subjects
  join public.streams on streams.id = subjects.stream_id
  join public.grades on grades.id = subjects.grade_id
  where streams.slug in ('science', 'management')
    and grades.number in (11, 12)
    and subjects.slug in (
      'physics', 'chemistry', 'biology', 'mathematics',
      'accountancy', 'economics', 'business-studies', 'business-mathematics',
      'computer-science'
    )
)
select 'Catalogue subjects' as record_group, count(*) as record_count
from scope_subjects
union all
select 'Pending candidates', count(*)
from public.curriculum_review_items
where subject_id in (select id from scope_subjects)
  and verification_status = 'pending_verification'
union all
select 'Verified candidates', count(*)
from public.curriculum_review_items
where subject_id in (select id from scope_subjects)
  and verification_status = 'verified'
union all
select 'Verified active units', count(*)
from public.units
where subject_id in (select id from scope_subjects)
  and is_active
  and verification_status = 'verified'
union all
select 'Verified active chapters', count(*)
from public.chapters
where subject_id in (select id from scope_subjects)
  and is_active
  and verification_status = 'verified';
