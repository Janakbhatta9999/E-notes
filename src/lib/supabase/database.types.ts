type Table<Row> = {
  Row: Row;
  Insert: Partial<Row>;
  Update: Partial<Row>;
  Relationships: [];
};

type Timestamped = {
  id: string;
  created_at: string;
  updated_at: string;
};

export type StreamRow = Timestamped & {
  name_en: string;
  name_ne: string | null;
  slug: string;
  description_en: string | null;
  description_ne: string | null;
  is_active: boolean;
  sort_order: number;
};

export type GradeRow = Timestamped & {
  number: number;
  label_en: string;
  label_ne: string | null;
  is_active: boolean;
  sort_order: number;
};

export type SubjectRow = Timestamped & {
  stream_id: string;
  grade_id: string;
  curriculum_edition_id: string | null;
  name_en: string;
  name_ne: string | null;
  slug: string;
  description_en: string | null;
  description_ne: string | null;
  is_active: boolean;
  sort_order: number;
};

export type ChapterRow = Timestamped & {
  subject_id: string;
  unit_id: string | null;
  source_id: string | null;
  verification_status: "legacy_unverified" | "pending_verification" | "verified";
  title_en: string;
  title_ne: string | null;
  slug: string;
  chapter_number: number | null;
  description_en: string | null;
  description_ne: string | null;
  is_active: boolean;
  sort_order: number;
};

export type UnitRow = Timestamped & {
  subject_id: string;
  title_en: string;
  title_ne: string | null;
  slug: string;
  unit_number: number | null;
  source_id: string | null;
  verification_status: "pending_verification" | "verified";
  is_active: boolean;
  sort_order: number;
};

export type CurriculumEditionRow = Timestamped & {
  code: string;
  name_en: string;
  name_ne: string | null;
  status: "draft" | "current" | "superseded";
  effective_from: string | null;
  effective_to: string | null;
};

export type CurriculumSourceRow = Timestamped & {
  curriculum_edition_id: string | null;
  subject_id: string | null;
  source_name: string;
  source_url: string;
  verification_status: "pending_verification" | "verified" | "unavailable";
  checked_at: string | null;
  notes: string | null;
};

export type CurriculumReviewItemRow = {
  id: string;
  subject_id: string;
  curriculum_edition_id: string | null;
  source_id: string | null;
  candidate_type: "unit_candidate" | "chapter_candidate" | "topic_group_candidate";
  candidate_number: number;
  candidate_unit_title: string | null;
  title_en: string;
  verification_status: "pending_verification" | "verified" | "rejected";
  verification_note: string;
  created_at: string;
};

export type ResourceRow = Timestamped & {
  title: string;
  slug: string;
  description: string | null;
  language: "en" | "ne";
  resource_type: "notes" | "past_paper" | "model_question" | "practice" | "reference";
  format: "web" | "pdf";
  stream_id: string | null;
  grade_id: string | null;
  subject_id: string | null;
  chapter_id: string | null;
  content: string | null;
  storage_path: string | null;
  external_url: string | null;
  file_size_bytes: number | null;
  exam_year: number | null;
  source_name: string | null;
  source_url: string | null;
  rights_status: "original" | "permission_confirmed" | "public_domain" | "external_link" | "needs_review";
  status: "draft" | "published" | "archived";
  published_at: string | null;
};

export type Database = {
  public: {
    Tables: {
      streams: Table<StreamRow>;
      grades: Table<GradeRow>;
      subjects: Table<SubjectRow>;
      chapters: Table<ChapterRow>;
      curriculum_editions: Table<CurriculumEditionRow>;
      curriculum_sources: Table<CurriculumSourceRow>;
      units: Table<UnitRow>;
      curriculum_review_items: Table<CurriculumReviewItemRow>;
      resources: Table<ResourceRow>;
    };
    Views: Record<string, never>;
    Functions: Record<string, never>;
    Enums: Record<string, never>;
    CompositeTypes: Record<string, never>;
  };
};
