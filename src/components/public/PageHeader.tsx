import Link from "next/link";
import { messages, type Locale } from "@/i18n";

export function PageHeader({
  locale,
  eyebrow,
  title,
  description,
  breadcrumbs = [],
}: {
  locale: Locale;
  eyebrow: string;
  title: string;
  description: string;
  breadcrumbs?: { label: string; href: string }[];
}) {
  const t = messages[locale];

  return (
    <section className="hero-bg py-14 text-white sm:py-18">
      <div className="site-container">
        <nav aria-label={t.breadcrumbs}>
          <ol className="flex flex-wrap items-center gap-2 text-sm font-semibold text-blue-200">
            <li><Link href={`/${locale}`} className="hover:text-white">{t.home}</Link></li>
            {breadcrumbs.map((breadcrumb) => (
              <li key={breadcrumb.href} className="flex items-center gap-2">
                <span aria-hidden="true">/</span>
                <Link href={breadcrumb.href} className="hover:text-white">{breadcrumb.label}</Link>
              </li>
            ))}
          </ol>
        </nav>
        <p className="mt-6 text-xs font-bold uppercase tracking-[0.18em] text-blue-200">{eyebrow}</p>
        <h1 className="mt-3 max-w-3xl text-4xl font-bold tracking-tight sm:text-5xl">{title}</h1>
        <p className="mt-5 max-w-2xl leading-7 text-slate-300">{description}</p>
      </div>
    </section>
  );
}
