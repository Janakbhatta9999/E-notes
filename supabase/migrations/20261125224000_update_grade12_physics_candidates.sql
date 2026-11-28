do $$
declare
  v_subject_id uuid;
  v_existing_count integer;
  v_matching_pending_count integer;
  v_matching_updated_count integer;
  v_old_note constant text := 'User-provided chapter list. The linked official CDC PDF returned HTTP 404; verify each chapter against an accessible official document before promotion.';
  v_new_note constant text := 'Updated user-provided Grade 12 Physics list; chapter titles and sequence remain pending official CDC document verification.';
begin
  select subjects.id
  into v_subject_id
  from public.subjects
  join public.streams on streams.id = subjects.stream_id
  join public.grades on grades.id = subjects.grade_id
  where streams.slug = 'science'
    and grades.number = 12
    and subjects.slug = 'physics'
    and subjects.curriculum_edition_id is null;

  if v_subject_id is null then
    raise exception 'Grade 12 Science Physics subject was not found; no candidates were changed.';
  end if;

  select
    count(*),
    count(*) filter (
      where verification_status = 'pending_verification'
        and verification_note = v_old_note
    ),
    count(*) filter (
      where verification_status = 'pending_verification'
        and verification_note = v_new_note
    )
  into v_existing_count, v_matching_pending_count, v_matching_updated_count
  from public.curriculum_review_items
  where subject_id = v_subject_id
    and candidate_type = 'chapter_candidate';

  if v_existing_count = 25 and v_matching_updated_count = 25 then
    raise notice 'Grade 12 Physics candidates are already updated (25 rows); no candidates were changed.';
    return;
  end if;

  if v_existing_count <> 17 or v_matching_pending_count <> 17 then
    raise exception 'Expected exactly 17 original pending Grade 12 Physics candidates; found % chapter candidates and % matching pending rows. No candidates were changed.',
      v_existing_count, v_matching_pending_count;
  end if;

  delete from public.curriculum_review_items
  where subject_id = v_subject_id
    and candidate_type = 'chapter_candidate'
    and verification_status = 'pending_verification'
    and verification_note = v_old_note;

  insert into public.curriculum_review_items (
    subject_id,
    curriculum_edition_id,
    source_id,
    candidate_type,
    candidate_number,
    candidate_unit_title,
    title_en,
    verification_note
  )
  values
    (v_subject_id, null, null, 'chapter_candidate', 1, 'Mechanics', 'Rotational Dynamics and Oscillatory Motion', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 2, 'Mechanics', 'Periodic Motion', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 3, 'Mechanics', 'Fluid Mechanics', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 4, 'Heat and Thermodynamics', 'First Law of Thermodynamics', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 5, 'Heat and Thermodynamics', 'Second Law of Thermodynamics', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 6, 'Waves and Optics', 'Wave Motion', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 7, 'Waves and Optics', 'Mechanical Wave', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 8, 'Waves and Optics', 'Waves in Pipes and Strings', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 9, 'Waves and Optics', 'Acoustic Phenomenon', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 10, 'Waves and Optics', 'Nature and Propagation of Light', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 11, 'Waves and Optics', 'Interference of Light', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 12, 'Waves and Optics', 'Diffraction', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 13, 'Waves and Optics', 'Polarisation', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 14, 'Electricity and Magnetism', 'Electrical Circuits', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 15, 'Electricity and Magnetism', 'Thermoelectric Effect', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 16, 'Electricity and Magnetism', 'Magnetic Fields', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 17, 'Electricity and Magnetism', 'Magnetic Properties of Materials', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 18, 'Electricity and Magnetism', 'Electromagnetic Induction', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 19, 'Electricity and Magnetism', 'Alternating Current', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 20, 'Modern Physics', 'Electrons', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 21, 'Modern Physics', 'Photons', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 22, 'Modern Physics', 'Semiconductor Devices', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 23, 'Modern Physics', 'Quantization of Energy', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 24, 'Modern Physics', 'Radioactivity and Nuclear Reaction', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 25, 'Modern Physics', 'Recent Trends in Physics', v_new_note);
end
$$;
