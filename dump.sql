--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE restaurants (
    id integer NOT NULL,
    yelp_id character varying(64) NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE restaurants OWNER TO vagrant;

--
-- Name: restaurants_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE restaurants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE restaurants_id_seq OWNER TO vagrant;

--
-- Name: restaurants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE restaurants_id_seq OWNED BY restaurants.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE users (
    id integer NOT NULL,
    fname character varying(64) NOT NULL,
    lname character varying(64) NOT NULL,
    email character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    password character varying(64) NOT NULL,
    home_str character varying(64),
    home_cty character varying(64),
    home_sta character varying(20),
    home_zip character varying(15),
    work_str character varying(64),
    work_cty character varying(64),
    work_sta character varying(20),
    work_zip character varying(15),
    phone_num character varying(64)
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO vagrant;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: uservisits; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE uservisits (
    id integer NOT NULL,
    visit_id integer NOT NULL,
    user_id integer NOT NULL,
    rating integer
);


ALTER TABLE uservisits OWNER TO vagrant;

--
-- Name: uservisits_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE uservisits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE uservisits_id_seq OWNER TO vagrant;

--
-- Name: uservisits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE uservisits_id_seq OWNED BY uservisits.id;


--
-- Name: visits; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE visits (
    id integer NOT NULL,
    rest_id integer NOT NULL,
    date timestamp without time zone
);


ALTER TABLE visits OWNER TO vagrant;

--
-- Name: visits_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visits_id_seq OWNER TO vagrant;

--
-- Name: visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE visits_id_seq OWNED BY visits.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants ALTER COLUMN id SET DEFAULT nextval('restaurants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY uservisits ALTER COLUMN id SET DEFAULT nextval('uservisits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY visits ALTER COLUMN id SET DEFAULT nextval('visits_id_seq'::regclass);


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY restaurants (id, yelp_id, name) FROM stdin;
1	kiraku-berkeley	Kiraku
2	the-snack-shack-berkeley	The Snack Shack
3	wood-tavern-oakland	Wood Tavern
4	koja-kitchen-berkeley	KoJa Kitchen
5	angelines-louisiana-kitchen-berkeley	Angeline's Louisiana Kitchen
6	royal-rangoon-berkeley-2	Royal Rangoon
7	gather-berkeley	Gather
8	eureka-berkeley-3	Eureka!
9	simply-bowl-berkeley	Simply Bowl
10	southie-oakland	Southie
11	brazil-fresh-squeeze-cafe-berkeley	Brazil Fresh Squeeze Cafe
12	gypsys-trattoria-italiano-berkeley	Gypsy's Trattoria Italiano
13	tigerlily-berkeley-berkeley	Tigerlily Berkeley
14	smokes-poutinerie-berkeley	Smoke's Poutinerie
15	toss-noodle-bar-berkeley	Toss Noodle Bar
16	tivoli-caffe-berkeley	Tivoli Caffe
17	the-station-berkeley	The Station
18	great-china-berkeley	Great China
19	sushinista-berkeley	Sushinista
20	cheese-board-pizza-berkeley	Cheese Board Pizza
21	workshop-cafe-san-francisco	Workshop Cafe
22	chengdu-style-restaurant-berkeley	Chengdu Style Restaurant
23	famous-bao-berkeley	Famous Bao
24	chinese-express-berkeley	Chinese Express
25	dumpling-express-berkeley	Dumpling Express
26	lotus-house-berkeley	Lotus House
27	mandarin-house-berkeley	Mandarin House
28	sheng-kee-bakery-berkeley	Sheng Kee Bakery
29	viet-nam-village-berkeley	Viet Nam Village
30	thai-basil-cuisine-berkeley	Thai Basil Cuisine
31	tea-press-berkeley-2	Tea Press
32	gypsys-trattoria-italiano-berkeley	Gypsy
33	house-of-curries-berkeley-2	House of Curries
34	steves-bar-b-que-berkeley	Steve
\.


--
-- Name: restaurants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('restaurants_id_seq', 34, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (id, fname, lname, email, username, password, home_str, home_cty, home_sta, home_zip, work_str, work_cty, work_sta, work_zip, phone_num) FROM stdin;
1	Michelle	Kim	hi@mail.com	firstone	hihi	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	Johnny	Morales	jmorales0@odnoklassniki.ru	jmorales0	xFDUcq8sa	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	Helen	Mcdonald	hmcdonald1@goo.gl	hmcdonald1	0Eqere4q	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	Justin	Wood	jwood2@wordpress.com	jwood2	F0bGTWoAc	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	Scott	Williamson	swilliamson3@google.de	swilliamson3	9fuuwxL	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	Samuel	Russell	srussell4@ucoz.com	srussell4	HzQsLhD	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	Ruby	Mccoy	rmccoy5@fastcompany.com	rmccoy5	OqX8gp7Vg1J	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	Ruby	Flores	rflores6@whitehouse.gov	rflores6	43bfiXOAnHT	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	Donald	Ward	dward7@howstuffworks.com	dward7	VyhDygI	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	Patrick	Sanders	psanders8@myspace.com	psanders8	eDAGm6Y	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	Michael	Alexander	malexander9@eventbrite.com	malexander9	D5kz6yp	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	Wayne	Hansen	whansena@dmoz.org	whansena	DkxvFi6Fk8	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	Karen	Scott	kscottb@infoseek.co.jp	kscottb	3A35eWX	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	Kelly	Green	kgreenc@plala.or.jp	kgreenc	DghqzIL2O59	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	Juan	Burns	jburnsd@spotify.com	jburnsd	Re42RTVrU0eR	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	Fred	Brooks	fbrookse@quantcast.com	fbrookse	IUWlzpQ24lwl	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	Earl	Carter	ecarterf@digg.com	ecarterf	OODfRJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
18	Amanda	Shaw	ashawg@soup.io	ashawg	3zAx81VB	\N	\N	\N	\N	\N	\N	\N	\N	\N
19	Susan	Andrews	sandrewsh@wunderground.com	sandrewsh	NYpqvA3b	\N	\N	\N	\N	\N	\N	\N	\N	\N
20	Joan	Ford	jfordi@nbcnews.com	jfordi	7Qi87zHoZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
21	Earl	Banks	ebanksj@cloudflare.com	ebanksj	N2dMgVt	\N	\N	\N	\N	\N	\N	\N	\N	\N
22	Amy	Scott	ascottk@yahoo.com	ascottk	vLajNHF0zo	\N	\N	\N	\N	\N	\N	\N	\N	\N
23	Louis	Diaz	ldiazl@storify.com	ldiazl	uwRCfw8Xm2B	\N	\N	\N	\N	\N	\N	\N	\N	\N
24	Brenda	Chavez	bchavezm@odnoklassniki.ru	bchavezm	BtdJ8bXHhlf	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	Margaret	Murray	mmurrayn@biglobe.ne.jp	mmurrayn	uT2HMW7Uer6	\N	\N	\N	\N	\N	\N	\N	\N	\N
26	Katherine	Myers	kmyerso@nps.gov	kmyerso	SdfaV7O3Z6aJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
27	Bonnie	Watson	bwatsonp@skyrock.com	bwatsonp	SuGJnYmlcp6	\N	\N	\N	\N	\N	\N	\N	\N	\N
28	Scott	Thomas	sthomasq@imdb.com	sthomasq	TlunXpDG5Q6H	\N	\N	\N	\N	\N	\N	\N	\N	\N
29	Joan	Lawrence	jlawrencer@storify.com	jlawrencer	7oVVkY4jyu3i	\N	\N	\N	\N	\N	\N	\N	\N	\N
30	Heather	Frazier	hfraziers@omniture.com	hfraziers	1NxzpNoE	\N	\N	\N	\N	\N	\N	\N	\N	\N
31	Andrew	Washington	awashingtont@marketwatch.com	awashingtont	DjuVfQmgNa	\N	\N	\N	\N	\N	\N	\N	\N	\N
32	Marilyn	Day	mdayu@g.co	mdayu	Zblb69	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	Linda	Watson	lwatsonv@homestead.com	lwatsonv	qn7QBaOR24Ak	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	Patricia	Sullivan	psullivanw@admin.ch	psullivanw	tyRXrLX7PPy5	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	Randy	Warren	rwarrenx@sakura.ne.jp	rwarrenx	1Hxjyoc	\N	\N	\N	\N	\N	\N	\N	\N	\N
36	Walter	Hernandez	whernandezy@wikispaces.com	whernandezy	CkIkHLWC5ne	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	Lori	Morales	lmoralesz@taobao.com	lmoralesz	rGy8gzvpRuC	\N	\N	\N	\N	\N	\N	\N	\N	\N
38	Paula	Olson	polson10@macromedia.com	polson10	crLZKIKc	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	Christina	Bishop	cbishop11@miitbeian.gov.cn	cbishop11	MstZaS9gyjF	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	Antonio	Medina	amedina12@sitemeter.com	amedina12	6eEsyb	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	Frank	Black	fblack13@google.pl	fblack13	p78MnOgyf	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	Kenneth	Welch	kwelch14@istockphoto.com	kwelch14	l26lmN	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	Annie	Stevens	astevens15@mit.edu	astevens15	4CneWU	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	Linda	Smith	lsmith16@comcast.net	lsmith16	6HqqZd	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	Randy	Morales	rmorales17@economist.com	rmorales17	NxbWI6A	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	Bobby	Hicks	bhicks18@miibeian.gov.cn	bhicks18	8b95wIb8IZ1y	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	Carlos	Larson	clarson19@opensource.org	clarson19	b6HhIoi2Ywl2	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	Clarence	Romero	cromero1a@cyberchimps.com	cromero1a	I5mWMZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	Peter	Garza	pgarza1b@china.com.cn	pgarza1b	SUIVicfZe	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	Jesse	Patterson	jpatterson1c@360.cn	jpatterson1c	Bkwjzp	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	Bobby	Castillo	bcastillo1d@walmart.com	bcastillo1d	UPVPhn8	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	Jonathan	Wallace	jwallace1e@google.ru	jwallace1e	f4bI0tB	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	Lois	Diaz	ldiaz1f@sogou.com	ldiaz1f	rFtyfdik	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	Phyllis	Ruiz	pruiz1g@biblegateway.com	pruiz1g	tSvVwVVl	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	Susan	Clark	sclark1h@psu.edu	sclark1h	8GGkcArlR7P	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	Helen	Palmer	hpalmer1i@npr.org	hpalmer1i	dBbGhcuJaf	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	Judy	Wallace	jwallace1j@free.fr	jwallace1j	ZHNu6f9SlE	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	Joshua	Chavez	jchavez1k@oakley.com	jchavez1k	WRecjD	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	Susan	Jones	sjones1l@dell.com	sjones1l	FSS404Ss7q	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	Marie	Simpson	msimpson1m@xrea.com	msimpson1m	9BVJVkCBLWjj	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	Debra	Torres	dtorres1n@unesco.org	dtorres1n	KugC6dX	\N	\N	\N	\N	\N	\N	\N	\N	\N
62	George	Fuller	gfuller1o@mozilla.com	gfuller1o	AjwYmHGMBUX	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	Robert	Arnold	rarnold1p@symantec.com	rarnold1p	d4SqHFN	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	Dennis	Webb	dwebb1q@freewebs.com	dwebb1q	vzu43KvEn	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	Elizabeth	Jackson	ejackson1r@google.co.jp	ejackson1r	mB6XdKcig	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	Raymond	Walker	rwalker1s@furl.net	rwalker1s	SFa5T7LjNeW2	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	Jack	Robertson	jrobertson1t@1688.com	jrobertson1t	j1qrud	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	Tina	Lopez	tlopez1u@odnoklassniki.ru	tlopez1u	aXgzaikcx3	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	Amy	Peters	apeters1v@cpanel.net	apeters1v	AUzeEMsoE	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	Tammy	Morgan	tmorgan1w@posterous.com	tmorgan1w	Iq3i25h	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	Virginia	Little	vlittle1x@nih.gov	vlittle1x	MEwdrvnm	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	Melissa	Warren	mwarren1y@diigo.com	mwarren1y	950xoD	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	Eric	Walker	ewalker1z@yahoo.co.jp	ewalker1z	chZc6ngmis	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	Wanda	Daniels	wdaniels20@cnn.com	wdaniels20	yyL82LO5U	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	Marie	Dunn	mdunn21@odnoklassniki.ru	mdunn21	RgIehGx	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	Adam	Cole	acole22@sciencedaily.com	acole22	m1KOZHRg	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	Bruce	Gray	bgray23@buzzfeed.com	bgray23	1n8chMRgQ	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	Julia	Roberts	jroberts24@youtu.be	jroberts24	lIlOwAr	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	Frances	Wilson	fwilson25@soup.io	fwilson25	px9bIajKM	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	Ruby	Romero	rromero26@mapquest.com	rromero26	RoQlqi	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	Fred	Wood	fwood27@cargocollective.com	fwood27	Uikp504a	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	Albert	Burke	aburke28@gmpg.org	aburke28	RDFK5COnp	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	Peter	Gibson	pgibson29@dailymail.co.uk	pgibson29	xiFbzHyLMe2B	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	Jerry	Carpenter	jcarpenter2a@gmpg.org	jcarpenter2a	DRhpjpi8kzT	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	Chris	Lee	clee2b@ca.gov	clee2b	eWWcN2vA	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	Catherine	Burke	cburke2c@mashable.com	cburke2c	hyPmEk	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	Julie	Washington	jwashington2d@feedburner.com	jwashington2d	JWCde93U	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	Shawn	Holmes	sholmes2e@cnet.com	sholmes2e	SgpNfoFHD0L	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	Arthur	Lynch	alynch2f@networkadvertising.org	alynch2f	nBp4PUfOSH3X	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	Susan	Fox	sfox2g@jimdo.com	sfox2g	XHzwFvAhD	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	Ashley	Hunter	ahunter2h@live.com	ahunter2h	XxkztLLfQZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	Melissa	Lopez	mlopez2i@printfriendly.com	mlopez2i	02dySla	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	Deborah	Stanley	dstanley2j@icio.us	dstanley2j	6vqiWOmTOQp	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	Donna	Castillo	dcastillo2k@storify.com	dcastillo2k	a4hpq2	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	Brian	Shaw	bshaw2l@imgur.com	bshaw2l	WOE0DzhRsgr1	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	Wayne	Garrett	wgarrett2m@ebay.co.uk	wgarrett2m	AyUetTdg	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	Melissa	Gibson	mgibson2n@hhs.gov	mgibson2n	oCXZD8a	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	Thomas	Hall	thall2o@uol.com.br	thall2o	SRKCQlQPV	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	Jonathan	Cunningham	jcunningham2p@umn.edu	jcunningham2p	BPYKbJVH6	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	Rebecca	Peters	rpeters2q@jigsy.com	rpeters2q	eEVrEOOXMWY	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	Virginia	Mendoza	vmendoza2r@quantcast.com	vmendoza2r	8v9E5J	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	Thomas	Morris	tmorris2s@cmu.edu	tmorris2s	QSbBTJJEU5KX	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	Jacqueline	Berry	jberry2t@weibo.com	jberry2t	t4Ct4fxACZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	Andrew	Nichols	anichols2u@apple.com	anichols2u	KcaDGL2Fs	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	Maria	Sanchez	msanchez2v@twitter.com	msanchez2v	89WGbYNsUFXd	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	Susan	Snyder	ssnyder2w@wikipedia.org	ssnyder2w	0zBswrw	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	Sean	Mcdonald	smcdonald2x@cmu.edu	smcdonald2x	LHOEBuZ61zEw	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	Eugene	Garrett	egarrett2y@shutterfly.com	egarrett2y	bWg1xMHCm	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	Brandon	Mills	bmills2z@webnode.com	bmills2z	JSR3d3vh	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	Donald	Evans	devans30@europa.eu	devans30	tUfVLNup4	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	Maria	Hayes	mhayes31@geocities.jp	mhayes31	fbwWU4cha	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	David	Dean	ddean32@twitpic.com	ddean32	hibZmwQad	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	Frank	Alexander	falexander33@webs.com	falexander33	xUaijCtQ	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	Marilyn	Porter	mporter34@nifty.com	mporter34	1SFC5nrBvGB	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	Kevin	Wheeler	kwheeler35@si.edu	kwheeler35	AogXJas0b	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	George	Black	gblack36@ifeng.com	gblack36	AOvcwRYM	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	Larry	Ward	lward37@businesswire.com	lward37	NJfPChQV6	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	Michael	Carter	mcarter38@ed.gov	mcarter38	1BmjLxwFx3m	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	Philip	Tucker	ptucker39@loc.gov	ptucker39	Jiewl4Th3oy	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	Irene	Hicks	ihicks3a@merriam-webster.com	ihicks3a	WGcU588yxNzk	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	Joe	Griffin	jgriffin3b@boston.com	jgriffin3b	rwOzVRi	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	Doris	Johnston	djohnston3c@i2i.jp	djohnston3c	sGrzOiw69Gd0	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	Kenneth	Holmes	kholmes3d@amazon.co.uk	kholmes3d	ZVw7MlSX	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	Dorothy	Clark	dclark3e@prlog.org	dclark3e	g0wcg288	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	Andrew	Mitchell	amitchell3f@businessinsider.com	amitchell3f	EGAdCsfeJO	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	Stephanie	Sims	ssims3g@wikimedia.org	ssims3g	ifz4URx7K	\N	\N	\N	\N	\N	\N	\N	\N	\N
127	Jennifer	Nichols	jnichols3h@marriott.com	jnichols3h	x8DPNQjqb	\N	\N	\N	\N	\N	\N	\N	\N	\N
128	George	Morris	gmorris3i@privacy.gov.au	gmorris3i	rL2PgL5JbcK	\N	\N	\N	\N	\N	\N	\N	\N	\N
129	Roy	Fernandez	rfernandez3j@yale.edu	rfernandez3j	oVfODh	\N	\N	\N	\N	\N	\N	\N	\N	\N
130	Albert	Gonzalez	agonzalez3k@goo.gl	agonzalez3k	GVOgeH	\N	\N	\N	\N	\N	\N	\N	\N	\N
131	Antonio	Parker	aparker3l@scientificamerican.com	aparker3l	fzKLd2	\N	\N	\N	\N	\N	\N	\N	\N	\N
132	Ashley	Moreno	amoreno3m@earthlink.net	amoreno3m	BNwMDlMVxcGE	\N	\N	\N	\N	\N	\N	\N	\N	\N
133	Michelle	White	mwhite3n@shareasale.com	mwhite3n	AfDZ8PmA6qyu	\N	\N	\N	\N	\N	\N	\N	\N	\N
134	Alan	Stone	astone3o@oracle.com	astone3o	zGF9ijhzwg	\N	\N	\N	\N	\N	\N	\N	\N	\N
135	Karen	Gordon	kgordon3p@ca.gov	kgordon3p	SbHWx5TPoU	\N	\N	\N	\N	\N	\N	\N	\N	\N
136	Jerry	Payne	jpayne3q@networkadvertising.org	jpayne3q	p2ROzH0	\N	\N	\N	\N	\N	\N	\N	\N	\N
137	Diane	Clark	dclark3r@soundcloud.com	dclark3r	r4YmvXyUyy	\N	\N	\N	\N	\N	\N	\N	\N	\N
138	Roy	Mendoza	rmendoza3s@reference.com	rmendoza3s	fOHS7BhRB	\N	\N	\N	\N	\N	\N	\N	\N	\N
139	Annie	Carroll	acarroll3t@wp.com	acarroll3t	NQ1xwDHDOB2	\N	\N	\N	\N	\N	\N	\N	\N	\N
140	Scott	Russell	srussell3u@usgs.gov	srussell3u	LyF3ZeEXEV	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	Roger	Alexander	ralexander3v@desdev.cn	ralexander3v	PuHbOCZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	Scott	Hamilton	shamilton3w@taobao.com	shamilton3w	ehocQ5cO	\N	\N	\N	\N	\N	\N	\N	\N	\N
143	Laura	Cunningham	lcunningham3x@spotify.com	lcunningham3x	HftPVF	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	Sara	Murphy	smurphy3y@ted.com	smurphy3y	AN8foXk	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	Benjamin	Hudson	bhudson3z@google.co.uk	bhudson3z	0A2brZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	Samuel	Gibson	sgibson40@dion.ne.jp	sgibson40	9rf1kzFfzZ1	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	Jennifer	Williamson	jwilliamson41@networkadvertising.org	jwilliamson41	XXK4MV	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	Theresa	Thompson	tthompson42@wikispaces.com	tthompson42	0wW9HbpiOIud	\N	\N	\N	\N	\N	\N	\N	\N	\N
149	Nancy	Mitchell	nmitchell43@youtube.com	nmitchell43	IB139g	\N	\N	\N	\N	\N	\N	\N	\N	\N
150	Ernest	Sanchez	esanchez44@google.com.au	esanchez44	qIP83XBVJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	Earl	Hicks	ehicks45@blogs.com	ehicks45	upeGLKXVCbw	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	Anna	Peterson	apeterson46@storify.com	apeterson46	knrSo6XUx	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	Lois	Welch	lwelch47@globo.com	lwelch47	78cMb6a0TQ9F	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	Antonio	Walker	awalker48@vimeo.com	awalker48	iOx9y15tseV	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	Irene	Dean	idean49@paypal.com	idean49	hHhYk0N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	Ryan	Medina	rmedina4a@t.co	rmedina4a	EilmpDLcX	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	Keith	Reid	kreid4b@seattletimes.com	kreid4b	6dFEbh6tCU	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	Teresa	Nguyen	tnguyen4c@ihg.com	tnguyen4c	2D2HMqvrB	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	Kimberly	Murray	kmurray4d@purevolume.com	kmurray4d	HKFhXY	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	Peter	Williamson	pwilliamson4e@angelfire.com	pwilliamson4e	B9M7bJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	Shirley	Cooper	scooper4f@amazonaws.com	scooper4f	CK4EiUg1	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	Mark	Kelly	mkelly4g@accuweather.com	mkelly4g	3JKIkbFLPJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	Kevin	Thomas	kthomas4h@scribd.com	kthomas4h	hDxXXfs	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	Dennis	Olson	dolson4i@php.net	dolson4i	aLxLYwiVC4	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	Ann	Baker	abaker4j@multiply.com	abaker4j	qhoH95KN	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	Heather	Martinez	hmartinez4k@dailymotion.com	hmartinez4k	oQXHw2uz	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	Marilyn	Dixon	mdixon4l@skyrock.com	mdixon4l	238dW59wpuOQ	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	Christopher	Morrison	cmorrison4m@ow.ly	cmorrison4m	alCshAb	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	Rachel	Hughes	rhughes4n@usa.gov	rhughes4n	ePYzXNgia	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	Howard	Diaz	hdiaz4o@163.com	hdiaz4o	JNYeyGkt65	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	Marie	Bradley	mbradley4p@acquirethisname.com	mbradley4p	qkTacXT0Bto	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	Ruby	Thomas	rthomas4q@fema.gov	rthomas4q	Y5iMd4LiArb	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	Carl	Stephens	cstephens4r@yellowbook.com	cstephens4r	KIzw3GtpZKlE	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	Martin	Gomez	mgomez4s@sohu.com	mgomez4s	7Wf2cTDYiEU	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	Kelly	Martin	kmartin4t@techcrunch.com	kmartin4t	2Qe8Ec	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	Michael	Green	mgreen4u@ox.ac.uk	mgreen4u	X8JSeznpN9	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	Joyce	Johnston	jjohnston4v@ted.com	jjohnston4v	gWt9fpgNzo	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	Gloria	Ruiz	gruiz4w@epa.gov	gruiz4w	s9MxGD7sQwg	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	Robin	Parker	rparker4x@issuu.com	rparker4x	cLoEZ3	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	Samuel	Richards	srichards4y@newsvine.com	srichards4y	rZ5wtVzjZeZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	Steven	Gibson	sgibson4z@yelp.com	sgibson4z	z8ulD7gGRNnC	\N	\N	\N	\N	\N	\N	\N	\N	\N
182	Jennifer	Shaw	jshaw50@gizmodo.com	jshaw50	Zemn6b3	\N	\N	\N	\N	\N	\N	\N	\N	\N
183	Michelle	Knight	mknight51@bizjournals.com	mknight51	3eg74JyARv	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	Sarah	Gray	sgray52@census.gov	sgray52	VFgcPZi	\N	\N	\N	\N	\N	\N	\N	\N	\N
185	Sandra	Henderson	shenderson53@google.pl	shenderson53	cq3FcvMBS	\N	\N	\N	\N	\N	\N	\N	\N	\N
186	Angela	Warren	awarren54@sphinn.com	awarren54	jIidJ35ItiL	\N	\N	\N	\N	\N	\N	\N	\N	\N
187	Douglas	Edwards	dedwards55@bing.com	dedwards55	qLAFKOAzI4x	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	Laura	Day	lday56@biglobe.ne.jp	lday56	PFVtaKtJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
189	Patricia	Gonzalez	pgonzalez57@shinystat.com	pgonzalez57	qUz1qYqZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
190	Bobby	Cole	bcole58@vk.com	bcole58	yCQjxK1tQ5k	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	Jean	Jenkins	jjenkins59@dropbox.com	jjenkins59	g2UgbYf	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	Louis	Day	lday5a@vinaora.com	lday5a	4qXA4N	\N	\N	\N	\N	\N	\N	\N	\N	\N
193	Angela	Holmes	aholmes5b@etsy.com	aholmes5b	JFlQh9Neug	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	Gary	Sullivan	gsullivan5c@mysql.com	gsullivan5c	B2valRjkn	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	Andrea	Ramos	aramos5d@cnn.com	aramos5d	fWet4UUp	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	Sara	Matthews	smatthews5e@princeton.edu	smatthews5e	xg0CKh8Hbl	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	Albert	Richards	arichards5f@un.org	arichards5f	4EqB0zJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
198	Charles	Moreno	cmoreno5g@comcast.net	cmoreno5g	y8IvyMQpwDj	\N	\N	\N	\N	\N	\N	\N	\N	\N
199	Pamela	Lynch	plynch5h@mail.ru	plynch5h	SClTv7D	\N	\N	\N	\N	\N	\N	\N	\N	\N
200	Deborah	Patterson	dpatterson5i@networkadvertising.org	dpatterson5i	zkj7tMKB939T	\N	\N	\N	\N	\N	\N	\N	\N	\N
201	Bonnie	Porter	bporter5j@whitehouse.gov	bporter5j	Or3vSb	\N	\N	\N	\N	\N	\N	\N	\N	\N
202	Judy	Hunt	jhunt5k@theatlantic.com	jhunt5k	EJ6gDV	\N	\N	\N	\N	\N	\N	\N	\N	\N
203	Donald	Alvarez	dalvarez5l@opera.com	dalvarez5l	q6OOj5OZ7y7	\N	\N	\N	\N	\N	\N	\N	\N	\N
204	Jonathan	Fowler	jfowler5m@360.cn	jfowler5m	D2Sv46caqE	\N	\N	\N	\N	\N	\N	\N	\N	\N
205	Adam	Torres	atorres5n@chronoengine.com	atorres5n	cIGayfXu8yhh	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	Jacqueline	Harrison	jharrison5o@desdev.cn	jharrison5o	oTsBI3Afq	\N	\N	\N	\N	\N	\N	\N	\N	\N
207	Gerald	Mendoza	gmendoza5p@kickstarter.com	gmendoza5p	RYm8Q6bf	\N	\N	\N	\N	\N	\N	\N	\N	\N
208	Janet	Thomas	jthomas5q@google.com.br	jthomas5q	tClRUao	\N	\N	\N	\N	\N	\N	\N	\N	\N
209	Jerry	Hart	jhart5r@google.com	jhart5r	lqpHFM	\N	\N	\N	\N	\N	\N	\N	\N	\N
210	Ralph	Mitchell	rmitchell5s@bloglovin.com	rmitchell5s	clLJXDD	\N	\N	\N	\N	\N	\N	\N	\N	\N
211	Sean	Russell	srussell5t@forbes.com	srussell5t	21qTHgmJHOI	\N	\N	\N	\N	\N	\N	\N	\N	\N
212	Alice	Garcia	agarcia5u@fema.gov	agarcia5u	ES8UciPu5rO	\N	\N	\N	\N	\N	\N	\N	\N	\N
213	Walter	Coleman	wcoleman5v@imdb.com	wcoleman5v	mocxyRH4vs	\N	\N	\N	\N	\N	\N	\N	\N	\N
214	Elizabeth	Clark	eclark5w@hexun.com	eclark5w	vXQTQz6XJTm	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	Denise	Foster	dfoster5x@technorati.com	dfoster5x	VaZibSLsQ	\N	\N	\N	\N	\N	\N	\N	\N	\N
216	Peter	Harvey	pharvey5y@over-blog.com	pharvey5y	5fhVL8ndj	\N	\N	\N	\N	\N	\N	\N	\N	\N
217	Martha	Jackson	mjackson5z@angelfire.com	mjackson5z	fpCULde	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	Annie	Harper	aharper60@i2i.jp	aharper60	htZEpJ3E	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	Bobby	Price	bprice61@shutterfly.com	bprice61	9kNzqjGhz1	\N	\N	\N	\N	\N	\N	\N	\N	\N
220	Jennifer	Lee	jlee62@51.la	jlee62	BCGdRK	\N	\N	\N	\N	\N	\N	\N	\N	\N
221	Carolyn	Stanley	cstanley63@sbwire.com	cstanley63	SeNGZbAF59e8	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	Cynthia	Austin	caustin64@wordpress.com	caustin64	JSxbXATwWcPs	\N	\N	\N	\N	\N	\N	\N	\N	\N
223	Jennifer	Stevens	jstevens65@buzzfeed.com	jstevens65	PnJ0kGlReTIq	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	Richard	Collins	rcollins66@prnewswire.com	rcollins66	BC1L9b	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	Anne	James	ajames67@xing.com	ajames67	PaDHpGsE37K	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	Benjamin	Bailey	bbailey68@bloomberg.com	bbailey68	cIWt0j5EEPr	\N	\N	\N	\N	\N	\N	\N	\N	\N
227	Jimmy	Robertson	jrobertson69@cdc.gov	jrobertson69	g0P8u3h5d5N	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	Barbara	Watkins	bwatkins6a@cisco.com	bwatkins6a	6AazYp5yZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	Eugene	Morales	emorales6b@sun.com	emorales6b	VfGBRJUG0Bj	\N	\N	\N	\N	\N	\N	\N	\N	\N
230	Raymond	Marshall	rmarshall6c@google.com.au	rmarshall6c	Eeoaewp	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	Terry	Bradley	tbradley6d@furl.net	tbradley6d	X6ULI1	\N	\N	\N	\N	\N	\N	\N	\N	\N
232	Michael	Carter	mcarter6e@e-recht24.de	mcarter6e	jFZ1hdmzuSP	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	Chris	Moore	cmoore6f@people.com.cn	cmoore6f	dya2R9afH4	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	Walter	Snyder	wsnyder6g@state.tx.us	wsnyder6g	FOnF6X	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	Diana	Meyer	dmeyer6h@github.com	dmeyer6h	kQkfEWyDo3	\N	\N	\N	\N	\N	\N	\N	\N	\N
236	Russell	Robertson	rrobertson6i@xinhuanet.com	rrobertson6i	9qnWNXJNwjM	\N	\N	\N	\N	\N	\N	\N	\N	\N
237	Judith	Evans	jevans6j@github.com	jevans6j	Fu9u4c	\N	\N	\N	\N	\N	\N	\N	\N	\N
238	Dorothy	Kelley	dkelley6k@canalblog.com	dkelley6k	QIMffUOjnmM	\N	\N	\N	\N	\N	\N	\N	\N	\N
239	Stephanie	Snyder	ssnyder6l@51.la	ssnyder6l	lGKXShWp5wW1	\N	\N	\N	\N	\N	\N	\N	\N	\N
240	Ann	Fernandez	afernandez6m@over-blog.com	afernandez6m	v7DIDojD	\N	\N	\N	\N	\N	\N	\N	\N	\N
241	Charles	Wood	cwood6n@hubpages.com	cwood6n	d8JC76K	\N	\N	\N	\N	\N	\N	\N	\N	\N
242	Peter	Stephens	pstephens6o@answers.com	pstephens6o	deDeMjx	\N	\N	\N	\N	\N	\N	\N	\N	\N
243	Steve	Webb	swebb6p@pagesperso-orange.fr	swebb6p	8UfaJ01	\N	\N	\N	\N	\N	\N	\N	\N	\N
244	Stephanie	Thomas	sthomas6q@lulu.com	sthomas6q	cvrOjASFXk1R	\N	\N	\N	\N	\N	\N	\N	\N	\N
245	Samuel	Holmes	sholmes6r@amazonaws.com	sholmes6r	8Q3ODwoHcd8	\N	\N	\N	\N	\N	\N	\N	\N	\N
246	Nicole	Wallace	nwallace6s@fda.gov	nwallace6s	s9kh1rN	\N	\N	\N	\N	\N	\N	\N	\N	\N
247	Jesse	Harper	jharper6t@purevolume.com	jharper6t	yxiMKTG	\N	\N	\N	\N	\N	\N	\N	\N	\N
248	Chris	Fowler	cfowler6u@cbsnews.com	cfowler6u	WHxGyUnYlasj	\N	\N	\N	\N	\N	\N	\N	\N	\N
249	Ashley	Kim	akim6v@tripadvisor.com	akim6v	RvUwMAbDHlT	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	Gloria	Mason	gmason6w@omniture.com	gmason6w	Z0n9qUF7a	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	Frances	Stephens	fstephens6x@purevolume.com	fstephens6x	7tZA99r	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	Nicholas	Tucker	ntucker6y@bravesites.com	ntucker6y	32yhSq7dD0a	\N	\N	\N	\N	\N	\N	\N	\N	\N
253	Frank	Hansen	fhansen6z@surveymonkey.com	fhansen6z	T8m7Vr9SnSG	\N	\N	\N	\N	\N	\N	\N	\N	\N
254	Sean	Alexander	salexander70@time.com	salexander70	vgAliVktP	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	Larry	Stevens	lstevens71@blogspot.com	lstevens71	dWTnQ3fl	\N	\N	\N	\N	\N	\N	\N	\N	\N
256	Robin	Lane	rlane72@apache.org	rlane72	5Hrx9sZz7x9	\N	\N	\N	\N	\N	\N	\N	\N	\N
257	Gregory	Robertson	grobertson73@elegantthemes.com	grobertson73	p5WTukvrw	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	Justin	Larson	jlarson74@dmoz.org	jlarson74	fxifuBlm	\N	\N	\N	\N	\N	\N	\N	\N	\N
259	Jose	Perry	jperry75@baidu.com	jperry75	fIWUruR6	\N	\N	\N	\N	\N	\N	\N	\N	\N
260	Kimberly	Shaw	kshaw76@geocities.com	kshaw76	rrN6Y2j	\N	\N	\N	\N	\N	\N	\N	\N	\N
261	Phillip	Howard	phoward77@mysql.com	phoward77	dblSIv	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	Judy	Garrett	jgarrett78@drupal.org	jgarrett78	Q8KzKYTXi	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	Paula	Perez	pperez79@unesco.org	pperez79	4v5ZmLmly8sn	\N	\N	\N	\N	\N	\N	\N	\N	\N
264	Deborah	Robertson	drobertson7a@abc.net.au	drobertson7a	xNe3pbV	\N	\N	\N	\N	\N	\N	\N	\N	\N
265	Ronald	Austin	raustin7b@harvard.edu	raustin7b	UdaeEQh6no	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	Louise	Walker	lwalker7c@oracle.com	lwalker7c	rFJh8ANP	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	Cynthia	Simmons	csimmons7d@yahoo.co.jp	csimmons7d	o5c4SbAOW	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	Walter	Hudson	whudson7e@zimbio.com	whudson7e	Kg7M55gwssP1	\N	\N	\N	\N	\N	\N	\N	\N	\N
269	Larry	Morris	lmorris7f@discovery.com	lmorris7f	bjXt3S	\N	\N	\N	\N	\N	\N	\N	\N	\N
270	Kelly	Schmidt	kschmidt7g@jiathis.com	kschmidt7g	h1GF0Qc	\N	\N	\N	\N	\N	\N	\N	\N	\N
271	Kathleen	Cox	kcox7h@g.co	kcox7h	Lv3qTvaDCfZ	\N	\N	\N	\N	\N	\N	\N	\N	\N
272	Billy	Alexander	balexander7i@about.me	balexander7i	DjnsGlQNT1E8	\N	\N	\N	\N	\N	\N	\N	\N	\N
273	Tammy	Reynolds	treynolds7j@nbcnews.com	treynolds7j	VuW5kh	\N	\N	\N	\N	\N	\N	\N	\N	\N
274	Julie	Duncan	jduncan7k@wunderground.com	jduncan7k	HyIcCD	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	Ronald	Barnes	rbarnes7l@liveinternet.ru	rbarnes7l	Tzf1jIg	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	Lori	Boyd	lboyd7m@gizmodo.com	lboyd7m	wQF86h1	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	Kathleen	Elliott	kelliott7n@imageshack.us	kelliott7n	Jl6fJyUqo	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	Gary	Castillo	gcastillo7o@dell.com	gcastillo7o	8duGiiYcuky	\N	\N	\N	\N	\N	\N	\N	\N	\N
279	Scott	Gonzalez	sgonzalez7p@cbsnews.com	sgonzalez7p	5NRu0p80ONy	\N	\N	\N	\N	\N	\N	\N	\N	\N
280	Jack	Wright	jwright7q@oaic.gov.au	jwright7q	uUy7hRCNp7ie	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	Wanda	Ramos	wramos7r@tinyurl.com	wramos7r	zq5st0	\N	\N	\N	\N	\N	\N	\N	\N	\N
282	Ryan	Ruiz	rruiz7s@dell.com	rruiz7s	h44wQVzeK	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	Alice	Perry	aperry7t@hibu.com	aperry7t	yrP9noWFy7	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	Joseph	Hill	jhill7u@barnesandnoble.com	jhill7u	iUbSiMf31QTa	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	Deborah	Parker	dparker7v@chronoengine.com	dparker7v	e7jnjts	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	Julia	Murray	jmurray7w@taobao.com	jmurray7w	PANpM9x	\N	\N	\N	\N	\N	\N	\N	\N	\N
287	Patrick	Foster	pfoster7x@miibeian.gov.cn	pfoster7x	PbGzJr	\N	\N	\N	\N	\N	\N	\N	\N	\N
288	Harry	Robertson	hrobertson7y@yandex.ru	hrobertson7y	ZXzYmVi2uOoX	\N	\N	\N	\N	\N	\N	\N	\N	\N
289	Jimmy	Porter	jporter7z@nih.gov	jporter7z	dDADSVrnL	\N	\N	\N	\N	\N	\N	\N	\N	\N
290	John	Mcdonald	jmcdonald80@yale.edu	jmcdonald80	e2nWa5dYm3O	\N	\N	\N	\N	\N	\N	\N	\N	\N
291	Justin	Reyes	jreyes81@arizona.edu	jreyes81	4Tg2IFhs	\N	\N	\N	\N	\N	\N	\N	\N	\N
292	Michael	White	mwhite82@1und1.de	mwhite82	Hy1GYaS	\N	\N	\N	\N	\N	\N	\N	\N	\N
293	Cynthia	Martinez	cmartinez83@ca.gov	cmartinez83	wo1et9L5	\N	\N	\N	\N	\N	\N	\N	\N	\N
294	Benjamin	Bradley	bbradley84@yellowpages.com	bbradley84	epneY1U8	\N	\N	\N	\N	\N	\N	\N	\N	\N
295	David	Murphy	dmurphy85@bloglines.com	dmurphy85	yfmFgzd3Yrfa	\N	\N	\N	\N	\N	\N	\N	\N	\N
296	Kimberly	Castillo	kcastillo86@paypal.com	kcastillo86	T8Y5cPP	\N	\N	\N	\N	\N	\N	\N	\N	\N
297	Jennifer	Robinson	jrobinson87@yelp.com	jrobinson87	LOve7fEaZz8H	\N	\N	\N	\N	\N	\N	\N	\N	\N
298	Roy	Parker	rparker88@cnet.com	rparker88	rMSvpcD4525	\N	\N	\N	\N	\N	\N	\N	\N	\N
299	Marie	Miller	mmiller89@europa.eu	mmiller89	bc3nPPfOT	\N	\N	\N	\N	\N	\N	\N	\N	\N
300	Carol	Woods	cwoods8a@sina.com.cn	cwoods8a	rSc4YLzBh	\N	\N	\N	\N	\N	\N	\N	\N	\N
301	Raymond	Schmidt	rschmidt8b@addthis.com	rschmidt8b	fF02vg	\N	\N	\N	\N	\N	\N	\N	\N	\N
302	Frank	Morales	fmorales8c@php.net	fmorales8c	D8aF1pyA	\N	\N	\N	\N	\N	\N	\N	\N	\N
303	Jason	Daniels	jdaniels8d@ovh.net	jdaniels8d	h0gFt9	\N	\N	\N	\N	\N	\N	\N	\N	\N
304	Judy	Fernandez	jfernandez8e@over-blog.com	jfernandez8e	y7yDMxk6l	\N	\N	\N	\N	\N	\N	\N	\N	\N
305	Ronald	Thompson	rthompson8f@phoca.cz	rthompson8f	DqMiCsoLXqj	\N	\N	\N	\N	\N	\N	\N	\N	\N
306	Kathy	Moore	kmoore8g@cyberchimps.com	kmoore8g	Wcqy7O5A	\N	\N	\N	\N	\N	\N	\N	\N	\N
307	Margaret	Alexander	malexander8h@businessweek.com	malexander8h	8shKeJ	\N	\N	\N	\N	\N	\N	\N	\N	\N
308	Eric	Graham	egraham8i@gmpg.org	egraham8i	yDXFq5	\N	\N	\N	\N	\N	\N	\N	\N	\N
309	Angela	Williamson	awilliamson8j@godaddy.com	awilliamson8j	0u5YhP0CFWS	\N	\N	\N	\N	\N	\N	\N	\N	\N
310	Annie	Peters	apeters8k@mashable.com	apeters8k	80dB55O	\N	\N	\N	\N	\N	\N	\N	\N	\N
311	Janet	Walker	jwalker8l@hostgator.com	jwalker8l	p2VMc8	\N	\N	\N	\N	\N	\N	\N	\N	\N
312	Billy	Adams	badams8m@tmall.com	badams8m	TGIsX1Ib	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	Stephen	Carpenter	scarpenter8n@google.co.uk	scarpenter8n	7mcRjdfHEC	\N	\N	\N	\N	\N	\N	\N	\N	\N
314	Nancy	Kelly	nkelly8o@tumblr.com	nkelly8o	c0OnEes5vXvl	\N	\N	\N	\N	\N	\N	\N	\N	\N
315	Elizabeth	Castillo	ecastillo8p@unesco.org	ecastillo8p	fC47QlLj	\N	\N	\N	\N	\N	\N	\N	\N	\N
316	Bonnie	Stewart	bstewart8q@ft.com	bstewart8q	ooNcKsUIad	\N	\N	\N	\N	\N	\N	\N	\N	\N
317	Keith	Sims	ksims8r@yellowbook.com	ksims8r	LelGb8	\N	\N	\N	\N	\N	\N	\N	\N	\N
318	Lois	Taylor	ltaylor8s@si.edu	ltaylor8s	vMIR4Ob	\N	\N	\N	\N	\N	\N	\N	\N	\N
319	Willie	Daniels	wdaniels8t@behance.net	wdaniels8t	4sqmOif	\N	\N	\N	\N	\N	\N	\N	\N	\N
320	Joseph	Butler	jbutler8u@360.cn	jbutler8u	Hkc675	\N	\N	\N	\N	\N	\N	\N	\N	\N
321	Ryan	Mccoy	rmccoy8v@jimdo.com	rmccoy8v	qISsOfQCMjeK	\N	\N	\N	\N	\N	\N	\N	\N	\N
322	Joan	Stevens	jstevens8w@cbc.ca	jstevens8w	uMrRg2LSMj	\N	\N	\N	\N	\N	\N	\N	\N	\N
323	Phyllis	Anderson	panderson8x@sphinn.com	panderson8x	fgQ3lgTHznnd	\N	\N	\N	\N	\N	\N	\N	\N	\N
324	Jeffrey	Turner	jturner8y@nps.gov	jturner8y	ZjXho0l	\N	\N	\N	\N	\N	\N	\N	\N	\N
325	Emily	Lane	elane8z@barnesandnoble.com	elane8z	zW6z8jt	\N	\N	\N	\N	\N	\N	\N	\N	\N
326	Joan	King	jking90@alibaba.com	jking90	WVpgufgH	\N	\N	\N	\N	\N	\N	\N	\N	\N
327	Philip	Walker	pwalker91@wikia.com	pwalker91	4K9MSt	\N	\N	\N	\N	\N	\N	\N	\N	\N
328	Timothy	Cook	tcook92@discovery.com	tcook92	EdDH2ri4o	\N	\N	\N	\N	\N	\N	\N	\N	\N
329	Gloria	Stone	gstone93@geocities.jp	gstone93	qbA0DFQ	\N	\N	\N	\N	\N	\N	\N	\N	\N
330	Amanda	Cunningham	acunningham94@bizjournals.com	acunningham94	Rgv3gdXq8kL	\N	\N	\N	\N	\N	\N	\N	\N	\N
331	Emily	Fernandez	efernandez95@cam.ac.uk	efernandez95	ZjPk2qG8	\N	\N	\N	\N	\N	\N	\N	\N	\N
332	Keith	Wright	kwright96@oaic.gov.au	kwright96	HZ61NaqGaX	\N	\N	\N	\N	\N	\N	\N	\N	\N
333	Donald	Williamson	dwilliamson97@examiner.com	dwilliamson97	KI0UD2n	\N	\N	\N	\N	\N	\N	\N	\N	\N
334	Michelle	Sanchez	msanchez98@walmart.com	msanchez98	X2n92PlM3	\N	\N	\N	\N	\N	\N	\N	\N	\N
335	Jane	Meyer	jmeyer99@sohu.com	jmeyer99	2IvnKy9cd9I	\N	\N	\N	\N	\N	\N	\N	\N	\N
336	Roger	Meyer	rmeyer9a@last.fm	rmeyer9a	r1DNwaKAzWPk	\N	\N	\N	\N	\N	\N	\N	\N	\N
337	Thomas	Pierce	tpierce9b@springer.com	tpierce9b	4RtQS88q	\N	\N	\N	\N	\N	\N	\N	\N	\N
338	Howard	Richards	hrichards9c@constantcontact.com	hrichards9c	HWPZ2uy	\N	\N	\N	\N	\N	\N	\N	\N	\N
339	George	Hudson	ghudson9d@arizona.edu	ghudson9d	CaUESHT	\N	\N	\N	\N	\N	\N	\N	\N	\N
340	Andrew	Flores	aflores9e@amazon.co.uk	aflores9e	nlqB2EDike	\N	\N	\N	\N	\N	\N	\N	\N	\N
341	Nicole	Stanley	nstanley9f@ezinearticles.com	nstanley9f	szDxf7VMMqj	\N	\N	\N	\N	\N	\N	\N	\N	\N
342	Donald	Rose	drose9g@hud.gov	drose9g	NCcPhks9	\N	\N	\N	\N	\N	\N	\N	\N	\N
343	Anne	Roberts	aroberts9h@mac.com	aroberts9h	DoaQOphtzns	\N	\N	\N	\N	\N	\N	\N	\N	\N
344	Jerry	Wells	jwells9i@patch.com	jwells9i	e7602Fvbkc	\N	\N	\N	\N	\N	\N	\N	\N	\N
345	Betty	Robertson	brobertson9j@spiegel.de	brobertson9j	4fI3Riiv2	\N	\N	\N	\N	\N	\N	\N	\N	\N
346	Anthony	Ward	award9k@unblog.fr	award9k	XuFVvSs03Efc	\N	\N	\N	\N	\N	\N	\N	\N	\N
347	Melissa	Garcia	mgarcia9l@abc.net.au	mgarcia9l	syCsI49Bq16e	\N	\N	\N	\N	\N	\N	\N	\N	\N
348	Jesse	Reyes	jreyes9m@miitbeian.gov.cn	jreyes9m	AG5S49B	\N	\N	\N	\N	\N	\N	\N	\N	\N
349	Steven	Snyder	ssnyder9n@themeforest.net	ssnyder9n	0t9e6Nh	\N	\N	\N	\N	\N	\N	\N	\N	\N
350	Katherine	Patterson	kpatterson9o@biblegateway.com	kpatterson9o	vVfMtl	\N	\N	\N	\N	\N	\N	\N	\N	\N
351	Billy	Harvey	bharvey9p@flavors.me	bharvey9p	la1WJ471Ih	\N	\N	\N	\N	\N	\N	\N	\N	\N
352	Helen	Wang	helen@mail.com	helen	hi	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_id_seq', 352, true);


--
-- Data for Name: uservisits; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY uservisits (id, visit_id, user_id, rating) FROM stdin;
1	1	258	4
2	1	229	1
3	2	327	5
4	2	25	5
5	3	20	3
6	3	82	3
7	4	59	5
8	4	266	4
9	5	53	3
10	5	92	2
11	6	341	5
12	6	270	1
13	7	77	1
14	7	158	2
15	8	74	4
16	8	341	3
17	9	189	1
18	9	90	3
19	10	250	1
20	10	190	4
21	11	78	3
22	11	233	2
23	12	147	4
24	12	72	1
25	13	320	3
26	13	323	1
27	14	120	2
28	14	186	5
29	15	68	3
30	15	139	5
31	16	148	2
32	16	209	1
33	17	254	3
34	17	97	4
35	18	134	5
36	18	102	2
37	19	22	5
38	19	70	3
39	20	56	4
40	20	157	3
41	21	69	2
42	21	33	4
43	22	70	4
44	22	305	3
45	23	2	5
46	23	120	3
47	24	351	3
48	24	101	4
49	25	227	2
50	25	90	2
51	26	114	4
52	26	24	4
53	27	102	4
54	27	38	5
55	28	97	3
56	28	55	5
57	29	263	3
58	29	284	1
59	30	183	1
60	30	123	2
61	31	70	2
62	31	342	1
63	32	162	5
64	32	102	5
65	33	295	5
66	33	259	3
67	34	146	1
68	34	195	5
69	35	330	2
70	35	213	5
71	36	279	3
72	36	29	1
73	37	72	3
74	37	73	5
75	38	29	3
76	38	63	3
77	39	197	2
78	39	202	4
79	40	243	2
80	40	231	2
81	41	166	4
82	41	327	4
83	42	211	3
84	42	233	5
85	43	144	2
86	43	343	4
87	44	31	4
88	44	192	1
89	45	173	1
90	45	110	1
91	46	157	3
92	46	184	5
93	47	154	1
94	47	128	4
95	48	231	3
96	48	9	1
97	49	181	3
98	49	28	2
99	50	76	3
100	50	242	2
101	51	154	3
102	51	73	2
103	52	176	2
104	52	230	5
105	53	141	3
106	53	260	2
107	54	225	2
108	54	103	4
109	55	226	3
110	55	224	3
111	56	305	4
112	56	93	3
113	57	189	3
114	57	151	2
115	58	152	2
116	58	113	5
117	59	118	5
118	59	246	1
119	60	54	5
120	60	56	2
121	61	127	4
122	61	242	5
123	62	147	2
124	62	72	4
125	63	350	4
126	63	125	4
127	64	182	5
128	64	201	5
129	65	290	3
130	65	66	1
131	66	134	5
132	66	309	5
133	67	109	1
134	67	331	4
135	68	299	4
136	68	101	4
137	69	183	1
138	69	64	4
139	70	11	1
140	70	106	2
141	71	1	2
142	71	289	5
143	72	49	2
144	72	212	4
145	73	73	3
146	73	351	3
147	74	181	3
148	74	262	1
149	75	64	1
150	75	235	4
151	76	242	4
152	76	271	3
153	77	26	4
154	77	56	3
155	78	49	5
156	78	223	4
157	79	276	4
158	79	22	1
159	80	91	3
160	80	147	5
161	81	342	1
162	81	140	4
163	82	147	2
164	82	254	3
165	83	127	4
166	83	36	1
167	84	179	4
168	84	296	2
169	85	228	4
170	85	334	4
171	86	229	4
172	86	101	5
173	87	291	3
174	87	171	2
175	88	101	5
176	88	296	4
177	89	338	4
178	89	19	1
179	90	34	2
180	90	272	2
181	91	206	5
182	91	120	4
183	92	109	3
184	92	242	4
185	93	61	2
186	93	321	1
187	94	187	3
188	94	268	5
189	95	48	1
190	95	236	5
191	96	327	5
192	96	305	4
193	97	148	2
194	97	289	4
195	98	322	2
196	98	53	3
197	99	232	4
198	99	4	4
199	100	155	5
200	100	227	1
201	101	268	2
202	101	313	1
203	102	116	5
204	102	1	1
205	103	177	4
206	103	152	5
207	104	346	1
208	104	41	1
209	105	323	1
210	105	99	5
211	106	3	3
212	106	343	3
213	107	127	2
214	107	224	3
215	108	19	2
216	108	219	4
217	109	113	3
218	109	177	3
219	110	188	4
220	110	319	2
221	111	304	1
222	111	216	3
223	112	139	3
224	112	302	4
225	113	203	4
226	113	125	2
227	114	285	1
228	114	208	1
229	115	162	4
230	115	55	2
231	116	288	3
232	116	326	2
233	117	233	4
234	117	16	4
235	118	318	5
236	118	221	1
237	119	30	5
238	119	120	3
239	120	176	4
240	120	57	1
241	121	34	1
242	121	288	1
243	122	43	3
244	122	203	3
245	123	343	2
246	123	215	1
247	124	51	5
248	124	348	1
249	125	235	5
250	125	39	2
251	126	93	5
252	126	266	2
253	127	307	2
254	127	8	3
255	128	290	3
256	128	120	3
257	129	253	2
258	129	214	4
259	130	316	3
260	130	304	3
261	131	200	4
262	131	190	5
263	132	339	3
264	132	314	3
265	133	136	2
266	133	173	2
267	134	165	3
268	134	133	5
269	135	274	1
270	135	90	1
271	136	302	4
272	136	234	2
273	137	236	2
274	137	41	3
275	138	155	4
276	138	148	2
277	139	109	3
278	139	191	5
279	140	285	4
280	140	196	1
281	141	317	2
282	141	141	3
283	142	228	2
284	142	314	2
285	143	288	5
286	143	16	2
287	144	284	2
288	144	75	4
289	145	235	2
290	145	287	2
291	146	13	1
292	146	254	2
293	147	161	3
294	147	106	2
295	148	295	5
296	148	297	3
297	149	77	3
298	149	206	2
299	150	150	5
300	150	248	3
301	151	112	3
302	151	26	4
303	152	181	3
304	152	72	2
305	153	67	5
306	153	249	5
307	154	55	1
308	154	79	3
309	155	211	4
310	155	126	3
311	156	101	2
312	156	115	4
313	157	109	3
314	157	229	4
315	158	350	3
316	158	178	2
317	159	322	4
318	159	251	5
319	160	61	4
320	160	201	3
321	161	67	2
322	161	168	3
323	162	251	5
324	162	246	1
325	163	73	5
326	163	235	5
327	164	126	5
328	164	123	1
329	165	111	3
330	165	212	3
331	166	259	5
332	166	346	5
333	167	48	4
334	167	28	2
335	168	35	5
336	168	73	3
337	169	145	5
338	169	173	2
339	170	270	4
340	170	250	1
341	171	104	4
342	171	265	5
343	172	58	3
344	172	98	1
345	173	123	4
346	173	221	4
347	174	28	2
348	174	188	4
349	175	143	1
350	175	64	4
351	176	257	1
352	176	95	2
353	177	107	4
354	177	334	1
355	178	286	3
356	178	103	2
357	179	73	1
358	179	48	1
359	180	52	2
360	180	129	5
361	181	210	5
362	181	147	4
363	182	329	1
364	182	35	1
365	183	84	3
366	183	82	4
367	184	196	2
368	184	73	5
369	185	87	1
370	185	253	4
371	186	140	4
372	186	70	2
373	187	243	2
374	187	190	5
375	188	108	1
376	188	23	4
377	189	344	2
378	189	211	2
379	190	26	1
380	190	148	1
381	191	75	1
382	191	346	5
383	192	2	3
384	192	59	2
385	193	329	2
386	193	230	2
387	194	87	4
388	194	338	3
389	195	152	2
390	195	74	1
391	196	303	2
392	196	298	5
393	197	351	5
394	197	166	2
395	198	257	5
396	198	238	4
397	199	13	4
398	199	305	1
399	200	177	5
400	200	220	1
401	201	152	5
402	201	15	2
403	202	44	5
404	202	285	5
405	203	169	2
406	203	112	5
407	204	302	1
408	204	155	2
409	205	288	2
410	205	221	2
411	206	168	1
412	206	57	1
413	207	120	4
414	207	11	2
415	208	241	3
416	208	151	4
417	209	292	4
418	209	295	3
419	210	271	4
420	210	7	5
421	211	111	1
422	211	277	2
423	212	175	5
424	212	120	3
425	213	76	4
426	213	321	2
427	214	236	5
428	214	289	3
429	215	302	5
430	215	9	3
431	216	199	3
432	216	105	2
433	217	298	1
434	217	324	2
435	218	271	1
436	218	14	1
437	219	219	3
438	219	324	2
439	220	72	4
440	220	215	5
441	221	268	4
442	221	8	2
443	222	140	1
444	222	239	3
445	223	232	2
446	223	228	2
447	224	242	1
448	224	271	1
449	225	144	4
450	225	318	5
451	226	242	4
452	226	173	2
453	227	147	5
454	227	211	5
455	228	339	2
456	228	244	2
457	229	294	5
458	229	81	4
459	230	202	3
460	230	278	3
461	231	337	4
462	231	343	5
463	232	4	3
464	232	251	5
465	233	117	2
466	233	89	3
467	234	14	4
468	234	171	2
469	235	91	1
470	235	349	2
471	236	276	4
472	236	88	1
473	237	284	1
474	237	186	5
475	238	7	2
476	238	115	1
477	239	77	1
478	239	10	4
479	240	182	3
480	240	335	5
481	241	109	4
482	241	64	1
483	242	87	4
484	242	88	4
485	243	54	5
486	243	350	3
487	244	238	5
488	244	190	1
489	245	294	4
490	245	144	4
491	246	87	1
492	246	261	3
493	247	118	5
494	247	1	4
495	248	47	5
496	248	262	5
497	249	185	5
498	249	317	4
499	250	341	3
500	250	231	2
501	251	344	4
502	251	64	2
503	252	264	4
504	252	47	3
505	253	154	3
506	253	298	3
507	254	282	3
508	254	341	2
509	255	146	2
510	255	141	2
511	256	114	3
512	256	277	1
513	257	208	3
514	257	204	5
515	258	95	5
516	258	150	1
517	259	262	2
518	259	7	1
519	260	149	2
520	260	178	4
521	261	289	3
522	261	185	1
523	262	226	3
524	262	150	2
525	263	153	3
526	263	20	1
527	264	288	5
528	264	201	4
529	265	153	5
530	265	169	4
531	266	163	3
532	266	84	5
533	267	321	2
534	267	232	4
535	269	318	2
536	269	283	3
537	270	39	4
538	270	43	1
539	271	341	2
540	271	92	3
541	272	289	5
542	272	265	3
543	273	242	2
544	273	77	2
545	274	229	2
546	274	29	4
547	275	248	2
548	275	109	2
549	276	287	1
550	276	188	2
551	277	281	2
552	277	321	2
553	278	206	4
554	278	229	4
555	279	44	4
556	279	334	3
557	280	349	4
558	280	151	3
559	281	49	2
560	281	240	3
561	282	131	2
562	282	55	1
563	283	51	3
564	283	197	3
565	284	87	5
566	284	190	1
567	285	147	4
568	285	140	4
569	286	187	3
570	286	134	2
571	287	83	1
572	287	303	4
573	288	313	2
574	288	168	5
575	289	148	4
576	289	268	3
577	290	14	1
578	290	29	2
579	291	254	5
580	291	326	4
581	292	140	3
582	292	326	4
583	293	67	4
584	293	302	5
585	294	102	5
586	294	62	3
587	295	92	4
588	295	7	2
589	296	322	5
590	296	261	2
591	297	22	1
592	297	195	4
593	298	135	4
594	298	199	3
595	299	174	2
596	299	116	4
597	300	321	4
598	300	325	2
599	301	322	4
600	301	39	4
601	302	32	5
602	302	250	2
603	303	109	1
604	303	112	3
605	304	138	4
606	304	301	2
607	305	154	1
608	305	155	1
609	306	24	5
610	306	8	4
611	307	294	3
612	307	81	3
613	308	139	1
614	308	221	2
615	309	29	4
616	309	167	4
617	310	95	1
618	310	271	1
619	311	286	2
620	311	2	2
621	312	337	4
622	312	147	3
623	313	82	4
624	313	86	5
625	314	240	5
626	314	62	1
627	315	306	3
628	315	112	3
629	316	269	5
630	316	245	2
631	317	37	3
632	317	345	5
633	318	9	2
634	318	112	4
635	319	39	1
636	319	260	4
637	320	248	1
638	320	218	3
639	321	13	3
640	321	260	2
641	322	64	2
642	322	128	3
643	323	190	5
644	323	285	4
645	324	101	3
646	324	263	4
647	325	282	3
648	325	349	5
649	326	112	3
650	326	118	2
651	327	339	5
652	327	264	3
653	328	252	2
654	328	157	3
655	329	105	1
656	329	143	1
657	330	36	2
658	330	282	4
659	331	33	1
660	331	83	2
661	332	174	3
662	332	133	1
663	333	202	4
664	333	110	2
665	334	107	5
666	334	209	5
667	335	75	2
668	335	308	5
669	336	190	3
670	336	265	1
671	337	15	2
672	337	144	1
673	338	225	2
674	338	33	2
675	339	24	5
676	339	107	5
677	340	226	1
678	340	173	1
679	341	284	3
680	341	112	4
681	342	240	5
682	342	318	3
683	343	269	2
684	343	290	4
685	344	191	5
686	344	226	3
687	345	51	1
688	345	207	1
689	346	194	3
690	346	257	2
691	347	21	3
692	347	299	2
693	348	99	3
694	348	98	3
695	349	59	4
696	349	110	2
697	350	118	1
698	350	203	2
699	351	341	1
700	351	109	1
701	352	49	4
702	352	288	1
703	353	177	3
704	353	3	4
705	354	288	2
706	354	229	4
707	355	184	5
708	355	245	4
709	356	282	2
710	356	331	1
711	357	195	3
712	357	14	2
713	358	197	5
714	358	300	2
715	359	70	5
716	359	16	1
717	360	304	4
718	360	66	4
719	361	315	3
720	361	61	3
721	362	126	3
722	362	120	1
723	363	202	3
724	363	349	5
725	364	108	2
726	364	303	3
727	365	249	3
728	365	325	1
729	366	160	1
730	366	167	1
731	367	73	1
732	367	343	3
733	368	61	2
734	368	287	2
735	369	119	3
736	369	110	3
737	370	301	5
738	370	94	3
739	371	338	5
740	371	209	5
741	372	348	5
742	372	329	3
743	373	157	3
744	373	274	3
745	374	119	5
746	374	268	4
747	375	14	2
748	375	304	4
749	376	318	2
750	376	156	4
751	377	18	3
752	377	134	5
753	378	216	4
754	378	223	3
755	379	173	5
756	379	221	2
757	380	252	4
758	380	88	4
759	381	182	2
760	381	120	5
761	382	153	1
762	382	85	1
763	383	3	3
764	383	66	4
765	384	309	2
766	384	260	2
767	385	158	2
768	385	287	1
769	386	30	2
770	386	151	4
771	387	293	4
772	387	310	4
773	388	87	1
774	388	62	1
775	389	230	5
776	389	77	4
777	390	12	2
778	390	161	5
779	391	251	2
780	391	275	5
781	392	56	1
782	392	204	3
783	393	184	5
784	393	144	3
785	394	96	4
786	394	222	2
787	395	154	3
788	395	122	3
789	396	284	5
790	396	283	4
791	397	127	4
792	397	109	5
793	398	7	3
794	398	263	2
795	399	133	3
796	399	341	1
797	400	291	3
798	400	114	4
799	401	103	3
800	401	326	3
801	402	349	1
802	402	315	1
803	403	189	5
804	403	261	4
805	404	34	5
806	404	268	4
807	405	223	5
808	405	273	5
809	406	180	2
810	406	257	5
811	407	297	1
812	407	173	4
813	408	305	2
814	408	108	4
815	409	274	5
816	409	270	1
817	410	208	2
818	410	42	5
819	411	179	2
820	411	93	4
821	412	78	5
822	412	95	3
823	413	67	4
824	413	41	4
825	414	334	2
826	414	79	4
827	415	162	3
828	415	108	4
829	416	164	4
830	416	53	4
831	417	33	3
832	417	116	2
833	418	73	3
834	418	279	5
835	419	333	5
836	419	124	4
837	420	114	1
838	420	306	1
839	421	276	5
840	421	66	3
841	422	93	4
842	422	163	5
843	423	314	5
844	423	111	3
845	424	273	5
846	424	70	5
847	425	168	1
848	425	115	5
849	426	156	1
850	426	125	5
851	427	333	5
852	427	245	4
853	428	293	3
854	428	328	2
855	429	324	1
856	429	96	2
857	430	331	2
858	430	154	1
859	431	301	1
860	431	339	4
861	432	332	1
862	432	58	3
863	433	248	3
864	433	141	2
865	434	301	4
866	434	75	1
867	435	240	5
868	435	333	1
869	436	152	2
870	436	137	4
871	437	214	5
872	437	348	2
873	438	289	2
874	438	345	3
875	439	292	1
876	439	24	5
877	440	144	3
878	440	92	5
879	441	344	4
880	441	243	4
881	442	197	2
882	442	158	5
883	443	252	2
884	443	28	1
885	444	53	1
886	444	127	4
887	445	159	4
888	445	240	3
889	446	315	4
890	446	322	3
891	447	209	4
892	447	97	5
893	448	204	2
894	448	14	2
895	449	21	5
896	449	136	5
897	450	49	3
898	450	223	1
899	451	148	1
900	451	95	1
901	452	173	2
902	452	220	2
903	453	40	5
904	453	110	4
905	454	52	2
906	454	257	4
907	455	19	3
908	455	122	2
909	456	261	2
910	456	78	5
911	457	329	5
912	457	207	2
913	458	123	2
914	458	268	1
915	459	111	3
916	459	242	4
917	460	342	4
918	460	205	5
919	461	244	5
920	461	104	3
921	462	167	3
922	462	322	4
923	463	204	3
924	463	324	3
925	464	135	3
926	464	204	3
927	465	166	5
928	465	343	5
929	466	314	4
930	466	249	2
931	467	150	4
932	467	276	2
933	468	40	2
934	468	284	4
935	469	35	2
936	469	8	1
937	470	50	1
938	470	321	2
939	471	114	1
940	471	138	3
941	472	309	2
942	472	109	2
943	473	44	2
944	473	278	5
945	474	58	1
946	474	190	3
947	475	320	1
948	475	248	4
949	476	222	5
950	476	310	4
951	477	349	5
952	477	210	1
953	478	79	5
954	478	60	4
955	479	277	2
956	479	287	4
957	480	163	4
958	480	183	2
959	481	306	1
960	481	309	3
961	482	303	1
962	482	37	2
963	483	198	1
964	483	325	5
965	484	212	4
966	484	332	1
967	485	35	3
968	485	12	1
969	486	106	5
970	486	54	1
971	487	342	1
972	487	299	1
973	488	152	4
974	488	93	3
975	489	26	1
976	489	248	3
977	490	56	3
978	490	235	3
979	491	207	3
980	491	181	2
981	492	210	2
982	492	148	5
983	493	251	4
984	493	120	1
985	494	251	4
986	494	33	1
987	495	28	4
988	495	98	1
989	496	21	2
990	496	11	1
991	497	70	1
992	497	257	4
993	498	15	2
994	498	108	4
995	499	192	2
996	499	278	1
997	500	244	4
998	500	343	4
999	501	201	4
1000	501	256	2
1001	502	325	2
1002	502	229	5
1003	503	241	3
1004	503	72	4
1005	504	223	3
1006	504	259	5
1007	505	2	5
1008	505	45	1
1009	506	305	5
1010	506	257	4
1011	507	277	4
1012	507	90	4
1013	508	253	2
1014	508	275	2
1015	509	254	1
1016	509	58	3
1017	510	145	2
1018	510	237	5
1019	511	344	2
1020	511	304	1
1021	512	59	2
1022	512	348	3
1023	513	47	1
1024	513	280	2
1025	514	26	2
1026	514	236	5
1027	515	133	4
1028	515	67	5
1029	516	49	5
1030	516	198	1
1031	517	222	2
1032	517	270	1
1033	518	60	2
1034	518	87	2
1035	519	321	2
1036	519	93	2
1037	520	144	2
1038	520	215	2
1039	521	82	5
1040	521	112	5
1041	522	122	5
1042	522	349	5
1043	523	280	2
1044	523	29	2
1045	524	277	5
1046	524	107	2
1047	525	351	4
1048	525	329	3
1049	526	26	4
1050	526	241	2
1051	527	226	4
1052	527	337	3
1053	528	58	4
1054	528	173	4
1055	529	34	4
1056	529	207	5
1057	530	182	3
1058	530	260	1
1059	531	237	4
1060	531	191	1
1061	532	245	3
1062	532	155	4
1063	533	289	4
1064	533	189	3
1065	534	345	3
1066	534	143	1
1067	535	271	5
1068	535	52	4
1069	536	205	1
1070	536	292	4
1071	537	212	5
1072	537	132	5
1073	538	335	3
1074	538	161	2
1075	539	348	2
1076	539	242	5
1077	540	28	1
1078	540	74	2
1079	541	314	5
1080	541	229	3
1081	542	136	2
1082	542	302	4
1083	543	342	5
1084	543	267	4
1085	544	230	2
1086	544	97	5
1087	545	68	4
1088	545	342	3
1089	546	44	3
1090	546	123	4
1091	547	17	5
1092	547	48	2
1093	548	296	4
1094	548	117	2
1095	549	246	5
1096	549	33	2
1097	550	246	4
1098	550	297	5
1099	551	323	5
1100	551	176	4
1101	552	36	4
1102	552	229	5
1103	553	242	3
1104	553	35	2
1105	554	273	2
1106	554	34	1
1107	555	177	1
1108	555	290	4
1109	556	58	1
1110	556	283	2
1111	557	104	2
1112	557	295	5
1113	558	313	4
1114	558	34	4
1115	559	175	2
1116	559	334	4
1117	560	95	3
1118	560	94	1
1119	561	276	3
1120	561	149	5
1121	562	171	3
1122	562	319	5
1123	563	146	3
1124	563	24	4
1125	564	101	5
1126	564	75	1
1127	565	139	5
1128	565	163	1
1129	566	78	3
1130	566	140	1
1131	567	70	5
1132	567	217	5
1133	568	101	4
1134	568	278	4
1135	569	271	2
1136	569	12	2
1137	570	177	4
1138	570	9	1
1139	571	262	1
1140	571	213	1
1141	572	267	5
1142	572	201	1
1143	573	290	1
1144	573	64	5
1145	574	214	2
1146	574	113	3
1147	575	69	1
1148	575	124	1
1149	576	22	4
1150	576	20	2
1151	577	318	1
1152	577	182	1
1153	578	311	3
1154	578	351	1
1155	579	171	5
1156	579	136	3
1157	580	247	4
1158	580	33	5
1159	581	226	2
1160	581	2	5
1161	582	260	2
1162	582	27	1
1163	583	268	4
1164	583	335	5
1165	584	319	2
1166	584	251	3
1167	585	241	4
1168	585	149	1
1169	586	106	4
1170	586	172	2
1171	587	261	5
1172	587	90	2
1173	588	153	2
1174	588	100	4
1175	589	321	1
1176	589	292	3
1177	590	104	1
1178	590	118	4
1179	591	37	3
1180	591	143	1
1181	592	305	3
1182	592	331	2
1183	593	6	5
1184	593	194	1
1185	594	188	1
1186	594	191	2
1187	595	187	1
1188	595	158	1
1189	596	231	2
1190	596	218	3
1191	597	305	5
1192	597	327	5
1193	598	62	3
1194	598	237	2
1195	599	24	4
1196	599	90	1
1197	600	62	5
1198	600	36	5
1199	603	1	4
1200	603	352	\N
1201	607	1	3
1202	607	352	\N
1203	608	1	2
1204	608	352	\N
1205	609	1	3
1206	609	352	\N
1207	610	1	4
1208	610	352	\N
1209	611	1	2
1210	611	352	\N
1211	618	1	5
1212	618	352	\N
1213	619	1	2
1214	619	352	\N
\.


--
-- Name: uservisits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('uservisits_id_seq', 1214, true);


--
-- Data for Name: visits; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY visits (id, rest_id, date) FROM stdin;
1	18	2016-11-20 03:38:08.304394
2	3	2016-11-20 03:38:08.304465
3	7	2016-11-20 03:38:08.304486
4	2	2016-11-20 03:38:08.304502
5	5	2016-11-20 03:38:08.304517
6	14	2016-11-20 03:38:08.304532
7	9	2016-11-20 03:38:08.304546
8	17	2016-11-20 03:38:08.304559
9	19	2016-11-20 03:38:08.304573
10	20	2016-11-20 03:38:08.304588
11	9	2016-11-20 03:38:08.304602
12	13	2016-11-20 03:38:08.304615
13	1	2016-11-20 03:38:08.304629
14	12	2016-11-20 03:38:08.304643
15	4	2016-11-20 03:38:08.304656
16	18	2016-11-20 03:38:08.30467
17	20	2016-11-20 03:38:08.304683
18	10	2016-11-20 03:38:08.304697
19	20	2016-11-20 03:38:08.304711
20	15	2016-11-20 03:38:08.304724
21	2	2016-11-20 03:38:08.304737
22	20	2016-11-20 03:38:08.304751
23	16	2016-11-20 03:38:08.304764
24	17	2016-11-20 03:38:08.304777
25	10	2016-11-20 03:38:08.30479
26	14	2016-11-20 03:38:08.304804
27	6	2016-11-20 03:38:08.304818
28	11	2016-11-20 03:38:08.304831
29	4	2016-11-20 03:38:08.304845
30	12	2016-11-20 03:38:08.304858
31	18	2016-11-20 03:38:08.304871
32	1	2016-11-20 03:38:08.304884
33	8	2016-11-20 03:38:08.304897
34	3	2016-11-20 03:38:08.304911
35	19	2016-11-20 03:38:08.304924
36	20	2016-11-20 03:38:08.304937
37	19	2016-11-20 03:38:08.304951
38	11	2016-11-20 03:38:08.304964
39	7	2016-11-20 03:38:08.304978
40	9	2016-11-20 03:38:08.304991
41	20	2016-11-20 03:38:08.305004
42	9	2016-11-20 03:38:08.305018
43	3	2016-11-20 03:38:08.305031
44	7	2016-11-20 03:38:08.305044
45	12	2016-11-20 03:38:08.305058
46	18	2016-11-20 03:38:08.305102
47	8	2016-11-20 03:38:08.305118
48	1	2016-11-20 03:38:08.305133
49	7	2016-11-20 03:38:08.305146
50	17	2016-11-20 03:38:08.30516
51	19	2016-11-20 03:38:08.305173
52	9	2016-11-20 03:38:08.305186
53	19	2016-11-20 03:38:08.305199
54	17	2016-11-20 03:38:08.305213
55	20	2016-11-20 03:38:08.305226
56	19	2016-11-20 03:38:08.30524
57	19	2016-11-20 03:38:08.305253
58	18	2016-11-20 03:38:08.305266
59	4	2016-11-20 03:38:08.305279
60	13	2016-11-20 03:38:08.305293
61	5	2016-11-20 03:38:08.305307
62	20	2016-11-20 03:38:08.30532
63	12	2016-11-20 03:38:08.305333
64	6	2016-11-20 03:38:08.305346
65	18	2016-11-20 03:38:08.305359
66	7	2016-11-20 03:38:08.305373
67	14	2016-11-20 03:38:08.305386
68	19	2016-11-20 03:38:08.305399
69	1	2016-11-20 03:38:08.305413
70	6	2016-11-20 03:38:08.305426
71	12	2016-11-20 03:38:08.305439
72	1	2016-11-20 03:38:08.305452
73	18	2016-11-20 03:38:08.305465
74	20	2016-11-20 03:38:08.305479
75	2	2016-11-20 03:38:08.305492
76	3	2016-11-20 03:38:08.305505
77	18	2016-11-20 03:38:08.305519
78	9	2016-11-20 03:38:08.305532
79	19	2016-11-20 03:38:08.305545
80	15	2016-11-20 03:38:08.305559
81	20	2016-11-20 03:38:08.305572
82	16	2016-11-20 03:38:08.305585
83	3	2016-11-20 03:38:08.305599
84	18	2016-11-20 03:38:08.305612
85	19	2016-11-20 03:38:08.305625
86	9	2016-11-20 03:38:08.305638
87	8	2016-11-20 03:38:08.305652
88	15	2016-11-20 03:38:08.305665
89	17	2016-11-20 03:38:08.305678
90	13	2016-11-20 03:38:08.305691
91	2	2016-11-20 03:38:08.305705
92	18	2016-11-20 03:38:08.305718
93	4	2016-11-20 03:38:08.305731
94	6	2016-11-20 03:38:08.305744
95	5	2016-11-20 03:38:08.305757
96	19	2016-11-20 03:38:08.30577
97	9	2016-11-20 03:38:08.305783
98	20	2016-11-20 03:38:08.305796
99	9	2016-11-20 03:38:08.305809
100	13	2016-11-20 03:38:08.305822
101	9	2016-11-20 03:38:08.305835
102	6	2016-11-20 03:38:08.305848
103	15	2016-11-20 03:38:08.305861
104	5	2016-11-20 03:38:08.305875
105	10	2016-11-20 03:38:08.305888
106	5	2016-11-20 03:38:08.305901
107	17	2016-11-20 03:38:08.305914
108	5	2016-11-20 03:38:08.305929
109	4	2016-11-20 03:38:08.305943
110	6	2016-11-20 03:38:08.305957
111	19	2016-11-20 03:38:08.30597
112	20	2016-11-20 03:38:08.305983
113	11	2016-11-20 03:38:08.306483
114	9	2016-11-20 03:38:08.306506
115	18	2016-11-20 03:38:08.306522
116	7	2016-11-20 03:38:08.306537
117	13	2016-11-20 03:38:08.306552
118	2	2016-11-20 03:38:08.306565
119	3	2016-11-20 03:38:08.306579
120	18	2016-11-20 03:38:08.306592
121	3	2016-11-20 03:38:08.306605
122	16	2016-11-20 03:38:08.306619
123	6	2016-11-20 03:38:08.306632
124	5	2016-11-20 03:38:08.306646
125	20	2016-11-20 03:38:08.306659
126	2	2016-11-20 03:38:08.306673
127	3	2016-11-20 03:38:08.306687
128	19	2016-11-20 03:38:08.306701
129	12	2016-11-20 03:38:08.306715
130	3	2016-11-20 03:38:08.306729
131	9	2016-11-20 03:38:08.306742
132	12	2016-11-20 03:38:08.306755
133	1	2016-11-20 03:38:08.306769
134	20	2016-11-20 03:38:08.306783
135	8	2016-11-20 03:38:08.306796
136	20	2016-11-20 03:38:08.30681
137	20	2016-11-20 03:38:08.306824
138	5	2016-11-20 03:38:08.306837
139	11	2016-11-20 03:38:08.306851
140	11	2016-11-20 03:38:08.306864
141	12	2016-11-20 03:38:08.306878
142	6	2016-11-20 03:38:08.306891
143	12	2016-11-20 03:38:08.306905
144	4	2016-11-20 03:38:08.306919
145	5	2016-11-20 03:38:08.306932
146	2	2016-11-20 03:38:08.306946
147	4	2016-11-20 03:38:08.306959
148	8	2016-11-20 03:38:08.306973
149	18	2016-11-20 03:38:08.306987
150	10	2016-11-20 03:38:08.307001
151	15	2016-11-20 03:38:08.307015
152	18	2016-11-20 03:38:08.307029
153	7	2016-11-20 03:38:08.307042
154	6	2016-11-20 03:38:08.307056
155	10	2016-11-20 03:38:08.307069
156	3	2016-11-20 03:38:08.307083
157	6	2016-11-20 03:38:08.307096
158	1	2016-11-20 03:38:08.30711
159	14	2016-11-20 03:38:08.307123
160	4	2016-11-20 03:38:08.307137
161	2	2016-11-20 03:38:08.30715
162	14	2016-11-20 03:38:08.307164
163	4	2016-11-20 03:38:08.307177
164	16	2016-11-20 03:38:08.307191
165	1	2016-11-20 03:38:08.307204
166	7	2016-11-20 03:38:08.307217
167	15	2016-11-20 03:38:08.307231
168	20	2016-11-20 03:38:08.307244
169	2	2016-11-20 03:38:08.307257
170	3	2016-11-20 03:38:08.307271
171	16	2016-11-20 03:38:08.307284
172	6	2016-11-20 03:38:08.307298
173	10	2016-11-20 03:38:08.307311
174	18	2016-11-20 03:38:08.307324
175	15	2016-11-20 03:38:08.307338
176	7	2016-11-20 03:38:08.307351
177	20	2016-11-20 03:38:08.307365
178	13	2016-11-20 03:38:08.307379
179	18	2016-11-20 03:38:08.307392
180	16	2016-11-20 03:38:08.307405
181	9	2016-11-20 03:38:08.307418
182	8	2016-11-20 03:38:08.307432
183	9	2016-11-20 03:38:08.307445
184	1	2016-11-20 03:38:08.307458
185	14	2016-11-20 03:38:08.307472
186	8	2016-11-20 03:38:08.307485
187	10	2016-11-20 03:38:08.307498
188	11	2016-11-20 03:38:08.307512
189	2	2016-11-20 03:38:08.307525
190	8	2016-11-20 03:38:08.307539
191	14	2016-11-20 03:38:08.307552
192	3	2016-11-20 03:38:08.307565
193	20	2016-11-20 03:38:08.307578
194	10	2016-11-20 03:38:08.307592
195	14	2016-11-20 03:38:08.307605
196	14	2016-11-20 03:38:08.307619
197	19	2016-11-20 03:38:08.307632
198	4	2016-11-20 03:38:08.307646
199	9	2016-11-20 03:38:08.307659
200	20	2016-11-20 03:38:08.307672
201	13	2016-11-20 03:38:08.307685
202	11	2016-11-20 03:38:08.307698
203	18	2016-11-20 03:38:08.307712
204	5	2016-11-20 03:38:08.307726
205	2	2016-11-20 03:38:08.307739
206	7	2016-11-20 03:38:08.307752
207	5	2016-11-20 03:38:08.307765
208	8	2016-11-20 03:38:08.307779
209	18	2016-11-20 03:38:08.307792
210	13	2016-11-20 03:38:08.307806
211	13	2016-11-20 03:38:08.307819
212	10	2016-11-20 03:38:08.307832
213	8	2016-11-20 03:38:08.307846
214	13	2016-11-20 03:38:08.307913
215	1	2016-11-20 03:38:08.307928
216	14	2016-11-20 03:38:08.307941
217	1	2016-11-20 03:38:08.307955
218	18	2016-11-20 03:38:08.307968
219	5	2016-11-20 03:38:08.307981
220	8	2016-11-20 03:38:08.307995
221	8	2016-11-20 03:38:08.308007
222	20	2016-11-20 03:38:08.308021
223	3	2016-11-20 03:38:08.308033
224	4	2016-11-20 03:38:08.308047
225	17	2016-11-20 03:38:08.30806
226	12	2016-11-20 03:38:08.308073
227	16	2016-11-20 03:38:08.308087
228	18	2016-11-20 03:38:08.3081
229	17	2016-11-20 03:38:08.308113
230	18	2016-11-20 03:38:08.308126
231	14	2016-11-20 03:38:08.308139
232	7	2016-11-20 03:38:08.308152
233	4	2016-11-20 03:38:08.308165
234	10	2016-11-20 03:38:08.308178
235	19	2016-11-20 03:38:08.308192
236	3	2016-11-20 03:38:08.308205
237	20	2016-11-20 03:38:08.308219
238	17	2016-11-20 03:38:08.308232
239	3	2016-11-20 03:38:08.308245
240	15	2016-11-20 03:38:08.308258
241	18	2016-11-20 03:38:08.308271
242	16	2016-11-20 03:38:08.308285
243	7	2016-11-20 03:38:08.308298
244	8	2016-11-20 03:38:08.308311
245	14	2016-11-20 03:38:08.308324
246	1	2016-11-20 03:38:08.308338
247	1	2016-11-20 03:38:08.308351
248	8	2016-11-20 03:38:08.308364
249	17	2016-11-20 03:38:08.308377
250	17	2016-11-20 03:38:08.30839
251	6	2016-11-20 03:38:08.308404
252	11	2016-11-20 03:38:08.308417
253	13	2016-11-20 03:38:08.30843
254	20	2016-11-20 03:38:08.308444
255	20	2016-11-20 03:38:08.308457
256	3	2016-11-20 03:38:08.30847
257	15	2016-11-20 03:38:08.308483
258	3	2016-11-20 03:38:08.308496
259	15	2016-11-20 03:38:08.30851
260	7	2016-11-20 03:38:08.308523
261	19	2016-11-20 03:38:08.308536
262	19	2016-11-20 03:38:08.30855
263	12	2016-11-20 03:38:08.308563
264	9	2016-11-20 03:38:08.308576
265	13	2016-11-20 03:38:08.308589
266	13	2016-11-20 03:38:08.308602
267	9	2016-11-20 03:38:08.308615
268	3	2016-11-20 03:38:08.308628
269	2	2016-11-20 03:38:08.308641
270	7	2016-11-20 03:38:08.308655
271	20	2016-11-20 03:38:08.308668
272	18	2016-11-20 03:38:08.308681
273	17	2016-11-20 03:38:08.308694
274	5	2016-11-20 03:38:08.308707
275	13	2016-11-20 03:38:08.308721
276	6	2016-11-20 03:38:08.308734
277	13	2016-11-20 03:38:08.308747
278	1	2016-11-20 03:38:08.30876
279	9	2016-11-20 03:38:08.308773
280	13	2016-11-20 03:38:08.308786
281	14	2016-11-20 03:38:08.308799
282	9	2016-11-20 03:38:08.308812
283	20	2016-11-20 03:38:08.308826
284	5	2016-11-20 03:38:08.308839
285	3	2016-11-20 03:38:08.308853
286	3	2016-11-20 03:38:08.308866
287	17	2016-11-20 03:38:08.308879
288	5	2016-11-20 03:38:08.308892
289	4	2016-11-20 03:38:08.308905
290	2	2016-11-20 03:38:08.308918
291	9	2016-11-20 03:38:08.308931
292	4	2016-11-20 03:38:08.308945
293	16	2016-11-20 03:38:08.308958
294	20	2016-11-20 03:38:08.308971
295	19	2016-11-20 03:38:08.308983
296	11	2016-11-20 03:38:08.308996
297	18	2016-11-20 03:38:08.309009
298	1	2016-11-20 03:38:08.309023
299	7	2016-11-20 03:38:08.309036
300	5	2016-11-20 03:38:08.309049
301	4	2016-11-20 03:38:08.309062
302	13	2016-11-20 03:38:08.309075
303	11	2016-11-20 03:38:08.309088
304	15	2016-11-20 03:38:08.309101
305	15	2016-11-20 03:38:08.309115
306	8	2016-11-20 03:38:08.309129
307	4	2016-11-20 03:38:08.309189
308	6	2016-11-20 03:38:08.309204
309	4	2016-11-20 03:38:08.309217
310	17	2016-11-20 03:38:08.30923
311	5	2016-11-20 03:38:08.309244
312	10	2016-11-20 03:38:08.309257
313	3	2016-11-20 03:38:08.309272
314	5	2016-11-20 03:38:08.309285
315	2	2016-11-20 03:38:08.309298
316	5	2016-11-20 03:38:08.309311
317	5	2016-11-20 03:38:08.309324
318	20	2016-11-20 03:38:08.309337
319	11	2016-11-20 03:38:08.30935
320	7	2016-11-20 03:38:08.309363
321	9	2016-11-20 03:38:08.309376
322	14	2016-11-20 03:38:08.30939
323	8	2016-11-20 03:38:08.309403
324	4	2016-11-20 03:38:08.309416
325	7	2016-11-20 03:38:08.309429
326	1	2016-11-20 03:38:08.309442
327	19	2016-11-20 03:38:08.309455
328	16	2016-11-20 03:38:08.309468
329	10	2016-11-20 03:38:08.309482
330	18	2016-11-20 03:38:08.309495
331	9	2016-11-20 03:38:08.309508
332	14	2016-11-20 03:38:08.309521
333	18	2016-11-20 03:38:08.309534
334	13	2016-11-20 03:38:08.309547
335	6	2016-11-20 03:38:08.30956
336	1	2016-11-20 03:38:08.309573
337	11	2016-11-20 03:38:08.309586
338	8	2016-11-20 03:38:08.309599
339	9	2016-11-20 03:38:08.309613
340	7	2016-11-20 03:38:08.309626
341	9	2016-11-20 03:38:08.309639
342	11	2016-11-20 03:38:08.309652
343	7	2016-11-20 03:38:08.309665
344	11	2016-11-20 03:38:08.309678
345	10	2016-11-20 03:38:08.309691
346	6	2016-11-20 03:38:08.309704
347	18	2016-11-20 03:38:08.309717
348	12	2016-11-20 03:38:08.30973
349	4	2016-11-20 03:38:08.309743
350	8	2016-11-20 03:38:08.309756
351	16	2016-11-20 03:38:08.309769
352	1	2016-11-20 03:38:08.309783
353	16	2016-11-20 03:38:08.309796
354	20	2016-11-20 03:38:08.309809
355	11	2016-11-20 03:38:08.309823
356	7	2016-11-20 03:38:08.309836
357	12	2016-11-20 03:38:08.30985
358	16	2016-11-20 03:38:08.309863
359	14	2016-11-20 03:38:08.309875
360	15	2016-11-20 03:38:08.309888
361	3	2016-11-20 03:38:08.309901
362	12	2016-11-20 03:38:08.309915
363	14	2016-11-20 03:38:08.309928
364	13	2016-11-20 03:38:08.309941
365	7	2016-11-20 03:38:08.309954
366	7	2016-11-20 03:38:08.309967
367	6	2016-11-20 03:38:08.30998
368	6	2016-11-20 03:38:08.309993
369	3	2016-11-20 03:38:08.310006
370	10	2016-11-20 03:38:08.310019
371	1	2016-11-20 03:38:08.310031
372	17	2016-11-20 03:38:08.310044
373	20	2016-11-20 03:38:08.310057
374	12	2016-11-20 03:38:08.31007
375	16	2016-11-20 03:38:08.310083
376	13	2016-11-20 03:38:08.310096
377	11	2016-11-20 03:38:08.310109
378	1	2016-11-20 03:38:08.310122
379	14	2016-11-20 03:38:08.310135
380	6	2016-11-20 03:38:08.310147
381	12	2016-11-20 03:38:08.310161
382	1	2016-11-20 03:38:08.310174
383	3	2016-11-20 03:38:08.310187
384	4	2016-11-20 03:38:08.3102
385	4	2016-11-20 03:38:08.310213
386	19	2016-11-20 03:38:08.310226
387	18	2016-11-20 03:38:08.310239
388	8	2016-11-20 03:38:08.310252
389	10	2016-11-20 03:38:08.310265
390	10	2016-11-20 03:38:08.310278
391	8	2016-11-20 03:38:08.310291
392	14	2016-11-20 03:38:08.310304
393	20	2016-11-20 03:38:08.310317
394	12	2016-11-20 03:38:08.310329
395	7	2016-11-20 03:38:08.310387
396	9	2016-11-20 03:38:08.310401
397	4	2016-11-20 03:38:08.310415
398	16	2016-11-20 03:38:08.310428
399	13	2016-11-20 03:38:08.310442
400	6	2016-11-20 03:38:08.310455
401	15	2016-11-20 03:38:08.310468
402	8	2016-11-20 03:38:08.310481
403	16	2016-11-20 03:38:08.310494
404	1	2016-11-20 03:38:08.310507
405	8	2016-11-20 03:38:08.31052
406	15	2016-11-20 03:38:08.310533
407	4	2016-11-20 03:38:08.310547
408	11	2016-11-20 03:38:08.31056
409	18	2016-11-20 03:38:08.310584
410	9	2016-11-20 03:38:08.310598
411	3	2016-11-20 03:38:08.310673
412	7	2016-11-20 03:38:08.310705
413	2	2016-11-20 03:38:08.310728
414	14	2016-11-20 03:38:08.310741
415	2	2016-11-20 03:38:08.310755
416	7	2016-11-20 03:38:08.310768
417	11	2016-11-20 03:38:08.310781
418	14	2016-11-20 03:38:08.310802
419	6	2016-11-20 03:38:08.310816
420	18	2016-11-20 03:38:08.310829
421	8	2016-11-20 03:38:08.310842
422	5	2016-11-20 03:38:08.310855
423	5	2016-11-20 03:38:08.31087
424	13	2016-11-20 03:38:08.310883
425	12	2016-11-20 03:38:08.310896
426	4	2016-11-20 03:38:08.310909
427	14	2016-11-20 03:38:08.310922
428	11	2016-11-20 03:38:08.310937
429	6	2016-11-20 03:38:08.310951
430	2	2016-11-20 03:38:08.310964
431	12	2016-11-20 03:38:08.310977
432	10	2016-11-20 03:38:08.310993
433	8	2016-11-20 03:38:08.311006
434	3	2016-11-20 03:38:08.311019
435	5	2016-11-20 03:38:08.311032
436	15	2016-11-20 03:38:08.311045
437	3	2016-11-20 03:38:08.31106
438	6	2016-11-20 03:38:08.311073
439	16	2016-11-20 03:38:08.311086
440	1	2016-11-20 03:38:08.311099
441	14	2016-11-20 03:38:08.311112
442	8	2016-11-20 03:38:08.311126
443	13	2016-11-20 03:38:08.31114
444	17	2016-11-20 03:38:08.311155
445	18	2016-11-20 03:38:08.311168
446	20	2016-11-20 03:38:08.311183
447	9	2016-11-20 03:38:08.311196
448	18	2016-11-20 03:38:08.311209
449	20	2016-11-20 03:38:08.311224
450	9	2016-11-20 03:38:08.311239
451	1	2016-11-20 03:38:08.311254
452	5	2016-11-20 03:38:08.311267
453	20	2016-11-20 03:38:08.31128
454	8	2016-11-20 03:38:08.311293
455	6	2016-11-20 03:38:08.311306
456	12	2016-11-20 03:38:08.311321
457	16	2016-11-20 03:38:08.311334
458	15	2016-11-20 03:38:08.311347
459	12	2016-11-20 03:38:08.31136
460	3	2016-11-20 03:38:08.311375
461	17	2016-11-20 03:38:08.311389
462	13	2016-11-20 03:38:08.311403
463	15	2016-11-20 03:38:08.311417
464	15	2016-11-20 03:38:08.311431
465	2	2016-11-20 03:38:08.311447
466	11	2016-11-20 03:38:08.311462
467	9	2016-11-20 03:38:08.311476
468	14	2016-11-20 03:38:08.311488
469	18	2016-11-20 03:38:08.311501
470	15	2016-11-20 03:38:08.311516
471	13	2016-11-20 03:38:08.311529
472	17	2016-11-20 03:38:08.311542
473	8	2016-11-20 03:38:08.311554
474	16	2016-11-20 03:38:08.311569
475	18	2016-11-20 03:38:08.311582
476	7	2016-11-20 03:38:08.311595
477	13	2016-11-20 03:38:08.311608
478	8	2016-11-20 03:38:08.311621
479	13	2016-11-20 03:38:08.311638
480	3	2016-11-20 03:38:08.311651
481	16	2016-11-20 03:38:08.311666
482	19	2016-11-20 03:38:08.311736
483	19	2016-11-20 03:38:08.311763
484	7	2016-11-20 03:38:08.311779
485	15	2016-11-20 03:38:08.311793
486	2	2016-11-20 03:38:08.311806
487	15	2016-11-20 03:38:08.311818
488	12	2016-11-20 03:38:08.311833
489	19	2016-11-20 03:38:08.311846
490	13	2016-11-20 03:38:08.311861
491	3	2016-11-20 03:38:08.311875
492	13	2016-11-20 03:38:08.311888
493	3	2016-11-20 03:38:08.311902
494	4	2016-11-20 03:38:08.311916
495	15	2016-11-20 03:38:08.311928
496	6	2016-11-20 03:38:08.311941
497	4	2016-11-20 03:38:08.311954
498	15	2016-11-20 03:38:08.311969
499	1	2016-11-20 03:38:08.311982
500	6	2016-11-20 03:38:08.311997
501	3	2016-11-20 03:38:08.31201
502	6	2016-11-20 03:38:08.312025
503	20	2016-11-20 03:38:08.312038
504	16	2016-11-20 03:38:08.312051
505	18	2016-11-20 03:38:08.312063
506	13	2016-11-20 03:38:08.312076
507	14	2016-11-20 03:38:08.312091
508	9	2016-11-20 03:38:08.312104
509	12	2016-11-20 03:38:08.312117
510	18	2016-11-20 03:38:08.31213
511	9	2016-11-20 03:38:08.312142
512	11	2016-11-20 03:38:08.312158
513	18	2016-11-20 03:38:08.312173
514	12	2016-11-20 03:38:08.312186
515	7	2016-11-20 03:38:08.312199
516	18	2016-11-20 03:38:08.312213
517	14	2016-11-20 03:38:08.312228
518	19	2016-11-20 03:38:08.312241
519	5	2016-11-20 03:38:08.312254
520	18	2016-11-20 03:38:08.312266
521	13	2016-11-20 03:38:08.312281
522	13	2016-11-20 03:38:08.312294
523	3	2016-11-20 03:38:08.312307
524	20	2016-11-20 03:38:08.312319
525	14	2016-11-20 03:38:08.312332
526	8	2016-11-20 03:38:08.312346
527	11	2016-11-20 03:38:08.31236
528	9	2016-11-20 03:38:08.312373
529	19	2016-11-20 03:38:08.312387
530	5	2016-11-20 03:38:08.312401
531	6	2016-11-20 03:38:08.312414
532	19	2016-11-20 03:38:08.312427
533	12	2016-11-20 03:38:08.31244
534	18	2016-11-20 03:38:08.312454
535	12	2016-11-20 03:38:08.312469
536	12	2016-11-20 03:38:08.312485
537	13	2016-11-20 03:38:08.312499
538	18	2016-11-20 03:38:08.312512
539	20	2016-11-20 03:38:08.312524
540	5	2016-11-20 03:38:08.312539
541	19	2016-11-20 03:38:08.312552
542	20	2016-11-20 03:38:08.312565
543	11	2016-11-20 03:38:08.312578
544	17	2016-11-20 03:38:08.312593
545	16	2016-11-20 03:38:08.312606
546	18	2016-11-20 03:38:08.312619
547	6	2016-11-20 03:38:08.312632
548	7	2016-11-20 03:38:08.312645
549	7	2016-11-20 03:38:08.312658
550	14	2016-11-20 03:38:08.312671
551	15	2016-11-20 03:38:08.312684
552	1	2016-11-20 03:38:08.312697
553	13	2016-11-20 03:38:08.31271
554	5	2016-11-20 03:38:08.312723
555	10	2016-11-20 03:38:08.312736
556	5	2016-11-20 03:38:08.312748
557	16	2016-11-20 03:38:08.312761
558	1	2016-11-20 03:38:08.312775
559	6	2016-11-20 03:38:08.312788
560	9	2016-11-20 03:38:08.312801
561	7	2016-11-20 03:38:08.312814
562	17	2016-11-20 03:38:08.312827
563	19	2016-11-20 03:38:08.31284
564	19	2016-11-20 03:38:08.312853
565	16	2016-11-20 03:38:08.312866
566	15	2016-11-20 03:38:08.312879
567	1	2016-11-20 03:38:08.312892
568	12	2016-11-20 03:38:08.312905
569	18	2016-11-20 03:38:08.312918
570	6	2016-11-20 03:38:08.312975
571	8	2016-11-20 03:38:08.312989
572	9	2016-11-20 03:38:08.313002
573	14	2016-11-20 03:38:08.313016
574	6	2016-11-20 03:38:08.313028
575	10	2016-11-20 03:38:08.313041
576	19	2016-11-20 03:38:08.313054
577	14	2016-11-20 03:38:08.313068
578	2	2016-11-20 03:38:08.313081
579	11	2016-11-20 03:38:08.313094
580	7	2016-11-20 03:38:08.313107
581	10	2016-11-20 03:38:08.31312
582	5	2016-11-20 03:38:08.313133
583	1	2016-11-20 03:38:08.313146
584	1	2016-11-20 03:38:08.313159
585	13	2016-11-20 03:38:08.313172
586	7	2016-11-20 03:38:08.313185
587	3	2016-11-20 03:38:08.313198
588	9	2016-11-20 03:38:08.313211
589	2	2016-11-20 03:38:08.313224
590	18	2016-11-20 03:38:08.313237
591	16	2016-11-20 03:38:08.31325
592	9	2016-11-20 03:38:08.313263
593	17	2016-11-20 03:38:08.313277
594	12	2016-11-20 03:38:08.31329
595	10	2016-11-20 03:38:08.313303
596	1	2016-11-20 03:38:08.313316
597	16	2016-11-20 03:38:08.313329
598	14	2016-11-20 03:38:08.313341
599	1	2016-11-20 03:38:08.313354
600	15	2016-11-20 03:38:08.313368
601	21	2016-11-21 00:00:00
602	21	2016-11-21 00:00:00
603	22	2015-06-05 00:00:00
604	23	2016-09-15 00:00:00
605	23	2016-09-15 00:00:00
606	23	2016-09-15 00:00:00
607	24	2014-08-15 00:00:00
608	24	2016-11-05 00:00:00
609	25	2014-10-01 00:00:00
610	26	2015-09-23 00:00:00
611	27	2015-05-05 00:00:00
612	28	2015-07-20 00:00:00
613	28	2015-07-20 00:00:00
614	29	2016-07-30 00:00:00
615	30	2016-11-01 00:00:00
616	31	2015-08-20 00:00:00
617	12	2015-05-16 00:00:00
618	33	2013-08-30 00:00:00
619	34	2014-06-19 00:00:00
\.


--
-- Name: visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('visits_id_seq', 619, true);


--
-- Name: restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: uservisits_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY uservisits
    ADD CONSTRAINT uservisits_pkey PRIMARY KEY (id);


--
-- Name: visits_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (id);


--
-- Name: uservisits_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY uservisits
    ADD CONSTRAINT uservisits_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: uservisits_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY uservisits
    ADD CONSTRAINT uservisits_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES visits(id);


--
-- Name: visits_rest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_rest_id_fkey FOREIGN KEY (rest_id) REFERENCES restaurants(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

