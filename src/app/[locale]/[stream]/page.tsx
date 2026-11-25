import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale } from "@/i18n";

export default function StreamPage({ params }: { params: Promise<{ locale: string; stream: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <StreamPageContent params={params} />
    </Suspense>
  );
}

async function StreamPageContent({ params }: { params: Promise<{ locale: string; stream: string }> }) {
  const { locale, stream: streamSlug } = await params;
  if (!isLocale(locale)) notFound();
  const academicData = await getPublicAcademicData();
  if (academicData.status === "ready" && !academicData.streams.some((item) => item.slug === streamSlug)) notFound();
  const stream = academicData.status === "ready"
    ? academicData.streams.find((item) => item.slug === streamSlug)
    : undefined;
  const ne = locale === "ne";
  const streamName = stream ? (ne ? stream.name_ne || stream.name_en : stream.name_en) : streamSlug;

  return (
    <>
      <PageHeader locale={locale} eyebrow={ne ? "धारा" : "Stream"} title={streamName} description={stream ? (ne ? stream.description_ne || stream.description_en || "" : stream.description_en || "") : ""} />
      <section className="site-container py-16">
        <h2 className="text-3xl font-bold text-brand-dark">{ne ? "कक्षा छान्नुहोस्" : "Choose a grade"}</h2>
        <div className="mt-8 grid gap-5 md:grid-cols-2">
          {academicData.status === "unconfigured" ? <DatabaseSetupNotice locale={locale} /> : null}
          {academicData.status === "ready" && academicData.grades.length === 0 ? <p className="text-muted">{ne ? "अहिले कुनै सक्रिय कक्षा उपलब्ध छैन।" : "No active grades are available yet."}</p> : null}
          {academicData.status === "ready" && academicData.grades.map((grade) => (
            <Link key={grade.id} href={`/${locale}/${streamSlug}/grade-${grade.number}`} className="card-hover rounded-2xl border border-border bg-white p-7">
              <h3 className="text-2xl font-bold text-brand-dark">{ne ? grade.label_ne || grade.label_en : grade.label_en}</h3>
              <span className="mt-5 inline-block text-sm font-bold text-science">{ne ? "विषय हेर्नुहोस्" : "View subjects"} →</span>
            </Link>
          ))}
        </div>
      </section>
    </>
  );
}
