do $$
declare
  v_seed constant jsonb := $seed$
[
  {"grade":11,"number":1,"unit":"Biomolecules and cell biology","topics":["1.1 Biomolecules: Introduction and functions of: carbohydrates, proteins, lipids, nucleic acids, minerals, enzymes and water.","1.2 Cell: Introduction of cell, concepts of prokaryotic and eukaryotic cells, detail structure of eukaryotic cells (composition, structure and functions of cell wall, cell membrane, mitochondria, plastids, endoplasmic reticulum, golgi bodies, lysosomes, ribosomes, nucleus, chromosomes, cilia, flagella and cell inclusions.","1.3 Cell division : Concept of cell cycle, types of cell division (amitosis, mitosis and meiosis) and significances"]},
  {"grade":11,"number":2,"unit":"Floral diversity","topics":["2.1 Introduction: Three domains of life, binomial nomenclature, five kingdom classification system (Monera, Protista, Fungi, Plantae and Animalia); status of flora in Nepal and world representation","2.2 Fungi: General introduction and characteristic features of phycomycetes, ascomycetes, basidiomycetes and deuteromycetes; structure and Reproduction of Mucor and Yeast, introduction of Mushrooms, poisonous and non-poisonous mushrooms, economic importance of fungi.","2.3 Lichen: General introduction, characteristic features and economic importance of lichen","2.4 Algae: General introduction and characteristic feature of green, brown and red algae; structure and reproduction of Spirogyra. Economic importance of algae","2.5 Bryophyta: General introduction and characteristic features of liverworts, hornworts and moss; morphological structure and reproduction of Marchantia. Economic importance of bryophytes","2.6 Pteridophyta: General introduction and characteristic features of pteridophytes; morphological structure and reproduction of Dryopteris. Economic importance of pteridophytes","2.7 Gymnosperm: General introduction and characteristic features of Gymnosperms; morphology and reproduction of Pinus. Economic importance of gymnosperm","2.8 Angiosperm: Morphology (root, stem, leaves, inflorescences, flowers and fruit); Taxonomic study: Definition, taxonomic hierarchy, classification systems (artificial, natural and phylogenetic) of angiosperms, taxonomic description of the families – Brassicaceae, Fabaceae, Solanaceae, and Liliaceae with economic importance"]},
  {"grade":11,"number":3,"unit":"Introductory microbiology","topics":["3.1 Monera: General introduction, structure of bacterial cell, mode of nutrition, bacterial growth; cyanobacteria (blue green algae).","3.2 Virus: General introduction, structure and importance of virus, bacteriophage","3.3 Impacts of biotechnology in the field of microbiology."]},
  {"grade":11,"number":4,"unit":"Ecology","topics":["4.1 Ecosystem ecology: Concept of ecology, biotic and abiotic factors, species interactions; concept of ecosystem, structural and functional aspects of pond and forest ecosystem, food chain, food web, trophic level, ecological pyramids, productivity, biogeochemical cycle - carbon and nitrogen cycles, concept of succession.","4.2 Ecological Adaptation: Concept of adaptation, hydrophytes and xerophytes.","4.3 Ecological Imbalances: Green house effects and climate change, depletion of ozone layer, acid rain and biological invasion."]},
  {"grade":11,"number":5,"unit":"Vegetation","topics":["a. Vegetation: Introduction, types of vegetation in Nepal, concept of In-situ (protected areas) and Ex-situ (botanical garden, seed bank) conservation.","Natural environment-vegetation and human activities"]},
  {"grade":11,"number":6,"unit":"Introduction to biology","topics":["6.1 Introduction to Biology: Scope and fields of biology. Relation with other science."]},
  {"grade":11,"number":7,"unit":"Evolutionary biology","topics":["7.1 Life and its Origin: Oparin-Haldane theory, Miller and Urey's experiment.","7.2 Evidences of evolution: Morphological, Anatomical, Paleontological, Embryological and Biochemical.","7.3 Theories of evolution: Lamarckism, Darwinism & concept of Neo Darwinism.","7.4 Human evolution: Position of man in animal kingdom. Differences between new world monkeys & old world monkeys, apes & man. Evolution of modern man starting from anthropoid ancestor."]},
  {"grade":11,"number":8,"unit":"Faunal diversity","topics":["8.1 Protista: Outline classification. Protozoa: diagnostic features and classification up to class with examples; Paramecium caudatum, Plasmodium vivax - habits and habitat, structure, reproduction, life-cycle and economic importance of P. falciparum.","8.2 Animalia: Level of organization, body plan, body symmetry, body cavity and segmentation in animals. Diagnostic features and classification of the following phyla (up to class) with examples:Porifera, Coelenterata (Cnidaria), Platyhelminthes, Aschelminthes (Nemathelminthes), Annelida, Arthropoda, Mollusca, Echinodermata and Chordata.","Earthworm (Pheretima posthuma): Habit and habitat, External features; Digestive system (alimentary canal & physiology of digestion), Excretory system (types of nephridia, structure and arrangement of septal nephridia), Nervous system (central & peripheral nervous system, working mechanism) & Reproductive systems (male & female reproductive organs), Copulation,Cocoon formation and Economic importance.","Frog (Rana tigrina): Habit and habitat, External features, Digestive system (alimentary canal, digestive glands & physiology of digestion), Blood vascular system (structure & working mechanism of heart), Respiratory system (respiratory organs & physiology of respiration) and Reproductive system (male & female reproductive organs)."]},
  {"grade":11,"number":9,"unit":"Biota and environment","topics":["9.1 Animal adaptation: Aquatic (Primary & Secondary), Terrestrial (Cursorial, Fossorial & Arboreal) and Volant adaptation.","9.2 Animal behavior: Reflex action, taxes, dominance and leadership. Fish and bird Migration.","9.3 Environmental Pollution: Sources, effects and control measures of air, water and soil pollution. Pesticides & their effects."]},
  {"grade":11,"number":10,"unit":"Conservation biology","topics":["10.1 Conservation Biology: Concept of biodiversity, biodiversity conservation, national parks, wildlife reserves,conservation areas, biodiversity hotspots, wetland & Ramsar sites.","Wildlife-Importance, causes of extinction and conservation strategies. IUCN categories of threatened species- meaning of extinct, endangered, vulnerable, rare, and threatened species. Endangered species in Nepal."]},
  {"grade":12,"number":1,"unit":"Plant anatomy","topics":["1.1 Plant anatomy: Concept of tissues, types of plant tissues (meristems and permanent tissues), Anatomy of dicot and monocot root, stem and leaf Secondary growth of dicot stem."]},
  {"grade":12,"number":2,"unit":"Plant physiology","topics":["2.1 Water relation: Introduction and significance of - diffusion, osmosis, and plasmolysis, ascent of sap, transpiration and guttation.","2.2 Photosynthesis: Introduction and significance of photosynthesis, photosynthetic pigments, mechanism of photosynthesis (photochemical phase and Calvin-Benson cycle), C3 and C4 plants, photorespiration, factorsaffecting photosynthesis.","2.3 Respiration: Introduction and significance of respiration, types of respiration, mechanism of respiration (glycolysis, Kreb cycle, electron transport system), factors affecting respiration.","2.4 Plant hormones: Introduction, physiological effects of auxins, gibberellins and Cytokinins.","2.5 Plant growth and movement: Concept on seed germination, dormancy, photoperiodism, vernalization, senescence; plant movements (tropic and nastic)."]},
  {"grade":12,"number":3,"unit":"Genetics","topics":["3.1 Genetic Materials: Introduction to genetics and genetic materials, composition, structure and function of DNA and RNA, DNA replication, introduction of genetic code.","3.2 Mendelian genetics: General terminology, Mendel’s experiment and laws of inheritance, gene interactions (incomplete dominance, co- dominance).","3.3 Linkage and crossing over: Concept and types of linkage (complete and incomplete), sex-linked inheritance (colour blindness in man and eye colour of Drosophila), concept and significances of crossing over.","3.4 Mutation and polyploidy: Concept, type (gene and chromosomal mutation), importance of mutation (positive and negative), polyploidy (origin and significance)."]},
  {"grade":12,"number":4,"unit":"Embryology","topics":["4.1 Embryology: Asexual and sexual reproductions in angiosperms, pollination, fertilization, development of male and female gametophytes, development of dicot and monocot embryos, concept of endosperm"]},
  {"grade":12,"number":5,"unit":"Biotechnology","topics":["5.1 Introduction, tissue culture, plant breeding, disease resistance plants, green manure and bio- fertilizer, bio-pesticide, genetic engineering and GMOs (genetically modified organisms) and application, bio- engineering, food safety and food security."]},
  {"grade":12,"number":6,"unit":"Animal tissues","topics":["6.1 Animal Tissues: Introduction; Types of animal tissues: epithelial, connective, muscular and nervous (structure, functions & location of different sub-types)."]},
  {"grade":12,"number":7,"unit":"Development biology","topics":["7.1 Gametogenesis: Spermatogenesis & Oogenesis.","7.2 Development of frog: Fertilization & its effects, cleavage, morulation, blastulation, gastrulation, organogenesis – formation of notochord, nerve cord & coelom."]},
  {"grade":12,"number":8,"unit":"Human biology","topics":["8.1 Digestive system: Alimentary canal and digestive glands, physiology of digestion.","8.2 Respiratory System: Respiratory organs, respiratory mechanism - exchange of gases, transport of gases and regulation of respiration.","8.3 Circulatory System: Double circulation (concept), heart (structure and working mechanism), origin and conduction of heart beat, cardiac cycle, cardiac output, arterial and venous systems (major arteries and veins), blood grouping, blood pressure.","8.4 Excretory System: Concept of modes of excretion (ammonotelism, ureotelism, Excretory mechanism formation.uricotelism), organs, of urine","8.5 Nervous system: Types of nervous system (central, peripheral & autonomous), structure and function of brain, Origin and conduction of nerve impulse.","8.6 Sense organs: Structure and functions of eye and ear.","8.7 Endocrinology: Endocrine glands and hormones – structure & functions of hypothalamus, pituitary, pineal, thyroid, parathyroid, adrenal, pancreas, gonads; hypo- and hyper-activity and related disorders.","8.8 Reproductive System: Male and female reproductive organs, ovarian & menstrual cycle."]},
  {"grade":12,"number":9,"unit":"Human population and health disorders","topics":["9.1 Human Population: Growth problem and control strategies, Concept of demographic cycle.","9.2 Health disorders: Concept of cardiovascular, respiratory & renal disorders; Substance abuse: Drug, alcohol and smoking abuse."]},
  {"grade":12,"number":10,"unit":"Applied biology","topics":["10.1 Application of Zoology: Tissue and organs transplantation, in-vitro fertilization (IVF), amniocentesis, concept of genetically modified organisms (transgenic animals). Poultry farming and fish farming.","10.2 Microbial diseases and application of microbiology: Risk and hazard group of microorganisms. Introduction, causative agents, symptoms, prevention and control measures of selected human diseases: Typhoid, Tuberculosis and HIV infection, Cholera influenza, Hepatitis candidiasis. Basic concepts of immunology–vaccines. Application of microorganisms in dairy and beverage industries, microbial contamination of water, sewage and drinking water treatment, bio-control agents and bio-fertilizers."]}
]$seed$::jsonb;
  v_old_note constant text := 'User-provided topic list; confirm whether these are units or chapters and verify the official CDC sequence before promotion.';
  v_new_note constant text := 'User-provided detailed Biology syllabus; unit and chapter hierarchy is pending review and has not been independently verified.';
  v_grade integer;
  v_subject_id uuid;
  v_existing_count integer;
  v_matching_old_count integer;
  v_matching_new_count integer;
  v_expected_old_count integer;
  v_expected_unit_count integer;
  v_expected_topic_count integer;
  v_topic_number integer;
  v_unit jsonb;
  v_topic text;
