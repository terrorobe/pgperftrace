--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: batch; Type: TABLE; Schema: public; Owner: robe; Tablespace: 
--

CREATE TABLE batch (
    id integer NOT NULL,
    name text NOT NULL,
    submitter integer,
    status text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone
);


ALTER TABLE public.batch OWNER TO robe;

--
-- Name: batch_id_seq; Type: SEQUENCE; Schema: public; Owner: robe
--

CREATE SEQUENCE batch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.batch_id_seq OWNER TO robe;

--
-- Name: batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robe
--

ALTER SEQUENCE batch_id_seq OWNED BY batch.id;


--
-- Name: benchclient; Type: TABLE; Schema: public; Owner: robe; Tablespace: 
--

CREATE TABLE benchclient (
    id integer NOT NULL,
    name text NOT NULL,
    authkey text NOT NULL,
    maintainer integer,
    servermodel text,
    processor text,
    ram text,
    storage text,
    os text
);


ALTER TABLE public.benchclient OWNER TO robe;

--
-- Name: benchclient_id_seq; Type: SEQUENCE; Schema: public; Owner: robe
--

CREATE SEQUENCE benchclient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.benchclient_id_seq OWNER TO robe;

--
-- Name: benchclient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robe
--

ALTER SEQUENCE benchclient_id_seq OWNED BY benchclient.id;


--
-- Name: job; Type: TABLE; Schema: public; Owner: robe; Tablespace: 
--

CREATE TABLE job (
    id integer NOT NULL,
    batch integer,
    benchclient integer,
    benchtype text NOT NULL,
    benchconfig text,
    status text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone
);


ALTER TABLE public.job OWNER TO robe;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: robe
--

CREATE SEQUENCE job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.job_id_seq OWNER TO robe;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robe
--

ALTER SEQUENCE job_id_seq OWNED BY job.id;


--
-- Name: result; Type: TABLE; Schema: public; Owner: robe; Tablespace: 
--

CREATE TABLE result (
    id integer NOT NULL,
    job integer,
    systeminfo text NOT NULL,
    benchruninfo text NOT NULL,
    raw_output text NOT NULL,
    parsed_output text
);


ALTER TABLE public.result OWNER TO robe;

--
-- Name: result_id_seq; Type: SEQUENCE; Schema: public; Owner: robe
--

CREATE SEQUENCE result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.result_id_seq OWNER TO robe;

--
-- Name: result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robe
--

ALTER SEQUENCE result_id_seq OWNED BY result.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: robe; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    name text NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    role text NOT NULL
);


ALTER TABLE public."user" OWNER TO robe;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: robe
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO robe;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robe
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: robe
--

ALTER TABLE batch ALTER COLUMN id SET DEFAULT nextval('batch_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: robe
--

ALTER TABLE benchclient ALTER COLUMN id SET DEFAULT nextval('benchclient_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: robe
--

ALTER TABLE job ALTER COLUMN id SET DEFAULT nextval('job_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: robe
--

ALTER TABLE result ALTER COLUMN id SET DEFAULT nextval('result_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: robe
--

ALTER TABLE "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: batch_pkey; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (id);


--
-- Name: benchclient_name_key; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY benchclient
    ADD CONSTRAINT benchclient_name_key UNIQUE (name);


--
-- Name: benchclient_pkey; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY benchclient
    ADD CONSTRAINT benchclient_pkey PRIMARY KEY (id);


--
-- Name: job_pkey; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: result_job_key; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_job_key UNIQUE (job);


--
-- Name: result_pkey; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: robe; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: batch_submitter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: robe
--

ALTER TABLE ONLY batch
    ADD CONSTRAINT batch_submitter_fkey FOREIGN KEY (submitter) REFERENCES "user"(id);


--
-- Name: benchclient_maintainer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: robe
--

ALTER TABLE ONLY benchclient
    ADD CONSTRAINT benchclient_maintainer_fkey FOREIGN KEY (maintainer) REFERENCES "user"(id);


--
-- Name: job_batch_fkey; Type: FK CONSTRAINT; Schema: public; Owner: robe
--

ALTER TABLE ONLY job
    ADD CONSTRAINT job_batch_fkey FOREIGN KEY (batch) REFERENCES batch(id);


--
-- Name: job_benchclient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: robe
--

ALTER TABLE ONLY job
    ADD CONSTRAINT job_benchclient_fkey FOREIGN KEY (benchclient) REFERENCES benchclient(id);


--
-- Name: result_job_fkey; Type: FK CONSTRAINT; Schema: public; Owner: robe
--

ALTER TABLE ONLY result
    ADD CONSTRAINT result_job_fkey FOREIGN KEY (job) REFERENCES job(id);


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

