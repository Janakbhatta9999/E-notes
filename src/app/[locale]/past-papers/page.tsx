import { Suspense } from "react";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { PageHeader } from "@/components/public/PageHeader";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

type PastPaperParams = {
  grade?: string | string[];
  stream?: string | string[];
  subject?: string | string[];
  year?: string | string[];
};

function singleFilter(value: string | string[] | undefined) {
  return typeof value === "string" ? value : undefined;
}

export default function PastPapersPage({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string }>;
  searchParams: Promise<PastPaperParams>;
}) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <PastPapersContent params={params} searchParams={searchParams} />
    </Suspense>
  );
}

async function PastPapersContent({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string }>;
  searchParams: Promise<PastPaperParams>;
}) {
  const [{ locale }, filters] = await Promise.all([params, searchParams]);
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  const t = messages[locale];
  const academicData = await getPublicAcademicData();
  const gradeFilter = singleFilter(filters.grade);
  const streamFilter = singleFilter(filters.stream);
  const subjectFilter = singleFilter(filters.subject);
  const yearFilter = singleFilter(filters.year);
  const gradeNumber = gradeFilter ? Number(gradeFilter) : null;
  const grade = gradeNumber ? academicData.status === "ready" ? academicData.grades.find((item) => item.number === gradeNumber) : undefined : undefined;
  const stream = streamFilter && academicData.status === "ready"
    ? academicData.streams.find((item) => item.slug === streamFilter)
    : undefined;
  const subject = subjectFilter && academicData.status === "ready"
    ? academicData.subjects.find((item) => item.id === subjectFilter)
    : undefined;
  const year = yearFilter && /^\d{4}$/.test(yearFilter) ? Number(yearFilter) : null;

  const papers = academicData.status === "ready"
    ? academicData.resources.filter((resource) =>
        resource.resource_type === "past_paper" &&
        (!gradeFilter || resource.grade_id === grade?.id) &&
        (!streamFilter || resource.stream_id === stream?.id) &&
        (!subjectFilter || resource.subject_id === subject?.id) &&
        (!yearFilter || (year !== null && resource.exam_year === year)),
      )
    : [];

  return (
    <>
      <PageHeader
        locale={locale}
        eyebrow={ne ? "परीक्षा संग्रह" : "Exam archive"}
        title={ne ? "पुरानो प्रश्नपत्र" : "Past Papers"}
        description={ne ? "कक्षा, धारा, विषय र वर्षअनुसार स्रोत खोज्नुहोस्।" : "Find papers by grade, stream, subject and exam year."}
      />
      <section className="site-container py-16">
        {academicData.status === "unconfigured" ? <DatabaseSetupNotice locale={locale} /> : (
          <>
            <form method="get" action={`/${locale}/past-papers`} className="grid gap-3 rounded-2xl border border-border bg-white p-5 sm:grid-cols-2 lg:grid-cols-5">
              <label className="grid gap-1 text-xs font-bold text-muted">
                {t.grades}
                <select name="grade" defaultValue={gradeFilter || ""} className="h-12 rounded-lg border border-border px-3 text-sm text-text">
                  <option value="">{ne ? "सबै कक्षा" : "All grades"}</option>
                  {academicData.grades.map((item) => <option key={item.id} value={item.number}>{ne ? item.label_ne || item.label_en : item.label_en}</option>)}
                </select>
              </label>
              <label className="grid gap-1 text-xs font-bold text-muted">
                {ne ? "धारा" : "Stream"}
                <select name="stream" defaultValue={streamFilter || ""} className="h-12 rounded-lg border border-border px-3 text-sm text-text">
                  <option value="">{ne ? "सबै धारा" : "All streams"}</option>
                  {academicData.streams.map((item) => <option key={item.id} value={item.slug}>{ne ? item.name_ne || item.name_en : item.name_en}</option>)}
                </select>
              </label>
              <label className="grid gap-1 text-xs font-bold text-muted">
                {t.subjects}
                <select name="subject" defaultValue={subjectFilter || ""} className="h-12 rounded-lg border border-border px-3 text-sm text-text">
                  <option value="">{ne ? "सबै विषय" : "All subjects"}</option>
                  {academicData.subjects.map((item) => <option key={item.id} value={item.id}>{ne ? item.name_ne || item.name_en : item.name_en}</option>)}
                </select>
              </label>
              <label className="grid gap-1 text-xs font-bold text-muted">
                {t.examYear}
                <input name="year" type="number" min="1950" max="2200" defaultValue={year !== null ? year : ""} className="h-12 rounded-lg border border-border px-3 text-sm text-text" />
              </label>
              <button className="self-end h-12 rounded-lg bg-science px-5 text-sm font-bold text-white">{ne ? "खोज्नुहोस्" : "Apply filters"}</button>
            </form>
            <div className="mt-8">
              <ResourceGrid resources={papers} locale={locale} academic={academicData} />
            </div>
          </>
        )}
      </section>
    </>
  );
}
