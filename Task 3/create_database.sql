--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-12-03 01:13:06

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 256 (class 1255 OID 24651)
-- Name: instrument_rental_limit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.instrument_rental_limit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    -- Count active rentals for the student
    IF (SELECT COUNT(*) 
        FROM rented_instrument 
        WHERE student_id = NEW.student_id AND rent_end IS NULL) >= 2 THEN
        RAISE EXCEPTION 'Student has already rented the maximum of 2 instruments';
    END IF;
    RETURN NEW;  -- Allow the insertion if the condition is not violated
END;
$$;


ALTER FUNCTION public.instrument_rental_limit() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16398)
-- Name: adress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adress (
    adress_id integer NOT NULL,
    person_id integer NOT NULL,
    city character varying(100) NOT NULL,
    zip_code character varying(100) NOT NULL,
    street character varying(100) NOT NULL
);


ALTER TABLE public.adress OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16397)
-- Name: adress_adress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.adress ALTER COLUMN adress_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.adress_adress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16478)
-- Name: email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email (
    email_id integer NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.email OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16477)
-- Name: email_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.email ALTER COLUMN email_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.email_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 248 (class 1259 OID 24622)
-- Name: ensemble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ensemble (
    ensemble_id integer NOT NULL,
    lesson_id integer NOT NULL,
    genre character varying(100) NOT NULL,
    min_students integer NOT NULL,
    max_students integer NOT NULL
);


ALTER TABLE public.ensemble OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 24621)
-- Name: ensamble_ensamble_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ensemble ALTER COLUMN ensemble_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ensamble_ensamble_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 24577)
-- Name: lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson (
    lesson_id integer NOT NULL,
    instructor_id integer NOT NULL,
    lesson_code character varying(100) NOT NULL,
    lesson_type character varying(100) NOT NULL,
    skill_level character varying(100) NOT NULL,
    "time" time without time zone NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.lesson OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24653)
-- Name: lesson_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_students (
    lesson_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.lesson_students OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 32983)
-- Name: ensemble_this_week; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ensemble_this_week AS
 SELECT lesson.date AS day,
    ensemble.genre,
        CASE
            WHEN ((ensemble.max_students - count(lesson_students.student_id)) = 0) THEN 'No Seats'::text
            WHEN ((ensemble.max_students - count(lesson_students.student_id)) <= 2) THEN '1 or 2 Seats'::text
            ELSE 'Many Seats'::text
        END AS no_of_free_seats
   FROM ((public.lesson
     JOIN public.ensemble ON ((lesson.lesson_id = ensemble.lesson_id)))
     LEFT JOIN public.lesson_students ON ((lesson.lesson_id = lesson_students.lesson_id)))
  WHERE ((lesson.date >= (CURRENT_DATE + 1)) AND (lesson.date <= (CURRENT_DATE + 7)))
  GROUP BY lesson.date, ensemble.genre, ensemble.max_students
  ORDER BY ensemble.genre, lesson.date;


ALTER VIEW public.ensemble_this_week OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 24594)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    lesson_id integer NOT NULL,
    instrument_type character varying(100) NOT NULL,
    groups_id integer NOT NULL,
    max_students integer NOT NULL,
    min_students integer NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 32894)
-- Name: groups_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.groups ALTER COLUMN groups_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.groups_groups_id_seq
    START WITH 1
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16424)
-- Name: guardian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guardian (
    guardian_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.guardian OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16423)
-- Name: guardian_guardian_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.guardian ALTER COLUMN guardian_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.guardian_guardian_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16462)
-- Name: guardian_student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guardian_student (
    student_id integer NOT NULL,
    guardian_id integer NOT NULL,
    relationship character varying(100) NOT NULL
);


ALTER TABLE public.guardian_student OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 24609)
-- Name: individual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.individual (
    individual_id integer NOT NULL,
    lesson_id integer NOT NULL,
    instrument_type character varying(100) NOT NULL
);


ALTER TABLE public.individual OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 24608)
-- Name: individual_individual_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.individual ALTER COLUMN individual_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.individual_individual_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16439)
-- Name: instructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor (
    instructor_id integer NOT NULL,
    person_id integer NOT NULL,
    employment_id character varying(100) NOT NULL,
    available character varying(100) NOT NULL
);


ALTER TABLE public.instructor OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16438)
-- Name: instructor_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instructor ALTER COLUMN instructor_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instructor_instructor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16452)
-- Name: instructor_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_skill (
    instructor_skill_id integer NOT NULL,
    instructor_id integer NOT NULL,
    instrument_type character varying(100),
    skill_level character varying(100) NOT NULL,
    genre character varying(100)
);


