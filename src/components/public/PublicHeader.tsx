"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect } from "react";
import type { Locale } from "@/i18n";
import { messages } from "@/i18n";
import { siteConfig } from "@/config/site";

export function PublicHeader({ locale }: { locale: Locale }) {
  const pathname = usePathname();
  const t = messages[locale];
  const switchLocale = locale === "en" ? "ne" : "en";
  const localizedPath = pathname.replace(/^\/(en|ne)(?=\/|$)/, `/${switchLocale}`);
  const links = [
    { href: `/${locale}/science`, label: t.science },
    { href: `/${locale}/management`, label: t.management },
    { href: `/${locale}/past-papers`, label: t.pastPapers },
    { href: `/${locale}/model-questions`, label: t.modelQuestions },
    { href: `/${locale}/search`, label: t.search },
    { href: `/${locale}/about`, label: t.about },
    { href: `/${locale}/contact`, label: t.contact },
  ];

  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  return (
    <header className="border-b border-slate-800 bg-brand-darkest text-white">
      <nav className="site-container flex h-20 items-center justify-between" aria-label="Main navigation">
        <Link href={`/${locale}`} className="flex items-center gap-3" aria-label={`${siteConfig.name} home`}>
          <span className="grid h-10 w-10 place-items-center rounded-xl bg-white text-brand-dark">
            <svg aria-hidden="true" viewBox="0 0 24 24" className="h-6 w-6 fill-none stroke-current stroke-2">
              <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H11v16H6.5A2.5 2.5 0 0 0 4 21.5zM20 5.5A2.5 2.5 0 0 0 17.5 3H13v16h4.5a2.5 2.5 0 0 1 2.5 2.5z" />
            </svg>
          </span>
          <span className="font-bold">{siteConfig.name}</span>
        </Link>
        <div className="hidden items-center gap-6 text-sm font-medium text-slate-200 lg:flex">
          {links.map((link) => <Link key={link.href} href={link.href} className="transition-colors hover:text-white">{link.label}</Link>)}
        </div>
        <div className="flex items-center gap-2">
          <Link href={localizedPath || `/${switchLocale}`} className="rounded-lg border border-white/20 px-3 py-2 text-xs font-bold" aria-label={t.language}>
            {locale === "en" ? "ने" : "EN"}
          </Link>
          <details className="relative lg:hidden">
            <summary className="grid h-10 w-10 cursor-pointer list-none place-items-center rounded-lg border border-white/20" aria-label={t.openMenu}>
              <svg aria-hidden="true" viewBox="0 0 24 24" className="h-5 w-5 fill-none stroke-current stroke-2">
                <path d="M4 7h16M4 12h16M4 17h16" />
              </svg>
            </summary>
            <div className="absolute right-0 z-30 mt-3 w-56 rounded-xl border border-white/10 bg-brand-darkest p-2 shadow-2xl">
              {links.map((link) => (
                <Link key={link.href} href={link.href} className="block rounded-lg px-3 py-2.5 text-sm font-semibold text-slate-200 hover:bg-white/10 hover:text-white">
                  {link.label}
                </Link>
              ))}
            </div>
          </details>
        </div>
      </nav>
    </header>
  );
}
