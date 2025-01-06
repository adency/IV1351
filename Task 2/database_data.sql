--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (person_id, first_name, last_name, person_number) FROM stdin;
1	Madison	Ashely	19261042-2365
2	Brenden	Gabriel	19504143-2852
3	Nina	Unity	19656260-4552
4	Denise	Chanda	19824524-1306
5	Althea	Adria	19325111-8464
6	Elmo	Giacomo	19427625-0059
7	Craig	Megan	19082356-6727
8	Althea	Charles	19975854-8452
9	Elliott	Aquila	19349437-6463
10	Megan	Hakeem	19216159-3428
11	Mechelle	Chloe	19131272-5438
12	Odysseus	Yoshio	19055026-6261
13	Jamalia	Britanni	19326237-2634
14	Dane	Farrah	19145764-3349
15	Iliana	Tamara	19768582-1484
16	Gisela	Acton	19674349-1553
17	Joseph	Abel	19512388-1572
18	Angelica	Scott	19442283-5246
19	Robert	Declan	19752895-1275
20	Jael	Murphy	19958845-5367
21	Adara	Zane	19535166-7968
22	Hayfa	Abbot	19382156-2475
23	Aristotle	Macon	19577145-5423
24	Macy	Porter	19517356-6275
25	Kasimir	Madaline	19698265-3282
26	Tallulah	Melvin	19266702-4963
27	Morgan	Hakeem	19548604-7260
28	Zena	Chastity	19128265-6717
29	Anne	Martena	19114175-7266
30	Lisandra	Bo	19385136-4571
31	Boris	Tamara	19864011-7358
32	Regina	Felicia	19239882-6364
33	Vaughan	Aristotle	19897754-1774
34	Herman	Castor	19379342-3258
35	Dexter	Mufutau	19219484-3473
36	Len	Merritt	19834317-9424
37	Rachel	Natalie	19456347-2114
38	Darius	Rose	19141805-2709
39	Xaviera	Helen	19644848-0627
40	Dara	Hakeem	19213021-5875
41	Lydia	Camille	19233244-2174
42	Maggie	Nerea	19188051-9645
43	Tobias	Madeline	19359695-7119
44	Laurel	Aquila	19585557-8129
45	Cameron	Jermaine	19277815-6743
46	Kevin	Julie	19866182-4539
47	Palmer	Hammett	19574597-6123
48	Noah	Nicole	19142165-6025
49	Xaviera	Jeanette	19486196-9755
50	Trevor	Cole	19318222-7714
\.


