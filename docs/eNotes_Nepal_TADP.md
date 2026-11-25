# eNotes Nepal --- Technical Architecture & Development Plan

**Document type:** Technical Architecture and Development Plan (TADP)\
**Version:** 1.0\
**Date:** 24 November 2026\
**Product:** eNotes Nepal (temporary working name)\
**Companion document:** `eNotes_Nepal_PRD.md`\
**Purpose:** Turn the approved product requirements into an
implementable, testable development blueprint.

------------------------------------------------------------------------

## 1. Executive recommendation

Build eNotes Nepal as a **mobile-first, bilingual educational resource
website** using:

  -----------------------------------------------------------------------
  Layer                   Recommended technology  Responsibility
  ----------------------- ----------------------- -----------------------
  Web application         Next.js (App Router) +  Pages, routing, server
                          TypeScript              rendering, application
                                                  logic

  Styling                 Tailwind CSS            Responsive design and
                                                  consistent UI

  UI components           Accessible component    Reusable menus,
                          primitives, such as     dialogs, forms, cards
                          shadcn/ui where useful  

  Database                Supabase PostgreSQL     Grades, streams,
                                                  subjects, chapters,
                                                  resources, metadata

  Authentication          Supabase Auth           Administrator sign-in
                                                  only

  File storage            Supabase Storage        PDFs and other approved
                                                  learning files

  Hosting                 Vercel                  Deploy and serve the
                                                  Next.js application

  Version control         Git + GitHub            Source history,
                                                  collaboration, rollback

  Testing                 Vitest and Playwright   Unit/integration and
                                                  browser testing

  Monitoring              Hosting logs plus a     Diagnose production
                          lightweight             problems
                          error-monitoring        
                          service if needed       
  -----------------------------------------------------------------------

**Why this stack:** It supports a real content-management workflow
without requiring a large custom backend. Next.js handles the public
website; Supabase provides the database, admin authentication, and file
storage; Vercel provides a straightforward deployment path.

Start on free tiers where available. Free-tier quotas, limits, and
commercial-use terms can change, so check the providers' current pricing
and policies before launch. Do not design the product around a promise
that hosting or storage will remain free forever.

### Architecture principle

Keep the first release deliberately small. Build the public resource
library and a secure, usable admin workflow before considering student
accounts, quizzes, bookmarks, payments, or advertising.

------------------------------------------------------------------------

## 2. Product decisions carried forward from the PRD

The implementation must preserve these confirmed requirements:

-   Initial audience: Nepal NEB Grade 11 and Grade 12 students.
-   Initial streams: Science and Management.
-   Interface languages: English and Nepali.
-   Public access: students can browse, read, and download without
    signing in.
-   Content formats: web-based notes and PDFs.
-   Admin access: protected separately from public student access.
-   Monetization: no advertising dependency for the initial launch;
    advertising may be considered later.
-   Content must be organized by grade, stream, subject, chapter/unit,
    and resource type.
-   Subject and chapter structures must be data-driven, not permanently
    hard-coded into page components.
-   Materials must have source/attribution information where known, and
    the site must not imply that material is official unless verified.
-   Only material that the site has permission to distribute may be
    published.

The brand name remains provisional. Keep it in one central configuration
location so it can be changed without editing many files.

------------------------------------------------------------------------

## 3. System architecture

``` text
                         PUBLIC VISITORS
                    Mobile / Tablet / Desktop
                                |
                                v
                    Next.js Website (Vercel)
                 App Router + TypeScript + Tailwind
                                |
              +-----------------+-----------------+
              |                 |                 |
              v                 v                 v
         Public pages       Search/filter      Resource reader
              |                 |                 |
              +-----------------+-----------------+
                                |
                         Server-side data access
                                |
                 +--------------+---------------+
                 |                              |
                 v                              v
          Supabase PostgreSQL             Supabase Storage
       academic structure + metadata      published PDFs/files
                 ^
                 |
          Protected admin operations
                 |
          Admin dashboard (Next.js)
                 |
          Supabase Auth + role checks
```

### Responsibilities

