with requested_subjects (stream_slug, grade_number, name_en, slug, sort_order) as (
  values
    ('science', 11, 'Physics', 'physics', 1),
    ('science', 11, 'Chemistry', 'chemistry', 2),
    ('science', 11, 'Biology', 'biology', 3),
    ('science', 11, 'Mathematics', 'mathematics', 4),
    ('science', 12, 'Physics', 'physics', 1),
    ('science', 12, 'Chemistry', 'chemistry', 2),
    ('science', 12, 'Biology', 'biology', 3),
    ('science', 12, 'Mathematics', 'mathematics', 4),
    ('management', 11, 'Accountancy', 'accountancy', 1),
    ('management', 11, 'Economics', 'economics', 2),
    ('management', 11, 'Business Studies', 'business-studies', 3),
    ('management', 11, 'Business Mathematics', 'business-mathematics', 4),
    ('management', 12, 'Accountancy', 'accountancy', 1),
    ('management', 12, 'Economics', 'economics', 2),
    ('management', 12, 'Business Studies', 'business-studies', 3),
    ('management', 12, 'Business Mathematics', 'business-mathematics', 4)
)
insert into public.subjects (stream_id, grade_id, name_en, slug, sort_order)
select streams.id, grades.id, requested.name_en, requested.slug, requested.sort_order
from requested_subjects requested
join public.streams streams on streams.slug = requested.stream_slug
join public.grades grades on grades.number = requested.grade_number
where not exists (
  select 1
  from public.subjects existing
  where existing.stream_id = streams.id
    and existing.grade_id = grades.id
    and existing.slug = requested.slug
);

insert into public.curriculum_sources (
  source_name,
  source_url,
  verification_status,
  checked_at,
  notes
)
values (
  'CDC Physics curriculum link supplied by the user',
  'https://moecdc.gov.np/storage/gallery/1674713349.pdf',
  'unavailable',
  '2026-11-25 00:00:00+05:45',
  'Checked 2026-11-25: the supplied official URL returned HTTP 404. CDC notice https://moecdc.gov.np/content/707/regarding-the-blocking-of-downloading-and-uploading/ reports download problems caused by full server storage. Physics candidates remain pending until an accessible official document is checked.'
)
on conflict (source_url) do nothing;