--
-- Data for Name: adress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adress (adress_id, person_id, city, zip_code, street) FROM stdin;
1	1	Värnamo	67476	Drottninggatan 32
2	2	Sandviken	63926	Sveavägen 12
3	3	Ockelbo	60582	Kungsgatan 45
4	4	Linköping	49210	Vasagatan 8
5	5	Sandviken	19656	Storgatan 23
6	6	Hofors	27117	Kyrkogatan 17
7	7	Tranås	56924	Skolgatan 5
8	8	Mora	17648	Strandvägen 48
9	9	Vänersborg	77509	Östergatan 11
10	10	Söderhamn	52721	Västergatan 29
11	11	Avesta	28411	Norr Mälarstrand 3
12	12	Trollhättan	88238	Söder Mälarstrand 15
13	13	Hofors	14123	Hornsgatan 21
14	14	Sandviken	83647	Långholmsgatan 9
15	15	Norrköping	06552	Gotlandsgatan 42
16	16	Ludvika	45733	Ringvägen 35
17	17	Hudiksvall	73775	Fleminggatan 6
18	18	Gävle	25375	Scheelegatan 18
19	19	Mora	71377	Sankt Eriksgatan 4
20	20	Hofors	32661	Birger Jarlsgatan 27
21	21	Norrköping	04477	Karlavägen 10
22	22	Motala	44033	Narvavägen 38
23	23	Upplands Väsby	54389	Valhallavägen 41
24	24	Gävle	03625	Odengatan 13
25	25	Ludvika	64975	Rådmansgatan 25
26	26	Hudiksvall	06570	Tegnérgatan 7
27	27	Mjölby	37369	Upplandsgatan 19
28	28	Avesta	40316	Drottning Kristinas Väg 49
29	29	Vetlanda	48325	Linnégatan 42
30	30	Tumba	85013	Folkungagatan 25
31	31	Stockholm	42656	Götgatan 18
32	32	Borås	43836	Katarina Bangata 4
33	33	Nässjö	56488	Bondegatan 27
34	34	Tranås	57391	Nytorgsgatan 10
35	35	Bollnäs	73402	Södermalmsallén 38
36	36	Södertälje	37117	Åsögatan 41
37	37	Mora	35321	Hantverkargatan 13
38	38	Täby	12318	Kocksgatan 25
39	39	Alingsås	27284	Regeringsgatan 7
40	40	Ockelbo	17822	Mäster Samuelsgatan 19
41	41	Värnamo	73211	Hamngatan 49
42	42	Lidingo	74115	Kungsträdgården 2
43	43	Ludvika	83115	Sergels Torg 33
44	44	Sandviken	98404	Norrmalmstorg 16
45	45	Upplands Väsby	14116	Stureplan 4
46	46	Hofors	08627	Biblioteksgatan 28
47	47	Norrköping	79241	Humlegården 31
48	48	Stockholm	36447	Djurgårdsvägen 1
49	49	Vetlanda	86701	Skeppsbron 40
50	50	Norrköping	04768	Strandvägen 14
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email (email_id, email) FROM stdin;
1	sit.amet@hotmail.com
2	luctus.lobortis.class@protonmail.ca
3	habitant.morbi.tristique@aol.couk
4	vitae.mauris@hotmail.ca
5	faucibus@hotmail.ca
6	urna.et@aol.net
7	a.purus@google.couk
8	est.tempor.bibendum@google.net
9	porttitor.interdum@aol.org
10	lobortis.quam.a@outlook.edu
11	in.mi.pede@outlook.net
12	orci.lacus@protonmail.org
13	auctor.non@google.couk
14	molestie.orci@yahoo.net
15	elit.curabitur@yahoo.com
16	volutpat.nunc@yahoo.org
17	erat@aol.couk
18	gravida.praesent@outlook.net
19	sed@aol.couk
20	duis.cursus@outlook.ca
21	elit.pharetra@icloud.edu
22	fermentum.risus.at@yahoo.org
23	vitae.posuere@icloud.com
24	libero.lacus.varius@protonmail.net
25	metus.sit@icloud.couk
26	cras.eu@protonmail.com
27	tortor.at.risus@protonmail.couk
28	fermentum.risus@outlook.com
29	urna.et@aol.couk
30	in.nec@protonmail.net
31	eu@hotmail.couk
32	a.feugiat.tellus@yahoo.couk
33	pellentesque@google.ca
34	amet.risus.donec@icloud.com
35	aliquam.gravida@protonmail.edu
36	vitae.semper@outlook.org
37	nunc.interdum@outlook.couk
38	pellentesque.a.facilisis@aol.couk
39	libero.dui@aol.com
40	purus.accumsan.interdum@google.edu
41	augue.eu@icloud.couk
42	amet.consectetuer@yahoo.couk
43	nascetur@aol.net
44	nunc.ullamcorper@protonmail.com
45	aliquam.adipiscing.lobortis@aol.edu
46	suspendisse@hotmail.com
47	vel.faucibus.id@hotmail.org
48	sem@icloud.net
49	sed.est@hotmail.net
50	nulla.at@aol.com
\.


--
-- Data for Name: instructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor (instructor_id, person_id, employment_id, available) FROM stdin;
1	31	1	No
2	32	2	No
3	33	3	Yes
4	34	4	No
5	35	5	Yes
6	36	6	Yes
7	37	7	Yes
8	38	8	Yes
9	39	9	Yes
10	40	10	Yes
11	41	11	Yes
12	42	12	Yes
13	43	13	Yes
14	44	14	No
15	45	15	No
\.


--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson (lesson_id, instructor_id, lesson_code, lesson_type, skill_level, "time", date) FROM stdin;
1	1	GROINT01	groups	Intermediate	10:00:00	2024-11-05
2	2	INDADV02	individual	Advanced	11:00:00	2024-11-12
3	3	ENSINT03	ensemble	Intermediate	12:00:00	2024-11-15
4	4	INDADV04	individual	Advanced	13:00:00	2024-11-20
5	5	GROINT05	groups	Intermediate	14:00:00	2024-11-25
6	6	INDADV06	individual	Advanced	10:00:00	2024-12-01
7	7	GROBEG07	groups	Beginner	11:00:00	2024-12-10
8	8	ENSINT08	ensemble	Intermediate	12:00:00	2024-12-15
9	9	GROBEG09	groups	Beginner	13:00:00	2024-12-20
10	10	INDINT10	individual	Intermediate	14:00:00	2024-12-30
11	11	GROINT11	groups	Intermediate	10:00:00	2025-01-05
12	12	ENSADV12	ensemble	Advanced	11:00:00	2025-01-10
13	13	INDADV13	individual	Advanced	12:00:00	2025-01-15
14	14	GROINT14	groups	Intermediate	13:00:00	2025-01-20
15	15	ENSADV15	ensemble	Advanced	14:00:00	2025-01-25
16	1	INDINT16	individual	Intermediate	10:00:00	2025-02-01
17	3	ENSINT17	ensemble	Intermediate	11:00:00	2025-02-05
18	4	INDADV18	individual	Advanced	12:00:00	2025-02-10
19	7	GROBEG19	groups	Beginner	13:00:00	2025-02-20
20	15	ENSBEG20	ensemble	Beginner	14:00:00	2025-02-25
\.


