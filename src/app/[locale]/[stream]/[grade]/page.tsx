import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

export default function GradePage({ params }: { params: Promise<{ locale: string; stream: string; grade: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <GradePageContent params={params} />
    </Suspense>
  );
}

async function GradePageContent({ params }: { params: Promise<{ locale: string; stream: string; grade: string }> }) {
  const { locale, stream: streamSlug, grade: gradeSlug } = await params;
  if (!isLocale(locale)) notFound();
  const academicData = await getPublicAcademicData();
  if (academicData.status === "unconfigured") {
    return <section className="site-container py-16"><DatabaseSetupNotice locale={locale} /></section>;
  }
  const stream = academicData.streams.find((item) => item.slug === streamSlug);
  const gradeNumber = /^grade-(\d+)$/.exec(gradeSlug)?.[1];
  const grade = academicData.grades.find((item) => item.number === Number(gradeNumber));
  if (!stream || !grade) notFound();
  const ne = locale === "ne";
  const matchingSubjects = academicData.subjects.filter((item) => item.stream_id === stream.id && item.grade_id === grade.id);
  const streamName = ne ? stream.name_ne || stream.name_en : stream.name_en;
  const gradeName = ne ? grade.label_ne || grade.label_en : grade.label_en;

  return (
    <>
      <PageHeader
        locale={locale}
        eyebrow={ne ? "धारा" : "Stream"}
        title={gradeName}
        description={ne ? "विषय छानी अध्यायअनुसार स्रोतहरू पढ्नुहोस्।" : "Choose a subject to browse its chapters and study resources."}
        breadcrumbs={[{ label: streamName, href: `/${locale}/${stream.slug}` }]}
      />
      <section className="site-container py-16">
        <div className="mb-8 flex flex-wrap items-end justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.18em] text-science">{streamName}</p>
            <h2 className="mt-2 text-3xl font-bold tracking-tight text-brand-dark">{ne ? "विषयहरू" : "Choose a subject"}</h2>
          </div>
          <p className="text-sm text-muted">{matchingSubjects.length} {ne ? "विषय" : "subjects"}</p>
        </div>
        {matchingSubjects.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-border bg-white p-10 text-center text-muted">
            {ne ? "यस कक्षाका विषयहरू अझै थपिएका छैनन्।" : "No subjects have been added for this grade yet."}
          </div>
        ) : <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {matchingSubjects.map((subject) => {
            const chapterCount = academicData.chapters.filter((chapter) => chapter.subject_id === subject.id).length;
            const resourceCount = academicData.resources.filter((resource) => resource.subject_id === subject.id).length;
            return (
              <Link key={subject.id} href={`/${locale}/${stream.slug}/grade-${grade.number}/${subject.slug}`} className="card-hover rounded-2xl border border-border bg-white p-6">
                <h3 className="text-xl font-bold text-brand-dark">{ne ? subject.name_ne || subject.name_en : subject.name_en}</h3>
                <div className="mt-4 flex flex-wrap gap-2 text-xs font-semibold text-muted">
                  <span className="rounded-full bg-page-bg px-3 py-1.5">{chapterCount} {messages[locale].availableChapters}</span>
                  <span className="rounded-full bg-page-bg px-3 py-1.5">{resourceCount} {messages[locale].resourcesCountLabel}</span>
                </div>
                <span className="mt-5 inline-flex text-sm font-bold text-science">{ne ? "अध्याय र स्रोत हेर्नुहोस्" : "Browse chapters and resources"} <span aria-hidden="true" className="ml-1">→</span></span>
              </Link>
            );
          })}
        </div>}
      </section>
    </>
  );
}
