import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { PageHeader } from "@/components/public/PageHeader";
import { getPublicAcademicData } from "@/data/academic-repository";
import { createPublicSupabaseClient } from "@/lib/supabase/server";
import { isLocale, messages } from "@/i18n";

function isHttpUrl(value: string | null): value is string {
  if (!value) return false;
  try {
    const url = new URL(value);
    return url.protocol === "https:" || url.protocol === "http:";
  } catch {
    return false;
  }
}

function formatFileSize(bytes: number, locale: string) {
  const units = ["B", "KB", "MB", "GB"];
  let size = bytes;
  let unitIndex = 0;
  while (size >= 1024 && unitIndex < units.length - 1) {
    size /= 1024;
    unitIndex += 1;
  }
  return `${new Intl.NumberFormat(locale, { maximumFractionDigits: 1 }).format(size)} ${units[unitIndex]}`;
}

export default function ResourcePage({ params }: { params: Promise<{ locale: string; slug: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <ResourcePageContent params={params} />
    </Suspense>
  );
}

async function ResourcePageContent({ params }: { params: Promise<{ locale: string; slug: string }> }) {
  const { locale, slug } = await params;
  if (!isLocale(locale)) notFound();
  const academicData = await getPublicAcademicData();
  if (academicData.status === "unconfigured") {
    return <section className="site-container py-16"><DatabaseSetupNotice locale={locale} /></section>;
  }

  const resource = academicData.resources.find((item) => item.slug === slug);
  if (!resource) notFound();

  const ne = locale === "ne";
  const t = messages[locale];
  const stream = academicData.streams.find((item) => item.id === resource.stream_id);
  const grade = academicData.grades.find((item) => item.id === resource.grade_id);
  const subject = academicData.subjects.find((item) => item.id === resource.subject_id);
  const chapter = academicData.chapters.find((item) => item.id === resource.chapter_id);
  const unit = academicData.units.find((item) => item.id === chapter?.unit_id);
  const location = [
    stream ? (ne ? stream.name_ne || stream.name_en : stream.name_en) : null,
    grade ? (ne ? grade.label_ne || grade.label_en : grade.label_en) : null,
    subject ? (ne ? subject.name_ne || subject.name_en : subject.name_en) : null,
    unit ? (ne ? unit.title_ne || unit.title_en : unit.title_en) : null,
    chapter ? (ne ? chapter.title_ne || chapter.title_en : chapter.title_en) : null,
  ].filter(Boolean).join(" · ");

  let fileUrl: string | null = null;
  if (resource.format === "pdf") {
    if (isHttpUrl(resource.external_url)) {
      fileUrl = resource.external_url;
    } else if (resource.storage_path) {
      const supabase = createPublicSupabaseClient();
      fileUrl = supabase?.storage.from("published-resources").getPublicUrl(resource.storage_path).data.publicUrl ?? null;
    }
  }

  const issueLink = `/${locale}/report-issue?resourceUrl=${encodeURIComponent(`/${locale}/resources/${resource.slug}`)}`;

  return (
    <>
      <PageHeader locale={locale} eyebrow={location || (ne ? "अध्ययन सामग्री" : "Study resource")} title={resource.title} description={resource.description || ""} />
      <section className="site-container py-12">
        <div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-sm text-muted">
          <span>{ne ? (resource.language === "ne" ? "नेपाली" : "अंग्रेजी") : (resource.language === "ne" ? "Nepali" : "English")}</span>
          <span>{resource.format.toUpperCase()}</span>
          {resource.file_size_bytes !== null && <span>{formatFileSize(resource.file_size_bytes, ne ? "ne-NP" : "en-NP")}</span>}
          {resource.exam_year && <span>{resource.exam_year}</span>}
          {resource.source_name && <span>{t.source}: {resource.source_name}</span>}
          <span>{t.updated}: {resource.updated_at.slice(0, 10)}</span>
        </div>

        {resource.format === "web" && resource.content ? (
          <article className="prose prose-slate mt-8 max-w-4xl whitespace-pre-wrap break-words rounded-2xl border border-border bg-white p-6 leading-8 sm:p-10">
            {resource.content}
          </article>
        ) : fileUrl ? (
          <div className="mt-8">
            {resource.source_url && isHttpUrl(resource.source_url) && (
              <p className="mb-4 text-sm text-muted">{t.source}: <a href={resource.source_url} target="_blank" rel="noopener noreferrer" className="font-semibold text-science underline">{resource.source_name || resource.source_url}</a></p>
            )}
            <iframe title={resource.title} src={fileUrl} className="min-h-[65vh] w-full rounded-xl border border-border bg-white" />
            <a href={fileUrl} target="_blank" rel="noopener noreferrer" className="mt-5 inline-flex h-12 items-center rounded-lg bg-science px-5 text-sm font-bold text-white">
              {t.download} {resource.format.toUpperCase()}
            </a>
          </div>
        ) : (
          <div role="status" className="mt-8 rounded-2xl border border-amber-200 bg-amber-50 p-6 text-amber-950">
            <p>{t.fileUnavailable}</p>
            <Link href={issueLink} className="mt-4 inline-flex font-bold underline">{t.reportIssue}</Link>
          </div>
        )}

        {resource.format === "web" && resource.source_name && resource.source_url && isHttpUrl(resource.source_url) && (
          <p className="mt-6 text-sm text-muted">{t.source}: <a href={resource.source_url} target="_blank" rel="noopener noreferrer" className="font-semibold text-science underline">{resource.source_name}</a></p>
        )}
        <Link href={issueLink} className="mt-8 inline-flex text-sm font-semibold text-science underline">{t.reportIssue}</Link>
      </section>
    </>
  );
}