ALTER TABLE public.instructor_skill OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16451)
-- Name: instructor_skill_instructor_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instructor_skill ALTER COLUMN instructor_skill_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instructor_skill_instructor_skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    person_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    person_number character varying(13)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 32968)
-- Name: instructors_lesson_count; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.instructors_lesson_count AS
 SELECT instructor.instructor_id,
    person.first_name,
    person.last_name,
    count(lesson.lesson_id) AS no_of_lessons
   FROM ((public.instructor
     JOIN public.person ON ((instructor.person_id = person.person_id)))
     JOIN public.lesson ON ((instructor.instructor_id = lesson.instructor_id)))
  WHERE ((EXTRACT(month FROM lesson.date) = EXTRACT(month FROM CURRENT_DATE)) AND (EXTRACT(year FROM lesson.date) = EXTRACT(year FROM CURRENT_DATE)))
  GROUP BY instructor.instructor_id, person.first_name, person.last_name
 HAVING (count(lesson.lesson_id) > 0)
  ORDER BY (count(lesson.lesson_id)) DESC;


ALTER VIEW public.instructors_lesson_count OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16520)
-- Name: instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrument (
    instrument_id integer NOT NULL,
    instrument_serial_number character varying(100) NOT NULL,
    instrument_type character varying(100) NOT NULL,
    brand character varying(100) NOT NULL,
    rental_fee character varying(100) NOT NULL,
    rent_period character varying(100) NOT NULL
);


ALTER TABLE public.instrument OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16519)
-- Name: instrument_instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instrument ALTER COLUMN instrument_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instrument_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 24576)
-- Name: lesson_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lesson ALTER COLUMN lesson_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lesson_lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 243 (class 1259 OID 24583)
-- Name: lesson_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_price (
    lesson_price_id integer NOT NULL,
    lesson_id integer NOT NULL,
    price character varying(100) NOT NULL
);


ALTER TABLE public.lesson_price OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 24582)
-- Name: lesson_price_lesson_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lesson_price ALTER COLUMN lesson_price_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lesson_price_lesson_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 251 (class 1259 OID 32932)
-- Name: lessons_per_month_2024; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.lessons_per_month_2024 AS
 SELECT to_char((date)::timestamp with time zone, 'YYYY-MM'::text) AS month,
    count(*) AS total_lessons,
    sum(
        CASE
            WHEN ((lesson_type)::text = 'individual'::text) THEN 1
            ELSE 0
        END) AS individual_lessons,
    sum(
        CASE
            WHEN ((lesson_type)::text = 'group'::text) THEN 1
            ELSE 0
        END) AS group_lessons,
    sum(
        CASE
            WHEN ((lesson_type)::text = 'ensemble'::text) THEN 1
            ELSE 0
        END) AS ensemble_lessons
   FROM public.lesson
  WHERE (EXTRACT(year FROM date) = (2024)::numeric)
  GROUP BY (to_char((date)::timestamp with time zone, 'YYYY-MM'::text))
  ORDER BY (to_char((date)::timestamp with time zone, 'YYYY-MM'::text));


ALTER VIEW public.lessons_per_month_2024 OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 32937)
-- Name: lessons_per_month_2025; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.lessons_per_month_2025 AS
 SELECT to_char((date)::timestamp with time zone, 'YYYY-MM'::text) AS month,
    count(*) AS total_lessons,
    sum(
        CASE
            WHEN ((lesson_type)::text = 'individual'::text) THEN 1
            ELSE 0
        END) AS individual_lessons,
    sum(
        CASE
            WHEN ((lesson_type)::text = 'group'::text) THEN 1
            ELSE 0
        END) AS group_lessons,
    sum(
        CASE
            WHEN ((lesson_type)::text = 'ensemble'::text) THEN 1
            ELSE 0
        END) AS ensemble_lessons
   FROM public.lesson
  WHERE (EXTRACT(year FROM date) = (2025)::numeric)
  GROUP BY (to_char((date)::timestamp with time zone, 'YYYY-MM'::text))
  ORDER BY (to_char((date)::timestamp with time zone, 'YYYY-MM'::text));


ALTER VIEW public.lessons_per_month_2025 OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 32954)
-- Name: no_siblings; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.no_siblings AS
 SELECT no_of_siblings,
    count(*) AS no_of_students
   FROM ( SELECT gs1.student_id,
            (count(DISTINCT gs2.student_id) - 1) AS no_of_siblings
           FROM (public.guardian_student gs1
             LEFT JOIN public.guardian_student gs2 ON ((gs1.guardian_id = gs2.guardian_id)))
          GROUP BY gs1.student_id) sibling_counts
  GROUP BY no_of_siblings
  ORDER BY no_of_siblings;


ALTER VIEW public.no_siblings OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16504)
-- Name: person_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person_email (
    person_id integer NOT NULL,
    email_id integer NOT NULL
);


