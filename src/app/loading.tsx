export default function Loading() {
  return (
    <div className="grid min-h-[60vh] place-items-center bg-page-bg">
      <div className="text-center">
        <div className="mx-auto h-10 w-10 animate-spin rounded-full border-4 border-border border-t-science" />
        <p className="mt-4 text-sm font-semibold text-muted">Loading resources...</p>
      </div>
    </div>
  );
}
