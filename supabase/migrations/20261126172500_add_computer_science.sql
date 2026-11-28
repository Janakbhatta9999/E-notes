do $$
declare
  v_seed constant jsonb := $seed$
[{"grade":11,"number":1,"unit":"Computer System","topics":[{"title":"1.1 Introduction of computer","details":["1.1.1 Definition, characteristics and application of computer","1.1.2 Evolution of computer technology","1.1.3 Measurement unit of processing speed and storage unit","1.1.4 Super, Mainframe, Mini and Microcomputers","1.1.5 Mobile Computing and its Application"]},{"title":"1.2 Computer system and I/O devices","details":["1.2.1 Concept of computer architecture and organization","1.2.2 Components of computer system: input unit, output unit, processing unit, memory unit and storage","1.2.3 Microprocessor: basic concepts, clock speed, word length, components and functions","1.2.4 Bus System: data bus, address bus and control bus","1.2.5 Primary memory: Definition, RAM, ROM, Cache, Buffer, types of RAM and ROM","1.2.6 Secondary Memory: Definition, Magnetic Disk, Flash Memory, Optical Disk, External Storage Device and memo stick","1.2.7 Input Devices – Keyboard, Mouse, Scanner, Light Pen, OMR, OCR, BCR, MICR, Scanner, Touch Screen, Microphone and Digital Camera.","1.2.8 Output Devices: Monitor (LCD, LED), Printer (Dot Matrix, Inkjet, Laser), Speaker","1.2.9 Hardware Interfaces: Parallel Port, Serial Port, USB Ports, HDMI and Expansion Slots"]}]},{"grade":11,"number":2,"unit":"Number System and Conversion Boolean Logic","topics":[{"title":"2.1 Number System and conversion","details":["2.1.1 Decimal, Binary, Octal, Hexadecimal Number System & conversion","2.1.2 Calculation in binary addition, subtraction","2.1.3 One’s and Two’s complement methods of binary subtraction"]},{"title":"2.2 Logic Function and Boolean Algebra","details":["2.2.1 Introduction to Boolean algebra","2.2.2 Introduction to Boolean values, truth table, Boolean expression and Boolean function.","2.2.3 Logic Gates –AND, OR, NOT, NAND, NOR, XOR and XNOR – its definition, truth table, logic symbol, logic function","2.2.4 Laws of Boolean algebra – Boolean identities, Complement Laws, Identity, Commutative, Associative and Distributive","2.2.5 Statement and verification of Laws of Boolean algebra using truth table"]}]},{"grade":11,"number":3,"unit":"Computer Software and Operating System","topics":[{"title":"3.1 Concept of Software","details":["3.1.1 Definition of software","3.1.2 Categories of software: System, Utility, Application, Web Based, Mobile Apps"]},{"title":"3.2 Concept of Operating System","details":["3.2.1 Introduction to Operating System","3.2.2 Role of Operating System","3.2.3 Functions of an Operating System","3.2.4 Operating system terminology: multiprogramming, multitasking, multiprocessing and distributed"]},{"title":"3.3 Windows Operating System","details":["3.3.1 Introduction to GUI based Operating system and its features","3.3.2 Working in Desktop Application and Window Environment","3.3.3 Manage Files and Folders with File Explorer","3.3.4 Customize the start screen and desktop","3.3.5 Installing and removing devices","3.3.6 Manage passwords and privacy levels","3.3.7 Use of control panel, system tools and accessories"]},{"title":"3.4 Open sources and Mobile Operating System","details":["3.4.1 Concept of Open Sources Operating System","3.4.2 Introduction to Linux and UNIX","3.4.3 Linux Distributions","3.4.4 Concept of Mobile Operating System","3.4.5 Types of Mobile Operating System"]}]},{"grade":11,"number":4,"unit":"Application Package","topics":[{"title":"4.1 Introduction to Office Package -","details":["Word processor, Presentation tool, spreadsheet package, database management system;"]},{"title":"4.2 Introduction to domain-specific tools - school management system, inventory management system,","details":["payroll system, financial accounting, hotel management, weather forecasting system."]}]},{"grade":11,"number":5,"unit":"Programming Concepts & Logics","topics":[{"title":"5.1 Programming Concept","details":["5.1.1 Introduction to programming languages","5.1.2 Low level, High level, 4 GL programming languages","5.1.3 Compiler, Interpreter and Assembler","5.1.4 Syntax, Semantic and Runtime errors","5.1.5 ControlStructures: Sequence,Selection and Iteration","5.1.6 Program Design tools – Algorithm, Flowchart and Pseudocode","5.1.7 Absolute binary, BCD, ASCII and Unicode"]},{"title":"5.2 C Programming Languages","details":["5.2.1 Introduction and features of C Language","5.2.2 Structure of C program","5.2.3 C Preprocessor and Header Files","5.2.4 Character Set used in C","5.2.5 Use of Comments","5.2.6 Identifiers, Keywords and Tokens","5.2.7 Basic Data Types in C","5.2.8 Constants and Variables","5.2.9 Type of Specifier","5.2.10 Simple and Compound Statements","5.2.11 Operators and Expressions: arithmetic, relational, logical, assignment, unary and conditional operators","5.2.12 Input/output (I/O) Functions","5.2.13 Selection Control Statement: Decisions (if, if-else, if-else-if, nested and, switch)","5.2.14 Iteration Control Statement: Looping (while, do while, for nested)","5.2.15 Array: definition, types(1D and 2D), matrix addition and subtraction","5.2.16 String: definition and string function : strlen(), strcat(), strcmp(), strrev(), strcpy(), strlwr(), strupr()"]}]},{"grade":11,"number":6,"unit":"Web Technology I","topics":[{"title":"6.1 Introduction: Web development introduction","details":[]},{"title":"6.2 Web browsers and search Engines","details":[]},{"title":"6.3 Overview of various internet & web technologies","details":[]},{"title":"6.4 Content Management System (CMS) / HTML: The Language of the Web","details":["6.4.1 Objectives","6.4.2 Structure of HTML","6.4.3 Published and Hosting","6.4.4 HTML Tags vs. Attributes","6.4.5 Basic Tags of HTML: HTML, HEAD, TITLE, BODY (Setting the Fore color and Background color, Background Image, Background Sound)","6.4.6 Heading tag (H1 to H6) and attributes(ALIGN),","6.4.7 FONT tag and Attributes (Size: 1 to 7 Levels, BASEFONT, SMALL, BIG,COLOR)","6.4.8 Paragraph Formatting (P)","6.4.9 Break Line BR","6.4.10 Comment in HTML ()","6.4.11 Formatting Text (B, I, U, Mark, Sup, Sub, EM, BLOCKQUOTE, PREFORMATTED)","6.4.12 Ordered List- OL (LI, Type- 1, I, A, a; START,VALUE)","6.4.13 Unordered List - UL (Bullet Type- Disc, Circle, Square, DL, DT, DD)","6.4.14 ADDRESS Tag","  Creating Links: Link to other HTML documents or data objects","  Links to other places in the same HTML documents","  Links to places in other HTML documents","  Anchor Tag and Hyperlink","6.4.15 Tables: Creating Tables using TH, TR and TD tags","6.4.16 Forms: Creating form using Textbox, radio, checkbox, text area, button","6.4.17 Introduction to HTML 5 Elements including audio, embed, source, track and video attributes","6.4.18 HTML 5 Graphics using canvas and svg tags","6.4.19 Concept of domain name and web hosting"]},{"title":"6.5 Cascading Style Sheets","details":["6.5.1 Introduction to Cascading Style Sheet (CSS)","6.5.2 Inline CSS","6.5.3 Embedded CSS","6.5.4 External CSS"]}]},{"grade":11,"number":7,"unit":"Multimedia","topics":[{"title":"7.1 Introduction to Multimedia","details":[]},{"title":"7.2 Component of Multimedia: Text, Graphics, Audio, Video and Animation","details":[]},{"title":"7.3 Application of Multimedia","details":[]}]},{"grade":11,"number":8,"unit":"Information Security and Cyber Law","topics":[{"title":"8.1 Digital society and computer ethics","details":[]},{"title":"8.2 Concept of Information security","details":[]},{"title":"8.3 Concept of Cybercrime","details":[]},{"title":"8.4 Malicious software and Spam","details":[]},{"title":"8.5 Protection from cybercrime","details":[]},{"title":"8.6 Intellectual Property Right","details":[]},{"title":"8.7 Concept of Digital Signature","details":[]},{"title":"8.8 Concept of Cyber Law in Nepal","details":[]},{"title":"8.9 ICT Policy in Nepal","details":[]}]},{"grade":12,"number":1,"unit":"Database Management System (DBMS)","topics":[{"title":"1.1 Introduction to data, database, Database system, DBMS","details":[]},{"title":"1.2 Field, Record, Objects, Primary Key, Alternate key, Candidate key","details":[]},{"title":"1.3 Advantages of using DBMS","details":[]},{"title":"1.4 DDL (Data Definition Language) and DML (Data Manipulation Language)","details":[]},{"title":"1.5 Database Model: Network Model, Hierarchical Model, Relational database model","details":[]},{"title":"1.6 Concept of Normalization: 1NF, 2NF, 3NF","details":[]},{"title":"1.7 Centralized Vs. Distributed Database","details":[]},{"title":"1.8 Database Security","details":[]}]},{"grade":12,"number":2,"unit":"Data Communication and Networking","topics":[{"title":"2.1 Basic elements of Communication System:","details":[]},{"title":"2.2 Concept of Communication System","details":[]},{"title":"2.3 Block Diagram of communication System /Model","details":[]},{"title":"2.4 Elements of Data Communication/Transmission","details":[]},{"title":"2.5 Simplex, Half duplex and Full duplex communication mode","details":[]},{"title":"2.6 Concept of LAN and WAN","details":[]},{"title":"2.7 Transmission Medium: Guided and Unguided","details":[]},{"title":"2.8 Transmission impairments terminology (Jitter, Singing, Echo, Crosstalk, Distortion, Noise, Bandwidth, Number of receivers)","details":[]},{"title":"2.9 Basic concept of Networks Architecture: Client- Server and Peer-to-peer","details":[]},{"title":"2.10 Some Basic Terms and Tool Used in Computer Network: IP Address, Sub Net Mask and Gateway, MAC address, Internet, Intranet","details":["Extranet"]},{"title":"2.11 Network Tool: Packet tracer, Remote Login","details":[]},{"title":"2.12 Network Connecting Devices: NIC, Modem, router, switch","details":[]},{"title":"2.13 Network Topologies: Bus, Ring and star topology","details":[]},{"title":"2.14 Basic Concept OSI Reference Model","details":[]},{"title":"2.15 Internet Protocol Addressing","details":[]}]},{"grade":12,"number":3,"unit":"Web technology II","topics":[{"title":"3.1 Introduction","details":[]},{"title":"3.2 Server side and Client Side Scripting","details":[]},{"title":"3.3 Introduction of internet technology","details":[]},{"title":"3.4 Adding Java script to HTML page","details":[]},{"title":"3.5 Java script fundamental","details":[]},{"title":"3.6 Java Script Data types","details":[]},{"title":"3.7 Variables and operators","details":[]},{"title":"3.8 Functions and control structure if-else, if-else- if, switch-case, for, while, do while loop","details":[]},{"title":"3.9 Object based programming with Java Script and Event handling","details":[]},{"title":"3.10 Image, event and form objects","details":[]},{"title":"3.11 Form validation, JQuery","details":[]},{"title":"3.12 Server Side Scripting using PHP","details":[]},{"title":"3.13 Introduction to PHP: Hardware and Software Requirements","details":[]},{"title":"3.14 Object oriented programming with server side scripting","details":[]},{"title":"3.15 Basic PHP syntax","details":[]},{"title":"3.16 PHP data types","details":[]},{"title":"3.17 Basic Programming in PHP","details":[]},{"title":"3.18 Operators (Arithmetic, logical, comparison, operator precedence)","details":[]},{"title":"3.19 Variables Manipulation","details":[]},{"title":"3.20 Database Connectivity","details":[]},{"title":"3.21 Connecting server side script to database","details":[]},{"title":"3.22 Making SQL queries","details":[]},{"title":"3.23 Fetching data sets getting data about data","details":[]},{"title":"3.24 Creating SQL database with server side scripting","details":[]},{"title":"3.25 Displaying queries in tables","details":[]}]},{"grade":12,"number":4,"unit":"Programming in C","topics":[{"title":"4.1 Review of C programming concept","details":[]},{"title":"4.2 Functions","details":["4.2.1 Concept of library and user defined functions and advantages","4.2.2 function definition, prototype, call and return statements","4.2.3 Accessing a Function by passing values","4.2.4 Concept of storage: automatic and external","4.2.5 Concept of Recursion: factorial and Fibonacci problems"]},{"title":"4.3 Structures and Unions","details":["4.3.1 Structure: Definition, Declaration, Initialization and Size of Structure.","4.3.2 Accessing member of structure","4.3.3 Array of structure","4.3.4 Union: Definition, Declaration","4.3.5 Difference between union and structure."]},{"title":"4.4 Pointers","details":["4.4.1 Definition of Pointer","4.4.2 Address (&) and indirection (*) operator","4.4.3 Pointer Expression and Assignment","4.4.4 Call by values and call by reference"]},{"title":"4.5 Working with Files","details":["4.5.1 Concept of Data File","4.5.2 Sequential and Random File","4.5.3 File manipulation function: putw, getw, putc, getc, fscanf, fprintf","4.5.4 Opening, Reading, Writing and Appending data file"]}]},{"grade":12,"number":5,"unit":"Object- Oriented Programming (OOP)","topics":[{"title":"5.1 Programming paradigms: procedural, structural and object oriented","details":[]},{"title":"5.2 Features of OOP: Class, Object, Polymorphism and Inheritance","details":[]},{"title":"5.3 Advantages of OOP","details":[]},{"title":"5.4 Application of OOP","details":[]}]},{"grade":12,"number":6,"unit":"Software Process Model","topics":[{"title":"6.1 Software Project Concept","details":[]},{"title":"6.2 Concept of software development process","details":[]},{"title":"6.3 Concept SDLC life cycle","details":[]},{"title":"6.4 System Analyst Vs Software Engineer","details":[]},{"title":"6.5 Requirement Collection Methods","details":[]},{"title":"6.6 Concept of system design","details":[]},{"title":"6.7 Software and quality","details":[]},{"title":"6.8 Software development model: waterfall, prototype, agile","details":[]}]},{"grade":12,"number":7,"unit":"Recent Trends in Technology","topics":[{"title":"7.1 Concept of Artificial Intelligence(AI)and Robotics","details":[]},{"title":"7.2 Concept of Cloud Computing","details":[]},{"title":"7.3 Concept of Big Data","details":[]},{"title":"7.4 Concept of Virtual Reality","details":[]},{"title":"7.5 Concept of e-com, e-medicine, e-gov.","details":[]},{"title":"7.6 Concept of Mobile Computing","details":[]},{"title":"7.7 Concept of Internet of things(IoT)","details":[]}]}]
$seed$::jsonb;
  v_new_note constant text := 'User-provided Computer Science syllabus; nested numbered details are retained below chapter candidates. Pending review; not independently verified.';
  v_grade integer;
  v_subject_id uuid;
  v_existing_count integer;
  v_matching_new_count integer;
  v_expected_unit_count integer;
  v_expected_topic_count integer;
  v_topic_number integer;
  v_unit jsonb;
  v_chapter jsonb;
  v_details text;
  v_chapter_note text;
