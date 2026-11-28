do $$
declare
  v_seed constant jsonb := $seed$
[
  {"grade":11,"number":1,"unit":"Foundation and Fundamentals","topics":["1.1 General introduction of chemistry","1.2 Importance and scope of chemistry","1.3 Basic concepts of chemistry (atoms, molecules, relative masses of atoms and molecules, atomic mass unit ( amu), radicals, molecular formula, empirical formula )","1.4 Percentage composition from molecular formula"]},
  {"grade":11,"number":2,"unit":"Stoichiometry","topics":["2.1 Dalton’s atomic theory and its postulates","2.2 Laws of stoichiometry","2.3 Avogadro’s law and some deductions","2.4 Mole and its relation with mass, volume and number of particles","2.5 Calculations based on mole concept","2.6 Limiting reactant and excess reactant","2.7 Theoretical yield, experimental yield and % yield","2.8 Calculation of empirical and molecular formula from % composition (Solving related numerical problems)"]},
  {"grade":11,"number":3,"unit":"Atomic structure","topics":["3.1 Rutherford's atomic model","3.2 Limitations of Rutherford's atomic model","3.3 Postulates of Bohr’s atomic model and its application","3.4 Spectrum of hydrogen atom","3.5 Defects of Bohr’s theory","3.6 Elementary idea of quantum mechanical model: de Broglie's wave equation","3.7 Heisenberg's Uncertainty Principle","3.8 Concept of probability","3.9 Quantum Numbers","3.10 Orbitals and shape of s and p orbitals only","3.11 Aufbau Principle","3.12 Pauli’s exclusion principle","3.13 Hund’s rule and electronic configurations of atoms and ions (up to atomic no. 30)"]},
  {"grade":11,"number":4,"unit":"Classification of elements and periodic table","topics":["4.1 Modern periodic law and modern periodic table","4.2 IUPAC classification of elements","4.3 Nuclear charge and effective nuclear charge","4.4 Periodic trend and periodicity"]},
  {"grade":11,"number":5,"unit":"Chemical bonding and shapes of molecules","topics":["5.1 Valence shell, valence electron and octet theory","5.2 Ionic bond and its properties","5.3 Covalent bond and coordinate covalent bond","5.4 Properties of covalent compounds","5.5 Lewis dot structure of some common compounds of s and p block elements","5.6 Resonance","5.7 VSEPR theory and shapes of some simple molecules (BeF2, BF3, CH4, CH3Cl, PCl5, SF6, H2O,NH3,CO2,H2S, PH3)","5.8 Elementary idea of Valence Bond Theory","5.9 Hybridization involving s and p orbitals only","5.10 Bond characteristics:","5.11 Vander Waal’s force and molecular solids","5.12 Hydrogen bonding and its application","5.13 Metallic bonding and properties of metallic solids"]},
  {"grade":11,"number":6,"unit":"Oxidation and reduction","topics":["6.1 General and electronic concept of oxidation and reduction","6.2 Oxidation number and rules for assigning oxidation number","6.3 Balancing redox reactions by oxidation number and ion-electron (half reaction) method","6.4 Electrolysis"]},
  {"grade":11,"number":7,"unit":"States of matter","topics":["7.1 Gaseous state","7.2 Liquid state","7.3 Solid state"]},
  {"grade":11,"number":8,"unit":"Chemical equilibrium","topics":["8.1 Physical and chemical equilibrium","8.2 Dynamic nature of chemical equilibrium","8.3 Law of mass action","8.4 Expression for equilibrium constant and its importance","8.5 Relationship between Kp and Kc","8.6 Le Chatelier’s Principle (Numericals not required)"]},
  {"grade":11,"number":9,"unit":"Chemistry of Non-metals","topics":["9.1 Hydrogen","9.2 Allotropes of Oxygen","9.3 Ozone","9.4 Nitrogen","9.5 Halogens","9.6 Carbon","9.7 Phosphorus","9.8 Sulphur"]},
  {"grade":11,"number":10,"unit":"Chemistry of metals","topics":["10.1 Metals and Metallurgical Principles","10.2 Alkali Metals","10.3 Alkaline Earth Metals"]},
  {"grade":11,"number":11,"unit":"Bio-inorganic chemistry","topics":["Introduction to Bio-inorganic Chemistry","11.1 Introduction","11.2 Micro and macro nutrients","11.3 Importance of metal ions in biological systems (ions of Na, K, Mg, Ca, Fe, Cu, Zn, Ni, Co, Cr)","11.4 Ion pumps (sodium-potassium and sodium-glucose pump)","11.5 Metal toxicity (toxicity due to iron, arsenic, mercury, lead and cadmium)"]},
  {"grade":11,"number":12,"unit":"Basic concept of organic chemistry","topics":["12.1 Introduction to organic chemistry and organic compounds","12.2 Reasons for the separate study of organic compounds from inorganic","12.3 Tetra-covalency and catenation properties of carbon","12.4 Classification of organic compounds","12.5 Alkyl groups, functional groups and homologous series","12.6 Idea of structural formula, contracted formula and bond line structural formula","12.7 Preliminary idea of cracking and reforming, quality of gasoline, octane number, cetane number and gasoline additive"]},
  {"grade":11,"number":13,"unit":"Fundamental principles of organic chemistry","topics":["13.1 IUPAC Nomenclature of Organic Compounds (upto chain having 6- carbon atoms)","13.2 Qualitative analysis of organic compounds (detection of N, S and halogens by Lassaigne's test)","13.3 Isomerism in Organic Compounds","13.4 Definition and classification of isomerism","13.5 Structural isomerism and its types: chain isomerism, position isomerism, functional isomerism, metamerism and tautomerism","13.6 Concept of geometrical isomerism (cis & trans) & optical isomerism (d & l form)","13.7 Preliminary Idea of Reaction Mechanism"]},
  {"grade":11,"number":14,"unit":"Hydrocarbons","topics":["14.1 Saturated Hydrocarbons (Alkanes)","14.2 Unsaturated hydrocarbons (Alkenes & Alkynes)","14.3 Alkynes: Preparation from carbon and hydrogen, 1,2 dibromoethane, chloroform/iodoform only","14.4 Test of unsaturation (ethene & ethyne): bromine water test and Baeyer's test","14.5 Comparative studies of physical properties of alkane, alkene and alkyne","14.6 Kolbe's electrolysis methods for the preparation of alkane, alkene and alkynes"]},
  {"grade":11,"number":15,"unit":"Aromatic hydrocarbons","topics":["15.1 Introduction and characteristics of aromatic compounds","15.2 Huckel's rule of aromaticity","15.3 Kekule structure of benzene","15.4 Resonance and isomerism","15.5 Preparation of benzene from decarboxylation of sodium benzoate, phenol, and ethyne only","15.6 Physical properties of benzene","15.7 Chemical properties of benzene: Addition reaction: hydrogen, halogen, Electrophilic substitution reactions: orientation of benzene derivatives (o, m & p), nitration, sulphonation, halogenations, Friedal-Craft's reaction (alkylation and acylation), combustion of benzene ( free combustion only) and uses Phenols"]},
  {"grade":11,"number":16,"unit":"Fundamentals of applied chemistry","topics":["16.1 Fundamentals of Applied Chemistry"]},
  {"grade":11,"number":17,"unit":"Modern chemical manufactures","topics":["17.1 Modern Chemical Manufactures (principle and flow sheet diagram only)","17.2 Fertilizers (Chemical fertilizers, types of chemical fertilizers, production of urea with flow-sheet diagram)"]},
  {"grade":12,"number":1,"unit":"Volumetric analysis","topics":["1.1 Introduction to gravimetric analysis, volumetric analysis and equivalent weight","1.2 Relationship between equivalent weight, atomic weight and valency","1.3 Equivalent weight of compounds (acid, base, salt, oxidizing and reducing agents)","1.4 Concentration of solution and its units in terms of : Percentage, g/L , molarity, molality, normality and formality, ppm and ppb","1.5 Primary and secondary standard substances","1.6 Law of equivalence and normality equation","1.7 Titration and its types: Acid-base titration, redox titration ( related numerical problems)"]},
  {"grade":12,"number":2,"unit":"Ionic equilibrium","topics":["Introduction to Acids and Bases","2.1 Limitation of Arrhenius concepts of acids and bases","2.2 Bronsted –Lowry definition of acids and bases","2.3 Relative strength of acids and bases","2.4 Conjugate acid –base pairs","2.5 Lewis definition of acids and bases","2.6 Ionization of weak electrolyte (Ostwald's dilution law)","2.7 Ionic product of water(Kw)","2.8 Dissociation constant of acid and base, (Ka& Kb)","2.9 Concept of pKa and pKb","2.10 pH value: pH of strong and weak acids, pH of strong and weak bases","2.11 Solubility and solubility product principle","2.12 Common Ion effect","2.13 Application of solubility product principle and common ion effect in precipitation reactions","2.14 Buffer solution and its application","2.15 Indicators and selection of indicators in acid base titration","2.16 Types of salts: Acidic salts, basic salts, simple salts, complex salts (introduction and examples)","2.17 Hydrolysis of salts"]},
  {"grade":12,"number":3,"unit":"Chemical kinetics","topics":["3.1 Introduction","3.2 Rate of reactions: Average and instantaneous rate of reactions","3.3 Rate law and its expressions","3.4 Rate constant and its unit and significance","3.5 Order and molecularity","3.6 Integrated rate equation for zero and first order reaction","3.7 Half-life of zero and first order reactions","3.8 Collision theory, concept of activation energy and activated complex","3.9 Factors affecting rate of reactions: Effect of concentration, temperature (Arrhenius Equation) and effect of catalyst (energy profile diagram)","3.10 Catalysis and types of catalysis: homogeneous, heterogeneous and enzyme catalysis (solving related numerical problems based on rate, rate constant and order of zero and first order reactions)"]},
  {"grade":12,"number":4,"unit":"Thermodynamics","topics":["4.1 Introduction","4.2 Energy in chemical reactions","4.3 Internal energy","4.4 First law of thermodynamics","4.5 Enthalpy and enthalpy changes: Endothermic and exothermic processes)","4.6 Enthalpy of reaction, enthalpy of solution, enthalpy of formation, enthalpy of combustion","4.7 Laws of thermochemistry (Laplace Law and Hess’s law)","4.8 Entropy and spontaneity","4.9 Second law of thermodynamics","4.10 Gibbs' free energy and prediction of spontaneity","4.11 Relationship between ∆G and equilibrium constant (Solving related numerical problems)"]},
  {"grade":12,"number":5,"unit":"Electrochemistry","topics":["5.1 Electrode potential and standard electrode potential","5.2 Types of electrodes: Standard hydrogen electrode and calomel electrodes","5.3 Electrochemical series and its applications","5.4 Voltaic cell: Zn-Cu cell, Ag- Cu cell","5.5 Cell potential and standard cell potential","5.6 Relationship between cell potential and free energy","5.7 Commercial batteries and fuel cells (hydrogen/oxygen)"]},
  {"grade":12,"number":6,"unit":"Transition metals","topics":["6.1 Introduction"]},
  {"grade":12,"number":7,"unit":"Studies of heavy metals","topics":["7.1 Copper","7.2 Zinc","7.3 Mercury","7.4 Iron","7.5 Silver"]},
  {"grade":12,"number":8,"unit":"Haloalkanes","topics":["8.1 Introduction","8.2 Nomenclature, isomerism and classification of monohaloalkanes","8.3 Preparation of monohaloalkanes from alkanes, alkenes and alcohols","8.4 Physical properties of monohaloalkanes","8.5 Chemical properties, substitution reactions SN1 and SN2 reactions (basic concept only)","8.6 Formation of alcohol, nitrile, amine, ether, thioether, carbylamines, nitrite and nitro alkane using haloalkanes","8.7 Elimination reaction (dehydrohalogenation- Saytzeff's rule), Reduction reactions, Wurtz reaction","8.8 Preparation of trichloromethane from ethanol and propanone","8.9 Chemical properties of trichloromethane: oxidation, reduction, action on silver powder, conc. nitric acid, propanone, and aqueous alkali"]},
  {"grade":12,"number":9,"unit":"Haloarenes","topics":["9.1 Introduction","9.2 Nomenclature and isomerism of haloarenes","9.3 Preparation of chlorobenzene from benzene and benzene diazonium chloride","9.4 Physical properties","9.5 Chemical properties","9.6 Uses of haloarenes"]},
  {"grade":12,"number":10,"unit":"Alcohols","topics":["10.1 Introduction","10.2 Nomenclature, isomerism and classification of monohydric alcohol","10.3 Distinction of primary, secondary and tertiary alcohols by Victor Meyer's Method","10.4 Preparation of monohydric alcohols from Haloalkane, primary amines, and esters","10.5 Industrial preparation alcohol from: oxo process, hydroboration-oxidation of ethene & fermentation of sugar","10.6 Definition of common terms: Absolute alcohol, power alcohol, denatured alcohol (methylated spirit), rectified spirit; alcoholic beverage","10.7 Physical properties monohydric alcohols","10.8 Chemical properties of monohydric alcohols"]},
  {"grade":12,"number":11,"unit":"Phenols","topics":["11.1 Introduction and nomenclature","11.2 Preparation of phenol from i. chlorobenzene ii. Diazonium salt and iii. benzene sulphonic acid","11.3 Physical properties of phenol","11.4 Chemical properties","11.5 Test of phenol: (FeCl3 test, aq. Bromine test & Libermann test)","11.6 Uses of phenol"]},
  {"grade":12,"number":12,"unit":"Ethers","topics":["12.1 Introduction","12.2 Nomenclature, classification and isomerism of ethers","12.3 Preparation of aliphatic and aromatic ethers from Williamson's synthesis","12.4 Physical properties of ether","12.5 Chemical properties of ethoxyethane: action with HI , Conc. HCl, Conc. H2SO4, air and Cl2","12.6 Uses of ethers"]},
  {"grade":12,"number":13,"unit":"Aldehydes and ketones","topics":["13.1 Aliphatic aldehydes and ketones","13.2 Aromatic aldehydes and Ketones"]},
  {"grade":12,"number":14,"unit":"Carboxylic acid and its derivatives","topics":["14.1 Aliphatic and aromatic carboxylic acids","14.2 Derivatives of Carboxylic acids (acid halides, amides, esters and anhydrides)"]},
  {"grade":12,"number":15,"unit":"Nitro compounds","topics":["15.1 Nitroalkanes","15.2 Nitrobenzene"]},
  {"grade":12,"number":16,"unit":"Amines","topics":["16.1 Aliphatic amines","16.2 Aromatic amine (Aniline)"]},
  {"grade":12,"number":17,"unit":"Organometallic compounds","topics":["17.1 Introduction, general formula and examples of organolithium, organocopper and organocadmium compounds","17.2 Nature of Metal-Carbon bond","17.3 Grignard reagent"]},
  {"grade":12,"number":18,"unit":"Chemistry in the service of mankind","topics":["18.1 Polymers","18.2 Dyes","18.3 Drugs","18.4 Pesticides"]},
  {"grade":12,"number":19,"unit":"Cement","topics":["19.1 Introduction","19.2 Raw materials for cement production","19.3 Main steps in cement production (crushing and grinding, strong heating and final grinding)","19.4 Types of cement- OPC and PPC","19.5 Portland cement process with flow-sheet diagram","19.6 Cement Industry in Nepal"]},
  {"grade":12,"number":20,"unit":"Paper and pulp","topics":["20.1 Introduction","20.2 Raw materials","20.3 Sources of raw materials","20.4 Stages in production of paper","20.5 Flow-sheet diagram for paper production","20.6 Quality of paper"]},
  {"grade":12,"number":21,"unit":"Nuclear chemistry and application of radioactivity","topics":["21.1 Natural and artificial radioactivity","21.2 Units of radioactivity","21.3 Nuclear reactions","21.4 Nuclear fission and fusion reactions","21.5 Nuclear power and nuclear weapons","21.6 Industrial uses of radioactivity","21.7 Medical uses of radioactivity","21.8 Radiocarbon dating","21.9 Harmful effects of nuclear radiations"]}
]$seed$::jsonb;
  v_old_note constant text := 'User describes these as condensed unit headings and asks for detailed CDC subdivisions before import. Keep pending; do not expose as verified units or chapters.';
  v_new_note constant text := 'User-provided detailed Chemistry syllabus; headings and topics are pending review and have not been independently verified.';
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
      and subjects.slug = 'chemistry'
      and subjects.curriculum_edition_id is null;

    if v_subject_id is null then
      raise exception 'Grade % Science Chemistry subject was not found; no candidates were changed.', v_grade;
    end if;

    select
      count(*),
      count(*) filter (
        where verification_status = 'pending_verification'
          and verification_note = v_old_note
      ),
      count(*) filter (where verification_note = v_new_note)
    into v_existing_count, v_matching_old_count, v_matching_new_count
    from public.curriculum_review_items
    where subject_id = v_subject_id
      and candidate_type in ('unit_candidate', 'chapter_candidate');

    select count(*), coalesce(sum(jsonb_array_length(entry.value -> 'topics')), 0)
    into v_expected_unit_count, v_expected_topic_count
    from jsonb_array_elements(v_seed) as entry(value)
    where (entry.value ->> 'grade')::integer = v_grade;

    if v_existing_count = v_expected_unit_count + v_expected_topic_count
      and v_matching_new_count = v_existing_count then
      raise notice 'Grade % Chemistry candidates are already expanded; no candidates were changed.', v_grade;
      continue;
    end if;

    v_expected_old_count := case when v_grade = 11 then 13 else 11 end;
    if v_existing_count <> v_expected_old_count or v_matching_old_count <> v_expected_old_count then
      raise exception 'Expected % original pending Grade % Chemistry unit candidates; found % chemistry candidates and % matching pending rows. No candidates were changed.',
        v_expected_old_count, v_grade, v_existing_count, v_matching_old_count;
    end if;

    delete from public.curriculum_review_items
    where subject_id = v_subject_id
      and candidate_type = 'unit_candidate'
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

    raise notice 'Expanded Grade % Chemistry to % pending unit candidates and % pending chapter candidates.',
      v_grade, v_expected_unit_count, v_expected_topic_count;
  end loop;
end
$$;
