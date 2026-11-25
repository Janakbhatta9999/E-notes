import Link from "next/link";
import { messages, type Locale } from "@/i18n";

export function PageHeader({
  locale,
  eyebrow,
  title,
  description,
}: {
  locale: Locale;
  eyebrow: string;
  title: string;
  description: string;
}) {
  const t = messages[locale];

  return (
    <section className="hero-bg py-14 text-white sm:py-18">
      <div className="site-container">
        <Link href={`/${locale}`} className="text-sm font-semibold text-blue-200 hover:text-white">← {t.home}</Link>
        <p className="mt-6 text-xs font-bold uppercase tracking-[0.18em] text-blue-200">{eyebrow}</p>
        <h1 className="mt-3 max-w-3xl text-4xl font-bold tracking-tight sm:text-5xl">{title}</h1>
        <p className="mt-5 max-w-2xl leading-7 text-slate-300">{description}</p>
      </div>
    </section>
  );
}