**Next.js application** - Renders public pages and resource detail
pages. - Provides language-aware routing and metadata. - Provides the
protected admin interface. - Validates form input and performs
authorized server-side mutations. - Connects to Supabase using
appropriately scoped credentials.

**Supabase PostgreSQL** - Stores academic structure and resource
metadata. - Stores publication status, language, source, and update
timestamps. - Enforces access through Row Level Security (RLS).

**Supabase Storage** - Stores uploaded PDFs and approved resource
files. - Separates files awaiting publication from publicly available
files where practical. - Does not store administrator secrets or
credentials.

**Vercel** - Hosts the Next.js application and deployment previews. -
Builds production deployments from the selected GitHub branch.

------------------------------------------------------------------------

## 4. Application structure and routes

Use a clear URL structure. Prefer stable, readable slugs over database
IDs in public URLs.

Example routes:

``` text
/
├── /science
│   ├── /science/grade-11
│   │   └── /science/grade-11/[subjectSlug]
│   │       └── /science/grade-11/[subjectSlug]/[chapterSlug]
│   └── /science/grade-12
├── /management
│   ├── /management/grade-11
│   └── /management/grade-12
├── /past-papers
│   └── /past-papers/[resourceSlug]
├── /model-questions
├── /search
├── /about
├── /contact
├── /report-issue
└── /admin
    ├── /admin/login
    ├── /admin/dashboard
    ├── /admin/resources
    ├── /admin/resources/new
    ├── /admin/resources/[id]/edit
    ├── /admin/subjects
    ├── /admin/chapters
    └── /admin/reports
```

The exact public route shape can be adjusted during implementation, but
it must preserve the PRD's navigation hierarchy.

### Language routing

Use a consistent locale strategy. Recommended initial approach:

``` text
/en/science/grade-11/physics
/ne/science/grade-11/physics
```

The route locale is `en` or `ne`. Use a small translation dictionary for
interface labels. Resource content has its own language field; selecting
Nepali interface language must not falsely imply that every resource is
available in Nepali.

Keep the chosen locale when navigating between pages. Provide a visible
language switcher. Use appropriate Nepali-capable fonts and test actual
Devanagari rendering on phones and desktop browsers.

------------------------------------------------------------------------

## 5. Database design

Use PostgreSQL with UUID primary keys. Academic structure and resource
metadata should be normalized so subjects and chapters can be updated
without rewriting page code.

### 5.1 Core tables

#### `streams`

  Column       Type      Notes
  ------------ --------- --------------------------
  id           uuid      Primary key
  name         text      Science, Management
  slug         text      Unique public identifier
  is_active    boolean   Whether shown publicly
  sort_order   integer   Display order

#### `grades`

  Column       Type      Notes
  ------------ --------- ------------------------
  id           uuid      Primary key
  number       integer   11 or 12 initially
  label        text      Grade 11 / Grade 12
  is_active    boolean   Whether shown publicly
  sort_order   integer   Display order

#### `subjects`

  Column           Type      Notes
  ---------------- --------- ----------------------------------
  id               uuid      Primary key
  stream_id        uuid      References `streams`
  grade_id         uuid      References `grades`
  name_en          text      English name
  name_ne          text      Nepali name, nullable
  slug             text      Unique within its academic scope
  description_en   text      Optional
  description_ne   text      Optional
  is_active        boolean   Whether shown publicly
  sort_order       integer   Display order

#### `chapters`

  Column           Type      Notes
  ---------------- --------- ---------------------------
  id               uuid      Primary key
  subject_id       uuid      References `subjects`
  title_en         text      English title
  title_ne         text      Nepali title, nullable
  slug             text      Unique within its subject
  chapter_number   integer   Optional
  description_en   text      Optional
  description_ne   text      Optional
  is_active        boolean   Whether shown publicly
  sort_order       integer   Display order

