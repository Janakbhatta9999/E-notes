"use client";

export default function ErrorPage({
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div className="grid min-h-[70vh] place-items-center bg-page-bg px-4">
      <div className="max-w-md text-center">
        <h1 className="text-3xl font-bold text-brand-dark">Something went wrong</h1>
        <p className="mt-3 text-muted">We could not load this page. Please try again.</p>
        <button type="button" onClick={reset} className="mt-6 rounded-lg bg-science px-5 py-3 text-sm font-bold text-white">Try again</button>
      </div>
    </div>
  );
}
