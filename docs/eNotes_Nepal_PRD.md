# Product Requirements Document (PRD)

## eNotes Nepal --- Grade 11 & 12 Science and Management

**Document status:** Initial product specification\
**Version:** 1.0\
**Date:** 24 November 2026\
**Working product name:** eNotes Nepal (provisional; final brand name
not supplied)\
**Initial market:** Nepal\
**Initial curriculum assumption:** National Examinations Board (NEB)\
**Initial scope:** Grade 11 and Grade 12, Science and Management streams

------------------------------------------------------------------------

## 1. Product summary

eNotes Nepal is a mobile-friendly educational resource website that
helps Grade 11 and Grade 12 students in Nepal find organized study
materials in one place. The first release will focus on the Science and
Management streams.

Students should be able to select their grade and stream, browse
subjects and chapters, read available notes, and access useful
exam-preparation resources such as past question papers, model
questions, and practice materials.

The product should feel like a well-organized digital library: simple to
navigate, quick to load, trustworthy, and easy to use on a phone.

## 2. Problem statement

Students often need to search across multiple websites, social media
posts, shared drives, and PDFs to find useful notes and examination
resources. Materials may be poorly organized, difficult to verify, or
hard to access on mobile devices.

eNotes Nepal aims to reduce that friction by organizing resources by: -
Grade: 11 or 12 - Stream: Science or Management - Subject - Chapter or
topic - Resource type

## 3. Product goals

### Primary goals

1.  Make Grade 11 and 12 Science and Management materials easy to
    discover.
2.  Organize notes in a consistent subject- and chapter-wise structure.
3.  Provide past papers and model questions for exam preparation.
4.  Make reading and downloading resources straightforward.
5.  Give the site owner a manageable way to add, update, and remove
    resources.
6.  Build a structure that can later support more streams, grades, and
    resource types.

### Success indicators

-   Students can reach a relevant subject page in a few clear steps.
-   Most resource pages load correctly on mobile and desktop.
-   Every published resource has clear grade, stream, subject, and
    resource-type labels.
-   Broken or outdated resources can be identified and corrected.
-   New materials can be published without changing the website code for
    every upload.

## 4. Target users

### Primary users

-   Grade 11 Science students
-   Grade 12 Science students
-   Grade 11 Management students
-   Grade 12 Management students

### Secondary users

-   Teachers who want to share learning resources
-   Students preparing for examinations
-   The site administrator or content editor

## 5. Information architecture

### Main navigation

-   Home
-   Science
-   Management
-   Past Papers
-   Model Questions
-   About
-   Contact / Report an Issue

### Recommended page hierarchy

``` text
Home
├── Science
│   ├── Grade 11
│   │   ├── Subject
│   │   │   ├── Subject overview
│   │   │   ├── Chapter list
│   │   │   └── Chapter/resource page
│   └── Grade 12
│       └── Same structure
├── Management
│   ├── Grade 11
│   │   └── Same structure
│   └── Grade 12
│       └── Same structure
├── Past Papers
│   ├── Grade
│   ├── Stream
│   └── Subject / Year
├── Model Questions
└── About / Contact
```

The homepage should let students choose a stream first. Each stream
should have a dedicated landing page, with clear Grade 11 and Grade 12
entry points. Each grade page should list the relevant subjects. Subject
pages should organize content by chapters and resource type.

The subject list must be configurable. Do not permanently hard-code
subject names into the page layout because curricula and available
materials may change.

## 5A. Confirmed product decisions

The following decisions are confirmed for the initial product direction:

  -----------------------------------------------------------------------
  Decision                            Confirmed direction
  ----------------------------------- -----------------------------------
  Website name                        Not yet provided; use **eNotes
                                      Nepal** as a temporary working name

  Language                            English and Nepali

  Access                              Free access; no student login
                                      required

  Content format                      Both web-based notes and PDFs

  Curriculum                          Nepal NEB curriculum

  Monetization                        Consider advertisements in the
                                      future; do not make ads a launch
                                      dependency
  -----------------------------------------------------------------------

### Bilingual content requirements

