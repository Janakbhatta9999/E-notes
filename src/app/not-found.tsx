import Link from "next/link";

export default function NotFound() {
  return (
    <div className="grid min-h-[70vh] place-items-center bg-page-bg px-4">
      <div className="max-w-md text-center">
        <p className="text-sm font-bold uppercase tracking-widest text-science">404</p>
        <h1 className="mt-3 text-3xl font-bold text-brand-dark">Page not found</h1>
        <p className="mt-3 text-muted">The page or resource you requested does not exist.</p>
        <Link href="/" className="mt-6 inline-flex rounded-lg bg-science px-5 py-3 text-sm font-bold text-white">Return home</Link>
      </div>
    </div>
  );
}
