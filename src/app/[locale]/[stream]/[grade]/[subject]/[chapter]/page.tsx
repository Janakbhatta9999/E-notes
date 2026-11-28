import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { PageHeader } from "@/components/public/PageHeader";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

type ChapterPageProps = {
  params: Promise<{ locale: string; stream: string; grade: string; subject: string; chapter: string }>;
};

export default function ChapterPage({ params }: ChapterPageProps) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <ChapterPageContent params={params} />
    </Suspense>
  );
}

async function ChapterPageContent({ params }: ChapterPageProps) {
  const { locale, stream: streamSlug, grade: gradeSlug, subject: subjectSlug, chapter: chapterSlug } = await params;
  if (!isLocale(locale)) notFound();

  const academicData = await getPublicAcademicData();
  if (academicData.status === "unconfigured") {
    return <section className="site-container py-16"><DatabaseSetupNotice locale={locale} /></section>;
  }

  const stream = academicData.streams.find((item) => item.slug === streamSlug);
  const gradeNumber = /^grade-(\d+)$/.exec(gradeSlug)?.[1];
  const grade = academicData.grades.find((item) => item.number === Number(gradeNumber));
  if (!stream || !grade) notFound();

  const subject = academicData.subjects.find((item) =>
    item.stream_id === stream.id &&
    item.grade_id === grade.id &&
    item.slug === subjectSlug
  );
  if (!subject) notFound();

  const chapter = academicData.chapters.find((item) =>
    item.subject_id === subject.id &&
    item.slug === chapterSlug
  );
  if (!chapter) notFound();

  const ne = locale === "ne";
  const streamName = ne ? stream.name_ne || stream.name_en : stream.name_en;
  const gradeName = ne ? grade.label_ne || grade.label_en : grade.label_en;
  const subjectName = ne ? subject.name_ne || subject.name_en : subject.name_en;
  const chapterName = ne ? chapter.title_ne || chapter.title_en : chapter.title_en;
  const unit = academicData.units.find((item) => item.id === chapter.unit_id);
  const unitName = unit ? (ne ? unit.title_ne || unit.title_en : unit.title_en) : null;
  const subjectChapters = academicData.chapters
    .filter((item) => item.subject_id === subject.id)
    .sort((a, b) => a.sort_order - b.sort_order);
  const chapterIndex = subjectChapters.findIndex((item) => item.id === chapter.id);
  const previousChapter = chapterIndex > 0 ? subjectChapters[chapterIndex - 1] : null;
  const nextChapter = chapterIndex >= 0 && chapterIndex < subjectChapters.length - 1
    ? subjectChapters[chapterIndex + 1]
    : null;
  const resources = academicData.resources.filter((resource) => resource.chapter_id === chapter.id);
  const subjectHref = `/${locale}/${stream.slug}/grade-${grade.number}/${subject.slug}`;
  const getChapterName = (titleEn: string, titleNe: string | null) => ne ? titleNe || titleEn : titleEn;

  return (
    <>
      <PageHeader
        locale={locale}
        eyebrow={unitName || (ne ? "अध्याय" : "Chapter")}
        title={chapterName}
        description={chapter.description_ne && ne
          ? chapter.description_ne
          : chapter.description_en || messages[locale].chapterPageIntro}
        breadcrumbs={[
          { label: streamName, href: `/${locale}/${stream.slug}` },
          { label: gradeName, href: `/${locale}/${stream.slug}/grade-${grade.number}` },
          { label: subjectName, href: subjectHref },
        ]}
      />
      <section className="site-container py-12 sm:py-16">
        <div className="mb-8 flex flex-wrap items-end justify-between gap-4">
          <div>
            <p className="text-sm font-semibold text-science">
              {chapter.chapter_number
                ? `${ne ? "अध्याय" : "Chapter"} ${chapter.chapter_number}`
                : unitName || (ne ? "अध्याय" : "Chapter")}
              {unitName ? ` · ${unitName}` : ""}
            </p>
            <h2 className="mt-2 text-2xl font-bold text-brand-dark">{messages[locale].chapterResources}</h2>
          </div>
          <Link href={subjectHref} className="text-sm font-bold text-science hover:text-science-dark">
            {messages[locale].browseSubject} →
          </Link>
        </div>

        <ResourceGrid
          resources={resources}
          locale={locale}
          academic={academicData}
          emptyMessage={messages[locale].noChapterResources}
        />

        {(previousChapter || nextChapter) && (
          <nav aria-label={messages[locale].breadcrumbs} className="mt-12 grid gap-3 sm:grid-cols-2">
            {previousChapter ? (
              <Link href={`${subjectHref}/${previousChapter.slug}`} className="rounded-xl border border-border bg-white p-4 hover:border-science/40">
                <span className="block text-xs font-semibold text-muted">{messages[locale].previousChapter}</span>
                <span className="mt-1 block font-bold text-brand-dark">{getChapterName(previousChapter.title_en, previousChapter.title_ne)}</span>
              </Link>
            ) : <span aria-hidden="true" />}
            {nextChapter ? (
              <Link href={`${subjectHref}/${nextChapter.slug}`} className="rounded-xl border border-border bg-white p-4 text-right hover:border-science/40">
                <span className="block text-xs font-semibold text-muted">{messages[locale].nextChapter}</span>
                <span className="mt-1 block font-bold text-brand-dark">{getChapterName(nextChapter.title_en, nextChapter.title_ne)}</span>
              </Link>
            ) : null}
          </nav>
        )}
      </section>
    </>
  );
}
