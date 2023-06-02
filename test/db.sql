--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS poa;
--
-- Name: poa; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE poa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE poa OWNER TO postgres;

\connect poa

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: roles; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.roles AS ENUM (
    'Administrator',
    'Director',
    'Assistant'
);


ALTER TYPE public.roles OWNER TO postgres;

--
-- Name: status_activity; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_activity AS ENUM (
    'Rejected',
    'Done',
    'In Process'
);


ALTER TYPE public.status_activity OWNER TO postgres;

--
-- Name: status_check; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_check AS ENUM (
    'Approved',
    'Rejected',
    'Pending'
);


ALTER TYPE public.status_check OWNER TO postgres;

--
-- Name: status_delivery; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_delivery AS ENUM (
    'Delivered on time',
    'Delivered late'
);


ALTER TYPE public.status_delivery OWNER TO postgres;

--
-- Name: status_time; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_time AS ENUM (
    'On time',
    'Late',
    'Early'
);


ALTER TYPE public.status_time OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: annual_programmes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annual_programmes (
    id integer NOT NULL,
    area json NOT NULL,
    process json NOT NULL,
    activities json NOT NULL,
    status public.status_delivery NOT NULL,
    date date DEFAULT now() NOT NULL,
    pdf_document text,
    period integer NOT NULL
);


ALTER TABLE public.annual_programmes OWNER TO postgres;

--
-- Name: annual_programmes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annual_programmes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annual_programmes_id_seq OWNER TO postgres;

--
-- Name: annual_programmes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annual_programmes_id_seq OWNED BY public.annual_programmes.id;


--
-- Name: area_processes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area_processes (
    id integer NOT NULL,
    area integer NOT NULL,
    process integer NOT NULL
);


ALTER TABLE public.area_processes OWNER TO postgres;

--
-- Name: area_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.area_processes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_processes_id_seq OWNER TO postgres;

--
-- Name: area_processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.area_processes_id_seq OWNED BY public.area_processes.id;


--
-- Name: areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas (
    id integer NOT NULL,
    area character varying(50) NOT NULL,
    status boolean DEFAULT true NOT NULL,
    director integer,
    assistant integer
);


ALTER TABLE public.areas OWNER TO postgres;

--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.areas_id_seq OWNER TO postgres;

--
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    lastname character varying(30) NOT NULL,
    email character varying(50) NOT NULL,
    password text NOT NULL,
    phone_number character varying NOT NULL,
    status boolean DEFAULT true NOT NULL,
    role public.roles NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: areas_users; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.areas_users AS
 SELECT a.id AS area_id,
    a.area AS area_name,
    u.id AS assistant_id,
    u.name AS assistant_name,
    u.lastname AS assistant_lastname,
    u.email AS assistant_email,
    u.role AS assistant_role,
    u2.id AS director_id,
    u2.name AS director_name,
    u2.lastname AS director_lastname,
    u2.email AS director_email,
    u2.role AS director_role
   FROM ((public.areas a
     JOIN public.users u ON ((u.id = a.assistant)))
     JOIN public.users u2 ON ((u2.id = a.director)));


ALTER TABLE public.areas_users OWNER TO postgres;