with seed_groups as (
  select *
  from jsonb_to_recordset(
    $curriculum_seed$
    [
      {
        "stream_slug": "science",
        "grade_number": 11,
        "subject_slug": "physics",
        "candidate_type": "chapter_candidate",
        "verification_note": "User-provided chapter list. The linked official CDC PDF returned HTTP 404; verify each chapter against an accessible official document before promotion.",
        "source_url": "https://moecdc.gov.np/storage/gallery/1674713349.pdf",
        "items": [
          {"title": "Physical Quantities", "unit": "Mechanics"},
          {"title": "Vectors", "unit": "Mechanics"},
          {"title": "Kinematics", "unit": "Mechanics"},
          {"title": "Dynamics", "unit": "Mechanics"},
          {"title": "Work, Energy and Power", "unit": "Mechanics"},
          {"title": "Circular Motion", "unit": "Mechanics"},
          {"title": "Gravitation", "unit": "Mechanics"},
          {"title": "Elasticity", "unit": "Mechanics"},
          {"title": "Heat and Temperature", "unit": "Heat & Thermodynamics"},
          {"title": "Thermal Expansion", "unit": "Heat & Thermodynamics"},
          {"title": "Quantity of Heat", "unit": "Heat & Thermodynamics"},
          {"title": "Rate of Heat Flow", "unit": "Heat & Thermodynamics"},
          {"title": "Reflection at Curved Mirrors", "unit": "Waves & Optics"},
          {"title": "Refraction at Plane Surfaces", "unit": "Waves & Optics"},
          {"title": "Refraction through Prisms", "unit": "Waves & Optics"},
          {"title": "Lenses", "unit": "Waves & Optics"},
          {"title": "Dispersion", "unit": "Waves & Optics"},
          {"title": "Electric Charges", "unit": "Electricity & Magnetism"},
          {"title": "Electric Field", "unit": "Electricity & Magnetism"},
          {"title": "Electric Potential", "unit": "Electricity & Magnetism"},
          {"title": "Capacitors", "unit": "Electricity & Magnetism"},
          {"title": "DC Circuits", "unit": "Electricity & Magnetism"},
          {"title": "Nuclear Physics", "unit": "Modern Physics"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 12,
        "subject_slug": "physics",
        "candidate_type": "chapter_candidate",
        "verification_note": "User-provided chapter list. The linked official CDC PDF returned HTTP 404; verify each chapter against an accessible official document before promotion.",
        "source_url": "https://moecdc.gov.np/storage/gallery/1674713349.pdf",
        "items": [
          {"title": "Rotational Dynamics", "unit": "Mechanics"},
          {"title": "Periodic Motion", "unit": "Mechanics"},
          {"title": "Fluid Statics", "unit": "Mechanics"},
          {"title": "First Law of Thermodynamics", "unit": "Thermodynamics"},
          {"title": "Wave Motion", "unit": "Waves & Optics"},
          {"title": "Mechanical Waves", "unit": "Waves & Optics"},
          {"title": "Waves in Pipes and Strings", "unit": "Waves & Optics"},
          {"title": "Acoustic Phenomena", "unit": "Waves & Optics"},
          {"title": "Wave Nature of Light", "unit": "Waves & Optics"},
          {"title": "Electrical Circuits", "unit": "Electricity & Magnetism"},
          {"title": "Magnetic Properties of Materials", "unit": "Electricity & Magnetism"},
          {"title": "Magnetic Field", "unit": "Electricity & Magnetism"},
          {"title": "Alternating Currents", "unit": "Electricity & Magnetism"},
          {"title": "Electrons", "unit": "Modern Physics"},
          {"title": "Photons", "unit": "Modern Physics"},
          {"title": "Semiconductor Devices", "unit": "Modern Physics"},
          {"title": "Quantization of Energy", "unit": "Modern Physics"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 11,
        "subject_slug": "chemistry",
        "candidate_type": "unit_candidate",
        "verification_note": "User describes these as condensed unit headings and asks for detailed CDC subdivisions before import. Keep pending; do not expose as verified units or chapters.",
        "source_url": null,
        "items": [
          {"title": "Foundation and Fundamentals"},
          {"title": "Stoichiometry"},
          {"title": "Atomic Structure"},
          {"title": "Classification of Elements and Periodic Table"},
          {"title": "Chemical Bonding and Shapes of Molecules"},
          {"title": "Oxidation and Reduction"},
          {"title": "States of Matter"},
          {"title": "Chemistry of Non-metals"},
          {"title": "Chemistry of Metals"},
          {"title": "Basic Concepts of Organic Chemistry"},
          {"title": "Fundamental Principles of Organic Chemistry"},
          {"title": "Hydrocarbons and aromatic compounds"},
          {"title": "Modern Chemical Manufactures"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 12,
        "subject_slug": "chemistry",
        "candidate_type": "unit_candidate",
        "verification_note": "User describes these as condensed unit headings and asks for detailed CDC subdivisions before import. Keep pending; do not expose as verified units or chapters.",
        "source_url": null,
        "items": [
          {"title": "Volumetric Analysis"},
          {"title": "Ionic Equilibrium"},
          {"title": "Chemical Kinetics"},
          {"title": "Thermodynamics"},
          {"title": "Electrochemistry"},
          {"title": "Chemistry of Metals"},
          {"title": "Studies of Heavy Metals"},
          {"title": "Haloalkanes and related organic compounds"},
          {"title": "Organic Chemistry"},
          {"title": "Chemistry in the Service of Mankind"},
          {"title": "Nuclear Chemistry and Applications of Radioactivity"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 11,
        "subject_slug": "biology",
        "candidate_type": "topic_group_candidate",
        "verification_note": "User-provided topic list; confirm whether these are units or chapters and verify the official CDC sequence before promotion.",
        "source_url": null,
        "items": [
          {"title": "Introduction to Biology"},
          {"title": "Floral Diversity"},
          {"title": "Faunal Diversity"},
          {"title": "Introduction to Microbiology"},
          {"title": "Vegetation"},
          {"title": "Biota and Environment"},
          {"title": "Ecology"},
          {"title": "Conservation Biology"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 12,
        "subject_slug": "biology",
        "candidate_type": "topic_group_candidate",
        "verification_note": "User-provided topic list; confirm whether these are units or chapters and verify the official CDC sequence before promotion.",
        "source_url": null,
        "items": [
          {"title": "Plant Anatomy"},
          {"title": "Animal Tissues"},
          {"title": "Plant Physiology"},
          {"title": "Genetics"},
          {"title": "Human Biology"},
          {"title": "Applied Biology"},
          {"title": "Biotechnology"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 11,
        "subject_slug": "mathematics",
        "candidate_type": "topic_group_candidate",
        "verification_note": "User-provided broad topic groups; exact CDC unit and chapter subdivisions are not verified.",
        "source_url": null,
        "items": [
          {"title": "Algebra"},
          {"title": "Trigonometry"},
          {"title": "Analytic Geometry"},
          {"title": "Vectors"},
          {"title": "Statistics and Probability"},
          {"title": "Calculus"}
        ]
      },
      {
        "stream_slug": "science",
        "grade_number": 12,
        "subject_slug": "mathematics",
        "candidate_type": "topic_group_candidate",
        "verification_note": "User-provided broad topic groups; exact CDC unit and chapter subdivisions are not verified.",
        "source_url": null,
        "items": [
          {"title": "Algebra"},
          {"title": "Trigonometry"},
          {"title": "Analytic Geometry"},
          {"title": "Vectors"},
          {"title": "Statistics and Probability"},
          {"title": "Calculus"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 11,
        "subject_slug": "business-studies",
        "candidate_type": "chapter_candidate",
        "verification_note": "User-provided chapter list; verify the official CDC edition and chapter sequence before promotion.",
        "source_url": null,
        "items": [
          {"title": "Introduction to Business"},
          {"title": "Business Idea"},
          {"title": "Resource Mobilization"},
          {"title": "Forms of Business Ownership"},
          {"title": "Business Ethics and Social Responsibility"},
          {"title": "Risk and Insurance"},
          {"title": "Taxation"},
          {"title": "Office Management"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 12,
        "subject_slug": "business-studies",
        "candidate_type": "chapter_candidate",
        "verification_note": "User-provided chapter list; verify the official CDC edition and chapter sequence before promotion.",
        "source_url": null,
        "items": [
          {"title": "Nature of Management"},
          {"title": "Classical Management Perspective"},
          {"title": "Planning and Decision Making"},
          {"title": "Organizing"},
          {"title": "Leading"},
          {"title": "Controlling"},
          {"title": "Other Management Functions"},
          {"title": "Contemporary Issues on Management"},
          {"title": "Business Letter Writing"},
          {"title": "Business Plan"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 11,
        "subject_slug": "accountancy",
        "candidate_type": "chapter_candidate",
        "verification_note": "Explicitly marked by the user as suggested catalogue areas subject to CDC textbook verification. Keep pending.",
        "source_url": null,
        "items": [
          {"title": "Introduction to Accounting"},
          {"title": "Basic Accounting Procedures"},
          {"title": "Journal and Ledger"},
          {"title": "Trial Balance"},
          {"title": "Bank Reconciliation"},
          {"title": "Depreciation Accounting"},
          {"title": "Financial Statements"},
          {"title": "Government Accounting"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 12,
        "subject_slug": "accountancy",
        "candidate_type": "chapter_candidate",
        "verification_note": "Explicitly marked by the user as suggested catalogue areas subject to CDC textbook verification. Keep pending.",
        "source_url": null,
        "items": [
          {"title": "Company Accounting"},
          {"title": "Partnership Accounting"},
          {"title": "Cost Accounting"},
          {"title": "Cash Flow Statement"},
          {"title": "Financial Statement Analysis"},
          {"title": "Budgeting and Management Accounting"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 11,
        "subject_slug": "economics",
        "candidate_type": "chapter_candidate",
        "verification_note": "Explicitly marked by the user as preliminary topic areas; verify curriculum edition and chapter sequence before promotion.",
        "source_url": null,
        "items": [
          {"title": "Introduction to Economics"},
          {"title": "Basic Economic Concepts"},
          {"title": "Demand and Supply"},
          {"title": "Elasticity"},
          {"title": "Theory of Consumer Behaviour"},
          {"title": "Theory of Production"},
          {"title": "Cost and Revenue"},
          {"title": "Market Structures"},
          {"title": "Basic Statistics"},
          {"title": "Nepalese Economy and Development"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 12,
        "subject_slug": "economics",
        "candidate_type": "chapter_candidate",
        "verification_note": "Explicitly marked by the user as preliminary topic areas; verify curriculum edition and chapter sequence before promotion.",
        "source_url": null,
        "items": [
          {"title": "National Income"},
          {"title": "Money and Banking"},
          {"title": "Government Finance"},
          {"title": "International Trade"},
          {"title": "Economic Growth and Development"},
          {"title": "Poverty and Unemployment"},
          {"title": "Inflation"},
          {"title": "Nepalese Economic Development"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 11,
        "subject_slug": "business-mathematics",
        "candidate_type": "topic_group_candidate",
        "verification_note": "User-provided topic groups; exact CDC unit and chapter sequence are not verified.",
        "source_url": null,
        "items": [
          {"title": "Algebra"},
          {"title": "Functions"},
          {"title": "Linear and Quadratic Equations"},
          {"title": "Exponential and Logarithmic Functions"},
          {"title": "Mathematics for Economics and Finance"}
        ]
      },
      {
        "stream_slug": "management",
        "grade_number": 12,
        "subject_slug": "business-mathematics",
        "candidate_type": "topic_group_candidate",
        "verification_note": "User-provided topic groups; exact CDC unit and chapter sequence are not verified.",
        "source_url": null,
        "items": [
          {"title": "Matrices"},
          {"title": "Determinants"},
          {"title": "Systems of Linear Equations"},
          {"title": "Input-Output Analysis"},
          {"title": "Mathematical Models in Economics"}
        ]
      }
    ]
    $curriculum_seed$::jsonb
  ) as seed (
    stream_slug text,
    grade_number integer,
    subject_slug text,
    candidate_type text,
    verification_note text,
    source_url text,
    items jsonb
  )
),
candidate_rows as (
  select
    subjects.id as subject_id,
    null::uuid as curriculum_edition_id,
    sources.id as source_id,
    seed.candidate_type,
    item.ordinality::integer as candidate_number,
    item.value ->> 'unit' as candidate_unit_title,
    item.value ->> 'title' as title_en,
    seed.verification_note
  from seed_groups seed
  cross join lateral jsonb_array_elements(seed.items) with ordinality as item(value, ordinality)
  join public.streams on streams.slug = seed.stream_slug
  join public.grades on grades.number = seed.grade_number
  join public.subjects on subjects.stream_id = streams.id
    and subjects.grade_id = grades.id
    and subjects.slug = seed.subject_slug
    and subjects.curriculum_edition_id is null
  left join public.curriculum_sources sources on sources.source_url = seed.source_url
)
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
select
  subject_id,
  curriculum_edition_id,
  source_id,
  candidate_type,
  candidate_number,
  candidate_unit_title,
  title_en,
  verification_note
from candidate_rows
on conflict do nothing;