-   The interface should support both English and Nepali.
-   Provide a clear language switcher that is easy to find.
-   Keep the selected language consistent while navigating the site
    where practical.
-   Resource metadata should identify the language of each note or PDF.
-   Do not assume every resource is available in both languages; show
    the actual language clearly.
-   Use fonts that render Nepali/Devanagari and English cleanly on
    common phones and computers.
-   Ensure search can find resources using the language and script used
    in their titles and descriptions.

### Free, no-login access requirements

-   Students must be able to browse, read, and download publicly
    available resources without creating an account.
-   Do not add a mandatory student sign-in wall to notes or past papers.
-   Keep administrator access protected separately.
-   Avoid collecting personal information unless a specific feature
    genuinely requires it.

### Web notes and PDF requirements

-   Support notes written as accessible web pages as well as
    downloadable or viewable PDFs.
-   Prefer web-based notes when content benefits from responsive
    reading, searchable text, and accessible headings.
-   Provide PDFs when a printable or fixed-layout document is useful.
-   Clearly label each resource format and language.
-   Where both formats exist for the same material, link them together.

### Future advertising requirements

-   The initial launch should prioritize usability and trustworthy
    learning content, not advertising.
-   Design page layouts so future ads can be added without disrupting
    reading or navigation.
-   Ads must not obscure notes, downloads, or essential controls.
-   Avoid intrusive pop-ups, misleading download buttons, or ad
    placements that could confuse students.
-   Review applicable privacy and advertising requirements before
    enabling ad services.

## 6. Functional requirements

### 6.1 Homepage

-   Clearly explain what eNotes Nepal offers.
-   Show prominent Science and Management choices.
-   Provide separate Grade 11 and Grade 12 entry points.
-   Highlight recently added or updated resources.
-   Provide easy access to Past Papers and Model Questions.
-   Include a visible search option.
-   Work well on mobile screens.

### 6.2 Stream landing pages

-   Provide separate Science and Management pages.
-   Show Grade 11 and Grade 12 cards or sections.
-   Explain what materials are available in that stream.
-   Keep navigation consistent between streams.

### 6.3 Grade pages

-   Display subjects available for the selected grade and stream.
-   Show subject names and, where useful, a short description.
-   Allow students to open a subject page.
-   Include links to relevant past papers and model questions.

### 6.4 Subject pages

-   Display grade, stream, and subject clearly.
-   Organize notes by chapter or unit.
-   Separate notes, question sets, past papers, and other resources.
-   Show resource titles, type, file format, and last-updated date where
    available.
-   Make it clear when a chapter has no materials yet.

### 6.5 Resource detail and reading

-   Display the resource title and its academic location (grade, stream,
    subject, chapter).
-   Provide an in-browser PDF preview when technically possible.
-   Provide a clear download action when downloading is permitted.
-   Show file size and format when available.
-   Include a report link for broken, incorrect, or inappropriate
    material.
-   If preview is unavailable, show a useful fallback message and the
    available download option.

### 6.6 Past papers

-   Allow filtering by grade, stream, subject, and examination year.
-   Clearly label the year and subject.
-   Distinguish official past papers from practice or model papers.
-   Show the source or attribution when known.
-   Do not label a paper as official unless its origin has been checked.

### 6.7 Search and filtering

-   Search resource titles, subjects, chapters, and relevant keywords.
-   Offer filters for grade, stream, subject, and resource type.
-   Show a helpful empty state when no results match.
-   Search results should link directly to the relevant resource page.

### 6.8 Recently added resources

-   Show a small section of recently published or updated materials.
-   Display the date added or updated.
-   Do not let this section replace clear subject-based navigation.

### 6.9 Feedback and issue reporting

-   Let students report broken links, incorrect labels, unreadable
    files, or suspected errors.
-   Keep the form short: issue type, resource link, and optional
    details.
-   Do not require students to create an account just to report a
    problem.
-   Provide a confirmation after a report is submitted.

### 6.10 Administration and content management