#### `resources`

  -------------------------------------------------------------------------
  Column                  Type                    Notes
  ----------------------- ----------------------- -------------------------
  id                      uuid                    Primary key

  title                   text                    Resource title

  slug                    text                    Unique public identifier

  description             text                    Optional summary

  language                text                    `en` or `ne`

  resource_type           text                    `notes`, `past_paper`,
                                                  `model_question`,
                                                  `practice`, `reference`

  format                  text                    `web`, `pdf`, or another
                                                  explicitly supported
                                                  value

  stream_id               uuid                    References `streams`,
                                                  when applicable

  grade_id                uuid                    References `grades`, when
                                                  applicable

  subject_id              uuid                    References `subjects`,
                                                  nullable for general
                                                  resources

  chapter_id              uuid                    References `chapters`,
                                                  nullable

  content                 text                    Web-note body; nullable
                                                  for file-only resources

  storage_path            text                    Supabase Storage object
                                                  path; nullable for
                                                  web-only resources

  external_url            text                    Approved external
                                                  resource URL; nullable

  file_size_bytes         bigint                  Optional

  exam_year               integer                 Optional, mainly for past
                                                  papers

  source_name             text                    Source or publisher, when
                                                  known

  source_url              text                    Source link, when known

  rights_status           text                    `original`,
                                                  `permission_confirmed`,
                                                  `public_domain`,
                                                  `external_link`,
                                                  `needs_review`

  status                  text                    `draft`, `published`,
                                                  `archived`

  created_at              timestamptz             Creation timestamp

  updated_at              timestamptz             Last update timestamp

  published_at            timestamptz             Publication timestamp,
                                                  nullable
  -------------------------------------------------------------------------

#### `issue_reports`

  -----------------------------------------------------------------------
  Column                  Type                    Notes
  ----------------------- ----------------------- -----------------------
  id                      uuid                    Primary key

  resource_id             uuid                    References `resources`,
                                                  nullable

  resource_url            text                    URL reported by visitor

  issue_type              text                    Broken file, incorrect
                                                  label, content concern,
                                                  other

  details                 text                    Optional; enforce a
                                                  length limit

  status                  text                    `new`, `reviewing`,
                                                  `resolved`, `dismissed`

  created_at              timestamptz             Submission timestamp
  -----------------------------------------------------------------------

#### `admin_profiles`

  Column       Type          Notes
  ------------ ------------- ------------------------------------------------
  user_id      uuid          Matches Supabase Auth user ID
  role         text          Initially `admin`; future roles only if needed
  created_at   timestamptz   Creation timestamp

### 5.2 Data integrity rules

-   Use foreign keys for academic relationships.
-   Add indexes to frequently filtered columns: `status`, `stream_id`,
    `grade_id`, `subject_id`, `chapter_id`, `resource_type`, and
    `language`.
-   Ensure public slugs are unique in their intended scope.
-   Restrict `language`, `resource_type`, `format`, `status`, and
    `rights_status` to known values using database constraints or
    validated enums.
-   A published PDF resource must have a valid storage path or an
    approved external URL.
-   A web resource must have non-empty content before publication.
-   A resource must not be publicly visible while its status is `draft`
    or `archived`.
-   Do not delete a subject or chapter if doing so would silently orphan
    published resources. Use safe archive/deactivation workflows.
-   Record `updated_at` on every relevant update.

### 5.3 Search

For the first release: - Search titles, descriptions, subject names,
chapter names, and relevant keywords. - Filter by grade, stream,
subject, resource type, and language. - Use PostgreSQL full-text search
for basic search. - Consider `pg_trgm` for typo-tolerant matching if
testing shows it is needed. - Test English and Nepali queries separately
with real sample content before launch.

Do not promise advanced Nepali stemming or perfect transliteration
matching in the MVP. Treat those as improvements that require testing
with actual Nepali search examples.

------------------------------------------------------------------------

## 6. File storage and PDF workflow

### Recommended storage buckets

1.  `resource-drafts` --- private; files awaiting review.
2.  `published-resources` --- publicly readable files approved for
    distribution.

If the chosen Supabase plan or configuration makes a two-bucket workflow
unnecessarily complex, use one private bucket and deliver published
files through a controlled server-side route. Choose one approach and
document it before implementation.

### Admin upload workflow