begin
  for v_grade in select grade_number from (values (11), (12)) as grades(grade_number)
  loop
    select subjects.id
    into v_subject_id
    from public.subjects
    join public.streams on streams.id = subjects.stream_id
    join public.grades on grades.id = subjects.grade_id
    where streams.slug = 'science'
      and grades.number = v_grade
      and subjects.slug = 'biology'
      and subjects.curriculum_edition_id is null;

    if v_subject_id is null then
      raise exception 'Grade % Science Biology subject was not found; no candidates were changed.', v_grade;
    end if;

    select
      count(*),
      count(*) filter (
        where candidate_type = 'topic_group_candidate'
          and verification_status = 'pending_verification'
          and verification_note = v_old_note
      ),
      count(*) filter (where verification_note = v_new_note)
    into v_existing_count, v_matching_old_count, v_matching_new_count
    from public.curriculum_review_items
    where subject_id = v_subject_id;

    select count(*), coalesce(sum(jsonb_array_length(entry.value -> 'topics')), 0)
    into v_expected_unit_count, v_expected_topic_count
    from jsonb_array_elements(v_seed) as entry(value)
    where (entry.value ->> 'grade')::integer = v_grade;

    if v_existing_count = v_expected_unit_count + v_expected_topic_count
      and v_matching_new_count = v_existing_count then
      raise notice 'Grade % Biology candidates are already expanded; no candidates were changed.', v_grade;
      continue;
    end if;

    v_expected_old_count := case when v_grade = 11 then 8 else 7 end;
    if v_existing_count <> v_expected_old_count or v_matching_old_count <> v_expected_old_count then
      raise exception 'Expected % original pending Grade % Biology topic groups; found % Biology candidates and % matching pending rows. No candidates were changed.',
        v_expected_old_count, v_grade, v_existing_count, v_matching_old_count;
    end if;

    delete from public.curriculum_review_items
    where subject_id = v_subject_id
      and candidate_type = 'topic_group_candidate'
      and verification_status = 'pending_verification'
      and verification_note = v_old_note;

    v_topic_number := 0;
    for v_unit in
      select entry.value
      from jsonb_array_elements(v_seed) as entry(value)
      where (entry.value ->> 'grade')::integer = v_grade
      order by (entry.value ->> 'number')::integer
    loop
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
      values (
        v_subject_id,
        null,
        null,
        'unit_candidate',
        (v_unit ->> 'number')::integer,
        null,
        v_unit ->> 'unit',
        v_new_note
      );

      for v_topic in
        select topic.value
        from jsonb_array_elements_text(v_unit -> 'topics') with ordinality as topic(value, ordinality)
        order by topic.ordinality
      loop
        v_topic_number := v_topic_number + 1;
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
        values (
          v_subject_id,
          null,
          null,
          'chapter_candidate',
          v_topic_number,
          v_unit ->> 'unit',
          v_topic,
          v_new_note
        );
      end loop;
    end loop;

    raise notice 'Expanded Grade % Biology to % pending unit candidates and % pending chapter candidates.',
      v_grade, v_expected_unit_count, v_expected_topic_count;
  end loop;
end
$$;