--
-- Name: indicator_numbers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.indicator_numbers (
    id integer NOT NULL,
    indicator_number character varying,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.indicator_numbers OWNER TO postgres;

--
-- Name: indicator_numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.indicator_numbers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indicator_numbers_id_seq OWNER TO postgres;

--
-- Name: indicator_numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.indicator_numbers_id_seq OWNED BY public.indicator_numbers.id;


--
-- Name: measure_units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measure_units (
    id integer NOT NULL,
    measure_unit character varying NOT NULL,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.measure_units OWNER TO postgres;

--
-- Name: measure_units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measure_units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measure_units_id_seq OWNER TO postgres;

--
-- Name: measure_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measure_units_id_seq OWNED BY public.measure_units.id;


--
-- Name: periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.periods (
    id integer NOT NULL,
    period character varying NOT NULL,
    requested_date date NOT NULL,
    due_date date NOT NULL,
    adjourned_date date
);


ALTER TABLE public.periods OWNER TO postgres;

--
-- Name: periods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.periods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.periods_id_seq OWNER TO postgres;

--
-- Name: periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.periods_id_seq OWNED BY public.periods.id;


--
-- Name: processes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.processes (
    id integer NOT NULL,
    process character varying NOT NULL,
    process_number integer NOT NULL,
    sheet_number integer,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.processes OWNER TO postgres;

--
-- Name: processes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.processes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.processes_id_seq OWNER TO postgres;

--
-- Name: processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.processes_id_seq OWNED BY public.processes.id;


--
-- Name: quarterly_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quarterly_reports (
    id integer NOT NULL,
    status public.status_delivery NOT NULL,
    date date DEFAULT now() NOT NULL,
    pdf_document text,
    period integer NOT NULL,
    poa integer NOT NULL
);


ALTER TABLE public.quarterly_reports OWNER TO postgres;

--
-- Name: quarterly_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quarterly_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quarterly_reports_id_seq OWNER TO postgres;

--
-- Name: quarterly_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quarterly_reports_id_seq OWNED BY public.quarterly_reports.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: annual_programmes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_programmes ALTER COLUMN id SET DEFAULT nextval('public.annual_programmes_id_seq'::regclass);


--
-- Name: area_processes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_processes ALTER COLUMN id SET DEFAULT nextval('public.area_processes_id_seq'::regclass);


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- Name: indicator_numbers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.indicator_numbers ALTER COLUMN id SET DEFAULT nextval('public.indicator_numbers_id_seq'::regclass);


--
-- Name: measure_units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_units ALTER COLUMN id SET DEFAULT nextval('public.measure_units_id_seq'::regclass);


--
-- Name: periods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods ALTER COLUMN id SET DEFAULT nextval('public.periods_id_seq'::regclass);


--
-- Name: processes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processes ALTER COLUMN id SET DEFAULT nextval('public.processes_id_seq'::regclass);


--
-- Name: quarterly_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports ALTER COLUMN id SET DEFAULT nextval('public.quarterly_reports_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: annual_programmes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annual_programmes (id, area, process, activities, status, date, pdf_document, period) FROM stdin;
\.


--
-- Data for Name: area_processes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.area_processes (id, area, process) FROM stdin;
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, area, status, director, assistant) FROM stdin;
30	DATID	f	3	2
1	DATIC	t	3	2
\.


--
-- Data for Name: indicator_numbers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_numbers (id, indicator_number, status) FROM stdin;
\.


--
-- Data for Name: measure_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measure_units (id, measure_unit, status) FROM stdin;
\.


--
-- Data for Name: periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.periods (id, period, requested_date, due_date, adjourned_date) FROM stdin;
\.


--
-- Data for Name: processes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.processes (id, process, process_number, sheet_number, status) FROM stdin;
\.


--
-- Data for Name: quarterly_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quarterly_reports (id, status, date, pdf_document, period, poa) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, lastname, email, password, phone_number, status, role) FROM stdin;
1	Joel	Herrera	joel@utez.edu.mx	123456	7774138126	t	Assistant
2	Mario	Perez	mario@utez.edu.mx	123456	6776862478	t	Director
3	Carlos	Martinez	carlos@utez.edu.mx	123456	9079766678	t	Assistant
\.


--
-- Name: annual_programmes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annual_programmes_id_seq', 1, false);


--
-- Name: area_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.area_processes_id_seq', 1, false);


--
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.areas_id_seq', 30, true);


--
-- Name: indicator_numbers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.indicator_numbers_id_seq', 1, false);


--
-- Name: measure_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measure_units_id_seq', 1, false);


--
-- Name: periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.periods_id_seq', 1, false);


--
-- Name: processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.processes_id_seq', 1, false);


--
-- Name: quarterly_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quarterly_reports_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: annual_programmes annual_programmes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_programmes
    ADD CONSTRAINT annual_programmes_pkey PRIMARY KEY (id);


--
-- Name: area_processes area_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_processes
    ADD CONSTRAINT area_processes_pkey PRIMARY KEY (id);


--
-- Name: areas areas_area_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_area_key UNIQUE (area);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: indicator_numbers indicator_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.indicator_numbers
    ADD CONSTRAINT indicator_numbers_pkey PRIMARY KEY (id);


--
-- Name: measure_units measure_units_measure_unit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_units
    ADD CONSTRAINT measure_units_measure_unit_key UNIQUE (measure_unit);


--
-- Name: measure_units measure_units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_units
    ADD CONSTRAINT measure_units_pkey PRIMARY KEY (id);


--
-- Name: periods periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (id);


--
-- Name: processes processes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processes
    ADD CONSTRAINT processes_pkey PRIMARY KEY (id);


--
-- Name: processes processes_process_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processes
    ADD CONSTRAINT processes_process_key UNIQUE (process);


--
-- Name: quarterly_reports quarterly_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports
    ADD CONSTRAINT quarterly_reports_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: area_processes fk_area; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_processes
    ADD CONSTRAINT fk_area FOREIGN KEY (area) REFERENCES public.areas(id);


--
-- Name: areas fk_area_assistant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_area_assistant FOREIGN KEY (assistant) REFERENCES public.users(id);


--
-- Name: areas fk_area_director; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_area_director FOREIGN KEY (director) REFERENCES public.users(id);


--
-- Name: quarterly_reports fk_period; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports
    ADD CONSTRAINT fk_period FOREIGN KEY (period) REFERENCES public.periods(id);


--
-- Name: quarterly_reports fk_poa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports
    ADD CONSTRAINT fk_poa FOREIGN KEY (poa) REFERENCES public.annual_programmes(id);


--
-- Name: annual_programmes fk_poa_period; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_programmes
    ADD CONSTRAINT fk_poa_period FOREIGN KEY (period) REFERENCES public.periods(id);


--
-- Name: area_processes fk_process; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_processes
    ADD CONSTRAINT fk_process FOREIGN KEY (process) REFERENCES public.processes(id);


--
-- PostgreSQL database dump complete
--

