do $$
declare
  v_subject_id uuid;
  v_existing_count integer;
  v_matching_pending_count integer;
  v_matching_updated_count integer;
  v_old_note constant text := 'User-provided chapter list. The linked official CDC PDF returned HTTP 404; verify each chapter against an accessible official document before promotion.';
  v_new_note constant text := 'Updated user-provided Grade 11 Physics list; chapter titles and sequence remain pending official CDC document verification.';
begin
  select subjects.id
  into v_subject_id
  from public.subjects
  join public.streams on streams.id = subjects.stream_id
  join public.grades on grades.id = subjects.grade_id
  where streams.slug = 'science'
    and grades.number = 11
    and subjects.slug = 'physics'
    and subjects.curriculum_edition_id is null;

  if v_subject_id is null then
    raise exception 'Grade 11 Science Physics subject was not found; no candidates were changed.';
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

  if v_existing_count = 26 and v_matching_updated_count = 26 then
    raise notice 'Grade 11 Physics candidates are already updated (26 rows); no candidates were changed.';
    return;
  end if;

  if v_existing_count <> 23 or v_matching_pending_count <> 23 then
    raise exception 'Expected exactly 23 original pending Grade 11 Physics candidates; found % chapter candidates and % matching pending rows. No candidates were changed.',
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
    (v_subject_id, null, null, 'chapter_candidate', 1, 'Mechanics', 'Physical Quantities', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 2, 'Mechanics', 'Vectors', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 3, 'Mechanics', 'Kinematics', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 4, 'Mechanics', 'Dynamics', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 5, 'Mechanics', 'Work, Energy and Power', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 6, 'Mechanics', 'Circular Motion', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 7, 'Mechanics', 'Gravitation', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 8, 'Mechanics', 'Elasticity', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 9, 'Heat and Thermodynamics', 'Heat and Temperature', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 10, 'Heat and Thermodynamics', 'Thermal Expansion', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 11, 'Heat and Thermodynamics', 'Quantity of Heat', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 12, 'Heat and Thermodynamics', 'Rate of Heat Flow', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 13, 'Heat and Thermodynamics', 'Ideal Gas', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 14, 'Waves and Optics', 'Reflection at Curved Mirror', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 15, 'Waves and Optics', 'Refraction at Plane Surfaces', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 16, 'Waves and Optics', 'Refraction Through Prisms', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 17, 'Waves and Optics', 'Lens', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 18, 'Waves and Optics', 'Dispersion', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 19, 'Electricity and Magnetism', 'Electric Charges', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 20, 'Electricity and Magnetism', 'Electric Field', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 21, 'Electricity and Magnetism', 'Electric Potential, Potential Difference and Potential Energy', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 22, 'Electricity and Magnetism', 'Capacitors', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 23, 'Electricity and Magnetism', 'D.C. Circuits', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 24, 'Modern Physics', 'Nuclear Physics', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 25, 'Modern Physics', 'Energy Levels', v_new_note),
    (v_subject_id, null, null, 'chapter_candidate', 26, 'Modern Physics', 'Solids', v_new_note);
end
$$;
