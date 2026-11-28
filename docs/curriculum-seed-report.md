# Curriculum seed-data report

## Result

The catalogue migration is non-destructive: it inserts a requested subject only when that stream/grade/slug does not already exist, and candidate inserts use `ON CONFLICT DO NOTHING`. Existing subjects, chapters, and resource links are not replaced.

| Record group | Expected from this seed | Verification / visibility |
| --- | ---: | --- |
| Science and Management streams | 0 new; 2 already present | Existing records retained |
| Grades 11 and 12 | 0 new; 2 already present | Existing records retained |
| Grade/stream-specific subjects | 18 after Computer Science is added | Catalogue entries; existing matches are skipped |
| User-supplied topic candidates | 162 before subject expansions; 589 expected after all | Pending; private review table |
| Verified units imported from candidates | 0 | None published |
| Verified chapters imported from candidates | 0 | None published |
| Curriculum sources | 1 | Supplied Physics PDF URL marked unavailable |

The initial read-only database check found 2 streams, 2 grades, 0 subjects, 0 chapters, and 0 resources. The initial seed added 151 candidates. Follow-up migrations replaced only the 23 original pending Grade 11 Physics candidates with 26 and the 17 original pending Grade 12 Physics candidates with 25. The user confirmed the live pending-candidate count was 162 before the Chemistry expansion below. These migrations stop without changing data if the expected original pending set is not present. Other rows are preserved.

## Pending candidates by subject and grade

| Stream | Grade | Subject | Pending candidates before subject expansions |
| --- | ---: | --- | ---: |
| Science | 11 | Physics | 26 |
| Science | 12 | Physics | 25 |
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
| **Total** |  |  | **162** |

Physics candidates retain the unit labels supplied by the user. Before the Chemistry expansion below, Chemistry candidates were limited to condensed unit headings. Biology, Mathematics, and Business Mathematics entries are topic-group candidates. Accountancy and Economics remain explicitly pending because the supplied lists were marked preliminary. Other supplied chapter lists also remain pending until checked against the applicable official CDC edition.

## Chemistry syllabus expansion

The user supplied detailed Grade 11 and 12 Chemistry syllabus text. Migration [`20261126171500_expand_chemistry_candidates.sql`](../supabase/migrations/20261126171500_expand_chemistry_candidates.sql) replaces the old condensed Chemistry unit candidates with:

| Grade | Pending unit candidates | Pending chapter candidates |
| ---: | ---: | ---: |
| 11 | 17 | 102 |
| 12 | 21 | 130 |

After applying it, the expected total is 408 pending candidates across the catalogue. The nested topics in the syllabus are recorded as chapter candidates under their unit headings. They remain pending and are not published as verified curriculum.

## Biology syllabus expansion

The user supplied detailed Grade 11 and 12 Biology syllabus text. Migration [`20261126172000_expand_biology_candidates.sql`](../supabase/migrations/20261126172000_expand_biology_candidates.sql) replaces the old broad topic-group candidates with:

| Grade | Pending unit candidates | Pending chapter candidates |
| ---: | ---: | ---: |
| 11 | 10 | 33 |
| 12 | 10 | 27 |

After applying both subject-expansion migrations, the expected catalogue total is 473 pending candidates. Biology and Chemistry candidates remain pending review and are not published as verified curriculum.

## Computer Science syllabus

The user supplied Grade 11 and 12 Computer Science content and chose to add Computer Science to the Science stream. Migration [`20261126172500_add_computer_science.sql`](../supabase/migrations/20261126172500_add_computer_science.sql) adds the two catalogue subjects and imports:

| Grade | Pending unit candidates | Pending chapter candidates | Nested details retained in review notes |
| ---: | ---: | ---: | ---: |
| 11 | 8 | 29 | 92 |
| 12 | 7 | 72 | 19 |

The direct subtopics become chapter candidates; deeper numbered details remain in their parent candidate's private review note. After applying the Computer Science, Chemistry, and Biology migrations, the expected total is 589 pending candidates. The Computer Science candidates are not independently verified or published.

## Source limitation

The supplied [CDC Physics PDF URL](https://moecdc.gov.np/storage/gallery/1674713349.pdf) returned HTTP 404 when checked. The CDC also published a [notice about download/upload problems caused by full server storage](https://moecdc.gov.np/content/707/regarding-the-blocking-of-downloading-and-uploading/). The PDF contents could not be checked, so no user-provided topic is represented as CDC-verified.

## Live database report query

To avoid pasting Markdown into Supabase, run the SQL-only script [`supabase/queries/curriculum_seed_report.sql`](../supabase/queries/curriculum_seed_report.sql) in the SQL Editor after applying the migrations. Copy only that file's contents; do not copy this report's headings or tables.

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