1.  Admin signs in.
2.  Admin opens **Add Resource**.
3.  Admin enters title, description, language, grade, stream, subject,
    chapter, resource type, source, and rights status.
4.  Admin uploads a PDF or enters an approved external URL, or writes
    web-based notes.
5.  Application validates file extension, MIME type, and file size.
6.  File is uploaded to the draft area.
7.  Admin previews the resource and checks its academic labels and
    source.
8.  Admin publishes it.
9.  The public resource page becomes available.
10. Admin can later edit, unpublish, archive, or replace the file.

### PDF requirements

-   Use a clear **Read / Preview** action and a separate **Download**
    action.
-   Display file type and file size when available.
-   Provide a fallback if the browser cannot preview the PDF.
-   Use descriptive storage paths, for example:

``` text
grade-11/science/physics/chapter-01/kinematics-notes.pdf
```

-   Do not trust a file's extension alone. Validate MIME type and size
    on the server.
-   Never allow visitors to upload arbitrary files in the MVP.
-   Do not publish a file until the administrator has checked its rights
    and source.

------------------------------------------------------------------------

## 7. Authentication, authorization, and security

Public students do not need accounts. Only administrators authenticate.

### Required safeguards

-   Use Supabase Auth for administrator sign-in.
-   Create administrator profiles deliberately; do not allow public
    self-registration as an admin.
-   Enforce admin authorization on the server for every create, update,
    publish, archive, and delete action.
-   Enable Row Level Security on tables exposed through Supabase APIs.
-   Public visitors may read only active academic structures and
    published resources.
-   Public visitors must not read admin profiles or draft resources.
-   Public visitors may submit issue reports through a narrowly scoped
    endpoint or policy with validation and rate limiting.
-   Admin-only database mutations must require an authenticated admin
    role.
-   Keep Supabase service-role keys and other secrets in server-side
    environment variables only.
-   Never place secrets in `NEXT_PUBLIC_` variables or browser code.
-   Validate and sanitize all user-controlled text.
-   Use HTTPS in production.
-   Add basic rate limiting and spam protection to issue reporting.
-   Avoid collecting unnecessary personal information.

### Security implementation rule

Do not treat hiding an admin button in the interface as authorization.
Every protected operation must be checked on the server and enforced by
database policies where applicable.

Before launch, test access using: 1. A logged-out visitor. 2. A normal
authenticated user, if one exists in the test environment. 3. An
administrator.

Verify that only the administrator can perform administrative actions.

------------------------------------------------------------------------

## 8. Frontend design system

### Visual direction

The website should feel like a clean, modern digital library---not a
crowded coaching advertisement page.

Priorities: - Mobile-first layout. - Clear Science and Management entry
points. - Obvious Grade 11 and Grade 12 selection. - Easy-to-scan
subject and chapter lists. - Comfortable reading width for notes. -
Clear resource format and language labels. - Visible search and language
switcher. - Minimal animation and no intrusive pop-ups.

### Reusable components

Build reusable components rather than duplicating page layouts:

``` text
SiteHeader
SiteFooter
LanguageSwitcher
SearchBar
StreamCard
GradeCard
SubjectCard
ChapterList
ResourceCard
ResourceTypeBadge
LanguageBadge
Breadcrumbs
PdfViewer
DownloadLink
EmptyState
LoadingState
ErrorState
ReportIssueForm
AdminSidebar
AdminResourceForm
AdminResourceTable
```

Use semantic HTML and accessible component patterns. Every interactive
control needs a keyboard-accessible focus state and a meaningful label.

### Content rendering

Web notes should use structured, safe content rendering. Do not render
arbitrary unsanitized HTML supplied through an admin form. Start with a
controlled Markdown editor or a limited rich-text format and sanitize
output.

------------------------------------------------------------------------

## 9. Internationalization and bilingual content

Separate **interface language** from **resource language**.

-   Interface locale: `en` or `ne`.
-   Resource language: the actual language in which that specific
    resource is written.
-   Subject and chapter records may have English and Nepali labels.
-   Resource titles and descriptions should be stored in the language
    actually supplied. If bilingual titles are needed later, add
    explicit fields rather than guessing translations.
