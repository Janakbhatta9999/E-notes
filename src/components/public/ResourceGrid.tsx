import { messages, type Locale } from "@/i18n";
import type { ChapterRow, GradeRow, ResourceRow, StreamRow, SubjectRow, UnitRow } from "@/lib/supabase/database.types";
import { ResourceCard } from "@/components/public/ResourceCard";

type ResourceGridProps = {
  resources: ResourceRow[];
  locale: Locale;
  emptyMessage?: string;
  academic: {
    streams: StreamRow[];
    grades: GradeRow[];
    subjects: SubjectRow[];
    chapters: ChapterRow[];
    units: UnitRow[];
  };
};

export function ResourceGrid({ resources, locale, academic, emptyMessage }: ResourceGridProps) {
  const t = messages[locale];

  if (resources.length === 0) {
    return (
      <div className="rounded-2xl border border-dashed border-border bg-white p-10 text-center">
        <p className="font-semibold text-muted">{emptyMessage || t.noResources}</p>
      </div>
    );
  }

  return (
    <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
      {resources.map((resource) => (
        <ResourceCard key={resource.id} resource={resource} locale={locale} academic={academic} />
      ))}
    </div>
  );
}
