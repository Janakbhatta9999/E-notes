import { Suspense } from "react";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { PageHeader } from "@/components/public/PageHeader";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

type SearchFilters = {
  q?: string | string[];
  grade?: string | string[];
  stream?: string | string[];
  subject?: string | string[];
  type?: string | string[];
  language?: string | string[];
};

const resourceTypes = ["notes", "past_paper", "model_question", "practice", "reference"] as const;

function singleFilter(value: string | string[] | undefined) {
  return typeof value === "string" ? value : undefined;
}

export default function SearchPage({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string }>;
  searchParams: Promise<SearchFilters>;
}) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <SearchPageContent params={params} searchParams={searchParams} />
    </Suspense>
  );
}

async function SearchPageContent({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string }>;
  searchParams: Promise<SearchFilters>;
}) {
  const [{ locale }, filters] = await Promise.all([params, searchParams]);
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  const t = messages[locale];
  const query = singleFilter(filters.q)?.trim().slice(0, 100) || "";
  const gradeFilter = singleFilter(filters.grade);
  const streamFilter = singleFilter(filters.stream);
  const subjectFilter = singleFilter(filters.subject);
  const typeFilter = singleFilter(filters.type);
  const languageFilter = singleFilter(filters.language);
  const normalizedQuery = query.toLocaleLowerCase(ne ? "ne-NP" : "en-NP");
  const academicData = await getPublicAcademicData();
  const gradeNumber = gradeFilter ? Number(gradeFilter) : null;
  const grade = gradeNumber && academicData.status === "ready"
    ? academicData.grades.find((item) => item.number === gradeNumber)
    : undefined;
  const stream = streamFilter && academicData.status === "ready"
    ? academicData.streams.find((item) => item.slug === streamFilter)
    : undefined;
  const subject = subjectFilter && academicData.status === "ready"
    ? academicData.subjects.find((item) => item.id === subjectFilter)
    : undefined;
  const validType = resourceTypes.find((type) => type === typeFilter);

  const results = academicData.status === "ready"
    ? academicData.resources.filter((resource) => {
        const resourceSubject = academicData.subjects.find((item) => item.id === resource.subject_id);
        const resourceChapter = academicData.chapters.find((item) => item.id === resource.chapter_id);
        const resourceUnit = academicData.units.find((item) => item.id === resourceChapter?.unit_id);
        const resourceStream = academicData.streams.find((item) => item.id === resource.stream_id);
        const resourceGrade = academicData.grades.find((item) => item.id === resource.grade_id);
        const searchableText = [
          resource.title,
          resource.description,
          resource.content,
          resourceSubject?.name_en,
          resourceSubject?.name_ne,
          resourceChapter?.title_en,
          resourceChapter?.title_ne,
          resourceUnit?.title_en,
          resourceUnit?.title_ne,
          resourceStream?.name_en,
          resourceStream?.name_ne,
          resourceGrade?.label_en,
          resourceGrade?.label_ne,
        ].filter(Boolean).join(" ").toLocaleLowerCase(ne ? "ne-NP" : "en-NP");

        return (!normalizedQuery || searchableText.includes(normalizedQuery)) &&
          (!gradeFilter || resource.grade_id === grade?.id) &&
          (!streamFilter || resource.stream_id === stream?.id) &&
          (!subjectFilter || resource.subject_id === subject?.id) &&
          (!typeFilter || resource.resource_type === validType) &&
          (!languageFilter || resource.language === languageFilter);
      })
    : [];

  return (
    <>
      <PageHeader locale={locale} eyebrow={ne ? "स्रोत खोज्नुहोस्" : "Resource search"} title={t.search} description={ne ? "विषय, अध्याय वा स्रोतको शीर्षकबाट खोज्नुहोस्।" : "Search resource titles, subjects and chapters, then narrow by academic filters."} />
      <section className="site-container py-16">
        {academicData.status === "unconfigured" ? <DatabaseSetupNotice locale={locale} /> : (
          <>
            <form method="get" role="search" className="grid gap-3 rounded-2xl border border-border bg-white p-5 sm:grid-cols-2 lg:grid-cols-3">
              <label className="grid gap-1 text-xs font-bold text-muted sm:col-span-2 lg:col-span-3">
                {t.search}
                <input name="q" maxLength={100} defaultValue={query} placeholder={ne ? "नोट, प्रश्नपत्र, विषय वा अध्याय खोज्नुहोस्..." : "Search notes, papers, subjects or chapters..."} className="h-12 rounded-lg border border-border bg-white px-4 text-sm font-normal text-text" />
              </label>
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
                {t.resourceType}
                <select name="type" defaultValue={typeFilter || ""} className="h-12 rounded-lg border border-border px-3 text-sm text-text">
                  <option value="">{t.allTypes}</option>
                  {resourceTypes.map((type) => <option key={type} value={type}>{t[type === "past_paper" ? "pastPaper" : type === "model_question" ? "modelQuestion" : type]}</option>)}
                </select>
              </label>
              <label className="grid gap-1 text-xs font-bold text-muted">
                {ne ? "भाषा" : "Language"}
                <select name="language" defaultValue={languageFilter || ""} className="h-12 rounded-lg border border-border px-3 text-sm text-text">
                  <option value="">{t.allLanguages}</option>
                  <option value="en">{t.english}</option>
                  <option value="ne">{t.nepali}</option>
                </select>
              </label>
              <button className="self-end h-12 rounded-lg bg-science px-5 text-sm font-bold text-white">{ne ? "खोज्नुहोस्" : "Search and filter"}</button>
            </form>
            <div className="mt-8">
              {results.length === 0 && !query && !gradeFilter && !streamFilter && !subjectFilter && !typeFilter && !languageFilter ? (
                <p className="mb-5 text-sm text-muted">{ne ? "स्रोतहरू खोज्न शब्द वा फिल्टर छान्नुहोस्।" : "Enter a search term or choose a filter to find resources."}</p>
              ) : null}
              <ResourceGrid resources={results} locale={locale} academic={academicData} />
            </div>
          </>
        )}
      </section>
    </>
  );
}