ALTER TABLE public.person_email OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.person ALTER COLUMN person_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.person_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16489)
-- Name: person_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person_phone (
    person_id integer NOT NULL,
    phone_id integer NOT NULL
);


ALTER TABLE public.person_phone OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16484)
-- Name: phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone (
    phone_id integer NOT NULL,
    phone character varying(100) NOT NULL
);


ALTER TABLE public.phone OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16483)
-- Name: phone_phone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.phone ALTER COLUMN phone_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.phone_phone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 239 (class 1259 OID 16528)
-- Name: rented_instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rented_instrument (
    rented_instrument_id integer NOT NULL,
    instrument_id integer NOT NULL,
    student_id integer NOT NULL,
    rent_start date NOT NULL,
    rent_end date NOT NULL
);


ALTER TABLE public.rented_instrument OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16527)
-- Name: rented_instrument_rented_instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rented_instrument ALTER COLUMN rented_instrument_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rented_instrument_rented_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16409)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    person_id integer NOT NULL,
    enrollment_id character varying NOT NULL
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16408)
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student ALTER COLUMN student_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.student_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4854 (class 2606 OID 16402)
-- Name: adress adress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adress_id);


--
-- TOC entry 4876 (class 2606 OID 16482)
-- Name: email email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (email_id);


--
-- TOC entry 4904 (class 2606 OID 24628)
-- Name: ensemble ensemble_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensemble
    ADD CONSTRAINT ensemble_lesson_id_key UNIQUE (lesson_id);


--
-- TOC entry 4906 (class 2606 OID 24626)
-- Name: ensemble ensemble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensemble
    ADD CONSTRAINT ensemble_pkey PRIMARY KEY (ensemble_id);


--
-- TOC entry 4896 (class 2606 OID 24600)
-- Name: groups group_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT group_lesson_id_key UNIQUE (lesson_id);


--
-- TOC entry 4898 (class 2606 OID 32900)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (groups_id);


--
-- TOC entry 4862 (class 2606 OID 24637)
-- Name: guardian guardian_person_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian
    ADD CONSTRAINT guardian_person_id_key UNIQUE (person_id);


--
-- TOC entry 4864 (class 2606 OID 16428)
-- Name: guardian guardian_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian
    ADD CONSTRAINT guardian_pkey PRIMARY KEY (guardian_id);


--
-- TOC entry 4874 (class 2606 OID 16466)
-- Name: guardian_student guardian_student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_student
    ADD CONSTRAINT guardian_student_pkey PRIMARY KEY (student_id, guardian_id);


--
-- TOC entry 4900 (class 2606 OID 24615)
-- Name: individual individual_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.individual
    ADD CONSTRAINT individual_lesson_id_key UNIQUE (lesson_id);


--
-- TOC entry 4902 (class 2606 OID 24613)
-- Name: individual individual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.individual
    ADD CONSTRAINT individual_pkey PRIMARY KEY (individual_id);


--
-- TOC entry 4866 (class 2606 OID 16445)
-- Name: instructor instructor_employment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_employment_id_key UNIQUE (employment_id);


--
-- TOC entry 4868 (class 2606 OID 24639)
-- Name: instructor instructor_person_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_person_id_key UNIQUE (person_id);


--
-- TOC entry 4870 (class 2606 OID 16443)
-- Name: instructor instructor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_pkey PRIMARY KEY (instructor_id);


--
-- TOC entry 4872 (class 2606 OID 16456)
-- Name: instructor_skill instructor_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_skill
    ADD CONSTRAINT instructor_skill_pkey PRIMARY KEY (instructor_skill_id, instructor_id);


--
-- TOC entry 4884 (class 2606 OID 16526)
-- Name: instrument instrument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT instrument_pkey PRIMARY KEY (instrument_id);


--
-- TOC entry 4890 (class 2606 OID 24581)
-- Name: lesson lesson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson
    ADD CONSTRAINT lesson_pkey PRIMARY KEY (lesson_id);


--
-- TOC entry 4892 (class 2606 OID 24607)
-- Name: lesson_price lesson_price_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_price
    ADD CONSTRAINT lesson_price_lesson_id_key UNIQUE (lesson_id);


--
-- TOC entry 4894 (class 2606 OID 24587)
-- Name: lesson_price lesson_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_price
    ADD CONSTRAINT lesson_price_pkey PRIMARY KEY (lesson_price_id, lesson_id);


--
-- TOC entry 4908 (class 2606 OID 24657)
-- Name: lesson_students lesson_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_students
    ADD CONSTRAINT lesson_students_pkey PRIMARY KEY (lesson_id, student_id);


