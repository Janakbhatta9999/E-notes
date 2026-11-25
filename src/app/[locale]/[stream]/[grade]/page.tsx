import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale } from "@/i18n";

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
      <PageHeader locale={locale} eyebrow={`${streamName} · ${gradeName}`} title={ne ? "विषयहरू" : "Subjects"} description={ne ? "विषय छानी अध्यायवाट स्रोतहरू पढ्नुहोस्।" : "Choose a subject to browse chapter-wise resources."} />
      <section className="site-container py-16">
        {matchingSubjects.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-border bg-white p-10 text-center text-muted">
            {ne ? "यस कक्षाका विषयहरू अझै थपिएका छैनन्।" : "No subjects have been added for this grade yet."}
          </div>
        ) : <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {matchingSubjects.map((subject) => (
            <Link key={subject.id} href={`/${locale}/${stream.slug}/grade-${grade.number}/${subject.slug}`} className="card-hover rounded-2xl border border-border bg-white p-6">
              <h3 className="text-xl font-bold text-brand-dark">{ne ? subject.name_ne || subject.name_en : subject.name_en}</h3>
              <span className="mt-4 inline-block text-sm font-bold text-science">{ne ? "अध्याय हेर्नुहोस्" : "View chapters"} →</span>
            </Link>
          ))}
        </div>}
      </section>
    </>
  );
}
