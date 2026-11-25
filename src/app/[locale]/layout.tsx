import { Suspense } from "react";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { PublicHeader } from "@/components/public/PublicHeader";
import { Footer } from "@/components/home/Footer";
import { isLocale } from "@/i18n";

export function generateStaticParams() {
  return [{ locale: "en" }, { locale: "ne" }];
}

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  if (!isLocale(locale)) notFound();

  return (
    <div className="min-h-screen bg-page-bg">
      <PublicHeader locale={locale} />
      <main className="flex-1">
        <Suspense fallback={<ContentLoading locale={locale} />}>{children}</Suspense>
      </main>
      <Footer locale={locale} />
    </div>
  );
}
