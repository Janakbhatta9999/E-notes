import { Suspense } from "react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { ContentLoading } from "@/components/public/ContentLoading";
import { DatabaseSetupNotice } from "@/components/public/DatabaseSetupNotice";
import { ResourceGrid } from "@/components/public/ResourceGrid";
import { getPublicAcademicData } from "@/data/academic-repository";
import { isLocale, messages } from "@/i18n";

export default function LocaleHome({ params }: { params: Promise<{ locale: string }> }) {
  return (
    <Suspense fallback={<ContentLoading locale="en" />}>
      <LocaleHomeContent params={params} />
    </Suspense>
  );
}

async function LocaleHomeContent({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  if (!isLocale(locale)) notFound();
  const ne = locale === "ne";
  const t = messages[locale];
  const academicData = await getPublicAcademicData();
  const streams = academicData.status === "ready" ? academicData.streams : [];
  const grades = academicData.status === "ready" ? academicData.grades : [];

  const features = [
    {
      href: `/${locale}#study-path`,
      number: "01",
      title: t.browsePathTitle,
      description: t.browsePathDescription,
    },
    {
      href: `/${locale}/past-papers`,
      number: "02",
      title: t.examPrepTitle,
      description: t.examPrepDescription,
    },
    {
      href: `/${locale}/search`,
      number: "03",
      title: t.searchLibraryTitle,
      description: t.searchLibraryDescription,
    },
  ];

  return (
    <>
      <section className="hero-bg relative overflow-hidden text-white">
        <div aria-hidden="true" className="pointer-events-none absolute -right-32 -top-32 h-96 w-96 rounded-full bg-science/20 blur-3xl" />
        <div className="site-container relative grid gap-10 py-14 sm:py-18 lg:grid-cols-[1.05fr_0.95fr] lg:items-center lg:gap-14 lg:py-20">
          <div>
            <p className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/5 px-4 py-2 text-xs font-bold uppercase tracking-[0.16em] text-blue-100">
              <span aria-hidden="true" className="h-2 w-2 rounded-full bg-emerald-400" />
              {t.homeEyebrow}
            </p>
            <h1 className="mt-6 max-w-2xl text-4xl font-bold leading-tight tracking-tight sm:text-5xl lg:text-6xl">
              {t.homeTitle}
            </h1>
            <p className="mt-5 max-w-xl text-base leading-7 text-slate-300 sm:text-lg">
              {t.homeDescription}
            </p>

            <form method="get" action={`/${locale}/search`} role="search" className="mt-8 flex max-w-xl gap-2 rounded-xl bg-white p-2 shadow-xl">
              <label htmlFor={`home-search-${locale}`} className="sr-only">{t.search}</label>
              <input
                id={`home-search-${locale}`}
                name="q"
                type="search"
                maxLength={100}
                placeholder={t.homeSearchPlaceholder}
                className="min-w-0 flex-1 rounded-lg px-3 text-sm text-brand-dark outline-none placeholder:text-muted"
              />
              <button type="submit" className="shrink-0 rounded-lg bg-science px-4 py-3 text-sm font-bold text-white transition-colors hover:bg-science-dark">
                {t.search}
              </button>
            </form>

            <div className="mt-5 flex flex-wrap gap-x-5 gap-y-2 text-sm font-semibold text-blue-100">
              <Link href={`/${locale}/past-papers`} className="hover:text-white">{t.pastPapers} →</Link>
              <Link href={`/${locale}/model-questions`} className="hover:text-white">{t.modelQuestions} →</Link>
              <Link href={`/${locale}/search`} className="hover:text-white">{t.allResources} →</Link>
            </div>
          </div>

          <div id="study-path" className="rounded-3xl border border-white/15 bg-white p-5 text-brand-dark shadow-2xl sm:p-7">
            <div className="flex items-start justify-between gap-4">
              <div>
                <p className="text-xs font-bold uppercase tracking-[0.16em] text-science">{ne ? "कक्षा ११ र १२" : "Grades 11 & 12"}</p>
                <h2 className="mt-2 text-2xl font-bold tracking-tight">{t.studyPathTitle}</h2>
                <p className="mt-2 text-sm leading-6 text-muted">{t.studyPathHint}</p>
              </div>
              <span aria-hidden="true" className="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-science-bg text-sm font-black text-science">
                11/12
              </span>
            </div>

            {academicData.status === "unconfigured" ? (
              <div className="mt-6"><DatabaseSetupNotice locale={locale} /></div>
            ) : streams.length === 0 ? (
              <p className="mt-6 rounded-xl bg-page-bg p-4 text-sm text-muted">{t.noActiveStreams}</p>
            ) : (
              <div className="mt-6 grid gap-3 sm:grid-cols-2 lg:grid-cols-1">
                {streams.map((stream) => {
                  const streamName = ne ? stream.name_ne || stream.name_en : stream.name_en;
                  const streamClass = stream.slug === "management"
                    ? "bg-management-bg text-management-dark"
                    : "bg-science-bg text-science-dark";

                  return (
                    <article key={stream.id} className="rounded-2xl border border-border p-4">
                      <div className="flex items-center gap-3">
                        <span className={`grid h-10 w-10 place-items-center rounded-xl text-sm font-black ${streamClass}`}>
                          {stream.slug === "management" ? "M" : "S"}
                        </span>
                        <div>
                          <h3 className="font-bold">{streamName}</h3>
                          <p className="mt-0.5 text-xs text-muted">{ne ? stream.description_ne || stream.description_en : stream.description_en}</p>
                        </div>
                      </div>
                      {grades.length === 0 ? (
                        <p className="mt-4 text-sm text-muted">{t.noActiveGrades}</p>
                      ) : (
                        <div className="mt-4 grid grid-cols-2 gap-2">
                          {grades.map((grade) => (
                            <Link
                              key={grade.id}
                              href={`/${locale}/${stream.slug}/grade-${grade.number}`}
                              className="flex items-center justify-between rounded-lg bg-page-bg px-3 py-2.5 text-sm font-semibold text-brand-dark transition-colors hover:bg-science-bg hover:text-science-dark"
                            >
                              {ne ? grade.label_ne || grade.label_en : grade.label_en}
                              <span aria-hidden="true">→</span>
                            </Link>
                          ))}
                        </div>
                      )}
                    </article>
                  );
                })}
              </div>
            )}
          </div>
        </div>
      </section>

      <section className="site-container py-14 sm:py-16">
        <div className="max-w-2xl">
          <p className="text-xs font-bold uppercase tracking-[0.18em] text-science">{t.homeFeaturesEyebrow}</p>
          <h2 className="mt-3 text-3xl font-bold tracking-tight text-brand-dark sm:text-4xl">{t.homeFeaturesTitle}</h2>
        </div>
        <div className="mt-8 grid gap-4 md:grid-cols-3">
          {features.map((feature) => (
            <Link key={feature.number} href={feature.href} className="card-hover rounded-2xl border border-border bg-white p-6">
              <span className="text-xs font-black tracking-widest text-science">{feature.number}</span>
              <h3 className="mt-5 text-lg font-bold text-brand-dark">{feature.title}</h3>
              <p className="mt-2 text-sm leading-6 text-muted">{feature.description}</p>
              <span className="mt-5 inline-flex text-sm font-bold text-science">{ne ? "हेर्नुहोस्" : "Explore"} →</span>
            </Link>
          ))}
        </div>
      </section>

      {academicData.status === "ready" && (
        <section id="recent" className="border-t border-border bg-white py-14 sm:py-16">
          <div className="site-container">
            <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-end">
              <div>
                <p className="text-xs font-bold uppercase tracking-[0.18em] text-science">{t.resources}</p>
                <h2 className="mt-3 text-3xl font-bold tracking-tight text-brand-dark">{t.publishedResources}</h2>
              </div>
              <Link href={`/${locale}/search`} className="text-sm font-bold text-science hover:text-science-dark">{t.allResources} →</Link>
            </div>
            <div className="mt-8">
              <ResourceGrid
                resources={academicData.resources.slice(0, 4)}
                locale={locale}
                academic={academicData}
                emptyMessage={t.noPublishedResources}
              />
            </div>
          </div>
        </section>
      )}
    </>
  );
}