An administrator should be able to: - Add, edit, publish, unpublish, and
delete resources. - Add and manage grades, streams, subjects, and
chapters. - Upload or link PDF files. - Enter resource title,
description, type, grade, stream, subject, chapter, year (if
applicable), source, and publication status. - Preview content before
publishing. - Correct broken links and replace outdated files. - Review
student issue reports.

For the first release, a simple protected admin interface or a secure
content-management workflow is sufficient. A large multi-role dashboard
is not required.

## 7. Content model

Each resource should store the following fields where applicable:

  ---------------------------------------------------------------------
  Field                              Purpose
  ---------------------------------- ----------------------------------
  Resource ID                        Unique identifier

  Title                              Name shown to students

  Description                        Short explanation of the resource

  Grade                              11 or 12

  Stream                             Science or Management

  Subject                            Related subject

  Chapter / Unit                     Related chapter, if applicable

  Resource type                      Notes, past paper, model question,
                                     practice set, reference

  File URL                           Stored file or approved external
                                     link

  File format                        PDF or other supported format

  File size                          Optional display information

  Exam year                          For past papers, if applicable

  Source / attribution               Where the material came from

  Status                             Draft, published, or archived

  Created date                       Date added

  Updated date                       Most recent update
  ---------------------------------------------------------------------

The content model should support new grades, streams, and subjects in
the future without requiring a redesign.

## 8. User experience and design requirements

-   Mobile-first responsive design.
-   Simple navigation with clear labels.
-   Consistent visual design across Science and Management.
-   Readable typography and comfortable spacing.
-   Strong contrast and visible keyboard focus.
-   Clear loading, empty, error, and success states.
-   Avoid excessive animations, pop-ups, and distracting elements.
-   Keep important actions such as Read and Download easy to find.
-   Use breadcrumbs on deeper pages, for example: Home \> Science \>
    Grade 11 \> Physics.
-   Use a consistent layout for subject and resource pages.

## 9. Non-functional requirements

### Performance

-   Pages should load quickly on typical mobile connections.
-   Compress images and avoid unnecessarily large assets.
-   Load long resource lists efficiently.
-   Use appropriate caching and a reliable file-hosting approach.

### Accessibility

-   Use semantic page headings and labels.
-   Ensure keyboard navigation works.
-   Provide meaningful text alternatives for informative images.
-   Do not rely on color alone to communicate status.

### Reliability

-   Validate resource links and file availability.
-   Show a useful message when a file cannot be opened.
-   Back up content and uploaded files.
-   Keep a record of important content updates.

### Search engine visibility

-   Give each grade, stream, subject, and resource page a meaningful
    page title and description.
-   Use readable URLs.
-   Avoid duplicate pages with nearly identical content.
-   Add a sitemap and basic search-engine metadata before public launch.

## 10. Security, privacy, and content rights

-   Protect administrator access with authentication.
-   Never expose admin credentials or private configuration in frontend
    code.
-   Validate uploaded file types and sizes.
-   Restrict file uploads to authorized administrators.
-   Use HTTPS in production.
-   Collect as little personal information as possible.
-   Publish a privacy notice if forms or analytics collect user
    information.
-   Only upload or distribute materials the site has permission to
    share.
-   Credit authors and sources where required.
-   Do not assume that a publicly accessible PDF is automatically free
    to republish.

## 11. Recommended MVP scope

The first release should be useful but intentionally small.

### Must have

-   Main homepage
-   Separate Science and Management landing pages
-   Grade 11 and Grade 12 pages for both streams
-   Subject listing pages
-   Chapter-wise resource organization
-   PDF preview or a reliable open/download option
-   Past-paper section with grade, subject, and year labels
-   Basic search and filters
-   Admin workflow for adding and updating resources
-   Mobile-responsive layout
-   About and contact/report-issue pages

### Should have

-   Recently added resources
-   Related resources on each subject page
-   Clear source and last-updated information
-   Empty states for subjects with no uploaded resources
-   Basic traffic and popular-resource analytics, with privacy
    considered

### Later releases

-   Student accounts
-   Bookmarks and saved resources
-   Personal study lists
-   Quizzes and chapter-wise practice
-   Progress tracking
-   Teacher or contributor submissions with admin approval
-   Comments or question discussions, if moderation can be provided
-   Notifications for newly added materials
-   Additional grades, streams, and curricula

