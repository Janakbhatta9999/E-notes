insert into storage.buckets (id, name, public)
values ('published-resources', 'published-resources', true)
on conflict (id) do update set public = excluded.public;

create policy "Public can read published resource files"
  on storage.objects for select to anon, authenticated
  using (bucket_id = 'published-resources');
