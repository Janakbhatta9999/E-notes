import Link from "next/link";
import type { ChapterRow, GradeRow, ResourceRow, StreamRow, SubjectRow, UnitRow } from "@/lib/supabase/database.types";
import { messages, type Locale } from "@/i18n";

type ResourceCardProps = {
  resource: ResourceRow;
  locale: Locale;
  academic: {
    streams: StreamRow[];
    grades: GradeRow[];
    subjects: SubjectRow[];
    chapters: ChapterRow[];
    units: UnitRow[];
  };
};

const resourceTypeLabels = {
  en: {
    notes: "Notes",
    past_paper: "Past paper",
    model_question: "Model question",
    practice: "Practice",
    reference: "Reference",
  },
  ne: {
    notes: "नोट",
    past_paper: "पुरानो प्रश्नपत्र",
    model_question: "मोडेल प्रश्न",
    practice: "अभ्यास",
    reference: "सन्दर्भ",
  },
} as const;

export function ResourceCard({ resource, locale, academic }: ResourceCardProps) {
  const t = messages[locale];
  const stream = academic.streams.find((item) => item.id === resource.stream_id);
  const grade = academic.grades.find((item) => item.id === resource.grade_id);
  const subject = academic.subjects.find((item) => item.id === resource.subject_id);
  const chapter = academic.chapters.find((item) => item.id === resource.chapter_id);
  const unit = academic.units.find((item) => item.id === chapter?.unit_id);
  const updatedDate = resource.updated_at.slice(0, 10);

  return (
    <article className="card-hover rounded-2xl border border-border bg-white p-5">
      <div className="flex items-start justify-between gap-3">
        <span className="rounded-full bg-science-bg px-3 py-1 text-xs font-bold text-science-dark">
          {resourceTypeLabels[locale][resource.resource_type]}
        </span>
        <span className="shrink-0 text-xs text-light">{resource.format.toUpperCase()}</span>
      </div>
      <p className="mt-4 text-xs font-semibold text-muted">
        {locale === "ne" ? (stream?.name_ne || stream?.name_en) : stream?.name_en}
        {grade ? ` · ${locale === "ne" ? grade.label_ne || grade.label_en : grade.label_en}` : ""}
        {subject ? ` · ${locale === "ne" ? subject.name_ne || subject.name_en : subject.name_en}` : ""}
      </p>
      <h2 className="mt-3 text-lg font-bold leading-snug text-brand-dark">{resource.title}</h2>
      {unit && (
        <p className="mt-2 text-xs text-muted">
          {locale === "ne" ? unit.title_ne || unit.title_en : unit.title_en}
        </p>
      )}
      {chapter && (
        <p className="mt-1 text-sm text-muted">
          {locale === "ne" ? chapter.title_ne || chapter.title_en : chapter.title_en}
        </p>
      )}
      {resource.description && <p className="mt-2 line-clamp-3 text-sm leading-6 text-muted">{resource.description}</p>}
      <div className="mt-5 flex items-center justify-between border-t border-border pt-4 text-xs font-semibold">
        <span className="text-muted">
          {locale === "ne" ? (resource.language === "ne" ? "नेपाली" : "अंग्रेजी") : (resource.language === "ne" ? "Nepali" : "English")}
          {resource.exam_year ? ` · ${resource.exam_year}` : ""}
          {` · ${t.updated} ${updatedDate}`}
        </span>
        <Link href={`/${locale}/resources/${resource.slug}`} className="text-science hover:text-science-dark">
          {t.readResource} →
        </Link>
      </div>
    </article>
  );
}
