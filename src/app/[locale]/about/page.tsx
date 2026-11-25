import { Suspense } from "react";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { isLocale } from "@/i18n";

export default function AboutPage({ params }: { params: Promise<{ locale: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <AboutPageContent params={params} />
    </Suspense>
  );
}

async function AboutPageContent({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  return (
    <>
      <PageHeader locale={locale} eyebrow={ne ? "हाम्रो बारेमा" : "About"} title="eNotes Nepal" description={ne ? "नेपालका कक्षा ११ र १२ विद्यार्थीका लागि व्यवस्थित अध्ययन स्रोत।" : "An organized digital study library for Nepal's Grade 11 and 12 students."} />
      <section className="site-container py-16"><div className="max-w-3xl rounded-2xl border border-border bg-white p-8 leading-7 text-muted"><p>{ne ? "eNotes Nepal ले एनईबी विज्ञान र व्यवस्थापनका स्रोतहरू खोज्न सजिलो बनाउँछ। सबै संसाधनको शैक्षिक लेबल र स्रोत जानकारी स्पष्ट रूपमा देखाइनेछ।" : "eNotes Nepal makes NEB Science and Management resources easier to find. Academic labels and source information are presented clearly for every resource."}</p></div></section>
    </>
  );
}
