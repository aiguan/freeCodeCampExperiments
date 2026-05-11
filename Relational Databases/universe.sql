--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    galaxy_class_id integer,
    size_in_kpc numeric(18,3),
    distance_from_earth_in_kpc integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_class; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_class (
    galaxy_class_id integer NOT NULL,
    name character varying(3) NOT NULL,
    description text
);


ALTER TABLE public.galaxy_class OWNER TO freecodecamp;

--
-- Name: galaxy_classes_class_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_classes_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_classes_class_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_classes_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_classes_class_id_seq OWNED BY public.galaxy_class.galaxy_class_id;


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planet_id integer,
    discoverer character varying(60),
    have_landed boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    star_id integer,
    distance_from_earth_in_million_km numeric,
    have_landed boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    galaxy_id integer,
    solar_mass_nearest_int integer,
    distance_from_earth_in_au numeric
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_class galaxy_class_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_class ALTER COLUMN galaxy_class_id SET DEFAULT nextval('public.galaxy_classes_class_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 4, 26.800, NULL);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 3, 46.560, 765);
INSERT INTO public.galaxy VALUES (3, 'Large Magellanic Cloud', 5, 9.860, 50);
INSERT INTO public.galaxy VALUES (4, 'Small Magellanic Cloud', 5, 5.780, 60);
INSERT INTO public.galaxy VALUES (5, 'Centaurus A', 1, 37.740, 3400);
INSERT INTO public.galaxy VALUES (6, 'Whirlpool', 3, 23.580, 9500);


--
-- Data for Name: galaxy_class; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_class VALUES (1, 'S0', 'Lenticular: visible disk as well as bulge, lacking spiral arms');
INSERT INTO public.galaxy_class VALUES (2, 'E', 'Elliptical: smooth, featureless light distributions');
INSERT INTO public.galaxy_class VALUES (3, 'S', 'Spiral: flattened disk with stars forming a spiral structure');
INSERT INTO public.galaxy_class VALUES (4, 'SB', 'Barred spiral: spiral with bar extending from centre and arms starting at end of bar');
INSERT INTO public.galaxy_class VALUES (5, 'Irr', 'Irregular: neither disk-like or ellipoidal');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 3, NULL, true);
INSERT INTO public.moon VALUES (2, 'Phobos', 4, 'Asaph Hall', false);
INSERT INTO public.moon VALUES (3, 'Deimos', 4, 'Asaph Hall', false);
INSERT INTO public.moon VALUES (4, 'Ganymede', 5, 'Galileo Galilei and Simon Marius', false);
INSERT INTO public.moon VALUES (5, 'Callisto', 5, 'Galileo Galilei and Simon Marius', false);
INSERT INTO public.moon VALUES (6, 'Io', 5, 'Galileo Galilei', false);
INSERT INTO public.moon VALUES (7, 'Europa', 5, 'Galileo Galilei and Simon Marius', false);
INSERT INTO public.moon VALUES (8, 'Titan', 6, 'Christiaan Huygens', true);
INSERT INTO public.moon VALUES (9, 'Enceladus', 6, 'William Herschel', false);
INSERT INTO public.moon VALUES (10, 'Hyperion', 6, 'William Bond, George Bond and William Lassell', false);
INSERT INTO public.moon VALUES (11, 'Prometheus', 6, 'Voyager 1', false);
INSERT INTO public.moon VALUES (12, 'Pandora', 6, 'Voyager 1', false);
INSERT INTO public.moon VALUES (13, 'Janus', 6, 'Audouin Dollfus', false);
INSERT INTO public.moon VALUES (14, 'Miranda', 7, 'Gerard P. Kuiper', false);
INSERT INTO public.moon VALUES (15, 'Ariel', 7, 'William Lassell', false);
INSERT INTO public.moon VALUES (16, 'Umbriel', 7, 'William Lassell', false);
INSERT INTO public.moon VALUES (17, 'Titania', 7, 'William Herschel', false);
INSERT INTO public.moon VALUES (18, 'Oberon', 7, 'William Herschel', false);
INSERT INTO public.moon VALUES (19, 'Triton', 8, 'William Lassell', false);
INSERT INTO public.moon VALUES (20, 'Charon', 9, 'James Christy and Robert Harrington', false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 1, 91.7, true);
INSERT INTO public.planet VALUES (2, 'Venus', 1, 41.1, true);
INSERT INTO public.planet VALUES (3, 'Earth', 1, 0, true);
INSERT INTO public.planet VALUES (4, 'Mars', 1, 78.3, true);
INSERT INTO public.planet VALUES (5, 'Jupiter', 1, 628.7, false);
INSERT INTO public.planet VALUES (6, 'Saturn', 1, 1275, false);
INSERT INTO public.planet VALUES (7, 'Uranus', 1, 2724, false);
INSERT INTO public.planet VALUES (8, 'Neptune', 1, 4351, false);
INSERT INTO public.planet VALUES (9, 'Pluto', 1, 5050, false);
INSERT INTO public.planet VALUES (10, 'Proxima Centauri b', 7, 40000000, false);
INSERT INTO public.planet VALUES (11, 'Proxima Centauri c', 7, 40000000, false);
INSERT INTO public.planet VALUES (12, 'Proxima Centauri d', 7, 40000000, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 1, 1);
INSERT INTO public.star VALUES (2, 'UY Scuti', 1, 8, 600000000);
INSERT INTO public.star VALUES (3, 'Sirius', 1, 2, 544000);
INSERT INTO public.star VALUES (4, 'Canopus', 1, 9, 19000000);
INSERT INTO public.star VALUES (5, 'Centauri A', 1, 1, 268770);
INSERT INTO public.star VALUES (6, 'Betelgeuse', 1, 15, 22000000);
INSERT INTO public.star VALUES (7, 'Proxima Centauri', 1, 0, 268770);


--
-- Name: galaxy_classes_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_classes_class_id_seq', 5, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: galaxy_class galaxy_classes_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_class
    ADD CONSTRAINT galaxy_classes_name_key UNIQUE (name);


--
-- Name: galaxy_class galaxy_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_class
    ADD CONSTRAINT galaxy_classes_pkey PRIMARY KEY (galaxy_class_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy galaxy_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_class_id_fkey FOREIGN KEY (galaxy_class_id) REFERENCES public.galaxy_class(galaxy_class_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

