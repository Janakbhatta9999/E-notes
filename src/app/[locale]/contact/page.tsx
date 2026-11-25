import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { isLocale } from "@/i18n";

export default function ContactPage({ params }: { params: Promise<{ locale: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <ContactPageContent params={params} />
    </Suspense>
  );
}

async function ContactPageContent({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  return (
    <>
      <PageHeader locale={locale} eyebrow={ne ? "सम्पर्क" : "Contact"} title={ne ? "सहयोग वा समस्या रिपोर्ट गर्नुहोस्" : "Get help or report a problem"} description={ne ? "टुक्रिएको लिंक, गलत लेबल वा अपठनीय फाइल रिपोर्ट गर्नुहोस्।" : "Report broken links, incorrect labels or unreadable files."} />
      <section className="site-container py-16"><div className="rounded-2xl border border-border bg-white p-8"><p className="text-muted">{ne ? "लगइन नगरी कुनै समस्या रिपोर्ट गर्न सकिन्छ।" : "Reports can be submitted without creating an account."}</p><Link href={`/${locale}/report-issue`} className="mt-6 inline-flex rounded-lg bg-science px-5 py-3 text-sm font-bold text-white">{ne ? "समस्या रिपोर्ट गर्नुहोस्" : "Report an issue"}</Link></div></section>
    </>
  );
}
