# Curriculum seed-data report

## Result

The catalogue migration is non-destructive: it inserts a requested subject only when that stream/grade/slug does not already exist, and candidate inserts use `ON CONFLICT DO NOTHING`. Existing subjects, chapters, and resource links are not replaced.

| Record group | Expected from this seed | Verification / visibility |
| --- | ---: | --- |
| Science and Management streams | 0 new; 2 already present | Existing records retained |
| Grades 11 and 12 | 0 new; 2 already present | Existing records retained |
| Grade/stream-specific subjects | 16 | Catalogue entries; existing matches are skipped |
| User-supplied topic candidates | 151 | Pending; private review table |
| Verified units imported from candidates | 0 | None published |
| Verified chapters imported from candidates | 0 | None published |
| Curriculum sources | 1 | Supplied Physics PDF URL marked unavailable |

The initial read-only database check found 2 streams, 2 grades, 0 subjects, 0 chapters, and 0 resources. Counts above describe the intended seed based on that snapshot; rows added to the database after that check are preserved.

## Pending candidates by subject and grade

| Stream | Grade | Subject | Pending candidates |
| --- | ---: | --- | ---: |
| Science | 11 | Physics | 23 |
| Science | 12 | Physics | 17 |
| Science | 11 | Chemistry | 13 |
| Science | 12 | Chemistry | 11 |
| Science | 11 | Biology | 8 |
| Science | 12 | Biology | 7 |
| Science | 11 | Mathematics | 6 |
| Science | 12 | Mathematics | 6 |
| Management | 11 | Business Studies | 8 |
| Management | 12 | Business Studies | 10 |
| Management | 11 | Accountancy | 8 |
| Management | 12 | Accountancy | 6 |
| Management | 11 | Economics | 10 |
| Management | 12 | Economics | 8 |
| Management | 11 | Business Mathematics | 5 |
| Management | 12 | Business Mathematics | 5 |
| **Total** |  |  | **151** |

Physics candidates retain the unit labels supplied by the user. Chemistry candidates are classified as condensed unit-heading candidates; Biology, Mathematics, and Business Mathematics entries are topic-group candidates. Accountancy and Economics remain explicitly pending because the supplied lists were marked preliminary. Other supplied chapter lists also remain pending until checked against the applicable official CDC edition.

## Source limitation

The supplied [CDC Physics PDF URL](https://moecdc.gov.np/storage/gallery/1674713349.pdf) returned HTTP 404 when checked. The CDC also published a [notice about download/upload problems caused by full server storage](https://moecdc.gov.np/content/707/regarding-the-blocking-of-downloading-and-uploading/). The PDF contents could not be checked, so no user-provided topic is represented as CDC-verified.

## Live database report query

Run this query in the Supabase SQL Editor after applying the migrations to see current counts for these catalogue subjects:

```sql
with scope_subjects as (
  select subjects.id
  from public.subjects
  join public.streams on streams.id = subjects.stream_id
  join public.grades on grades.id = subjects.grade_id
  where streams.slug in ('science', 'management')
    and grades.number in (11, 12)
    and subjects.slug in (
      'physics', 'chemistry', 'biology', 'mathematics',
      'accountancy', 'economics', 'business-studies', 'business-mathematics'
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
```