-   Language switching changes interface labels and route locale; it
    must not silently replace the resource with a different document.
-   Search should return matching resources regardless of the current
    interface locale, while displaying each resource's language clearly.

Test: - Nepali Unicode input and display. - Mixed English and Nepali
titles. - Search with Devanagari text. - Mobile font rendering. -
Breadcrumbs and navigation labels in both languages.

------------------------------------------------------------------------

## 10. SEO, performance, and accessibility

### SEO

-   Use server-rendered or statically generated public pages where
    appropriate.
-   Give each public page a unique title and description.
-   Use canonical URLs where needed.
-   Generate a sitemap for public pages.
-   Add `robots.txt`.
-   Use readable slugs.
-   Do not index admin pages, draft resources, or private content.
-   Use descriptive link text for PDFs and resources.

### Performance

-   Optimize images and avoid unnecessary large libraries.
-   Keep client-side JavaScript limited; prefer server components for
    content-heavy pages.
-   Paginate or progressively load long resource lists.
-   Cache public academic structures and published resource metadata
    appropriately.
-   Avoid loading PDF files until the user opens a resource.
-   Test on a typical mobile connection, not only fast desktop Wi-Fi.

### Accessibility

-   Use semantic headings in order.
-   Ensure keyboard navigation.
-   Provide visible focus indicators.
-   Use adequate color contrast.
-   Label forms and validation errors clearly.
-   Do not use color alone to indicate status.
-   Provide meaningful text alternatives for informative images.

------------------------------------------------------------------------

## 11. Project folder structure

Use this as the initial structure. The AI coding assistant may make
small justified adjustments, but it should explain them before
introducing unnecessary complexity.

``` text
enotes-nepal/
├── public/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── src/
│   ├── app/
│   │   ├── [locale]/
│   │   │   ├── page.tsx
│   │   │   ├── science/
│   │   │   ├── management/
│   │   │   ├── past-papers/
│   │   │   ├── model-questions/
│   │   │   ├── search/
│   │   │   ├── about/
│   │   │   └── contact/
│   │   ├── admin/
│   │   │   ├── login/
│   │   │   ├── dashboard/
│   │   │   ├── resources/
│   │   │   ├── subjects/
│   │   │   └── reports/
│   │   ├── api/
│   │   ├── layout.tsx
│   │   └── globals.css
│   ├── components/
│   │   ├── layout/
│   │   ├── navigation/
│   │   ├── academic/
│   │   ├── resources/
│   │   ├── search/
│   │   ├── forms/
│   │   └── ui/
│   ├── lib/
│   │   ├── supabase/
│   │   ├── auth/
│   │   ├── validation/
│   │   ├── search/
│   │   └── utils/
│   ├── services/
│   │   ├── resources.ts
│   │   ├── subjects.ts
│   │   ├── chapters.ts
│   │   └── reports.ts
│   ├── i18n/
│   │   ├── en.ts
│   │   └── ne.ts
│   └── types/
├── supabase/
│   ├── migrations/
│   ├── seed.sql
│   └── config.toml
├── tests/
│   ├── unit/
│   └── e2e/
├── .env.example
├── .gitignore
├── README.md
├── package.json
└── ...
```

Do not create every folder in advance if it has no purpose yet. Add
files as their features are implemented.

------------------------------------------------------------------------

## 12. Development workflow

Use a small, repeatable AI-assisted development cycle:

1.  Select one task from the current phase.
2.  Ask the coding assistant to inspect the existing project and
    relevant requirements.
3.  Ask it to propose a small implementation plan.
4.  Review the plan before code changes.
5.  Let it implement only that task.
6.  Run the application and relevant tests.
7.  Inspect the changed files and ask for an explanation of important
    code.
8.  Fix issues before moving on.
9.  Commit the working change to Git.
10. Update the task checklist and project notes.

### Rules for AI coding

-   Do not ask the AI to build the whole product in one prompt.
-   Do not let it replace working code without explaining why.
-   Ask it to inspect existing files before editing.
-   Keep changes focused and reviewable.
-   Require it to report files changed, commands run, test results, and
    known limitations.
