import type { Locale } from "@/i18n";

export function ContentLoading({ locale }: { locale: Locale }) {
  return (
    <div role="status" aria-live="polite" className="grid min-h-48 place-items-center">
      <p className="text-sm font-semibold text-muted">
        {locale === "ne" ? "लोड हुँदैछ..." : "Loading..."}
      </p>
    </div>
  );
}
