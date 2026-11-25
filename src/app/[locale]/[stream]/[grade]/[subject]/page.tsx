import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";
import type { ChapterRow } from "@/lib/supabase/database.types";

function ChapterCard({ chapter, locale }: { chapter: ChapterRow; locale: "en" | "ne" }) {
  const ne = locale === "ne";
  return (
    <li className="rounded-2xl border border-border bg-white p-6">
      <p className="text-xs font-bold uppercase tracking-wider text-science">
        {chapter.chapter_number ? `${ne ? "अध्याय" : "Chapter"} ${chapter.chapter_number}` : (ne ? "अध्याय" : "Chapter")}
      </p>
      <h3 className="mt-2 text-lg font-bold text-brand-dark">{ne ? chapter.title_ne || chapter.title_en : chapter.title_en}</h3>
      {(ne ? chapter.description_ne || chapter.description_en : chapter.description_en) && (
        <p className="mt-2 text-sm leading-6 text-muted">{ne ? chapter.description_ne || chapter.description_en : chapter.description_en}</p>
      )}
    </li>
  );
}

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
  const chapters = academicData.chapters.filter((chapter) => chapter.subject_id === subject.id);
  const units = academicData.units.filter((unit) => unit.subject_id === subject.id);
  const ungroupedChapters = chapters.filter((chapter) => chapter.unit_id === null);
  const resources = academicData.resources.filter((resource) => resource.subject_id === subject.id);

  return (
    <>
      <PageHeader locale={locale} eyebrow={`${streamName} · ${gradeName}`} title={subjectName} description={ne ? "अध्याय, नोट, मोडेल प्रश्न र पुराना प्रश्नपत्र।" : "Browse chapters, notes, model questions and past papers."} />
      <section className="site-container py-16">
        {!academicData.curriculumSchemaAvailable && (
          <p role="status" className="mb-8 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-950">
            {messages[locale].curriculumMigrationsPending}
          </p>
        )}
        {chapters.length === 0 && units.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-border bg-white p-8 text-center">
            <p className="text-lg font-bold text-brand-dark">{ne ? "यस विषयका अध्यायहरू अझै थपिएका छैनन्" : "No chapters have been added for this subject yet"}</p>
            <p className="mt-2 text-muted">{ne ? "अध्यायहरू डाटाबेसमा थपिएपछि यहाँ देखिनेछन्।" : "Chapters added to the academic database will appear here."}</p>
          </div>
        ) : (
          <div className="space-y-10">
            {units.map((unit) => (
              <section key={unit.id}>
                <h2 className="mb-4 text-2xl font-bold text-brand-dark">
                  {unit.unit_number ? `${ne ? "एकाइ" : "Unit"} ${unit.unit_number}: ` : ""}
                  {ne ? unit.title_ne || unit.title_en : unit.title_en}
                </h2>
                <ol className="grid gap-4 sm:grid-cols-2">
                  {chapters.filter((chapter) => chapter.unit_id === unit.id).map((chapter) => (
                    <ChapterCard key={chapter.id} chapter={chapter} locale={locale} />
                  ))}
                </ol>
              </section>
            ))}
            {ungroupedChapters.length > 0 && (
              <section>
                {units.length > 0 && <h2 className="mb-4 text-2xl font-bold text-brand-dark">{ne ? "अन्य अध्यायहरू" : "Other chapters"}</h2>}
                <ol className="grid gap-4 sm:grid-cols-2">
                  {ungroupedChapters.map((chapter) => <ChapterCard key={chapter.id} chapter={chapter} locale={locale} />)}
                </ol>
              </section>
            )}
          </div>
        )}
        <div className="mt-12">
          <h2 className="mb-5 text-2xl font-bold text-brand-dark">{ne ? "यस विषयका स्रोतहरू" : "Resources for this subject"}</h2>
          <ResourceGrid resources={resources} locale={locale} academic={academicData} />
        </div>
        <Link href={`/${locale}/past-papers`} className="mt-8 inline-flex rounded-lg bg-science px-5 py-3 text-sm font-bold text-white">{ne ? "पुराना प्रश्नपत्र हेर्नुहोस्" : "Browse past papers"}</Link>
      </section>
    </>
  );
}