begin
  insert into public.subjects (stream_id, grade_id, name_en, slug, sort_order)
  select streams.id, grades.id, 'Computer Science', 'computer-science', 5
  from public.streams
  cross join public.grades
  where streams.slug = 'science'
    and grades.number in (11, 12)
  on conflict do nothing;

  for v_grade in select grade_number from (values (11), (12)) as grades(grade_number)
  loop
    select subjects.id
    into v_subject_id
    from public.subjects
    join public.streams on streams.id = subjects.stream_id
    join public.grades on grades.id = subjects.grade_id
    where streams.slug = 'science'
      and grades.number = v_grade
      and subjects.slug = 'computer-science'
      and subjects.curriculum_edition_id is null;

    if v_subject_id is null then
      raise exception 'Grade % Science Computer Science subject was not found; no candidates were changed.', v_grade;
    end if;

    select
      count(*),
      count(*) filter (
        where left(verification_note, length(v_new_note)) = v_new_note
      )
    into v_existing_count, v_matching_new_count
    from public.curriculum_review_items
    where subject_id = v_subject_id;

    select count(*), coalesce(sum(jsonb_array_length(entry.value -> 'topics')), 0)
    into v_expected_unit_count, v_expected_topic_count
    from jsonb_array_elements(v_seed) as entry(value)
    where (entry.value ->> 'grade')::integer = v_grade;

    if v_existing_count = v_expected_unit_count + v_expected_topic_count
      and v_matching_new_count = v_existing_count then
      raise notice 'Grade % Computer Science candidates are already seeded; no candidates were changed.', v_grade;
      continue;
    end if;

    if v_existing_count <> 0 then
      raise exception 'Expected no existing Grade % Computer Science candidates before seeding; found %. No candidates were changed.',
        v_grade, v_existing_count;
    end if;

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

      for v_chapter in
        select topic.value
        from jsonb_array_elements(v_unit -> 'topics') with ordinality as topic(value, ordinality)
        order by topic.ordinality
      loop
        select string_agg(detail.value, E'\n' order by detail.ordinality)
        into v_details
        from jsonb_array_elements_text(v_chapter -> 'details') with ordinality as detail(value, ordinality);

        v_chapter_note := v_new_note;
        if v_details is not null then
          v_chapter_note := v_chapter_note || E'\nNested syllabus details:\n' || v_details;
        end if;

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
          v_chapter ->> 'title',
          v_chapter_note
        );
      end loop;
    end loop;

    raise notice 'Seeded Grade % Computer Science with % pending units and % pending chapter candidates.',
      v_grade, v_expected_unit_count, v_expected_topic_count;
  end loop;
end
$$;
