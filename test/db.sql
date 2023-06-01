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

CREATE DATABASE poa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Mexico.1252';


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
-- Name: status_format; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_format AS ENUM (
    'Approved',
    'Rejected',
    'Pending'
);


ALTER TYPE public.status_format OWNER TO postgres;

--
-- Name: insert_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_users() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (new.role = 'Director') THEN
        INSERT INTO directors(director_user) VALUES(new.id);
    END IF;
    IF (new.role = 'Assistant') THEN
        INSERT INTO assistants(assistant_user) VALUES(new.id);
    END IF;
    RETURN new;
END;

$$;


ALTER FUNCTION public.insert_users() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    activity character varying NOT NULL,
    status boolean DEFAULT true NOT NULL,
    indicator_number integer NOT NULL,
    indicator_type integer NOT NULL,
    measure_unit integer NOT NULL,
    area integer NOT NULL
);


ALTER TABLE public.activities OWNER TO postgres;

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_id_seq OWNER TO postgres;

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: annual_programmes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annual_programmes (
    id integer NOT NULL,
    status_poa public.status_format DEFAULT 'Pending'::public.status_format NOT NULL,
    dates json,
    pdf_document text,
    area_process integer NOT NULL,
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
    title character varying NOT NULL,
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
-- Name: assistants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assistants (
    id integer NOT NULL,
    assistant_user integer NOT NULL
);


ALTER TABLE public.assistants OWNER TO postgres;

--
-- Name: assistants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assistants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assistants_id_seq OWNER TO postgres;

--
-- Name: assistants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assistants_id_seq OWNED BY public.assistants.id;


--
-- Name: directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directors (
    id integer NOT NULL,
    director_user integer NOT NULL
);


ALTER TABLE public.directors OWNER TO postgres;

--
-- Name: directors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directors_id_seq OWNER TO postgres;

--
-- Name: directors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directors_id_seq OWNED BY public.directors.id;


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
    title character varying NOT NULL,
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
-- Name: poa_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poa_activities (
    id integer NOT NULL,
    status_activity public.status_activity DEFAULT 'In Process'::public.status_activity NOT NULL,
    annual_goal integer NOT NULL,
    observations json,
    evidence text,
    poa integer NOT NULL,
    activity integer NOT NULL
);


ALTER TABLE public.poa_activities OWNER TO postgres;

--
-- Name: poa_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poa_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poa_activities_id_seq OWNER TO postgres;

--
-- Name: poa_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poa_activities_id_seq OWNED BY public.poa_activities.id;


--
-- Name: processes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.processes (
    id integer NOT NULL,
    title character varying NOT NULL,
    process_number integer NOT NULL,
    sheet_number integer NOT NULL,
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
-- Name: quarterly_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quarterly_goals (
    id integer NOT NULL,
    quarter_number integer NOT NULL,
    programmed_goal integer NOT NULL,
    achieved_goal integer NOT NULL,
    programmed_annual_goal integer NOT NULL,
    achieved_annual_goal integer NOT NULL,
    poa_activity integer NOT NULL
);


ALTER TABLE public.quarterly_goals OWNER TO postgres;

--
-- Name: quarterly_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quarterly_goals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quarterly_goals_id_seq OWNER TO postgres;

--
-- Name: quarterly_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quarterly_goals_id_seq OWNED BY public.quarterly_goals.id;


--
-- Name: quarterly_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quarterly_reports (
    id integer NOT NULL,
    status_quarterly_report public.status_format DEFAULT 'Pending'::public.status_format NOT NULL,
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
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying NOT NULL,
    lastname character varying NOT NULL,
    email character varying NOT NULL,
    password text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    role public.roles NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

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
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


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
-- Name: assistants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assistants ALTER COLUMN id SET DEFAULT nextval('public.assistants_id_seq'::regclass);


--
-- Name: directors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors ALTER COLUMN id SET DEFAULT nextval('public.directors_id_seq'::regclass);


--
-- Name: measure_units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_units ALTER COLUMN id SET DEFAULT nextval('public.measure_units_id_seq'::regclass);


--
-- Name: periods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods ALTER COLUMN id SET DEFAULT nextval('public.periods_id_seq'::regclass);


--
-- Name: poa_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poa_activities ALTER COLUMN id SET DEFAULT nextval('public.poa_activities_id_seq'::regclass);


--
-- Name: processes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processes ALTER COLUMN id SET DEFAULT nextval('public.processes_id_seq'::regclass);


--
-- Name: quarterly_goals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_goals ALTER COLUMN id SET DEFAULT nextval('public.quarterly_goals_id_seq'::regclass);


--
-- Name: quarterly_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports ALTER COLUMN id SET DEFAULT nextval('public.quarterly_reports_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id, activity, status, indicator_number, indicator_type, measure_unit, area) FROM stdin;
\.


--
-- Data for Name: annual_programmes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annual_programmes (id, status_poa, dates, pdf_document, area_process, period) FROM stdin;
\.


--
-- Data for Name: area_processes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.area_processes (id, area, process) FROM stdin;
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, title, status, director, assistant) FROM stdin;
\.


--
-- Data for Name: assistants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assistants (id, assistant_user) FROM stdin;
1	2
\.


--
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directors (id, director_user) FROM stdin;
1	1
\.


--
-- Data for Name: measure_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measure_units (id, measure_unit, status) FROM stdin;
\.


--
-- Data for Name: periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.periods (id, title, requested_date, due_date, adjourned_date) FROM stdin;
\.


--
-- Data for Name: poa_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poa_activities (id, status_activity, annual_goal, observations, evidence, poa, activity) FROM stdin;
\.


--
-- Data for Name: processes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.processes (id, title, process_number, sheet_number, status) FROM stdin;
\.


--
-- Data for Name: quarterly_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quarterly_goals (id, quarter_number, programmed_goal, achieved_goal, programmed_annual_goal, achieved_annual_goal, poa_activity) FROM stdin;
\.


--
-- Data for Name: quarterly_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quarterly_reports (id, status_quarterly_report, pdf_document, period, poa) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, lastname, email, password, status, role) FROM stdin;
1	Marianne	Santos	20213tn140@utez.edu.mx	M08121971.	t	Director
2	Joel	Herrera	20213tn019@utez.edu.mx	J12345678.	t	Assistant
\.


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activities_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.areas_id_seq', 1, false);


--
-- Name: assistants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assistants_id_seq', 1, true);


--
-- Name: directors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directors_id_seq', 1, true);


--
-- Name: measure_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measure_units_id_seq', 1, false);


--
-- Name: periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.periods_id_seq', 1, false);


--
-- Name: poa_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poa_activities_id_seq', 1, false);


--
-- Name: processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.processes_id_seq', 1, false);


--
-- Name: quarterly_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quarterly_goals_id_seq', 1, false);


--
-- Name: quarterly_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quarterly_reports_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


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
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: assistants assistants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assistants
    ADD CONSTRAINT assistants_pkey PRIMARY KEY (id);


--
-- Name: directors directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (id);


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
-- Name: poa_activities poa_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poa_activities
    ADD CONSTRAINT poa_activities_pkey PRIMARY KEY (id);


--
-- Name: processes processes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processes
    ADD CONSTRAINT processes_pkey PRIMARY KEY (id);


--
-- Name: quarterly_goals quarterly_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_goals
    ADD CONSTRAINT quarterly_goals_pkey PRIMARY KEY (id);


--
-- Name: quarterly_reports quarterly_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports
    ADD CONSTRAINT quarterly_reports_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users insert_users_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_users_trigger AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.insert_users();


--
-- Name: poa_activities fk_activity; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poa_activities
    ADD CONSTRAINT fk_activity FOREIGN KEY (activity) REFERENCES public.activities(id);


--
-- Name: activities fk_activity_area; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT fk_activity_area FOREIGN KEY (area) REFERENCES public.areas(id);


--
-- Name: activities fk_activity_measure_unit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT fk_activity_measure_unit FOREIGN KEY (measure_unit) REFERENCES public.measure_units(id);


--
-- Name: area_processes fk_area; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_processes
    ADD CONSTRAINT fk_area FOREIGN KEY (area) REFERENCES public.areas(id);


--
-- Name: areas fk_area_assistant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_area_assistant FOREIGN KEY (assistant) REFERENCES public.assistants(id);


--
-- Name: areas fk_area_director; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_area_director FOREIGN KEY (director) REFERENCES public.directors(id);


--
-- Name: assistants fk_assistant_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assistants
    ADD CONSTRAINT fk_assistant_user FOREIGN KEY (assistant_user) REFERENCES public.users(id);


--
-- Name: directors fk_director_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT fk_director_user FOREIGN KEY (director_user) REFERENCES public.users(id);


--
-- Name: quarterly_goals fk_goals_activity; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_goals
    ADD CONSTRAINT fk_goals_activity FOREIGN KEY (poa_activity) REFERENCES public.poa_activities(id);


--
-- Name: poa_activities fk_poa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poa_activities
    ADD CONSTRAINT fk_poa FOREIGN KEY (poa) REFERENCES public.annual_programmes(id);


--
-- Name: annual_programmes fk_poa_area_process; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_programmes
    ADD CONSTRAINT fk_poa_area_process FOREIGN KEY (area_process) REFERENCES public.area_processes(id);


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
-- Name: quarterly_reports fk_quarterly_report_period; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports
    ADD CONSTRAINT fk_quarterly_report_period FOREIGN KEY (period) REFERENCES public.periods(id);


--
-- Name: quarterly_reports fk_quarterly_report_poa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quarterly_reports
    ADD CONSTRAINT fk_quarterly_report_poa FOREIGN KEY (poa) REFERENCES public.annual_programmes(id);


--
-- PostgreSQL database dump complete
--

