--
-- PostgreSQL database dump
--

\restrict F3Jkk6L3eH5v6ZcyHXFUgzIC5BohPeZ45gA2R9IuhJaS8VSyrDh5fcsbEw9def0

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: contact_platform; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.contact_platform AS ENUM (
    'whatsapp',
    'instagram',
    'facebook'
);


--
-- Name: content_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.content_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


--
-- Name: interaction_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.interaction_type AS ENUM (
    'view_profile',
    'view_product',
    'click_whatsapp',
    'click_instagram',
    'click_facebook',
    'click_maps'
);


--
-- Name: product_availability; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_availability AS ENUM (
    'available',
    'unavailable'
);


--
-- Name: umkm_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.umkm_status AS ENUM (
    'pending',
    'active',
    'rejected'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'admin',
    'penjual',
    'pembeli'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_activity_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_activity_logs (
    id bigint NOT NULL,
    admin_id bigint NOT NULL,
    action character varying(100) NOT NULL,
    entity_type character varying(80) NOT NULL,
    entity_id bigint,
    description text,
    old_values jsonb,
    new_values jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: admin_activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_activity_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_activity_logs_id_seq OWNED BY public.admin_activity_logs.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(120) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: data_export_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_export_logs (
    id bigint NOT NULL,
    exported_by bigint NOT NULL,
    export_name character varying(160) NOT NULL,
    data_type character varying(100) NOT NULL,
    file_format character varying(10) NOT NULL,
    file_path text,
    filters jsonb,
    exported_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT data_export_logs_file_format_check CHECK (((file_format)::text = ANY ((ARRAY['csv'::character varying, 'xlsx'::character varying, 'pdf'::character varying])::text[])))
);


--
-- Name: data_export_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.data_export_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_export_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.data_export_logs_id_seq OWNED BY public.data_export_logs.id;


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_images (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    image_path text NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_images_id_seq OWNED BY public.product_images.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    umkm_id bigint NOT NULL,
    category_id bigint NOT NULL,
    name character varying(160) NOT NULL,
    slug character varying(180) NOT NULL,
    description text,
    price numeric(14,2) NOT NULL,
    unit character varying(40),
    availability public.product_availability DEFAULT 'available'::public.product_availability NOT NULL,
    moderation_status public.content_status DEFAULT 'pending'::public.content_status NOT NULL,
    moderated_by bigint,
    moderated_at timestamp with time zone,
    rejection_reason text,
    is_featured boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT products_check CHECK ((((moderation_status = 'pending'::public.content_status) AND (moderated_by IS NULL) AND (moderated_at IS NULL)) OR ((moderation_status = ANY (ARRAY['approved'::public.content_status, 'rejected'::public.content_status])) AND (moderated_by IS NOT NULL) AND (moderated_at IS NOT NULL)))),
    CONSTRAINT products_price_check CHECK ((price >= (0)::numeric))
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_settings (
    id bigint NOT NULL,
    setting_key character varying(120) NOT NULL,
    setting_value text,
    description text,
    updated_by bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.system_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: umkm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umkm (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying(160) NOT NULL,
    slug character varying(180) NOT NULL,
    description text,
    address text NOT NULL,
    village character varying(120) NOT NULL,
    district character varying(120),
    latitude numeric(10,7),
    longitude numeric(10,7),
    logo_path text,
    status public.umkm_status DEFAULT 'pending'::public.umkm_status NOT NULL,
    verified_by bigint,
    verified_at timestamp with time zone,
    rejection_reason text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT umkm_check CHECK (((status = 'active'::public.umkm_status) OR ((verified_by IS NOT NULL) AND (verified_at IS NOT NULL)))),
    CONSTRAINT umkm_latitude_check CHECK (((latitude >= ('-90'::integer)::numeric) AND (latitude <= (90)::numeric))),
    CONSTRAINT umkm_longitude_check CHECK (((longitude >= ('-180'::integer)::numeric) AND (longitude <= (180)::numeric)))
);


--
-- Name: umkm_announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umkm_announcements (
    id bigint NOT NULL,
    umkm_id bigint NOT NULL,
    title character varying(160) NOT NULL,
    content text NOT NULL,
    image_path text,
    moderation_status public.content_status DEFAULT 'pending'::public.content_status NOT NULL,
    moderated_by bigint,
    moderated_at timestamp with time zone,
    rejection_reason text,
    start_date date,
    end_date date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT umkm_announcements_check CHECK (((end_date IS NULL) OR (start_date IS NULL) OR (end_date > start_date))),
    CONSTRAINT umkm_announcements_check1 CHECK ((((moderation_status = 'pending'::public.content_status) AND (moderated_by IS NULL) AND (moderated_at IS NULL)) OR ((moderation_status = ANY (ARRAY['approved'::public.content_status, 'rejected'::public.content_status])) AND (moderated_by IS NOT NULL) AND (moderated_at IS NOT NULL))))
);


--
-- Name: umkm_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.umkm_announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: umkm_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.umkm_announcements_id_seq OWNED BY public.umkm_announcements.id;


--
-- Name: umkm_contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umkm_contacts (
    id bigint NOT NULL,
    umkm_id bigint NOT NULL,
    platform public.contact_platform NOT NULL,
    contact_value character varying(255) NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    verified_by bigint,
    verified_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT umkm_contacts_check CHECK ((((is_verified = false) AND (verified_by IS NULL) AND (verified_at IS NULL)) OR ((is_verified = true) AND (verified_by IS NOT NULL) AND (verified_at IS NOT NULL))))
);


--
-- Name: umkm_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.umkm_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: umkm_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.umkm_contacts_id_seq OWNED BY public.umkm_contacts.id;


--
-- Name: umkm_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.umkm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: umkm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.umkm_id_seq OWNED BY public.umkm.id;


--
-- Name: umkm_interactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umkm_interactions (
    id bigint NOT NULL,
    umkm_id bigint NOT NULL,
    product_id bigint,
    interaction_type public.interaction_type NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT umkm_interactions_check CHECK (((interaction_type <> 'view_product'::public.interaction_type) OR (product_id IS NOT NULL)))
);


--
-- Name: umkm_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.umkm_interactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: umkm_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.umkm_interactions_id_seq OWNED BY public.umkm_interactions.id;


--
-- Name: umkm_operating_hours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.umkm_operating_hours (
    id bigint NOT NULL,
    umkm_id bigint NOT NULL,
    day_of_week smallint NOT NULL,
    open_time time without time zone,
    close_time time without time zone,
    is_closed boolean DEFAULT false NOT NULL,
    CONSTRAINT umkm_operating_hours_check CHECK ((((is_closed = true) AND (open_time IS NULL) AND (close_time IS NULL)) OR ((is_closed = false) AND (open_time IS NOT NULL) AND (close_time IS NOT NULL) AND (open_time < close_time)))),
    CONSTRAINT umkm_operating_hours_day_of_week_check CHECK (((day_of_week >= 1) AND (day_of_week <= 7)))
);


--
-- Name: umkm_operating_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.umkm_operating_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: umkm_operating_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.umkm_operating_hours_id_seq OWNED BY public.umkm_operating_hours.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(120) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    role public.user_role DEFAULT 'pembeli'::public.user_role NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: admin_activity_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_activity_logs ALTER COLUMN id SET DEFAULT nextval('public.admin_activity_logs_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: data_export_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_export_logs ALTER COLUMN id SET DEFAULT nextval('public.data_export_logs_id_seq'::regclass);


--
-- Name: product_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images ALTER COLUMN id SET DEFAULT nextval('public.product_images_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: umkm id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm ALTER COLUMN id SET DEFAULT nextval('public.umkm_id_seq'::regclass);


--
-- Name: umkm_announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_announcements ALTER COLUMN id SET DEFAULT nextval('public.umkm_announcements_id_seq'::regclass);


--
-- Name: umkm_contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_contacts ALTER COLUMN id SET DEFAULT nextval('public.umkm_contacts_id_seq'::regclass);


--
-- Name: umkm_interactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_interactions ALTER COLUMN id SET DEFAULT nextval('public.umkm_interactions_id_seq'::regclass);


--
-- Name: umkm_operating_hours id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_operating_hours ALTER COLUMN id SET DEFAULT nextval('public.umkm_operating_hours_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: admin_activity_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_activity_logs (id, admin_id, action, entity_type, entity_id, description, old_values, new_values, created_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name, slug, description, created_at, updated_at) FROM stdin;
3	Camilan Pedas	camilan-pedas	Berbagai macam camilan manis produksi UMKM desa	2026-11-07 22:44:45.370157+07	2026-11-07 22:44:45.370157+07
2	Makanan Berat	makanan-berat	Berbagai macam camilan produksi UMKM desa	2026-11-07 22:02:15.408051+07	2026-11-07 22:02:15.408051+07
\.


--
-- Data for Name: data_export_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.data_export_logs (id, exported_by, export_name, data_type, file_format, file_path, filters, exported_at) FROM stdin;
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_images (id, product_id, image_path, is_primary, created_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, umkm_id, category_id, name, slug, description, price, unit, availability, moderation_status, moderated_by, moderated_at, rejection_reason, is_featured, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_settings (id, setting_key, setting_value, description, updated_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: umkm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umkm (id, user_id, name, slug, description, address, village, district, latitude, longitude, logo_path, status, verified_by, verified_at, rejection_reason, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: umkm_announcements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umkm_announcements (id, umkm_id, title, content, image_path, moderation_status, moderated_by, moderated_at, rejection_reason, start_date, end_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: umkm_contacts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umkm_contacts (id, umkm_id, platform, contact_value, is_primary, is_verified, verified_by, verified_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: umkm_interactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umkm_interactions (id, umkm_id, product_id, interaction_type, created_at) FROM stdin;
\.


--
-- Data for Name: umkm_operating_hours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.umkm_operating_hours (id, umkm_id, day_of_week, open_time, close_time, is_closed) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, password_hash, role, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Name: admin_activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_activity_logs_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 4, true);


--
-- Name: data_export_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.data_export_logs_id_seq', 1, false);


--
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_images_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 1, false);


--
-- Name: umkm_announcements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umkm_announcements_id_seq', 1, false);


--
-- Name: umkm_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umkm_contacts_id_seq', 1, false);


--
-- Name: umkm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umkm_id_seq', 1, false);


--
-- Name: umkm_interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umkm_interactions_id_seq', 1, false);


--
-- Name: umkm_operating_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.umkm_operating_hours_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: admin_activity_logs admin_activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_activity_logs
    ADD CONSTRAINT admin_activity_logs_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- Name: data_export_logs data_export_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_export_logs
    ADD CONSTRAINT data_export_logs_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_umkm_id_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_umkm_id_slug_key UNIQUE (umkm_id, slug);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: umkm_announcements umkm_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_announcements
    ADD CONSTRAINT umkm_announcements_pkey PRIMARY KEY (id);


--
-- Name: umkm_contacts umkm_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_contacts
    ADD CONSTRAINT umkm_contacts_pkey PRIMARY KEY (id);


--
-- Name: umkm_contacts umkm_contacts_umkm_id_platform_contact_value_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_contacts
    ADD CONSTRAINT umkm_contacts_umkm_id_platform_contact_value_key UNIQUE (umkm_id, platform, contact_value);


--
-- Name: umkm_interactions umkm_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_interactions
    ADD CONSTRAINT umkm_interactions_pkey PRIMARY KEY (id);


--
-- Name: umkm_operating_hours umkm_operating_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_operating_hours
    ADD CONSTRAINT umkm_operating_hours_pkey PRIMARY KEY (id);


--
-- Name: umkm_operating_hours umkm_operating_hours_umkm_id_day_of_week_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_operating_hours
    ADD CONSTRAINT umkm_operating_hours_umkm_id_day_of_week_key UNIQUE (umkm_id, day_of_week);


--
-- Name: umkm umkm_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm
    ADD CONSTRAINT umkm_pkey PRIMARY KEY (id);


--
-- Name: umkm umkm_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm
    ADD CONSTRAINT umkm_slug_key UNIQUE (slug);


--
-- Name: umkm umkm_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm
    ADD CONSTRAINT umkm_user_id_key UNIQUE (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_admin_logs_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_logs_admin ON public.admin_activity_logs USING btree (admin_id);


--
-- Name: idx_admin_logs_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_logs_created ON public.admin_activity_logs USING btree (created_at);


--
-- Name: idx_admin_logs_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_logs_entity ON public.admin_activity_logs USING btree (entity_type, entity_id);


--
-- Name: idx_announcements_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_announcements_status ON public.umkm_announcements USING btree (moderation_status);


--
-- Name: idx_announcements_umkm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_announcements_umkm ON public.umkm_announcements USING btree (umkm_id);


--
-- Name: idx_export_logs_admin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_export_logs_admin ON public.data_export_logs USING btree (exported_by);


--
-- Name: idx_export_logs_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_export_logs_date ON public.data_export_logs USING btree (exported_at);


--
-- Name: idx_interactions_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_interactions_product ON public.umkm_interactions USING btree (product_id);


--
-- Name: idx_interactions_type_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_interactions_type_date ON public.umkm_interactions USING btree (interaction_type, created_at);


--
-- Name: idx_interactions_umkm_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_interactions_umkm_date ON public.umkm_interactions USING btree (umkm_id, created_at);


--
-- Name: idx_product_images_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_product_images_product ON public.product_images USING btree (product_id);


--
-- Name: idx_products_availability; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_products_availability ON public.products USING btree (availability);


--
-- Name: idx_products_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_products_category ON public.products USING btree (category_id);


--
-- Name: idx_products_moderation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_products_moderation ON public.products USING btree (moderation_status);


--
-- Name: idx_products_umkm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_products_umkm ON public.products USING btree (umkm_id);


--
-- Name: idx_umkm_contacts_umkm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_umkm_contacts_umkm ON public.umkm_contacts USING btree (umkm_id);


--
-- Name: idx_umkm_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_umkm_status ON public.umkm USING btree (status);


--
-- Name: idx_umkm_village; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_umkm_village ON public.umkm USING btree (village);


--
-- Name: uq_product_one_primary_image; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_product_one_primary_image ON public.product_images USING btree (product_id) WHERE (is_primary = true);


--
-- Name: uq_umkm_primary_contact_per_platform; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_umkm_primary_contact_per_platform ON public.umkm_contacts USING btree (umkm_id, platform) WHERE (is_primary = true);


--
-- Name: uq_users_email_lower; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_users_email_lower ON public.users USING btree (lower((email)::text));


--
-- Name: admin_activity_logs admin_activity_logs_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_activity_logs
    ADD CONSTRAINT admin_activity_logs_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: data_export_logs data_export_logs_exported_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_export_logs
    ADD CONSTRAINT data_export_logs_exported_by_fkey FOREIGN KEY (exported_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: product_images product_images_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;


--
-- Name: products products_moderated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: products products_umkm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_umkm_id_fkey FOREIGN KEY (umkm_id) REFERENCES public.umkm(id) ON DELETE CASCADE;


--
-- Name: system_settings system_settings_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: umkm_announcements umkm_announcements_moderated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_announcements
    ADD CONSTRAINT umkm_announcements_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: umkm_announcements umkm_announcements_umkm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_announcements
    ADD CONSTRAINT umkm_announcements_umkm_id_fkey FOREIGN KEY (umkm_id) REFERENCES public.umkm(id) ON DELETE CASCADE;


--
-- Name: umkm_contacts umkm_contacts_umkm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_contacts
    ADD CONSTRAINT umkm_contacts_umkm_id_fkey FOREIGN KEY (umkm_id) REFERENCES public.umkm(id) ON DELETE CASCADE;


--
-- Name: umkm_contacts umkm_contacts_verified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_contacts
    ADD CONSTRAINT umkm_contacts_verified_by_fkey FOREIGN KEY (verified_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: umkm_interactions umkm_interactions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_interactions
    ADD CONSTRAINT umkm_interactions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: umkm_interactions umkm_interactions_umkm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_interactions
    ADD CONSTRAINT umkm_interactions_umkm_id_fkey FOREIGN KEY (umkm_id) REFERENCES public.umkm(id) ON DELETE CASCADE;


--
-- Name: umkm_operating_hours umkm_operating_hours_umkm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm_operating_hours
    ADD CONSTRAINT umkm_operating_hours_umkm_id_fkey FOREIGN KEY (umkm_id) REFERENCES public.umkm(id) ON DELETE CASCADE;


--
-- Name: umkm umkm_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm
    ADD CONSTRAINT umkm_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: umkm umkm_verified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.umkm
    ADD CONSTRAINT umkm_verified_by_fkey FOREIGN KEY (verified_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict F3Jkk6L3eH5v6ZcyHXFUgzIC5BohPeZ45gA2R9IuhJaS8VSyrDh5fcsbEw9def0