Do not build all later-release features before the core resource library
works reliably.

## 12. Suggested technical approach

The final stack should be selected based on the developer's experience,
hosting budget, and expected content volume. A reasonable starting
architecture is:

-   **Frontend:** Next.js or another maintainable React framework.
-   **Styling:** Tailwind CSS or a consistent component-based CSS
    system.
-   **Database / content store:** Supabase (PostgreSQL) or another
    managed database if dynamic content is required.
-   **File storage:** Supabase Storage or a suitable object-storage
    provider for PDFs.
-   **Authentication:** Admin-only authentication for the MVP.
-   **Hosting:** A platform that supports the selected frontend
    framework.
-   **Analytics:** Privacy-conscious basic analytics.

A simpler static-site approach with a lightweight CMS can also work if
the first version has limited content and no student accounts. Avoid
adding a complex backend before the content workflow requires it.

## 13. Content quality rules

-   Check that every PDF opens before publishing.
-   Confirm the correct grade, stream, subject, and chapter.
-   Use descriptive file names.
-   State whether a resource is notes, a past paper, a model question,
    or a practice set.
-   Include the exam year for past papers when known.
-   Record source and attribution.
-   Review outdated resources periodically.
-   Do not claim that materials are official, complete, or
    syllabus-approved without verification.

## 14. Launch plan

### Phase 1 --- Foundation

-   Confirm the product name and visual identity.
-   Finalize the navigation and page hierarchy.
-   Build responsive homepage and stream pages.
-   Create reusable grade, subject, and resource page templates.

### Phase 2 --- Content library

-   Add Grade 11 and 12 Science and Management structures.
-   Add subjects and chapters based on the verified curriculum.
-   Implement resource upload/linking and PDF viewing.
-   Add past-paper organization.

### Phase 3 --- Discovery and administration

-   Add search and filters.
-   Add the admin publishing workflow.
-   Add recently updated resources and issue reporting.
-   Add basic SEO metadata and sitemap.

### Phase 4 --- Testing and launch

-   Test on mobile, tablet, and desktop.
-   Test every navigation path and resource link.
-   Check PDF previews and downloads.
-   Test admin permissions and upload validation.
-   Check page speed, accessibility basics, and error states.
-   Launch with a useful, verified starter collection.

## 15. Acceptance criteria

The MVP is ready for launch when: 1. A visitor can choose Science or
Management from the homepage. 2. A visitor can choose Grade 11 or Grade
12 within either stream. 3. A visitor can open a subject and browse its
chapters. 4. A visitor can open or download a published resource. 5. A
visitor can find past papers by grade, stream, subject, and year where
data exists. 6. Search and filters return relevant results and show a
useful empty state. 7. An administrator can add, edit, publish,
unpublish, and remove resources. 8. The website is usable on common
mobile and desktop screen sizes. 9. Published resources have accurate
academic labels and source information where available. 10. Broken links
and failed file loads are handled with clear messages.

## 16. Open decisions to confirm

These decisions should be confirmed before detailed implementation:

1.  **Brand:** Is "eNotes Nepal" the final name or only a working name?
2.  **Curriculum:** Is the initial content strictly NEB Grade 11 and 12?
3.  **Language:** English only, Nepali only, or both?
4.  **Access:** Should all notes and PDFs be free without login?
5.  **Content format:** Will the site host PDFs, display written notes
    as web pages, or support both?
6.  **Content creation:** Will the owner upload original notes, collect
    permitted resources, or accept teacher contributions?
7.  **Technology:** Is there an existing website or codebase that this
    PRD must fit?
8.  **Monetization:** Should the first release remain ad-free, or is a
    future revenue model planned?

------------------------------------------------------------------------

## Product recommendation

Launch with a focused, high-quality library rather than a large
collection of unverified files. Prioritize accurate organization,
working PDFs, clear sources, and a smooth mobile experience. Once
students can reliably find and use the materials, add accounts,
bookmarks, quizzes, and other interactive features based on actual user
needs.
