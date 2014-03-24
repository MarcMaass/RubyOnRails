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
-- Name: age_ranges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE age_ranges (
    id integer NOT NULL,
    min_age integer,
    max_age integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: age_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE age_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: age_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE age_ranges_id_seq OWNED BY age_ranges.id;


--
-- Name: athletes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE athletes (
    id integer NOT NULL,
    email character varying(255),
    password_digest character varying(255),
    last_name character varying(255),
    first_name character varying(255),
    birthday date,
    gender_id integer,
    street character varying(255),
    house_number integer,
    location_id integer,
    phone character varying(255),
    picture_file_name character varying(255),
    picture_content_type character varying(255),
    picture_file_size integer,
    picture_updated_at timestamp without time zone,
    activated boolean DEFAULT false,
    type character varying(255),
    organization_unit_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: athletes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE athletes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: athletes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE athletes_id_seq OWNED BY athletes.id;


--
-- Name: athletes_organization_units; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE athletes_organization_units (
    athlete_id integer NOT NULL,
    organization_unit_id integer NOT NULL
);


--
-- Name: athletes_sports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE athletes_sports (
    athlete_id integer NOT NULL,
    sport_id integer NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: discipline_ages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE discipline_ages (
    id integer NOT NULL,
    discipline_id integer,
    age_range_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: discipline_ages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE discipline_ages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discipline_ages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE discipline_ages_id_seq OWNED BY discipline_ages.id;


--
-- Name: disciplines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE disciplines (
    id integer NOT NULL,
    name character varying(255),
    year date,
    gender_id integer,
    unit_id integer,
    category_id integer,
    sport_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: disciplines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE disciplines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disciplines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE disciplines_id_seq OWNED BY disciplines.id;


--
-- Name: districts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE districts (
    id integer NOT NULL,
    name character varying(255),
    federal_state_id integer,
    district_chief_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: districts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE districts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: districts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE districts_id_seq OWNED BY districts.id;


--
-- Name: federal_states; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE federal_states (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: federal_states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE federal_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: federal_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE federal_states_id_seq OWNED BY federal_states.id;


--
-- Name: genders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE genders (
    id integer NOT NULL,
    sex character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: genders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE genders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE genders_id_seq OWNED BY genders.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    postal_code character varying(255),
    name character varying(255),
    district_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: medals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE medals (
    id integer NOT NULL,
    points integer,
    sign character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: medals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE medals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE medals_id_seq OWNED BY medals.id;


--
-- Name: organization_units; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organization_units (
    id integer NOT NULL,
    name character varying(255),
    street character varying(255),
    house_number integer,
    phone_number character varying(255),
    email character varying(255),
    url character varying(255),
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organization_units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_units_id_seq OWNED BY organization_units.id;


--
-- Name: organization_units_sport_facilities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organization_units_sport_facilities (
    organization_unit_id integer NOT NULL,
    sport_facility_id integer NOT NULL
);


--
-- Name: performances; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE performances (
    id integer NOT NULL,
    value double precision,
    date date,
    athlete_id integer,
    discipline_id integer,
    examiner_id integer,
    district_chief_id integer,
    sport_facility_id integer,
    inspected boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: performances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE performances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: performances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE performances_id_seq OWNED BY performances.id;


--
-- Name: required_performances; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE required_performances (
    id integer NOT NULL,
    value double precision,
    discipline_age_id integer,
    medal_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: required_performances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE required_performances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: required_performances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE required_performances_id_seq OWNED BY required_performances.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sport_facilities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sport_facilities (
    id integer NOT NULL,
    name character varying(255),
    street character varying(255),
    house_number integer,
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sport_facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sport_facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sport_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sport_facilities_id_seq OWNED BY sport_facilities.id;


--
-- Name: sports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sports (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sports_id_seq OWNED BY sports.id;


--
-- Name: test_appointments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE test_appointments (
    id integer NOT NULL,
    start_date date,
    "time" time without time zone,
    info_text text,
    cancelled boolean,
    discipline_id integer,
    sport_facility_id integer,
    district_chief_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: test_appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE test_appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE test_appointments_id_seq OWNED BY test_appointments.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE units (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE units_id_seq OWNED BY units.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY age_ranges ALTER COLUMN id SET DEFAULT nextval('age_ranges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY athletes ALTER COLUMN id SET DEFAULT nextval('athletes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY discipline_ages ALTER COLUMN id SET DEFAULT nextval('discipline_ages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY disciplines ALTER COLUMN id SET DEFAULT nextval('disciplines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY districts ALTER COLUMN id SET DEFAULT nextval('districts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY federal_states ALTER COLUMN id SET DEFAULT nextval('federal_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY genders ALTER COLUMN id SET DEFAULT nextval('genders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY medals ALTER COLUMN id SET DEFAULT nextval('medals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_units ALTER COLUMN id SET DEFAULT nextval('organization_units_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY performances ALTER COLUMN id SET DEFAULT nextval('performances_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY required_performances ALTER COLUMN id SET DEFAULT nextval('required_performances_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sport_facilities ALTER COLUMN id SET DEFAULT nextval('sport_facilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sports ALTER COLUMN id SET DEFAULT nextval('sports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY test_appointments ALTER COLUMN id SET DEFAULT nextval('test_appointments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY units ALTER COLUMN id SET DEFAULT nextval('units_id_seq'::regclass);


--
-- Name: age_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY age_ranges
    ADD CONSTRAINT age_ranges_pkey PRIMARY KEY (id);


--
-- Name: athletes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY athletes
    ADD CONSTRAINT athletes_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: discipline_ages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY discipline_ages
    ADD CONSTRAINT discipline_ages_pkey PRIMARY KEY (id);


--
-- Name: disciplines_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (id);


--
-- Name: districts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);


--
-- Name: federal_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY federal_states
    ADD CONSTRAINT federal_states_pkey PRIMARY KEY (id);


--
-- Name: genders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY genders
    ADD CONSTRAINT genders_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: medals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medals
    ADD CONSTRAINT medals_pkey PRIMARY KEY (id);


--
-- Name: organization_units_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organization_units
    ADD CONSTRAINT organization_units_pkey PRIMARY KEY (id);


--
-- Name: performances_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY performances
    ADD CONSTRAINT performances_pkey PRIMARY KEY (id);


--
-- Name: required_performances_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY required_performances
    ADD CONSTRAINT required_performances_pkey PRIMARY KEY (id);


--
-- Name: sport_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sport_facilities
    ADD CONSTRAINT sport_facilities_pkey PRIMARY KEY (id);


--
-- Name: sports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sports
    ADD CONSTRAINT sports_pkey PRIMARY KEY (id);


--
-- Name: test_appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY test_appointments
    ADD CONSTRAINT test_appointments_pkey PRIMARY KEY (id);


--
-- Name: units_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: index_athletes_on_gender_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_athletes_on_gender_id ON athletes USING btree (gender_id);


--
-- Name: index_athletes_on_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_athletes_on_location_id ON athletes USING btree (location_id);


--
-- Name: index_athletes_on_organization_unit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_athletes_on_organization_unit_id ON athletes USING btree (organization_unit_id);


--
-- Name: index_discipline_ages_on_age_range_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_discipline_ages_on_age_range_id ON discipline_ages USING btree (age_range_id);


--
-- Name: index_discipline_ages_on_discipline_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_discipline_ages_on_discipline_id ON discipline_ages USING btree (discipline_id);


--
-- Name: index_disciplines_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disciplines_on_category_id ON disciplines USING btree (category_id);


--
-- Name: index_disciplines_on_gender_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disciplines_on_gender_id ON disciplines USING btree (gender_id);


--
-- Name: index_disciplines_on_sport_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disciplines_on_sport_id ON disciplines USING btree (sport_id);


--
-- Name: index_disciplines_on_unit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disciplines_on_unit_id ON disciplines USING btree (unit_id);


--
-- Name: index_districts_on_district_chief_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_districts_on_district_chief_id ON districts USING btree (district_chief_id);


--
-- Name: index_districts_on_federal_state_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_districts_on_federal_state_id ON districts USING btree (federal_state_id);


--
-- Name: index_locations_on_district_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_locations_on_district_id ON locations USING btree (district_id);


--
-- Name: index_organization_units_on_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_organization_units_on_location_id ON organization_units USING btree (location_id);


--
-- Name: index_performances_on_athlete_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_performances_on_athlete_id ON performances USING btree (athlete_id);


--
-- Name: index_performances_on_discipline_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_performances_on_discipline_id ON performances USING btree (discipline_id);


--
-- Name: index_performances_on_district_chief_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_performances_on_district_chief_id ON performances USING btree (district_chief_id);


--
-- Name: index_performances_on_examiner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_performances_on_examiner_id ON performances USING btree (examiner_id);


--
-- Name: index_performances_on_sport_facility_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_performances_on_sport_facility_id ON performances USING btree (sport_facility_id);


--
-- Name: index_required_performances_on_discipline_age_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_required_performances_on_discipline_age_id ON required_performances USING btree (discipline_age_id);


--
-- Name: index_required_performances_on_medal_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_required_performances_on_medal_id ON required_performances USING btree (medal_id);


--
-- Name: index_sport_facilities_on_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sport_facilities_on_location_id ON sport_facilities USING btree (location_id);


--
-- Name: index_test_appointments_on_discipline_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_appointments_on_discipline_id ON test_appointments USING btree (discipline_id);


--
-- Name: index_test_appointments_on_district_chief_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_appointments_on_district_chief_id ON test_appointments USING btree (district_chief_id);


--
-- Name: index_test_appointments_on_sport_facility_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_appointments_on_sport_facility_id ON test_appointments USING btree (sport_facility_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20121206150748');

INSERT INTO schema_migrations (version) VALUES ('20121206152046');

INSERT INTO schema_migrations (version) VALUES ('20121206153003');

INSERT INTO schema_migrations (version) VALUES ('20121206153507');

INSERT INTO schema_migrations (version) VALUES ('20121206153742');

INSERT INTO schema_migrations (version) VALUES ('20121206154240');

INSERT INTO schema_migrations (version) VALUES ('20121206154358');

INSERT INTO schema_migrations (version) VALUES ('20121206160148');

INSERT INTO schema_migrations (version) VALUES ('20121206160310');

INSERT INTO schema_migrations (version) VALUES ('20121209141738');

INSERT INTO schema_migrations (version) VALUES ('20121209141859');

INSERT INTO schema_migrations (version) VALUES ('20121209141910');

INSERT INTO schema_migrations (version) VALUES ('20121209142002');

INSERT INTO schema_migrations (version) VALUES ('20121215162829');

INSERT INTO schema_migrations (version) VALUES ('20121220135250');

INSERT INTO schema_migrations (version) VALUES ('20121220135309');

INSERT INTO schema_migrations (version) VALUES ('20121226185421');

INSERT INTO schema_migrations (version) VALUES ('20121227142559');

INSERT INTO schema_migrations (version) VALUES ('20121229152951');

INSERT INTO schema_migrations (version) VALUES ('20130110073437');