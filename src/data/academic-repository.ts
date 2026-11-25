import { connection } from "next/server";
import { createPublicSupabaseClient } from "@/lib/supabase/server";
import type { ChapterRow, GradeRow, ResourceRow, StreamRow, SubjectRow, UnitRow } from "@/lib/supabase/database.types";

export type AcademicDataResult =
  | { status: "unconfigured" }
  | {
      status: "ready";
      streams: StreamRow[];
      grades: GradeRow[];
      subjects: SubjectRow[];
      chapters: ChapterRow[];
      units: UnitRow[];
      resources: ResourceRow[];
      curriculumSchemaAvailable: boolean;
    };

export async function getPublicAcademicData(): Promise<AcademicDataResult> {
  await connection();
  const supabase = createPublicSupabaseClient();
  if (!supabase) {
    return { status: "unconfigured" };
  }

  const [streamsResult, gradesResult, subjectsResult, chaptersResult, unitsResult, resourcesResult] = await Promise.all([
    supabase.from("streams").select("*").eq("is_active", true).order("sort_order"),
    supabase.from("grades").select("*").eq("is_active", true).order("sort_order"),
    supabase.from("subjects").select("*").eq("is_active", true).order("sort_order"),
    supabase.from("chapters").select("*").eq("is_active", true).order("sort_order"),
    supabase.from("units").select("*").eq("is_active", true).eq("verification_status", "verified").order("sort_order"),
    supabase.from("resources").select("*").eq("status", "published").order("published_at", { ascending: false }),
  ]);

  if (streamsResult.error) {
    throw new Error(`Could not load streams from Supabase: ${streamsResult.error.message}`);
  }
  if (gradesResult.error) {
    throw new Error(`Could not load grades from Supabase: ${gradesResult.error.message}`);
  }
  if (subjectsResult.error) {
    throw new Error(`Could not load subjects from Supabase: ${subjectsResult.error.message}`);
  }
  if (chaptersResult.error) {
    throw new Error(`Could not load chapters from Supabase: ${chaptersResult.error.message}`);
  }
  if (unitsResult.error && unitsResult.error.code !== "PGRST205") {
    throw new Error(`Could not load verified units from Supabase: ${unitsResult.error.message}`);
  }
  if (resourcesResult.error) {
    throw new Error(`Could not load published resources from Supabase: ${resourcesResult.error.message}`);
  }

  const curriculumSchemaAvailable = unitsResult.error === null;
  return {
    status: "ready",
    streams: streamsResult.data,
    grades: gradesResult.data,
    subjects: subjectsResult.data,
    chapters: curriculumSchemaAvailable
      ? chaptersResult.data
      : chaptersResult.data.map((chapter) => ({
          ...chapter,
          unit_id: null,
          source_id: null,
          verification_status: "legacy_unverified" as const,
        })),
    units: curriculumSchemaAvailable ? unitsResult.data : [],
    resources: resourcesResult.data,
    curriculumSchemaAvailable,
  };
}
