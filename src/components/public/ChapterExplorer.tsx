"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import { messages, type Locale } from "@/i18n";

export type ChapterExplorerItem = {
  id: string;
  slug: string;
  chapterNumber: number | null;
  titleEn: string;
  titleNe: string | null;
  descriptionEn: string | null;
  descriptionNe: string | null;
  unitId: string | null;
  unitNumber: number | null;
  unitTitleEn: string | null;
  unitTitleNe: string | null;
  resourceCount: number;
};

type ChapterExplorerProps = {
  chapters: ChapterExplorerItem[];
  locale: Locale;
  hrefPrefix: string;
};

export function ChapterExplorer({ chapters, locale, hrefPrefix }: ChapterExplorerProps) {
  const [query, setQuery] = useState("");
  const t = messages[locale];
  const filteredChapters = useMemo(() => {
    const searchTerm = query.trim().toLowerCase();
    if (!searchTerm) return chapters;

    return chapters.filter((chapter) => [
      chapter.titleEn,
      chapter.titleNe,
      chapter.descriptionEn,
      chapter.descriptionNe,
      chapter.chapterNumber?.toString(),
      chapter.unitTitleEn,
      chapter.unitTitleNe,
    ].some((value) => value?.toLowerCase().includes(searchTerm)));
  }, [chapters, query]);

  const groups = useMemo(() => {
    const grouped = new Map<string, { id: string; title: string; chapters: ChapterExplorerItem[] }>();

    filteredChapters.forEach((chapter) => {
      const id = chapter.unitId ?? "ungrouped";
      const unitTitle = locale === "ne"
        ? chapter.unitTitleNe || chapter.unitTitleEn || t.otherChapters
        : chapter.unitTitleEn || t.otherChapters;
      const title = chapter.unitNumber
        ? `${locale === "ne" ? "एकाइ" : "Unit"} ${chapter.unitNumber}: ${unitTitle}`
        : unitTitle;
      const group = grouped.get(id) ?? { id, title, chapters: [] };
      group.chapters.push(chapter);
      grouped.set(id, group);
    });

    return Array.from(grouped.values());
  }, [filteredChapters, locale, t.otherChapters]);

  return (
    <div>
      <label htmlFor="chapter-search" className="mb-2 block text-sm font-semibold text-brand-dark">
        {t.findChapter}
      </label>
      <input
        id="chapter-search"
        type="search"
        value={query}
        onChange={(event) => setQuery(event.target.value)}
        placeholder={t.chapterSearchPlaceholder}
        className="w-full rounded-xl border border-border bg-white px-4 py-3 text-sm text-brand-dark shadow-sm placeholder:text-light focus:border-science focus:outline-none focus:ring-2 focus:ring-science/20"
      />
      <p className="mt-3 text-sm text-muted" aria-live="polite">
        {filteredChapters.length} / {chapters.length} {t.chapterCountLabel}
      </p>

      {groups.length === 0 ? (
        <p role="status" className="mt-5 rounded-xl border border-dashed border-border bg-white p-5 text-sm text-muted">
          {t.noChapterMatches}
        </p>
      ) : (
        <div className="mt-5 space-y-4">
          {groups.map((group, index) => (
            <details key={group.id} open={query.trim().length > 0 || index === 0} className="group rounded-2xl border border-border bg-white">
              <summary className="flex cursor-pointer list-none items-center justify-between gap-4 p-5 font-bold text-brand-dark [&::-webkit-details-marker]:hidden">
                <span>{group.title}</span>
                <span className="flex shrink-0 items-center gap-3 text-sm font-semibold text-muted">
                  {group.chapters.length}
                  <span aria-hidden="true" className="transition-transform group-open:rotate-180">⌄</span>
                </span>
              </summary>
              <ol className="grid gap-3 border-t border-border p-4 sm:grid-cols-2">
                {group.chapters.map((chapter) => (
                  <li key={chapter.id}>
                    <Link
                      href={`${hrefPrefix}/${chapter.slug}`}
                      className="card-hover flex h-full items-start justify-between gap-3 rounded-xl border border-border p-4 hover:border-science/40"
                    >
                      <span>
                        <span className="block text-xs font-bold uppercase tracking-wide text-science">
                          {chapter.chapterNumber ? `${locale === "ne" ? "अध्याय" : "Chapter"} ${chapter.chapterNumber}` : t.otherChapters}
                        </span>
                        <span className="mt-1 block font-semibold text-brand-dark">
                          {locale === "ne" ? chapter.titleNe || chapter.titleEn : chapter.titleEn}
                        </span>
                        {(locale === "ne" ? chapter.descriptionNe || chapter.descriptionEn : chapter.descriptionEn) && (
                          <span className="mt-2 block text-sm leading-5 text-muted">
                            {locale === "ne" ? chapter.descriptionNe || chapter.descriptionEn : chapter.descriptionEn}
                          </span>
                        )}
                        {chapter.resourceCount > 0 && (
                          <span className="mt-2 block text-xs text-muted">
                            {chapter.resourceCount} {t.resourcesCountLabel}
                          </span>
                        )}
                      </span>
                      <span className="sr-only">{t.openChapter}</span>
                      <span aria-hidden="true" className="mt-1 shrink-0 font-bold text-science">→</span>
                    </Link>
                  </li>
                ))}
              </ol>
            </details>
          ))}
        </div>
      )}
    </div>
  );
}
