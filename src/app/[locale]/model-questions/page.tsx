import { Suspense } from "react";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { PageHeader } from "@/components/public/PageHeader";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

export default function ModelQuestionsPage({ params }: { params: Promise<{ locale: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <ModelQuestionsPageContent params={params} />
    </Suspense>
  );
}

async function ModelQuestionsPageContent({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  const t = messages[locale];
  const academicData = await getPublicAcademicData();
  const questions = academicData.status === "ready"
    ? academicData.resources.filter((resource) => resource.resource_type === "model_question")
    : [];

  return (
    <>
      <PageHeader locale={locale} eyebrow={ne ? "अभ्यास" : "Exam practice"} title={t.modelQuestions} description={ne ? "महत्त्वपूर्ण विषयमा आधारित अभ्यास सेटहरू।" : "Practice sets organized by subject and chapter."} />
      <section className="site-container py-16">
        {academicData.status === "unconfigured" ? (
          <DatabaseSetupNotice locale={locale} />
        ) : (
          <ResourceGrid resources={questions} locale={locale} academic={academicData} />
        )}
      </section>
    </>
  );
}