-   Never paste passwords, API keys, service-role keys, or private
    credentials into prompts or source files.
-   Do not accept a claim that something works without running it.
-   Ask for explanations when unfamiliar code is introduced.
-   Keep the PRD and this architecture document in the project
    repository.

### Suggested Git routine

``` bash
git status
git add .
git commit -m "Build homepage layout"
git push
```

Use a meaningful commit message for each working feature. Commit before
major changes so you can return to a known-good version.

------------------------------------------------------------------------

## 13. Phased development roadmap

Build in the following order. Each phase has a clear completion
condition.

### Phase 0 --- Project setup

Tasks: - Install and verify Node.js LTS and Git. - Create a GitHub
repository. - Create the Next.js TypeScript project. - Configure
Tailwind CSS. - Add the PRD and this TADP to the repository. - Add
`.env.example` and confirm `.env.local` is ignored by Git. - Run the
starter application locally.

Done when: - The project runs locally. - Git is initialized and the
first commit is pushed. - No secrets are committed.

### Phase 1 --- Public interface foundation

Tasks: - Create the site header and footer. - Create responsive
homepage. - Add Science and Management entry points. - Add Grade 11 and
Grade 12 navigation. - Add the language switcher and English/Nepali
interface labels. - Create loading, empty, and error states. - Add About
and Contact pages.

Done when: - Visitors can navigate the complete initial page hierarchy
using temporary sample data. - Layout works on mobile and desktop. -
Both interface languages render correctly.

### Phase 2 --- Database and academic structure

Tasks: - Create the Supabase project. - Add database migrations for
streams, grades, subjects, chapters, and resources. - Add initial
Science and Management stream records and Grade 11/12 records. - Add a
small verified subject and chapter sample. - Connect Next.js to Supabase
using server-side access. - Replace temporary sample data with database
queries.

Done when: - Grade, stream, subject, and chapter pages are driven by
database records. - Adding a subject does not require editing a page
component. - Public visitors cannot read drafts.

### Phase 3 --- Resource library

Tasks: - Build resource listing and detail pages. - Support web-based
notes. - Configure PDF storage. - Add PDF preview/open and download
actions. - Display resource language, type, source, and update date. -
Add past-paper and model-question views. - Add safe empty and
unavailable-file states.

Done when: - A visitor can browse a subject, open a chapter, read a web
note, and open/download an approved PDF. - Resource labels and academic
relationships are correct.

### Phase 4 --- Admin workflow

Tasks: - Configure Supabase Auth for the administrator. - Create the
admin profile/role and authorization checks. - Build admin login and
dashboard. - Build add/edit resource forms. - Add PDF upload and
preview. - Add draft, publish, unpublish, and archive actions. - Build
basic subject and chapter management. - Add issue-report review.

Done when: - An administrator can manage resources without editing
application source code. - Logged-out visitors cannot access admin
operations. - Database policies prevent unauthorized mutations.

### Phase 5 --- Search, filters, and quality improvements

Tasks: - Implement search across resource and academic metadata. - Add
grade, stream, subject, resource type, and language filters. - Add
recently updated resources. - Add pagination or efficient list
loading. - Add basic SEO metadata, sitemap, and robots rules. - Add
issue-report submission validation and rate limiting.

Done when: - Search and filters return relevant results. - Empty results
have a useful message. - Public pages have appropriate metadata.

### Phase 6 --- Testing and launch

Tasks: - Test public and admin permissions. - Test all navigation
paths. - Test PDF preview and download. - Test English and Nepali
interface rendering. - Test search with representative English and
Nepali queries. - Test phone, tablet, and desktop layouts. - Check
accessibility basics and page performance. - Verify source and rights
information for every published resource. - Deploy to Vercel. - Connect
a custom domain only when ready. - Run a final production smoke test.

Done when: - The PRD acceptance criteria are satisfied. - No known
critical security or content-rights issue remains. - A useful starter
library is available and verified.

------------------------------------------------------------------------

## 14. Testing plan

### Unit and integration tests