--
-- Data for Name: ensemble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ensemble (ensemble_id, lesson_id, genre, min_students, max_students) FROM stdin;
1	3	Jazz	3	10
2	8	Jazz	3	10
3	12	Rock	3	10
4	15	Rock	3	10
5	17	Jazz	3	10
6	20	Classical	3	10
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (lesson_id, instrument_type, groups_id, max_students, min_students) FROM stdin;
1	Piano	1	10	3
5	Piano	3	10	3
7	Violin	5	10	3
9	Violin	7	10	3
11	Piano	9	10	3
14	Piano	11	10	3
19	Violin	13	10	3
\.


--
-- Data for Name: guardian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guardian (guardian_id, person_id) FROM stdin;
1	46
2	47
3	48
4	49
5	50
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (student_id, person_id, enrollment_id) FROM stdin;
1	1	FJB59
2	2	XDF66
3	3	KQO14
4	4	GMK16
5	5	IEF18
6	6	BDU77
7	7	OUV62
8	8	EPR74
9	9	LIX51
10	10	RUL87
11	11	CSM78
12	12	UUB99
13	13	ITR27
14	14	ZEN26
15	15	XWR58
16	16	LUD53
17	17	JER21
18	18	MFU71
19	19	TOS87
20	20	MWK98
21	21	SLC05
22	22	STW74
23	23	YNS43
24	24	SJX67
25	25	BBB31
26	26	HNU63
27	27	BWY23
28	28	ESW55
29	29	SQS33
30	30	KPC85
\.


--
-- Data for Name: guardian_student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guardian_student (student_id, guardian_id, relationship) FROM stdin;
27	2	Mother
4	5	Teacher
12	1	Fathern
25	5	Teacher
12	3	Mother
5	5	Fathern
28	3	Mother
18	4	Teacher
15	1	Guardian
21	5	Father
\.


--
-- Data for Name: individual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.individual (individual_id, lesson_id, instrument_type) FROM stdin;
1	2	Clarinet
2	4	Clarinet
3	6	Clarinet
4	10	Saxophone
5	13	Clarinet
6	16	Saxophone
7	18	Clarinet
\.


--
-- Data for Name: instructor_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_skill (instructor_skill_id, instructor_id, instrument_type, skill_level, genre) FROM stdin;
3	1	Violin	Intermediate	\N
4	1	\N	Intermediate	Jazz
5	2	Clarinet	Advanced	\N
6	2	\N	Advanced	Pop
7	2	Flute	Intermediate	\N
8	3	Piano	Intermediate	\N
9	3	\N	Intermediate	Folk
10	3	Trumpet	Advanced	\N
11	4	Guitar	Advanced	\N
12	4	\N	Advanced	Rock
13	5	Piano	Intermediate	\N
14	5	\N	Advanced	Metal
15	6	Clarinet	Advanced	\N
16	6	\N	Beginner	Pop
17	7	Clarinet	Intermediate	\N
18	7	\N	Beginner	Jazz
19	8	Piano	Intermediate	\N
20	8	\N	Intermediate	Blues
21	8	Guitar	Advanced	\N
22	9	Piano	Intermediate	\N
23	9	\N	Beginner	Rock
24	9	Clarinet	Beginner	\N
25	10	Guitar	Intermediate	\N
26	10	\N	Advanced	Folk
27	11	Cello	Intermediate	\N
28	11	\N	Advanced	Metal
29	12	Flute	Intermediate	\N
30	12	\N	Intermediate	Blues
31	13	Piano	Advanced	\N
32	13	\N	Beginner	Blues
33	13	Clarinet	Beginner	\N
34	14	Trumpet	Advanced	\N
35	14	\N	Beginner	Metal
36	15	Flute	Advanced	\N
37	15	\N	Beginner	Metal
\.


--
-- Data for Name: instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument (instrument_id, instrument_serial_number, instrument_type, brand, rental_fee, rent_period) FROM stdin;
1	A12345	Violin	Yamaha	20.00	30
2	B98765	Guitar	Fender	25.00	30
3	C54321	Flute	Pearl	15.00	30
4	D67890	Drum Kit	Tama	50.00	30
5	E11223	Saxophone	Selmer	40.00	30
6	F44567	Trumpet	Bach	30.00	30
7	G78901	Piano	Steinway	100.00	30
8	H33455	Violin	Stradivarius	150.00	30
9	I66778	Cello	Suzuki	75.00	30
10	J99001	Clarinet	Buffet	35.00	30
\.


