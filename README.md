# eNotes Nepal

Mobile-friendly, bilingual study resource website for NEB Grade 11 and 12.

- Product requirements: [`docs/eNotes_Nepal_PRD.md`](./docs/eNotes_Nepal_PRD.md)
- Technical plan: [`docs/eNotes_Nepal_TADP.md`](./docs/eNotes_Nepal_TADP.md)

## Run locally

```powershell
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

## Connect Supabase

1. Create a Supabase project.
2. In the Supabase SQL Editor, run the migration files in `supabase/migrations` in filename order.
   They create the academic and curriculum tables, read-only public Row Level Security policies, the published-resources storage bucket, and initial Science, Management, Grade 11, and Grade 12 records.
3. Copy `.env.example` to `.env.local` and set `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` from the Supabase project settings. Legacy anon keys are also accepted, but new projects should use a publishable key.
4. Restart the Next.js development server.

The public app uses only the Supabase publishable key, with RLS enabled. Never use a secret key in public code or commit `.env.local`. The curriculum migration adds the 16 Grade 11–12 subjects and stores the supplied topics as private pending-review candidates; it does not publish unverified units or chapters. See the [curriculum seed-data report](./docs/curriculum-seed-report.md) for counts, source limitations, and a query to report the live database state.

If Supabase is not configured, public pages show a setup notice instead of silently substituting sample data. Database query failures are surfaced through the app error state.

## Checks

```powershell
npm run lint
npm run build
```
