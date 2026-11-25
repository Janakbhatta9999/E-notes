import { Suspense } from "react";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PageHeader } from "@/components/public/PageHeader";
import { isLocale } from "@/i18n";

type ReportIssueSearchParams = { resourceUrl?: string | string[] };

export default function ReportIssuePage({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string }>;
  searchParams: Promise<ReportIssueSearchParams>;
}) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <ReportIssuePageContent params={params} searchParams={searchParams} />
    </Suspense>
  );
}

async function ReportIssuePageContent({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string }>;
  searchParams: Promise<ReportIssueSearchParams>;
}) {
  const [{ locale }, filters] = await Promise.all([params, searchParams]);
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  return (
    <>
      <PageHeader locale={locale} eyebrow={ne ? "प्रतिक्रिया" : "Report"} title={ne ? "समस्या रिपोर्ट" : "Report an issue"} description={ne ? "छोटो विवरण दिनुहोस्। यो फारम खाता आवश्यक छैन।" : "Share a short description; no account is required."} />
      <section className="site-container py-16">
        <form className="grid max-w-2xl gap-5 rounded-2xl border border-border bg-white p-6">
          <label className="grid gap-2 text-sm font-bold text-brand-dark">{ne ? "समस्याको प्रकार" : "Issue type"}<select name="issueType" className="h-12 rounded-lg border border-border px-3"><option>Broken file</option><option>Incorrect label</option><option>Unreadable file</option><option>Content concern</option></select></label>
          <label className="grid gap-2 text-sm font-bold text-brand-dark">{ne ? "स्रोतको लिंक" : "Resource link"}<input name="resourceUrl" type="url" defaultValue={typeof filters.resourceUrl === "string" ? filters.resourceUrl : ""} className="h-12 rounded-lg border border-border px-3" /></label>
          <label className="grid gap-2 text-sm font-bold text-brand-dark">{ne ? "थप विवरण" : "Details"}<textarea name="details" rows={5} maxLength={1000} className="rounded-lg border border-border p-3" /></label>
          <button type="button" className="h-12 rounded-lg bg-science text-sm font-bold text-white">{ne ? "रिपोर्ट पेश गर्नुहोस्" : "Submit report"}</button>
        </form>
      </section>
    </>
  );
}
