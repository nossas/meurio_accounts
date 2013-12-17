--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    profession character varying(255),
    website character varying(255),
    bio text,
    facebook character varying(255),
    twitter character varying(255),
    public boolean DEFAULT true,
    secondary_email character varying(255),
    birthday date,
    gender character varying(255),
    postal_code character varying(255),
    phone character varying(255),
    city character varying(255),
    address_street character varying(255),
    address_district character varying(255),
    state character varying(255),
    admin boolean,
    avatar character varying(255),
    availability bigint,
    skills integer,
    topics integer,
    CONSTRAINT proper_email CHECK (((email)::text ~* '([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z_-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}'::text))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131018165047');

INSERT INTO schema_migrations (version) VALUES ('20131031162820');

INSERT INTO schema_migrations (version) VALUES ('20131031171858');

INSERT INTO schema_migrations (version) VALUES ('20131031171925');

INSERT INTO schema_migrations (version) VALUES ('20131031171945');

INSERT INTO schema_migrations (version) VALUES ('20131031172007');

INSERT INTO schema_migrations (version) VALUES ('20131031172026');

INSERT INTO schema_migrations (version) VALUES ('20131031172051');

INSERT INTO schema_migrations (version) VALUES ('20131031172127');

INSERT INTO schema_migrations (version) VALUES ('20131031172203');

INSERT INTO schema_migrations (version) VALUES ('20131031173810');

INSERT INTO schema_migrations (version) VALUES ('20131031174204');

INSERT INTO schema_migrations (version) VALUES ('20131031174806');

INSERT INTO schema_migrations (version) VALUES ('20131031185113');

INSERT INTO schema_migrations (version) VALUES ('20131031185243');

INSERT INTO schema_migrations (version) VALUES ('20131031185257');

INSERT INTO schema_migrations (version) VALUES ('20131031185311');

INSERT INTO schema_migrations (version) VALUES ('20131031200208');

INSERT INTO schema_migrations (version) VALUES ('20131101142508');

INSERT INTO schema_migrations (version) VALUES ('20131101142841');

INSERT INTO schema_migrations (version) VALUES ('20131119183337');

INSERT INTO schema_migrations (version) VALUES ('20131121154100');

INSERT INTO schema_migrations (version) VALUES ('20131121165448');

INSERT INTO schema_migrations (version) VALUES ('20131128110133');

INSERT INTO schema_migrations (version) VALUES ('20131128113358');

INSERT INTO schema_migrations (version) VALUES ('20131217105732');

INSERT INTO schema_migrations (version) VALUES ('20131217110047');

INSERT INTO schema_migrations (version) VALUES ('20131217110513');