Test: - Resource validation rules. - Required fields by resource type. -
Slug generation and uniqueness. - Search filters. - Locale selection. -
Permission-check helpers. - File metadata validation.

### End-to-end tests

Test these user journeys:

**Public student journey** 1. Open homepage. 2. Select Science. 3.
Select Grade 11. 4. Open Physics. 5. Open a chapter. 6. Open a web note.
7. Open or download a PDF. 8. Change interface language. 9. Search for a
resource. 10. Use filters.

**Admin journey** 1. Open admin login. 2. Sign in. 3. Create a draft
resource. 4. Upload a permitted PDF. 5. Preview it. 6. Publish it. 7.
Confirm it appears publicly. 8. Edit or unpublish it. 9. Review an issue
report.

**Security journey** 1. Visit admin pages while logged out. 2. Attempt
an admin mutation without an admin role. 3. Attempt to read a draft as a
public visitor. 4. Confirm each unauthorized action is rejected.

------------------------------------------------------------------------

## 15. Deployment and environment configuration

### Environments

Maintain: - Local development environment. - Preview deployment for
testing. - Production deployment for public visitors.

### Environment variables

Create `.env.example` with variable names and placeholder values only.
Typical variables may include:

``` env
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
```

Use the current Supabase client recommendations when implementing
authentication and server access. The service-role key must remain
server-only and must never be exposed to the browser.

### Deployment sequence

1.  Push the working code to GitHub.
2.  Import the repository into Vercel.
3.  Configure required environment variables in Vercel.
4.  Deploy a preview.
5.  Test the preview and database policies.
6.  Deploy production when acceptance checks pass.
7.  Configure a custom domain later if desired.
8.  Re-test the live site after DNS and HTTPS are active.

Do not store uploaded PDFs inside the Git repository. Use object
storage.

------------------------------------------------------------------------

## 16. Budget and scaling strategy

### Start lean

  -----------------------------------------------------------------------
  Service                 Initial approach        Upgrade trigger
  ----------------------- ----------------------- -----------------------
  GitHub                  Free repository         Team or advanced
                                                  collaboration needs

  Vercel                  Start with an eligible  Usage, commercial
                          free plan               terms, or production
                                                  needs exceed plan

  Supabase                Start with an eligible  Database, storage,
                          free plan               bandwidth, backup, or
                                                  reliability needs
                                                  exceed plan

  Domain                  Optional at first       Purchase when public
                                                  branding is ready

  Analytics               Defer or use a          Need to understand real
                          privacy-conscious       usage
                          option                  

  Error monitoring        Start with platform     More users or
                          logs                    harder-to-diagnose
                                                  failures
  -----------------------------------------------------------------------

Check current provider limits and terms before relying on a free tier,
especially for a public educational website. Keep a backup/export plan
for database records and uploaded files.

### Upgrade only when evidence supports it

Consider upgrading when: - Storage or bandwidth is consistently near the
plan limit. - The site needs stronger backup or recovery guarantees. -
Traffic causes performance or availability issues. - A provider's free
plan is not suitable for the site's commercial or operational use. -
Admins need more reliable production support.

Avoid paying for infrastructure before the MVP demonstrates a real need.

------------------------------------------------------------------------

## 17. Risks and mitigations

  -----------------------------------------------------------------------
  Risk                                Mitigation
  ----------------------------------- -----------------------------------
  Copyright or redistribution         Track source and rights status;
  complaints                          review before publishing

  Incorrect academic labels           Admin preview and content checklist

  Broken PDFs                         Validate files and periodically
                                      check published links

  Unauthorized admin access           Server-side authorization, RLS,
                                      secret management

  Spam issue reports                  Validation, rate limiting, and
                                      moderation

  Poor Nepali search quality          Test with real queries; improve
                                      only when evidence supports it

  Excessive infrastructure cost       Start with a small architecture and
                                      monitor usage

  AI-generated code defects           Small changes, tests, code review,
                                      and Git commits

  Scope expansion                     Keep later-release features out of
                                      the MVP
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 18. MVP definition of done

The MVP is complete only when all of the following are true:

