import type { Locale } from "@/i18n";

export function DatabaseSetupNotice({ locale }: { locale: Locale }) {
  const isNepali = locale === "ne";

  return (
    <div role="status" className="rounded-2xl border border-amber-200 bg-amber-50 p-6 text-amber-950">
      <h2 className="font-bold">
        {isNepali ? "डाटाबेस जडान गर्न बाँकी छ" : "Database connection is not configured"}
      </h2>
      <p className="mt-2 text-sm leading-6">
        {isNepali
          ? "Supabase परियोजना बनाएर .env.local मा NEXT_PUBLIC_SUPABASE_URL र NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY राख्नुहोस्।"
          : "Create a Supabase project, apply the migration in supabase/migrations, then set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY in .env.local."}
      </p>
    </div>
  );
}
