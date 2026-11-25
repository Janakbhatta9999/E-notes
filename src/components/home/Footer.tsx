import Link from "next/link";
import { siteConfig } from "@/config/site";
import { messages, type Locale } from "@/i18n";

export function Footer({ locale }: { locale: Locale }) {
  const t = messages[locale];

  return (
    <footer className="border-t border-slate-800 bg-brand-darkest py-10 text-slate-400">
      <div className="site-container">
        <div className="grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
          <div>
            <p className="text-lg font-bold text-white">{siteConfig.name}</p>
            <p className="mt-3 max-w-xs text-sm leading-6">
              {t.footerDescription}
            </p>
          </div>
          <div>
            <p className="text-sm font-bold text-white">{t.resources}</p>
            <div className="mt-3 flex flex-col gap-2 text-sm">
              <Link href={`/${locale}/past-papers`} className="hover:text-white">{t.pastPapers}</Link>
              <Link href={`/${locale}/model-questions`} className="hover:text-white">{t.modelQuestions}</Link>
              <Link href={`/${locale}/search`} className="hover:text-white">{t.allResources}</Link>
            </div>
          </div>
          <div>
            <p className="text-sm font-bold text-white">{t.subjects}</p>
            <div className="mt-3 flex flex-col gap-2 text-sm">
              <Link href={`/${locale}/science`} className="hover:text-white">{t.science}</Link>
              <Link href={`/${locale}/management`} className="hover:text-white">{t.management}</Link>
              <Link href={`/${locale}/science/grade-11`} className="hover:text-white">{t.grade11}</Link>
              <Link href={`/${locale}/science/grade-12`} className="hover:text-white">{t.grade12}</Link>
            </div>
          </div>
          <div>
            <p className="text-sm font-bold text-white">eNotes Nepal</p>
            <div className="mt-3 flex flex-col gap-2 text-sm">
              <Link href={`/${locale}/about`} className="hover:text-white">{t.about}</Link>
              <Link href={`/${locale}/contact`} className="hover:text-white">{t.contact}</Link>
              <Link href={`/${locale}/report-issue`} className="hover:text-white">{t.reportIssue}</Link>
            </div>
          </div>
        </div>
        <div className="mt-9 border-t border-slate-800 pt-6 text-xs">
          © 2026 {siteConfig.name}. {t.madeForStudents}
        </div>
      </div>
    </footer>
  );
}