--
-- Data for Name: lesson_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_price (lesson_price_id, lesson_id, price) FROM stdin;
1	1	150.00
2	2	100.00
3	3	200.00
4	4	100.00
5	5	150.00
6	6	100.00
7	7	150.00
8	8	200.00
9	9	150.00
10	10	100.00
11	11	150.00
12	12	200.00
13	13	100.00
14	14	150.00
15	15	200.00
16	16	100.00
17	17	200.00
18	18	100.00
19	19	150.00
20	20	200.00
\.


--
-- Data for Name: lesson_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_students (lesson_id, student_id) FROM stdin;
1	14
2	15
6	23
10	29
13	17
16	12
18	5
3	6
3	8
3	19
3	27
5	2
5	9
5	22
5	30
7	11
7	18
7	24
7	25
11	3
11	7
11	20
11	26
14	12
14	4
14	21
14	28
8	10
8	26
8	9
8	23
9	1
9	6
9	30
9	2
9	21
9	28
12	15
12	22
12	24
12	29
15	16
15	18
15	20
15	25
20	5
20	8
20	19
20	30
\.


--
-- Data for Name: person_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person_email (person_id, email_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	11
12	12
13	13
14	14
15	15
16	16
17	17
18	18
19	19
20	20
21	21
22	22
23	23
24	24
25	25
26	26
27	27
28	28
29	29
30	30
31	31
32	32
33	33
34	34
35	35
36	36
37	37
38	38
39	39
40	40
41	41
42	42
43	43
44	44
45	45
46	46
47	47
48	48
49	49
50	50
\.


--
-- Data for Name: phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phone (phone_id, phone) FROM stdin;
1	0725 591 552
2	0742 572 825
3	0728 566 922
4	0772 061 168
5	0794 312 520
6	0779 364 001
7	0765 871 510
8	0763 625 133
9	0785 605 859
10	0727 863 761
11	0772 797 549
12	0753 471 368
13	0710 546 587
14	0771 184 264
15	0743 834 715
16	0727 371 584
17	0734 252 463
18	0725 716 948
19	0778 850 326
20	0726 812 131
21	0755 468 671
22	0722 815 427
23	0782 021 521
24	0727 775 126
25	0748 816 753
26	0761 112 171
27	0736 035 171
28	0722 743 154
29	0703 780 681
30	0798 335 474
31	0731 878 120
32	0732 413 641
33	0710 345 447
34	0731 643 872
35	0738 524 527
36	0729 444 482
37	0737 371 469
38	0759 278 773
39	0756 849 483
40	0732 131 844
41	0798 234 477
42	0777 101 872
43	0737 394 377
44	0748 572 820
45	0777 228 213
46	0709 739 375
47	0757 877 654
48	0717 875 738
49	0729 813 800
50	0777 483 166
\.


--
-- Data for Name: person_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person_phone (person_id, phone_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	11
12	12
13	13
14	14
15	15
16	16
17	17
18	18
19	19
20	20
21	21
22	22
23	23
24	24
25	25
26	26
27	27
28	28
29	29
30	30
31	31
32	32
33	33
34	34
35	35
36	36
37	37
38	38
39	39
40	40
41	41
42	42
43	43
44	44
45	45
46	46
47	47
48	48
49	49
50	50
\.


--
-- Data for Name: rented_instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rented_instrument (rented_instrument_id, instrument_id, student_id, rent_start, rent_end) FROM stdin;
5	3	4	2024-12-04	2025-01-03
6	4	14	2024-11-29	2024-12-29
7	2	8	2024-11-27	2024-12-27
8	9	2	2024-11-26	2024-12-26
9	1	12	2024-12-03	2025-01-02
\.


--
-- Name: adress_adress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adress_adress_id_seq', 50, true);


--
-- Name: email_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_email_id_seq', 50, true);


--
-- Name: ensamble_ensamble_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ensamble_ensamble_id_seq', 6, true);


--
-- Name: groups_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_groups_id_seq', 13, true);


--
-- Name: guardian_guardian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guardian_guardian_id_seq', 5, true);


--
-- Name: individual_individual_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.individual_individual_id_seq', 7, true);


--
-- Name: instructor_instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_instructor_id_seq', 15, true);


--
-- Name: instructor_skill_instructor_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_skill_instructor_skill_id_seq', 37, true);


--
-- Name: instrument_instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrument_instrument_id_seq', 10, true);


--
-- Name: lesson_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_lesson_id_seq', 20, true);


--
-- Name: lesson_price_lesson_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_price_lesson_price_id_seq', 20, true);


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_person_id_seq', 50, true);


--
-- Name: phone_phone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phone_phone_id_seq', 50, true);


--
-- Name: rented_instrument_rented_instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rented_instrument_rented_instrument_id_seq', 9, true);


--
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_student_id_seq', 30, true);


--
-- PostgreSQL database dump complete
--