-   [ ] Homepage clearly offers Science and Management.
-   [ ] Grade 11 and Grade 12 are available under both streams.
-   [ ] Subjects and chapters are loaded from the database.
-   [ ] Visitors can browse without logging in.
-   [ ] English and Nepali interface options work.
-   [ ] Resource language is clearly displayed.
-   [ ] Web notes can be read.
-   [ ] Approved PDFs can be previewed or opened and downloaded.
-   [ ] Past papers can be identified by grade, subject, and year where
    data exists.
-   [ ] Search and filters work and have useful empty states.
-   [ ] Admin can add, edit, publish, unpublish, and archive resources.
-   [ ] Admin access is protected.
-   [ ] Draft resources and private admin data are not public.
-   [ ] Issue reporting works.
-   [ ] Mobile and desktop layouts are usable.
-   [ ] Published materials have checked academic labels and
    rights/source information.
-   [ ] Production deployment has been tested.

------------------------------------------------------------------------

## 19. First implementation task

Do not start with the database, admin dashboard, or PDF upload. First
create a clean, runnable application foundation.

### First task for the AI coding assistant

1.  Read `eNotes_Nepal_PRD.md` and `eNotes_Nepal_TADP.md` completely.
2.  Inspect the current folder and report whether it is empty or already
    contains a project.
3.  If no suitable project exists, create a Next.js App Router project
    using TypeScript and Tailwind CSS.
4.  Set up a clean homepage with temporary sample content:
    -   eNotes Nepal as the temporary brand.
    -   English/Nepali language switcher UI.
    -   Science and Management cards.
    -   Grade 11 and Grade 12 entry points.
    -   Past Papers and Model Questions links.
5.  Make the page responsive for mobile and desktop.
6.  Do not connect Supabase yet.
7.  Do not add authentication, payments, ads, or student accounts.
8.  Run the project and report the exact command used.
9.  List every file created or changed.
10. Explain the important parts of the code in beginner-friendly
    language.

**Completion check:** The homepage runs locally, looks organized on
mobile and desktop, and its main navigation is clickable. Only after
this is verified should the next task begin.

------------------------------------------------------------------------

## 20. Master instruction for AI coding assistants

Use this project instruction when starting a coding session:

> You are the senior full-stack engineer helping build eNotes Nepal.
> Treat `eNotes_Nepal_PRD.md` as the product requirements source and
> `eNotes_Nepal_TADP.md` as the technical implementation guide.
>
> The product is a mobile-first, bilingual (English and Nepali)
> educational resource website for Nepal NEB Grade 11 and 12 Science and
> Management students. Students browse for free without login.
> Administrators use protected access to manage resources.
>
> Follow the MVP scope. Implement one small, testable task at a time.
> Before changing files, inspect the existing project and explain your
> plan. Do not rewrite working code unnecessarily. Do not invent
> curriculum content or claim resources are official without
> verification. Do not publish material unless its distribution rights
> have been checked.
>
> Keep secrets out of frontend code and Git. Enforce admin authorization
> on the server and with database policies. Use accessible, responsive
> UI patterns. Prefer maintainable, understandable code over clever
> complexity.
>
> After each task, run appropriate checks and report: what changed,
> files affected, commands run, test results, known limitations, and the
> recommended next task. Explain important code decisions in
> beginner-friendly language because the project owner wants to review
> and learn while AI handles much of the implementation.

------------------------------------------------------------------------

## 21. Relationship to the PRD and remaining decisions

This TADP translates the PRD into a recommended technical plan. It does
not replace the PRD.

The following items still need confirmation or practical validation
during implementation:

-   Final brand name and visual identity.
-   Exact NEB subject and chapter lists, verified against the applicable
    curriculum.
-   Initial resource collection and distribution permissions.
-   Actual file size and storage needs.
-   Provider pricing and plan suitability at launch.
-   Whether public PDFs should be served from a public bucket or through
    a controlled download route.

When a decision changes, update this document and the relevant
implementation tasks rather than allowing the codebase and documentation
to drift apart.

**Recommended next action:** Complete Phase 0 and the first
implementation task. Do not begin later phases until the homepage
foundation is running and reviewed.
