import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { ChapterExplorer, type ChapterExplorerItem } from "@/components/public/ChapterExplorer";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

export default function SubjectPage({ params }: { params: Promise<{ locale: string; stream: string; grade: string; subject: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <SubjectPageContent params={params} />
    </Suspense>
  );
}

async function SubjectPageContent({ params }: { params: Promise<{ locale: string; stream: string; grade: string; subject: string }> }) {
  const { locale, stream: streamSlug, grade: gradeSlug, subject: subjectSlug } = await params;
  if (!isLocale(locale)) notFound();
  const academicData = await getPublicAcademicData();
  if (academicData.status === "unconfigured") {
    return <section className="site-container py-16"><DatabaseSetupNotice locale={locale} /></section>;
  }
  const stream = academicData.streams.find((item) => item.slug === streamSlug);
  const gradeNumber = /^grade-(\d+)$/.exec(gradeSlug)?.[1];
  const grade = academicData.grades.find((item) => item.number === Number(gradeNumber));
  if (!stream || !grade) notFound();
  const subject = academicData.subjects.find((item) => item.stream_id === stream.id && item.grade_id === grade.id && item.slug === subjectSlug);
  if (!subject) notFound();
  const ne = locale === "ne";
  const streamName = ne ? stream.name_ne || stream.name_en : stream.name_en;
  const gradeName = ne ? grade.label_ne || grade.label_en : grade.label_en;
  const subjectName = ne ? subject.name_ne || subject.name_en : subject.name_en;
  const chapters = academicData.chapters
    .filter((chapter) => chapter.subject_id === subject.id)
    .sort((a, b) => a.sort_order - b.sort_order);
  const units = academicData.units
    .filter((unit) => unit.subject_id === subject.id)
    .sort((a, b) => a.sort_order - b.sort_order);
  const resources = academicData.resources.filter((resource) => resource.subject_id === subject.id);
  const resourceCounts = new Map<string, number>();
  resources.forEach((resource) => {
    if (resource.chapter_id) {
      resourceCounts.set(resource.chapter_id, (resourceCounts.get(resource.chapter_id) ?? 0) + 1);
    }
  });
  const chapterExplorerItems: ChapterExplorerItem[] = chapters.map((chapter) => {
    const unit = units.find((item) => item.id === chapter.unit_id);
    return {
      id: chapter.id,
      slug: chapter.slug,
      chapterNumber: chapter.chapter_number,
      titleEn: chapter.title_en,
      titleNe: chapter.title_ne,
      descriptionEn: chapter.description_en,
      descriptionNe: chapter.description_ne,
      unitId: unit?.id ?? null,
      unitNumber: unit?.unit_number ?? null,
      unitTitleEn: unit?.title_en ?? null,
      unitTitleNe: unit?.title_ne ?? null,
      resourceCount: resourceCounts.get(chapter.id) ?? 0,
    };
  });

  return (
    <>
      <PageHeader
        locale={locale}
        eyebrow={ne ? "विषय" : "Subject"}
        title={subjectName}
        description={ne ? "एकाइअनुसार अध्याय खोज्नुहोस् र स्रोतहरू पढ्नुहोस्।" : "Search chapters by unit, then open notes and other resources."}
        breadcrumbs={[
          { label: streamName, href: `/${locale}/${stream.slug}` },
          { label: gradeName, href: `/${locale}/${stream.slug}/grade-${grade.number}` },
        ]}
      />
      <section className="site-container py-16">
        {!academicData.curriculumSchemaAvailable && (
          <p role="status" className="mb-8 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-950">
            {messages[locale].curriculumMigrationsPending}
          </p>
        )}
        <div className="mb-10 grid gap-3 sm:grid-cols-3">
          {[
            { label: messages[locale].availableChapters, count: chapters.length },
            { label: messages[locale].resourcesCountLabel, count: resources.length },
            { label: ne ? "एकाइहरू" : "verified units", count: units.length },
          ].map((item) => (
            <div key={item.label} className="rounded-2xl border border-border bg-white p-5">
              <p className="text-2xl font-bold text-brand-dark">{item.count}</p>
              <p className="mt-1 text-sm text-muted">{item.label}</p>
            </div>
          ))}
        </div>
        {chapters.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-border bg-white p-8 text-center">
            <p className="text-lg font-bold text-brand-dark">{messages[locale].chapterListPreparing}</p>
            <p className="mt-2 text-muted">{messages[locale].chapterListPreparingDescription}</p>
          </div>
        ) : (
          <div>
            <h2 className="mb-5 text-2xl font-bold text-brand-dark">{ne ? "अध्यायअनुसार ब्राउज गर्नुहोस्" : "Browse by chapter"}</h2>
            <ChapterExplorer
              chapters={chapterExplorerItems}
              locale={locale}
              hrefPrefix={`/${locale}/${stream.slug}/grade-${grade.number}/${subject.slug}`}
            />
          </div>
        )}
        <div className="mt-12">
          <h2 className="mb-5 text-2xl font-bold text-brand-dark">{ne ? "यस विषयका सबै स्रोतहरू" : "All resources for this subject"}</h2>
          <ResourceGrid resources={resources} locale={locale} academic={academicData} />
        </div>
        <Link href={`/${locale}/past-papers`} className="mt-8 inline-flex rounded-lg bg-science px-5 py-3 text-sm font-bold text-white">{ne ? "पुराना प्रश्नपत्र हेर्नुहोस्" : "Browse past papers"}</Link>
      </section>
    </>
  );
}