--
-- TOC entry 4882 (class 2606 OID 16508)
-- Name: person_email person_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_email
    ADD CONSTRAINT person_email_pkey PRIMARY KEY (person_id, email_id);


--
-- TOC entry 4850 (class 2606 OID 32769)
-- Name: person person_person_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_person_number_key UNIQUE (person_number);


--
-- TOC entry 4880 (class 2606 OID 16493)
-- Name: person_phone person_phone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone
    ADD CONSTRAINT person_phone_pkey PRIMARY KEY (person_id, phone_id);


--
-- TOC entry 4852 (class 2606 OID 16394)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- TOC entry 4878 (class 2606 OID 16488)
-- Name: phone phone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone
    ADD CONSTRAINT phone_pkey PRIMARY KEY (phone_id);


--
-- TOC entry 4886 (class 2606 OID 24643)
-- Name: rented_instrument rented_instrument_instrument_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rented_instrument
    ADD CONSTRAINT rented_instrument_instrument_id_key UNIQUE (instrument_id);


--
-- TOC entry 4888 (class 2606 OID 16532)
-- Name: rented_instrument rented_instrument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rented_instrument
    ADD CONSTRAINT rented_instrument_pkey PRIMARY KEY (rented_instrument_id);


--
-- TOC entry 4856 (class 2606 OID 16417)
-- Name: student student_enrollment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_enrollment_id_key UNIQUE (enrollment_id);


--
-- TOC entry 4858 (class 2606 OID 24635)
-- Name: student student_person_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_person_id_key UNIQUE (person_id);


--
-- TOC entry 4860 (class 2606 OID 16415)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4928 (class 2620 OID 24652)
-- Name: rented_instrument rent_limit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER rent_limit BEFORE INSERT ON public.rented_instrument FOR EACH ROW EXECUTE FUNCTION public.instrument_rental_limit();


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 4928
-- Name: TRIGGER rent_limit ON rented_instrument; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TRIGGER rent_limit ON public.rented_instrument IS 'Triggers every time a student wants to rent an instrument.';


--
-- TOC entry 4909 (class 2606 OID 16403)
-- Name: adress adress_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4925 (class 2606 OID 24629)
-- Name: ensemble ensemble_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensemble
    ADD CONSTRAINT ensemble_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lesson(lesson_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4923 (class 2606 OID 24601)
-- Name: groups group_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT group_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lesson(lesson_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4911 (class 2606 OID 16429)
-- Name: guardian guardian_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian
    ADD CONSTRAINT guardian_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4914 (class 2606 OID 16472)
-- Name: guardian_student guardian_student_guardian_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_student
    ADD CONSTRAINT guardian_student_guardian_id_fkey FOREIGN KEY (guardian_id) REFERENCES public.guardian(guardian_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4915 (class 2606 OID 16467)
-- Name: guardian_student guardian_student_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guardian_student
    ADD CONSTRAINT guardian_student_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4924 (class 2606 OID 24616)
-- Name: individual individual_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.individual
    ADD CONSTRAINT individual_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lesson(lesson_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4912 (class 2606 OID 16446)
-- Name: instructor instructor_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4913 (class 2606 OID 16457)
-- Name: instructor_skill instructor_skill_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_skill
    ADD CONSTRAINT instructor_skill_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4922 (class 2606 OID 24588)
-- Name: lesson_price lesson_price_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_price
    ADD CONSTRAINT lesson_price_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lesson(lesson_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4926 (class 2606 OID 24658)
-- Name: lesson_students lesson_students_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_students
    ADD CONSTRAINT lesson_students_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lesson(lesson_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4927 (class 2606 OID 24663)
-- Name: lesson_students lesson_students_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_students
    ADD CONSTRAINT lesson_students_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4918 (class 2606 OID 16514)
-- Name: person_email person_email_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_email
    ADD CONSTRAINT person_email_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email(email_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4919 (class 2606 OID 16509)
-- Name: person_email person_email_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_email
    ADD CONSTRAINT person_email_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4916 (class 2606 OID 16494)
-- Name: person_phone person_phone_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone
    ADD CONSTRAINT person_phone_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4917 (class 2606 OID 16499)
-- Name: person_phone person_phone_phone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_phone
    ADD CONSTRAINT person_phone_phone_id_fkey FOREIGN KEY (phone_id) REFERENCES public.phone(phone_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4920 (class 2606 OID 16533)
-- Name: rented_instrument rented_instrument_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rented_instrument
    ADD CONSTRAINT rented_instrument_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4921 (class 2606 OID 16538)
-- Name: rented_instrument rented_instrument_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rented_instrument
    ADD CONSTRAINT rented_instrument_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4910 (class 2606 OID 16418)
-- Name: student student_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-12-03 01:13:06

--
-- PostgreSQL database dump complete
--

