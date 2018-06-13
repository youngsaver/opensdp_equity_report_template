## Definitions for grades 3-8 features

| File Column Location | Variable Title                   | Suggested R Name |Definition            | Type       | Range/Key          |
| :-----          | :----------------------          | :-------         | :--------------      | :------    | :---------------------- |
| 1-4             | ADMINSTRATION DATE               | Date_Exam        | Date exam taken      | Factor     | 0418 = April <br> 0518 = May <br> 0618 = June  |
| 5-6             | GRADE LEVEL TESTED               | Test_Grade       | Grade level of test  | Numeric    | 03-08                   |
| 9-17            | COUNTY-DISTRICT-CAMPUS NUMBER    | School_ID        | School ID            | Numeric    | NA                      |
| 18-32           | DISTRICT-NAME                    | District         | Name of district     | Character  | NA                      |
| 74-82           | STUDENT-ID                       | Student_ID       | Student ID (Unique)  | Numeric    | NA                      |
| 83-83           | SEX-CODE                         | Sex              | Sex (Binary)         | Factor     | M = Male <br> F = Female|
| 84-91           | DATE-OF-BIRTH (MMDDYYYY)         | Date_Birth       | Birth Date (MMDDYYYY)| Numeric    |(MMDDYYYY)               |
| 99              |ETHNICITY/RACE REPORTING CATEGORY | Race_Ethn        | Race-Ethnicity       | Factor     | H = Hispanic/Latino <br> I = American Indian or Alaska Native <br> A = Asian <br> B = Black or African American <br> P = Native Hawaiian or Other Pacific Islander <br> W= White <br> T = Two or More Races <br> N = No Information Provided|
| 100             | ECONOMIC-DISADVANTAGE-CODE       | Eco_Dis          | Levels/types of economic disadvantage | Factor | 1 = Eligible for free meals under the National School Lunch and Child Nutrition Program <br> 2 = Eligible for reduced-price meals under the National School Lunch and Child Nutrition Program <br> 9 = Other economic disadvantage <br> 0 = Not identified as economically disadvantaged|
| 101             | TITLE-I-PART-A-INDICATOR-CODE    | Title_1          | Title 1 school factor | Factor    | 6 = Student attends campus with school-wide program <br> 7 = Student participates in program at targeted assistance school <br> 8 = Student is previous participant in program at targeted assistance school (not a current participant) <br> 9 = Student does not attend a Title I, Part A school but receives Title I, Part A services because the student is homeless <br> 0 = Student does not currently participate in and has not previously participated in program at current campus|
| 102             | MIGRANT-INDICATOR-CODE           | Migrant          | Indicator of migrant |Indicator   | 1 = Student identified as migrant <br> 0 = Not identified as migrant|
| 107             | LEP-INDICATOR-CODE               | LEP              | Factor of LEP (limited English proficiency) level  | Factor     | C = Student is currently identified as LEP <br> F = Student has met criteria for bilingual/ESL program exit, is no longer classified as LEP in TSDS PEIMS, and is in first year of monitoring <br> S = Student in second year of monitoring <br> 0 = Other Non-LEP student |
| 108             | BILINGUAL-INDICATOR-CODE         | BL               | Factor of bilingual program enrollment level | Factor| 2 = Transitional bilingual/early exit <br> 3 = Transitional bilingual/late exit <br> 4 = Dual language immersion/two-way <br> 5 = Dual language immersion/one-way <br> 0 = Student is not participating in a state-approved full bilingual program|
| 109            | ESL-INDICATOR-CODE               | ESL              | Factor of ESL (English as second language) level   | Factor  | 2 = ESL/content-based <br> 3 = ESL/pull-out <br> 0 = Student is not participating in a state-approved ESL program |
| 111            | SPECIAL-ED-INDICATOR-CODE        | SPED             | Indicator if special education enrolled | Indicator | 1 = Yes <br> 0 = No |
| 117            | GIFTED-TALENTED-INDICATOR-CODE   | GT               | Indicator if gifted and talented enrolled | Indicator | 1 = Yes <br> 0 = No|
| 118            | AT-RISK-INDICATOR-CODE           | At_Risk          | Indicator if at risk of dropping out of school under academic criteria only | 1 = Yes <br> 0 = No |
| 122            | CAREER-AND-TECHNICAL-ED-INDICATOR-CODE | CATE       | Factor of type of career/tech ed in which enrolled | Factor | 1 = Enrolled in one or more state-approved career and technical courses as an elective <br> 2 = Participant in the district's career and technical coherent sequence of courses program <br> 0 = No participation in career and technical courses <br> |
| 141-142        | ENROLLED GRADE                   | Enroll_Grade     | Enrolled student grade on registration; if unregistered, grade from PEIMS file; if student record does not match PEIMS file, defaulted to tested grade | Numeric | 03-08 |
| 143            | RECORD UPDATE INDICATOR           | Record_Error    | Factor if record error | Factor | 0 = No record update is needed <br> 1 = Student ID information (TSDS PEIMS ID, name, or date-of-birth) was omitted or is invalid. <br> 2 = Student ID information provided on the answer document does not match the information in the student directory <br> 3 = Student has multiple records for the same administration and subject. The student's results will not be available in the Student Portal/history until the discrepancy can be resolved. |
| 163            | MIGRANT STUDENT IN TEXAS MIGRANT INTERSTATE PROGRAM (TMIP) | TMIP | Indicator if migrant student and participated in Texas Migrant Interstate Program (TMIP) | Indicator | 1 = Yes <br> 0 = No |
| 190            | NEW TO TEXAS                      | New_TX          | Indicator if student is new to Texas                               | Indicator | 1 = Yes <br> 0 = No |
| 246            | EOC/ABOVE GRADE READING           | Above_R         | Indicator if student took exam above enrolled grade level in Reading | Indicator | 1 = Yes <br> 0 = No|
| 247            | EOC/ABOVE GRADE MATHEMATICS       | Above_M         | Indicator if student took exam above enrolled grade level in Math    | Indicator | 1 = Yes <br> 0 = No|
| 248            | EOC/ABOVE GRADE SOCIAL STUDIES    | Above_SS        | Indicator if student took exam above enrolled grade level in Social studies | Indicator | 1 = Yes <br> 0 = No|
| 249            | EOC/ABOVE GRADE SCIENCE           | Above_Sc        | Indicator if student took exam above enrolled grade level in Science | Indicator | 1 = Yes <br> 0 = No|
| 252            | Designated Supports (Reading)     | Acco_DS_R       | Indicator if student got Designated Support accomodation in Reading | Indicator | 1 = Yes <br> 0 = No |
| 253            | Braille (Reading)                 | Acco_BR_R       | Indicator if student got Braille accomodation in Reading            | Indicator | 1 = Yes <br> 0 = No |
| 254            | Large Print (Reading)             | Acco_LP_R       | Indicator if student got Large Print accomodation in Reading        | Indicator | 1 = Yes <br> 0 = No |
| 256            | Extra Day (Reading)               | Acco_ED_R       | Indicator if student got Extra Day accomodation in Reading          | Indicator | 1 = Yes <br> 0 = No |
| 259            | Text-to-Speech (Reading)          | Acco_TTS_R      | Indicator if student got Text-to-Speech accomodation in Reading     | Indicator | 1 = Yes <br> 0 = No |
| 262            | Content and Language (Reading)    | Acco_CLS_R      | Indicator if student got Content and Language Support in Reading    | Indicator | 1 = Yes <br> 0 = No |
| 272            | Designated Supports (Math)        | Acco_DS_M       | Indicator if student got Designated Support accomodation in Math    | Indicator | 1 = Yes <br> 0 = No |
| 273            | Braille (Math)                    | Acco_BR_M       | Indicator if student got Braille accomodation in Math               | Indicator | 1 = Yes <br> 0 = No |
| 274            | Large Print (Math)                | Acco_LP_M       | Indicator if student got Large Print accomodation in Math           | Indicator | 1 = Yes <br> 0 = No |
| 276            | Extra Day (Math)                  | Acco_ED_M       | Indicator if student got Extra Day accomodation in Math             | Indicator | 1 = Yes <br> 0 = No |
| 279            | Text-to-Speech (Math)             | Acco_TTS_M      | Indicator if student got Text-to-Speech accomodation in Math        | Indicator | 1 = Yes <br> 0 = No |
| 282            | Content and Language (Math)       | Acco_CLS_M      | Indicator if student got Content and Language Support in Math       | Indicator | 1 = Yes <br> 0 = No |
| 292            | Designated Supports (Writing)     | Acco_DS_W       | Indicator if student got Designated Support accomodation in Writing | Indicator | 1 = Yes <br> 0 = No |
| 293            | Braille (Writing)                 | Acco_BR_W       | Indicator if student got Braille accomodation in Writing            | Indicator | 1 = Yes <br> 0 = No |
| 294            | Large Print (Writing)             | Acco_LP_W       | Indicator if student got Large Print accomodation in Writing        | Indicator | 1 = Yes <br> 0 = No |
| 295            | Extra Day (Writing)               | Acco_ED_W       | Indicator if student got Extra Day accomodation in Writing          | Indicator | 1 = Yes <br> 0 = No |
| 297            | Text-to-Speech (Writing)          | Acco_TTS_W      | Indicator if student got Text-to-Speech accomodation in Writing     | Indicator | 1 = Yes <br> 0 = No |
| 300            | Content and Language (Writing)    | Acco_CLS_W      | Indicator if student got Content and Language Support in Writing    | Indicator | 1 = Yes <br> 0 = No |
| 301            | Spelling Assistance (Writing)     | Acco_SP_W       | Indicator if student got Spelling Assistance Accomodation in Writing| Indicator | 1 = Yes <br> 0 = No |
| 312       | Designated Supports (Social Studies) | Acco_DS_SS | Indicator if student got Designated Support accomodation in Social Studies | Indicator | 1 = Yes <br> 0 = No |
| 313       | Braille (Social Studies)             | Acco_BR_SS | Indicator if student got Braille accomodation in Social Studies            | Indicator | 1 = Yes <br> 0 = No |
| 314       | Large Print (Social Studies)         | Acco_LP_SS | Indicator if student got Large Print accomodation in Social Studies        | Indicator | 1 = Yes <br> 0 = No |
| 316       | Extra Day (Social Studies)           | Acco_ED_SS | Indicator if student got Extra Day accomodation in Social Studies          | Indicator | 1 = Yes <br> 0 = No |
| 319       | Text-to-Speech (Social Studies)      | Acco_TTS_SS| Indicator if student got Text-to-Speech accomodation in Social Studies     | Indicator | 1 = Yes <br> 0 = No |
| 322       | Content and Language (Social Studies)| Acco_CLS_SS| Indicator if student got Content and Language Support in Social Studies    | Indicator | 1 = Yes <br> 0 = No |
| 332       | Designated Supports (Science) | Acco_DS_Sc | Indicator if student got Designated Support accomodation in Science               | Indicator | 1 = Yes <br> 0 = No |
| 333       | Braille (Science)             | Acco_BR_Sc | Indicator if student got Braille accomodation in Science                          | Indicator | 1 = Yes <br> 0 = No |
| 334       | Large Print (Science)         | Acco_LP_Sc | Indicator if student got Large Print accomodation in Science                      | Indicator | 1 = Yes <br> 0 = No |
| 336       | Extra Day (Science)           | Acco_ED_Sc | Indicator if student got Extra Day accomodation in Science                        | Indicator | 1 = Yes <br> 0 = No |
| 339       | Text-to-Speech (Science)      | Acco_TTS_Sc| Indicator if student got Text-to-Speech accomodation in Science                   | Indicator | 1 = Yes <br> 0 = No |
| 342       | Content and Language (Science)| Acco_CLS_Sc| Indicator if student got Content and Language Support in Science                  | Indicator | 1 = Yes <br> 0 = No |
| 351       | SCORE CODE READING            | Score_Code_R | Factor to explain if missing score for Reading         | Factor  |A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> P = Previously achieved Approaches Grade Level performance <br> W = Parental Waiver: Parent or guardian requested that a student not participate in the third testing opportunity in SSI grades and subjects <br> * = No information available for this subject  <br> S = Score |
| 352       | SCORE CODE MATH               | Score_Code_M | Factor to explain if missing score for Math            | Factor  |A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> P = Previously achieved Approaches Grade Level performance <br> W = Parental Waiver: Parent or guardian requested that a student not participate in the third testing opportunity in SSI grades and subjects <br> * = No information available for this subject  <br> S = Score |
| 353       | SCORE CODE WRITING            | Score_Code_W | Factor to explain if missing score for Writing         | Factor  |A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> S = Score |
| 354       | SCORE CODE Social Studies     | Score_Code_SS| Factor to explain if missing score for Social Studies  | Factor  |A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> * = No information available for this subject  <br> S = Score |
| 355       | SCORE CODE Science            | Score_Code_Sc| Factor to explain if missing score for Science         | Factor  |A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> * = No information available for this subject  <br> S = Score |
| 401-406   | READING REPORTING CATEGORY SCORES    | RC_Scores_R_1 <br> RC_Scores_R_2 <br> RC_Scores_R_3 | Number of correct items on reading test by reporting category   | Numeric  | 6 - 20 (Dependent on category and grade level) |
| 407-408   | READING RAW SCORE    | Raw_Score_R | Raw number correct in reading   | Numeric  | Grade 3: 0-40 <br> Grade 4: 0-44 <br> Grade 5: 0-46 <br> Grade 6: 0-48 <br> Grade 7: 0-50 <br> Grade 8: 0-52 |
| 409-412   | READING SCALE SCORE    | Scale_Score_R | Scale score in reading   | Numeric  | NA |
| 423       | MEETS GRADE LEVEL IN READING  | Meet_R  | Indicator if met reading standard  | Indicator | 1 = Yes <br> 0 = No |
| 424       | APPROACHES GRADE LEVEL IN READING  | Approach_R  | Indicator if approaches reading standard  | Indicator | 1 = Yes <br> 0 = No |
| 425       | MASTERS GRADE LEVEL IN READING  | Master_R  | Indicator if mastered reading standard  | Indicator | 1 = Yes <br> 0 = No |
| 426       | STAAR PROGRESS MEASURE IN READING   | Progress_R  | Factor of level on STAAR Progress Measure for Reading, as defined here: https://tea.texas.gov/student.assessment/progressmeasure/ | Factor  | 2 = Accelerated <br> 1 = Expected <br> 0 = Limited |
| 429       | ON TRACK TO MEET GRADE LEVEL IN READING | Grade_Track_R  | On track to meet grade level in Reading  | Indicator  | 1 = Yes <br> 0 = No |
| 434-437   | PREVIOUS-YEAR SCALE SCORE IN READING  | Pre_Scale_Score_R  | Previous year scale score in Reading | Numeric | NA |
| 440       | PREVIOUS-YEAR SCORE CODE IN READING   | Pre_Score_Code_R   | Previous year score code in Reading | Factor | A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> P = Previously achieved Approaches Grade Level performance <br> W = Parental Waiver: Parent or guardian requested that a student not participate in the third testing opportunity in SSI grades and subjects <br> * = No information available for this subject  <br> S = Score
| 607-611   | LEXILE MEASURE | Lexile_R | Lexile level based on Reading score | Character | A-Z |
| 612-614   | READING PERCENTILE | Percentile_R  | Percentile in Reading, compared with students who took same test prior year | Numeric | 0-99  |
| 751-758   | Math REPORTING CATEGORY SCORES    | RC_Scores_M_1 <br> RC_Scores_M_2 <br> RC_Scores_M_3 <br> RC_Scores_M_4 | Number of correct items on Math test by reporting category   | Numeric  | 6 - 20 (Dependent on category and grade level) |
| 761-762   | MATH RAW SCORE    | Raw_Score_M | Raw number correct in Math   | Numeric  | Grade 3: 0-32 <br> Grade 4: 0-34 <br> Grade 5: 0-36 <br> Grade 6: 0-38 <br> Grade 7: 0-40 <br> Grade 8: 0-42 |
| 763-766   | MATH SCALE SCORE    | Scale_Score_M | Scale score in Math   | Numeric  | NA |
| 777       | MEETS GRADE LEVEL IN MATH  | Meet_M  | Indicator if met Math standard  | Indicator | 1 = Yes <br> 0 = No |
| 778       | APPROACHES GRADE LEVEL IN MATH  | Approach_M  | Indicator if approaches Math standard  | Indicator | 1 = Yes <br> 0 = No |
| 779       | MASTERS GRADE LEVEL IN MATH  | Master_M  | Indicator if mastered Math standard  | Indicator | 1 = Yes <br> 0 = No |
| 780       | STAAR PROGRESS MEASURE IN MATH   | Progress_M  | Factor of level on STAAR Progress Measure for Math, as defined here: https://tea.texas.gov/student.assessment/progressmeasure/ | Factor  | 2 = Accelerated <br> 1 = Expected <br> 0 = Limited |
| 782       | ON TRACK TO MEET GRADE LEVEL IN MATH | Grade_Track_M  | On track to meet grade level in Math  | Indicator  | 1 = Yes <br> 0 = No |
| 787-790   | PREVIOUS-YEAR SCALE SCORE IN MATH  | Pre_Scale_Score_M  | Previous year scale score in Math | Numeric | NA |
| 793       | PREVIOUS-YEAR SCORE CODE IN MATH   | Pre_Score_Code_M   | Previous year score code in Math | Factor | A = Absent <br> D = No information available for this subject <br> O = Other (e.g., illness during testing, testing irregularity) <br> P = Previously achieved Approaches Grade Level performance <br> W = Parental Waiver: Parent or guardian requested that a student not participate in the third testing opportunity in SSI grades and subjects <br> * = No information available for this subject  <br> S = Score |
| 969-971   | MATH PERCENTILE | Percentile_M  | Percentile in MATH, compared with students who took same test prior year | Numeric | 0-99  |
| 972-976   | QUANTILE MEASURE | Quantile_M | Quantile based on MATH score | Numeric | NA |
| 1101-1106   | WRITING REPORTING CATEGORY SCORES    | RC_Scores_W_1 <br> RC_Scores_W_2 <br> RC_Scores_W_3 | Number of correct items on Writing test by reporting category   | Numeric  | 1 - 17 (Dependent on category and grade level) |
| 1107-1108   | Writing RAW SCORE    | Raw_Score_W | Raw number correct in Writing   | Numeric  | Grade 4: 0-32 <br> Grade 7: 0-46 |
| 1109-1112 | WRITING SCALE SCORE    | Scale_Score_W | Scale score in Writing   | Numeric  | NA |
| 1123      | MEETS GRADE LEVEL IN Writing  | Meet_W  | Indicator if met Writing standard  | Indicator | 1 = Yes <br> 0 = No |
| 1124      | APPROACHES GRADE LEVEL IN WRITING  | Approach_W  | Indicator if approaches Writing standard  | Indicator | 1 = Yes <br> 0 = No |
| 1125      | MASTERS GRADE LEVEL IN WRITING  | Master_W  | Indicator if mastered Writing standard  | Indicator | 1 = Yes <br> 0 = No |
| 1126      | WRITTEN COMPOSITION SCORE  | Comp_W   | Written composition score | Ordinal | 0 = Nonscorable <br> 2 = Very Limited <br> 3 = Between Very Limited and Basic <br> 4 = Basic <br> 5 = Between Basic and Satisfactory <br> 6 = Satisfactory <br> 7 = Between Satisfactory and Accomplished <br> 8 = Accomplished <br> Score of 1 is not possible |
| 1311-1313   | WRITING PERCENTILE | Percentile_W  | Percentile in Writing, compared with students who took same test prior year | Numeric | 0-99  |
| 1501-1508   | SOCIAL STUDIES REPORTING CATEGORY SCORES    | RC_Scores_SS_1 <br> RC_Scores_SS_2 <br> RC_Scores_SS_3 <br> RC_Scores_SS_4 | Number of correct items on Social Studies test by reporting category   | Numeric  | Category 1: 0-17 <br> Category 2: 0-10  <br> Category 3: 0-10  <br> Category 4: 0-7|
| 1509-1510   | SOCIAL STUDIES RAW SCORE    | Raw_Score_SS | Raw number correct in Social Studies   | Numeric  | Grade 8: 0-44 |
| 1511-1514 | SOCIAL STUDIES SCALE SCORE    | Scale_Score_SS | Scale score in Social Studies   | Numeric  | NA |
| 1525      | MEETS GRADE LEVEL IN SOCIAL STUDIES  | Meet_SS  | Indicator if met Social Studies standard  | Indicator | 1 = Yes <br> 0 = No |
| 1526      | APPROACHES GRADE LEVEL IN SOCIAL STUDIES  | Approach_SS  | Indicator if approaches Social Studies standard  | Indicator | 1 = Yes <br> 0 = No |
| 1527      | MASTERS GRADE LEVEL IN SOCIAL STUDIES  | Master_SS  | Indicator if mastered Social Studies standard  | Indicator | 1 = Yes <br> 0 = No |
| 1757-1759   | SOCIAL STUDIES PERCENTILE | Percentile_SS  | Percentile in Social Studies, compared with students who took same test prior year | Numeric | 0-99  |
| 1901-1908   | SCIENCE REPORTING CATEGORY SCORES    | RC_Scores_Sc_1 <br> RC_Scores_Sc_2 <br> RC_Scores_Sc_3 <br> RC_Scores_Sc_4 | Number of correct items on Science test by reporting category   | Numeric  | 0-12 (Dependent on category and grade level)|
| 1909-1910   | SCIENCE RAW SCORE    | Raw_Score_Sc | Raw number correct in Science   | Numeric  | Grade 5: 0-36 <br> Grade 8: 0-42 |
| 1911-1914 | SCIENCE SCALE SCORE    | Scale_Score_Sc | Scale score in Science   | Numeric  | NA |
| 1925      | MEETS GRADE LEVEL IN SCIENCE  | Meet_Sc  | Indicator if met Science standard  | Indicator | 1 = Yes <br> 0 = No |
| 1926      | APPROACHES GRADE LEVEL IN SCIENCE  | Approach_Sc  | Indicator if approaches Science standard  | Indicator | 1 = Yes <br> 0 = No |
| 1927      | MASTERS GRADE LEVEL IN SCIENCE  | Master_Sc  | Indicator if mastered Science standard  | Indicator | 1 = Yes <br> 0 = No |
| 2163-2165   | SCIENCE PERCENTILE | Percentile_Sc  | Percentile in Science, compared with students who took same test prior year | Numeric | 0-99  |
|2901-2905 | Lexile Measure Grade 3 | Lexile_3 | Lexile score for student when in grade 3 | Character | A-Z|
|2906-2910 | Lexile Measure Grade 4 | Lexile_4 | Lexile score for student when in grade 4 | Character | A-Z|
|2911-2915 | Lexile Measure Grade 5 | Lexile_5 | Lexile score for student when in grade 5 | Character | A-Z|
|2916-2920 | Lexile Measure Grade 6 | Lexile_6 | Lexile score for student when in grade 6 | Character | A-Z|
|2921-2925 | Lexile Measure Grade 7 | Lexile_7 | Lexile score for student when in grade 7 | Character | A-Z|
|2926-2930 | Lexile Measure Grade 8 | Lexile_8 | Lexile score for student when in grade 8 | Character | A-Z|
|2956-2960| Quantile Measure Grade 3 | Quantile_3 | Math quantile score for student when in grade 3| Numeric | NA|
|2961-2965| Quantile Measure Grade 4 | Quantile_4 | Math quantile score for student when in grade 4| Numeric | NA|
|2966-2970| Quantile Measure Grade 5 | Quantile_5 | Math quantile score for student when in grade 5| Numeric | NA|
|2971-2975| Quantile Measure Grade 6 | Quantile_6 | Math quantile score for student when in grade 6| Numeric | NA|
|2976-2980| Quantile Measure Grade 7 | Quantile_7 | Math quantile score for student when in grade 7| Numeric | NA|
|2981-2985| Quantile Measure Grade 8 | Quantile_8 | Math quantile score for student when in grade 8| Numeric | NA|
