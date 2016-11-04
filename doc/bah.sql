--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: url; Type: TABLE; Schema: public; Owner: rogon; Tablespace: 
--

CREATE TABLE url (
    id integer NOT NULL,
    long_url text,
    short_url text,
    ts timestamp without time zone,
    visited integer
);


ALTER TABLE public.url OWNER TO rogon;

--
-- Name: url_id_seq; Type: SEQUENCE; Schema: public; Owner: rogon
--

CREATE SEQUENCE url_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_id_seq OWNER TO rogon;

--
-- Name: url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rogon
--

ALTER SEQUENCE url_id_seq OWNED BY url.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rogon
--

ALTER TABLE ONLY url ALTER COLUMN id SET DEFAULT nextval('url_id_seq'::regclass);


--
-- Data for Name: url; Type: TABLE DATA; Schema: public; Owner: rogon
--

COPY url (id, long_url, short_url, ts, visited) FROM stdin;
\.


--
-- Name: url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rogon
--

SELECT pg_catalog.setval('url_id_seq', 55, true);


--
-- Name: url_pkey; Type: CONSTRAINT; Schema: public; Owner: rogon; Tablespace: 
--

ALTER TABLE ONLY url
    ADD CONSTRAINT url_pkey PRIMARY KEY (id);


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

