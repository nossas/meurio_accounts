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
-- Name: casino_login_tickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_login_tickets (
    id integer NOT NULL,
    ticket character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_login_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_login_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_login_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_login_tickets_id_seq OWNED BY casino_login_tickets.id;


--
-- Name: casino_proxy_granting_tickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_proxy_granting_tickets (
    id integer NOT NULL,
    ticket character varying(255) NOT NULL,
    iou character varying(255) NOT NULL,
    granter_id integer NOT NULL,
    pgt_url character varying(255) NOT NULL,
    granter_type character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_proxy_granting_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_proxy_granting_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_proxy_granting_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_proxy_granting_tickets_id_seq OWNED BY casino_proxy_granting_tickets.id;


--
-- Name: casino_proxy_tickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_proxy_tickets (
    id integer NOT NULL,
    ticket character varying(255) NOT NULL,
    service text NOT NULL,
    consumed boolean DEFAULT false NOT NULL,
    proxy_granting_ticket_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_proxy_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_proxy_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_proxy_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_proxy_tickets_id_seq OWNED BY casino_proxy_tickets.id;


--
-- Name: casino_service_rules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_service_rules (
    id integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "order" integer DEFAULT 10 NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    regex boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_service_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_service_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_service_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_service_rules_id_seq OWNED BY casino_service_rules.id;


--
-- Name: casino_service_tickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_service_tickets (
    id integer NOT NULL,
    ticket character varying(255) NOT NULL,
    service text NOT NULL,
    ticket_granting_ticket_id integer,
    consumed boolean DEFAULT false NOT NULL,
    issued_from_credentials boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_service_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_service_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_service_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_service_tickets_id_seq OWNED BY casino_service_tickets.id;


--
-- Name: casino_ticket_granting_tickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_ticket_granting_tickets (
    id integer NOT NULL,
    ticket character varying(255) NOT NULL,
    user_agent character varying(255),
    user_id integer NOT NULL,
    awaiting_two_factor_authentication boolean DEFAULT false NOT NULL,
    long_term boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_ticket_granting_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_ticket_granting_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_ticket_granting_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_ticket_granting_tickets_id_seq OWNED BY casino_ticket_granting_tickets.id;


--
-- Name: casino_two_factor_authenticators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_two_factor_authenticators (
    id integer NOT NULL,
    user_id integer NOT NULL,
    secret character varying(255) NOT NULL,
    active boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_two_factor_authenticators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_two_factor_authenticators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_two_factor_authenticators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_two_factor_authenticators_id_seq OWNED BY casino_two_factor_authenticators.id;


--
-- Name: casino_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE casino_users (
    id integer NOT NULL,
    authenticator character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    extra_attributes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: casino_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE casino_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: casino_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE casino_users_id_seq OWNED BY casino_users.id;


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
-- Name: memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE memberships (
    id integer NOT NULL,
    user_id integer,
    organization_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE memberships_id_seq OWNED BY memberships.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    mailchimp_list_id character varying(255) NOT NULL,
    city character varying(255) NOT NULL
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


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
    topics integer,
    funder boolean DEFAULT false,
    cpf character varying(255),
    address_extra character varying(255),
    address_number character varying(255),
    country character varying(255),
    skills character varying(255)[] DEFAULT '{}'::character varying[],
    ip character varying(255),
    application_slug character varying(255),
    sponsor boolean DEFAULT false,
    CONSTRAINT proper_email CHECK (((email)::text ~* '([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z_-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}'::text)),
    CONSTRAINT proper_phone CHECK ((((phone)::text ~* '[(]{1}[0-9]{2}[)]{1} [0-9]{8,9}'::text) OR ((phone)::text = ''::text)))
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

ALTER TABLE ONLY casino_login_tickets ALTER COLUMN id SET DEFAULT nextval('casino_login_tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_proxy_granting_tickets ALTER COLUMN id SET DEFAULT nextval('casino_proxy_granting_tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_proxy_tickets ALTER COLUMN id SET DEFAULT nextval('casino_proxy_tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_service_rules ALTER COLUMN id SET DEFAULT nextval('casino_service_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_service_tickets ALTER COLUMN id SET DEFAULT nextval('casino_service_tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_ticket_granting_tickets ALTER COLUMN id SET DEFAULT nextval('casino_ticket_granting_tickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_two_factor_authenticators ALTER COLUMN id SET DEFAULT nextval('casino_two_factor_authenticators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY casino_users ALTER COLUMN id SET DEFAULT nextval('casino_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY memberships ALTER COLUMN id SET DEFAULT nextval('memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: casino_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_users
    ADD CONSTRAINT casino_users_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: login_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_login_tickets
    ADD CONSTRAINT login_tickets_pkey PRIMARY KEY (id);


--
-- Name: memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: proxy_granting_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_proxy_granting_tickets
    ADD CONSTRAINT proxy_granting_tickets_pkey PRIMARY KEY (id);


--
-- Name: proxy_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_proxy_tickets
    ADD CONSTRAINT proxy_tickets_pkey PRIMARY KEY (id);


--
-- Name: service_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_service_rules
    ADD CONSTRAINT service_rules_pkey PRIMARY KEY (id);


--
-- Name: service_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_service_tickets
    ADD CONSTRAINT service_tickets_pkey PRIMARY KEY (id);


--
-- Name: ticket_granting_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_ticket_granting_tickets
    ADD CONSTRAINT ticket_granting_tickets_pkey PRIMARY KEY (id);


--
-- Name: two_factor_authenticators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY casino_two_factor_authenticators
    ADD CONSTRAINT two_factor_authenticators_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: casino_proxy_tickets_on_pgt_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX casino_proxy_tickets_on_pgt_id ON casino_proxy_tickets USING btree (proxy_granting_ticket_id);


--
-- Name: casino_service_tickets_on_tgt_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX casino_service_tickets_on_tgt_id ON casino_service_tickets USING btree (ticket_granting_ticket_id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_casino_login_tickets_on_ticket; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_login_tickets_on_ticket ON casino_login_tickets USING btree (ticket);


--
-- Name: index_casino_proxy_granting_tickets_on_granter; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_proxy_granting_tickets_on_granter ON casino_proxy_granting_tickets USING btree (granter_type, granter_id);


--
-- Name: index_casino_proxy_granting_tickets_on_iou; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_proxy_granting_tickets_on_iou ON casino_proxy_granting_tickets USING btree (iou);


--
-- Name: index_casino_proxy_granting_tickets_on_ticket; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_proxy_granting_tickets_on_ticket ON casino_proxy_granting_tickets USING btree (ticket);


--
-- Name: index_casino_proxy_tickets_on_ticket; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_proxy_tickets_on_ticket ON casino_proxy_tickets USING btree (ticket);


--
-- Name: index_casino_service_rules_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_service_rules_on_url ON casino_service_rules USING btree (url);


--
-- Name: index_casino_service_tickets_on_ticket; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_service_tickets_on_ticket ON casino_service_tickets USING btree (ticket);


--
-- Name: index_casino_ticket_granting_tickets_on_ticket; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_ticket_granting_tickets_on_ticket ON casino_ticket_granting_tickets USING btree (ticket);


--
-- Name: index_casino_two_factor_authenticators_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_casino_two_factor_authenticators_on_user_id ON casino_two_factor_authenticators USING btree (user_id);


--
-- Name: index_casino_users_on_authenticator_and_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_casino_users_on_authenticator_and_username ON casino_users USING btree (authenticator, username);


--
-- Name: index_memberships_on_organization_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_memberships_on_organization_id_and_user_id ON memberships USING btree (organization_id, user_id);


--
-- Name: index_organizations_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_organizations_on_name ON organizations USING btree (name);


--
-- Name: index_proxy_granting_tickets_on_granter; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_proxy_granting_tickets_on_granter ON casino_proxy_granting_tickets USING btree (granter_type, granter_id);


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

INSERT INTO schema_migrations (version) VALUES ('20131121165448');

INSERT INTO schema_migrations (version) VALUES ('20131128110133');

INSERT INTO schema_migrations (version) VALUES ('20131128113358');

INSERT INTO schema_migrations (version) VALUES ('20131217105732');

INSERT INTO schema_migrations (version) VALUES ('20131217110047');

INSERT INTO schema_migrations (version) VALUES ('20131217110513');

INSERT INTO schema_migrations (version) VALUES ('20131217125300');

INSERT INTO schema_migrations (version) VALUES ('20131220211510');

INSERT INTO schema_migrations (version) VALUES ('20131223181401');

INSERT INTO schema_migrations (version) VALUES ('20131223181610');

INSERT INTO schema_migrations (version) VALUES ('20131223181817');

INSERT INTO schema_migrations (version) VALUES ('20131223181840');

INSERT INTO schema_migrations (version) VALUES ('20131223181947');

INSERT INTO schema_migrations (version) VALUES ('20131226223042');

INSERT INTO schema_migrations (version) VALUES ('20131227001105');

INSERT INTO schema_migrations (version) VALUES ('20140114181943');

INSERT INTO schema_migrations (version) VALUES ('20140114184655');

INSERT INTO schema_migrations (version) VALUES ('20140114185243');

INSERT INTO schema_migrations (version) VALUES ('20140328150542');

INSERT INTO schema_migrations (version) VALUES ('20140328181211');

INSERT INTO schema_migrations (version) VALUES ('20140407204415');

INSERT INTO schema_migrations (version) VALUES ('20140505130346');

INSERT INTO schema_migrations (version) VALUES ('20140509130729');

INSERT INTO schema_migrations (version) VALUES ('20140509130730');

INSERT INTO schema_migrations (version) VALUES ('20140509130731');

INSERT INTO schema_migrations (version) VALUES ('20140509130732');

INSERT INTO schema_migrations (version) VALUES ('20140509130733');

INSERT INTO schema_migrations (version) VALUES ('20140519135656');

INSERT INTO schema_migrations (version) VALUES ('20140519174420');

INSERT INTO schema_migrations (version) VALUES ('20140519175144');

INSERT INTO schema_migrations (version) VALUES ('20140520140252');

INSERT INTO schema_migrations (version) VALUES ('20140522105531');

INSERT INTO schema_migrations (version) VALUES ('20140522110815');

INSERT INTO schema_migrations (version) VALUES ('20140522110841');

INSERT INTO schema_migrations (version) VALUES ('20140522110852');

INSERT INTO schema_migrations (version) VALUES ('20140522110941');

INSERT INTO schema_migrations (version) VALUES ('20140522110953');

INSERT INTO schema_migrations (version) VALUES ('20140522111012');
