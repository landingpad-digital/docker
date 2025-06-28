--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

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
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


--
-- Name: accounts_after_insert_row_tr(); Type: FUNCTION; Schema: public; Owner: chatwoot_user
--

CREATE FUNCTION public.accounts_after_insert_row_tr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    execute format('create sequence IF NOT EXISTS conv_dpid_seq_%s', NEW.id);
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.accounts_after_insert_row_tr() OWNER TO chatwoot_user;

--
-- Name: camp_dpid_before_insert(); Type: FUNCTION; Schema: public; Owner: chatwoot_user
--

CREATE FUNCTION public.camp_dpid_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    execute format('create sequence IF NOT EXISTS camp_dpid_seq_%s', NEW.id);
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.camp_dpid_before_insert() OWNER TO chatwoot_user;

--
-- Name: campaigns_before_insert_row_tr(); Type: FUNCTION; Schema: public; Owner: chatwoot_user
--

CREATE FUNCTION public.campaigns_before_insert_row_tr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.display_id := nextval('camp_dpid_seq_' || NEW.account_id);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.campaigns_before_insert_row_tr() OWNER TO chatwoot_user;

--
-- Name: conversations_before_insert_row_tr(); Type: FUNCTION; Schema: public; Owner: chatwoot_user
--

CREATE FUNCTION public.conversations_before_insert_row_tr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.display_id := nextval('conv_dpid_seq_' || NEW.account_id);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.conversations_before_insert_row_tr() OWNER TO chatwoot_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.access_tokens (
    id bigint NOT NULL,
    owner_type character varying,
    owner_id bigint,
    token character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.access_tokens OWNER TO chatwoot_user;

--
-- Name: access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.access_tokens_id_seq OWNER TO chatwoot_user;

--
-- Name: access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.access_tokens_id_seq OWNED BY public.access_tokens.id;


--
-- Name: account_users; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.account_users (
    id bigint NOT NULL,
    account_id bigint,
    user_id bigint,
    role integer DEFAULT 0,
    inviter_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    active_at timestamp without time zone,
    availability integer DEFAULT 0 NOT NULL,
    auto_offline boolean DEFAULT true NOT NULL,
    custom_role_id bigint
);


ALTER TABLE public.account_users OWNER TO chatwoot_user;

--
-- Name: account_users_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.account_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_users_id_seq OWNER TO chatwoot_user;

--
-- Name: account_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.account_users_id_seq OWNED BY public.account_users.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    locale integer DEFAULT 0,
    domain character varying(100),
    support_email character varying(100),
    feature_flags bigint DEFAULT 0 NOT NULL,
    auto_resolve_duration integer,
    limits jsonb DEFAULT '{}'::jsonb,
    custom_attributes jsonb DEFAULT '{}'::jsonb,
    status integer DEFAULT 0,
    internal_attributes jsonb DEFAULT '{}'::jsonb NOT NULL,
    settings jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.accounts OWNER TO chatwoot_user;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO chatwoot_user;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: action_mailbox_inbound_emails; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.action_mailbox_inbound_emails (
    id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    message_id character varying NOT NULL,
    message_checksum character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.action_mailbox_inbound_emails OWNER TO chatwoot_user;

--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.action_mailbox_inbound_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.action_mailbox_inbound_emails_id_seq OWNER TO chatwoot_user;

--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.action_mailbox_inbound_emails_id_seq OWNED BY public.action_mailbox_inbound_emails.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO chatwoot_user;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO chatwoot_user;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp without time zone NOT NULL,
    service_name character varying NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO chatwoot_user;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO chatwoot_user;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO chatwoot_user;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO chatwoot_user;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: agent_bot_inboxes; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.agent_bot_inboxes (
    id bigint NOT NULL,
    inbox_id integer,
    agent_bot_id integer,
    status integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id integer
);


ALTER TABLE public.agent_bot_inboxes OWNER TO chatwoot_user;

--
-- Name: agent_bot_inboxes_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.agent_bot_inboxes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agent_bot_inboxes_id_seq OWNER TO chatwoot_user;

--
-- Name: agent_bot_inboxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.agent_bot_inboxes_id_seq OWNED BY public.agent_bot_inboxes.id;


--
-- Name: agent_bots; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.agent_bots (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    outgoing_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_id bigint,
    bot_type integer DEFAULT 0,
    bot_config jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.agent_bots OWNER TO chatwoot_user;

--
-- Name: agent_bots_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.agent_bots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agent_bots_id_seq OWNER TO chatwoot_user;

--
-- Name: agent_bots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.agent_bots_id_seq OWNED BY public.agent_bots.id;


--
-- Name: applied_slas; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.applied_slas (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    sla_policy_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sla_status integer DEFAULT 0
);


ALTER TABLE public.applied_slas OWNER TO chatwoot_user;

--
-- Name: applied_slas_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.applied_slas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.applied_slas_id_seq OWNER TO chatwoot_user;

--
-- Name: applied_slas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.applied_slas_id_seq OWNED BY public.applied_slas.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO chatwoot_user;

--
-- Name: article_embeddings; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.article_embeddings (
    id bigint NOT NULL,
    article_id bigint NOT NULL,
    term text NOT NULL,
    embedding public.vector(1536),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.article_embeddings OWNER TO chatwoot_user;

--
-- Name: article_embeddings_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.article_embeddings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.article_embeddings_id_seq OWNER TO chatwoot_user;

--
-- Name: article_embeddings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.article_embeddings_id_seq OWNED BY public.article_embeddings.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.articles (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    portal_id integer NOT NULL,
    category_id integer,
    folder_id integer,
    title character varying,
    description text,
    content text,
    status integer,
    views integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    author_id bigint,
    associated_article_id bigint,
    meta jsonb DEFAULT '{}'::jsonb,
    slug character varying NOT NULL,
    "position" integer,
    locale character varying DEFAULT 'en'::character varying NOT NULL
);


ALTER TABLE public.articles OWNER TO chatwoot_user;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.articles_id_seq OWNER TO chatwoot_user;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.attachments (
    id integer NOT NULL,
    file_type integer DEFAULT 0,
    external_url character varying,
    coordinates_lat double precision DEFAULT 0.0,
    coordinates_long double precision DEFAULT 0.0,
    message_id integer NOT NULL,
    account_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fallback_title character varying,
    extension character varying,
    meta jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.attachments OWNER TO chatwoot_user;

--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attachments_id_seq OWNER TO chatwoot_user;

--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.attachments_id_seq OWNED BY public.attachments.id;


--
-- Name: audits; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.audits (
    id bigint NOT NULL,
    auditable_id bigint,
    auditable_type character varying,
    associated_id bigint,
    associated_type character varying,
    user_id bigint,
    user_type character varying,
    username character varying,
    action character varying,
    audited_changes jsonb,
    version integer DEFAULT 0,
    comment character varying,
    remote_address character varying,
    request_uuid character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.audits OWNER TO chatwoot_user;

--
-- Name: audits_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audits_id_seq OWNER TO chatwoot_user;

--
-- Name: audits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.audits_id_seq OWNED BY public.audits.id;


--
-- Name: automation_rules; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.automation_rules (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    event_name character varying NOT NULL,
    conditions jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    actions jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.automation_rules OWNER TO chatwoot_user;

--
-- Name: automation_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.automation_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.automation_rules_id_seq OWNER TO chatwoot_user;

--
-- Name: automation_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.automation_rules_id_seq OWNED BY public.automation_rules.id;


--
-- Name: camp_dpid_seq_1; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.camp_dpid_seq_1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.camp_dpid_seq_1 OWNER TO chatwoot_user;

--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.campaigns (
    id bigint NOT NULL,
    display_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    message text NOT NULL,
    sender_id integer,
    enabled boolean DEFAULT true,
    account_id bigint NOT NULL,
    inbox_id bigint NOT NULL,
    trigger_rules jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    campaign_type integer DEFAULT 0 NOT NULL,
    campaign_status integer DEFAULT 0 NOT NULL,
    audience jsonb DEFAULT '[]'::jsonb,
    scheduled_at timestamp without time zone,
    trigger_only_during_business_hours boolean DEFAULT false
);


ALTER TABLE public.campaigns OWNER TO chatwoot_user;

--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.campaigns_id_seq OWNER TO chatwoot_user;

--
-- Name: campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.campaigns_id_seq OWNED BY public.campaigns.id;


--
-- Name: canned_responses; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.canned_responses (
    id integer NOT NULL,
    account_id integer NOT NULL,
    short_code character varying,
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.canned_responses OWNER TO chatwoot_user;

--
-- Name: canned_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.canned_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.canned_responses_id_seq OWNER TO chatwoot_user;

--
-- Name: canned_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.canned_responses_id_seq OWNED BY public.canned_responses.id;


--
-- Name: captain_assistant_responses; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.captain_assistant_responses (
    id bigint NOT NULL,
    question character varying NOT NULL,
    answer text NOT NULL,
    embedding public.vector(1536),
    assistant_id bigint NOT NULL,
    documentable_id bigint,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    documentable_type character varying
);


ALTER TABLE public.captain_assistant_responses OWNER TO chatwoot_user;

--
-- Name: captain_assistant_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.captain_assistant_responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.captain_assistant_responses_id_seq OWNER TO chatwoot_user;

--
-- Name: captain_assistant_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.captain_assistant_responses_id_seq OWNED BY public.captain_assistant_responses.id;


--
-- Name: captain_assistants; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.captain_assistants (
    id bigint NOT NULL,
    name character varying NOT NULL,
    account_id bigint NOT NULL,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    config jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.captain_assistants OWNER TO chatwoot_user;

--
-- Name: captain_assistants_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.captain_assistants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.captain_assistants_id_seq OWNER TO chatwoot_user;

--
-- Name: captain_assistants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.captain_assistants_id_seq OWNED BY public.captain_assistants.id;


--
-- Name: captain_documents; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.captain_documents (
    id bigint NOT NULL,
    name character varying,
    external_link character varying NOT NULL,
    content text,
    assistant_id bigint NOT NULL,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.captain_documents OWNER TO chatwoot_user;

--
-- Name: captain_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.captain_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.captain_documents_id_seq OWNER TO chatwoot_user;

--
-- Name: captain_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.captain_documents_id_seq OWNED BY public.captain_documents.id;


--
-- Name: captain_inboxes; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.captain_inboxes (
    id bigint NOT NULL,
    captain_assistant_id bigint NOT NULL,
    inbox_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.captain_inboxes OWNER TO chatwoot_user;

--
-- Name: captain_inboxes_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.captain_inboxes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.captain_inboxes_id_seq OWNER TO chatwoot_user;

--
-- Name: captain_inboxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.captain_inboxes_id_seq OWNED BY public.captain_inboxes.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    portal_id integer NOT NULL,
    name character varying,
    description text,
    "position" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    locale character varying DEFAULT 'en'::character varying,
    slug character varying NOT NULL,
    parent_category_id bigint,
    associated_category_id bigint,
    icon character varying DEFAULT ''::character varying
);


ALTER TABLE public.categories OWNER TO chatwoot_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO chatwoot_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: channel_api; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_api (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    webhook_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    identifier character varying,
    hmac_token character varying,
    hmac_mandatory boolean DEFAULT false,
    additional_attributes jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.channel_api OWNER TO chatwoot_user;

--
-- Name: channel_api_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_api_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_api_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_api_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_api_id_seq OWNED BY public.channel_api.id;


--
-- Name: channel_email; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_email (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    email character varying NOT NULL,
    forward_to_email character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    imap_enabled boolean DEFAULT false,
    imap_address character varying DEFAULT ''::character varying,
    imap_port integer DEFAULT 0,
    imap_login character varying DEFAULT ''::character varying,
    imap_password character varying DEFAULT ''::character varying,
    imap_enable_ssl boolean DEFAULT true,
    smtp_enabled boolean DEFAULT false,
    smtp_address character varying DEFAULT ''::character varying,
    smtp_port integer DEFAULT 0,
    smtp_login character varying DEFAULT ''::character varying,
    smtp_password character varying DEFAULT ''::character varying,
    smtp_domain character varying DEFAULT ''::character varying,
    smtp_enable_starttls_auto boolean DEFAULT true,
    smtp_authentication character varying DEFAULT 'login'::character varying,
    smtp_openssl_verify_mode character varying DEFAULT 'none'::character varying,
    smtp_enable_ssl_tls boolean DEFAULT false,
    provider_config jsonb DEFAULT '{}'::jsonb,
    provider character varying
);


ALTER TABLE public.channel_email OWNER TO chatwoot_user;

--
-- Name: channel_email_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_email_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_email_id_seq OWNED BY public.channel_email.id;


--
-- Name: channel_facebook_pages; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_facebook_pages (
    id integer NOT NULL,
    page_id character varying NOT NULL,
    user_access_token character varying NOT NULL,
    page_access_token character varying NOT NULL,
    account_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    instagram_id character varying
);


ALTER TABLE public.channel_facebook_pages OWNER TO chatwoot_user;

--
-- Name: channel_facebook_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_facebook_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_facebook_pages_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_facebook_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_facebook_pages_id_seq OWNED BY public.channel_facebook_pages.id;


--
-- Name: channel_instagram; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_instagram (
    id bigint NOT NULL,
    access_token character varying NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    account_id integer NOT NULL,
    instagram_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.channel_instagram OWNER TO chatwoot_user;

--
-- Name: channel_instagram_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_instagram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_instagram_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_instagram_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_instagram_id_seq OWNED BY public.channel_instagram.id;


--
-- Name: channel_line; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_line (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    line_channel_id character varying NOT NULL,
    line_channel_secret character varying NOT NULL,
    line_channel_token character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.channel_line OWNER TO chatwoot_user;

--
-- Name: channel_line_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_line_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_line_id_seq OWNED BY public.channel_line.id;


--
-- Name: channel_sms; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_sms (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    phone_number character varying NOT NULL,
    provider character varying DEFAULT 'default'::character varying,
    provider_config jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.channel_sms OWNER TO chatwoot_user;

--
-- Name: channel_sms_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_sms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_sms_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_sms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_sms_id_seq OWNED BY public.channel_sms.id;


--
-- Name: channel_telegram; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_telegram (
    id bigint NOT NULL,
    bot_name character varying,
    account_id integer NOT NULL,
    bot_token character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.channel_telegram OWNER TO chatwoot_user;

--
-- Name: channel_telegram_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_telegram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_telegram_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_telegram_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_telegram_id_seq OWNED BY public.channel_telegram.id;


--
-- Name: channel_twilio_sms; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_twilio_sms (
    id bigint NOT NULL,
    phone_number character varying,
    auth_token character varying NOT NULL,
    account_sid character varying NOT NULL,
    account_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    medium integer DEFAULT 0,
    messaging_service_sid character varying,
    api_key_sid character varying
);


ALTER TABLE public.channel_twilio_sms OWNER TO chatwoot_user;

--
-- Name: channel_twilio_sms_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_twilio_sms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_twilio_sms_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_twilio_sms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_twilio_sms_id_seq OWNED BY public.channel_twilio_sms.id;


--
-- Name: channel_twitter_profiles; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_twitter_profiles (
    id bigint NOT NULL,
    profile_id character varying NOT NULL,
    twitter_access_token character varying NOT NULL,
    twitter_access_token_secret character varying NOT NULL,
    account_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    tweets_enabled boolean DEFAULT true
);


ALTER TABLE public.channel_twitter_profiles OWNER TO chatwoot_user;

--
-- Name: channel_twitter_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_twitter_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_twitter_profiles_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_twitter_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_twitter_profiles_id_seq OWNED BY public.channel_twitter_profiles.id;


--
-- Name: channel_web_widgets; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_web_widgets (
    id integer NOT NULL,
    website_url character varying,
    account_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    website_token character varying,
    widget_color character varying DEFAULT '#1f93ff'::character varying,
    welcome_title character varying,
    welcome_tagline character varying,
    feature_flags integer DEFAULT 7 NOT NULL,
    reply_time integer DEFAULT 0,
    hmac_token character varying,
    pre_chat_form_enabled boolean DEFAULT false,
    pre_chat_form_options jsonb DEFAULT '{}'::jsonb,
    hmac_mandatory boolean DEFAULT false,
    continuity_via_email boolean DEFAULT true NOT NULL
);


ALTER TABLE public.channel_web_widgets OWNER TO chatwoot_user;

--
-- Name: channel_web_widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_web_widgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_web_widgets_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_web_widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_web_widgets_id_seq OWNED BY public.channel_web_widgets.id;


--
-- Name: channel_whatsapp; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.channel_whatsapp (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    phone_number character varying NOT NULL,
    provider character varying DEFAULT 'default'::character varying,
    provider_config jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    message_templates jsonb DEFAULT '{}'::jsonb,
    message_templates_last_updated timestamp without time zone
);


ALTER TABLE public.channel_whatsapp OWNER TO chatwoot_user;

--
-- Name: channel_whatsapp_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.channel_whatsapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_whatsapp_id_seq OWNER TO chatwoot_user;

--
-- Name: channel_whatsapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.channel_whatsapp_id_seq OWNED BY public.channel_whatsapp.id;


--
-- Name: contact_inboxes; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.contact_inboxes (
    id bigint NOT NULL,
    contact_id bigint,
    inbox_id bigint,
    source_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    hmac_verified boolean DEFAULT false,
    pubsub_token character varying
);


ALTER TABLE public.contact_inboxes OWNER TO chatwoot_user;

--
-- Name: contact_inboxes_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.contact_inboxes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_inboxes_id_seq OWNER TO chatwoot_user;

--
-- Name: contact_inboxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.contact_inboxes_id_seq OWNED BY public.contact_inboxes.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying,
    email character varying,
    phone_number character varying,
    account_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    additional_attributes jsonb DEFAULT '{}'::jsonb,
    identifier character varying,
    custom_attributes jsonb DEFAULT '{}'::jsonb,
    last_activity_at timestamp without time zone,
    contact_type integer DEFAULT 0,
    middle_name character varying DEFAULT ''::character varying,
    last_name character varying DEFAULT ''::character varying,
    location character varying DEFAULT ''::character varying,
    country_code character varying DEFAULT ''::character varying,
    blocked boolean DEFAULT false NOT NULL
);


ALTER TABLE public.contacts OWNER TO chatwoot_user;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO chatwoot_user;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: conv_dpid_seq_1; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.conv_dpid_seq_1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conv_dpid_seq_1 OWNER TO chatwoot_user;

--
-- Name: conversation_participants; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.conversation_participants (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.conversation_participants OWNER TO chatwoot_user;

--
-- Name: conversation_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.conversation_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversation_participants_id_seq OWNER TO chatwoot_user;

--
-- Name: conversation_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.conversation_participants_id_seq OWNED BY public.conversation_participants.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.conversations (
    id integer NOT NULL,
    account_id integer NOT NULL,
    inbox_id integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    assignee_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contact_id bigint,
    display_id integer NOT NULL,
    contact_last_seen_at timestamp without time zone,
    agent_last_seen_at timestamp without time zone,
    additional_attributes jsonb DEFAULT '{}'::jsonb,
    contact_inbox_id bigint,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    identifier character varying,
    last_activity_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    team_id bigint,
    campaign_id bigint,
    snoozed_until timestamp without time zone,
    custom_attributes jsonb DEFAULT '{}'::jsonb,
    assignee_last_seen_at timestamp without time zone,
    first_reply_created_at timestamp without time zone,
    priority integer,
    sla_policy_id bigint,
    waiting_since timestamp(6) without time zone,
    cached_label_list text
);


ALTER TABLE public.conversations OWNER TO chatwoot_user;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_seq OWNER TO chatwoot_user;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: copilot_messages; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.copilot_messages (
    id bigint NOT NULL,
    copilot_thread_id bigint NOT NULL,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    message_type character varying NOT NULL,
    message jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.copilot_messages OWNER TO chatwoot_user;

--
-- Name: copilot_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.copilot_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.copilot_messages_id_seq OWNER TO chatwoot_user;

--
-- Name: copilot_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.copilot_messages_id_seq OWNED BY public.copilot_messages.id;


--
-- Name: copilot_threads; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.copilot_threads (
    id bigint NOT NULL,
    title character varying NOT NULL,
    user_id bigint NOT NULL,
    account_id bigint NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.copilot_threads OWNER TO chatwoot_user;

--
-- Name: copilot_threads_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.copilot_threads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.copilot_threads_id_seq OWNER TO chatwoot_user;

--
-- Name: copilot_threads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.copilot_threads_id_seq OWNED BY public.copilot_threads.id;


--
-- Name: csat_survey_responses; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.csat_survey_responses (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    message_id bigint NOT NULL,
    rating integer NOT NULL,
    feedback_message text,
    contact_id bigint NOT NULL,
    assigned_agent_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.csat_survey_responses OWNER TO chatwoot_user;

--
-- Name: csat_survey_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.csat_survey_responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.csat_survey_responses_id_seq OWNER TO chatwoot_user;

--
-- Name: csat_survey_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.csat_survey_responses_id_seq OWNED BY public.csat_survey_responses.id;


--
-- Name: custom_attribute_definitions; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.custom_attribute_definitions (
    id bigint NOT NULL,
    attribute_display_name character varying,
    attribute_key character varying,
    attribute_display_type integer DEFAULT 0,
    default_value integer,
    attribute_model integer DEFAULT 0,
    account_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    attribute_description text,
    attribute_values jsonb DEFAULT '[]'::jsonb,
    regex_pattern character varying,
    regex_cue character varying
);


ALTER TABLE public.custom_attribute_definitions OWNER TO chatwoot_user;

--
-- Name: custom_attribute_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.custom_attribute_definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_attribute_definitions_id_seq OWNER TO chatwoot_user;

--
-- Name: custom_attribute_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.custom_attribute_definitions_id_seq OWNED BY public.custom_attribute_definitions.id;


--
-- Name: custom_filters; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.custom_filters (
    id bigint NOT NULL,
    name character varying NOT NULL,
    filter_type integer DEFAULT 0 NOT NULL,
    query jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.custom_filters OWNER TO chatwoot_user;

--
-- Name: custom_filters_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.custom_filters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_filters_id_seq OWNER TO chatwoot_user;

--
-- Name: custom_filters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.custom_filters_id_seq OWNED BY public.custom_filters.id;


--
-- Name: custom_roles; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.custom_roles (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    account_id bigint NOT NULL,
    permissions text[] DEFAULT '{}'::text[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.custom_roles OWNER TO chatwoot_user;

--
-- Name: custom_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.custom_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_roles_id_seq OWNER TO chatwoot_user;

--
-- Name: custom_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.custom_roles_id_seq OWNED BY public.custom_roles.id;


--
-- Name: dashboard_apps; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.dashboard_apps (
    id bigint NOT NULL,
    title character varying NOT NULL,
    content jsonb DEFAULT '[]'::jsonb,
    account_id bigint NOT NULL,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.dashboard_apps OWNER TO chatwoot_user;

--
-- Name: dashboard_apps_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.dashboard_apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dashboard_apps_id_seq OWNER TO chatwoot_user;

--
-- Name: dashboard_apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.dashboard_apps_id_seq OWNED BY public.dashboard_apps.id;


--
-- Name: data_imports; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.data_imports (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    data_type character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    processing_errors text,
    total_records integer,
    processed_records integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.data_imports OWNER TO chatwoot_user;

--
-- Name: data_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.data_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_imports_id_seq OWNER TO chatwoot_user;

--
-- Name: data_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.data_imports_id_seq OWNED BY public.data_imports.id;


--
-- Name: email_templates; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.email_templates (
    id bigint NOT NULL,
    name character varying NOT NULL,
    body text NOT NULL,
    account_id integer,
    template_type integer DEFAULT 1,
    locale integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.email_templates OWNER TO chatwoot_user;

--
-- Name: email_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.email_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_templates_id_seq OWNER TO chatwoot_user;

--
-- Name: email_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.email_templates_id_seq OWNED BY public.email_templates.id;


--
-- Name: folders; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.folders (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.folders OWNER TO chatwoot_user;

--
-- Name: folders_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.folders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.folders_id_seq OWNER TO chatwoot_user;

--
-- Name: folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.folders_id_seq OWNED BY public.folders.id;


--
-- Name: inbox_members; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.inbox_members (
    id integer NOT NULL,
    user_id integer NOT NULL,
    inbox_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.inbox_members OWNER TO chatwoot_user;

--
-- Name: inbox_members_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.inbox_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inbox_members_id_seq OWNER TO chatwoot_user;

--
-- Name: inbox_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.inbox_members_id_seq OWNED BY public.inbox_members.id;


--
-- Name: inboxes; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.inboxes (
    id integer NOT NULL,
    channel_id integer NOT NULL,
    account_id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    channel_type character varying,
    enable_auto_assignment boolean DEFAULT true,
    greeting_enabled boolean DEFAULT false,
    greeting_message character varying,
    email_address character varying,
    working_hours_enabled boolean DEFAULT false,
    out_of_office_message character varying,
    timezone character varying DEFAULT 'UTC'::character varying,
    enable_email_collect boolean DEFAULT true,
    csat_survey_enabled boolean DEFAULT false,
    allow_messages_after_resolved boolean DEFAULT true,
    auto_assignment_config jsonb DEFAULT '{}'::jsonb,
    lock_to_single_conversation boolean DEFAULT false NOT NULL,
    portal_id bigint,
    sender_name_type integer DEFAULT 0 NOT NULL,
    business_name character varying,
    csat_config jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.inboxes OWNER TO chatwoot_user;

--
-- Name: inboxes_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.inboxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inboxes_id_seq OWNER TO chatwoot_user;

--
-- Name: inboxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.inboxes_id_seq OWNED BY public.inboxes.id;


--
-- Name: installation_configs; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.installation_configs (
    id bigint NOT NULL,
    name character varying NOT NULL,
    serialized_value jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    locked boolean DEFAULT true NOT NULL
);


ALTER TABLE public.installation_configs OWNER TO chatwoot_user;

--
-- Name: installation_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.installation_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.installation_configs_id_seq OWNER TO chatwoot_user;

--
-- Name: installation_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.installation_configs_id_seq OWNED BY public.installation_configs.id;


--
-- Name: integrations_hooks; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.integrations_hooks (
    id bigint NOT NULL,
    status integer DEFAULT 1,
    inbox_id integer,
    account_id integer,
    app_id character varying,
    hook_type integer DEFAULT 0,
    reference_id character varying,
    access_token character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    settings jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.integrations_hooks OWNER TO chatwoot_user;

--
-- Name: integrations_hooks_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.integrations_hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.integrations_hooks_id_seq OWNER TO chatwoot_user;

--
-- Name: integrations_hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.integrations_hooks_id_seq OWNED BY public.integrations_hooks.id;


--
-- Name: labels; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.labels (
    id bigint NOT NULL,
    title character varying,
    description text,
    color character varying DEFAULT '#1f93ff'::character varying NOT NULL,
    show_on_sidebar boolean,
    account_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.labels OWNER TO chatwoot_user;

--
-- Name: labels_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.labels_id_seq OWNER TO chatwoot_user;

--
-- Name: labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.labels_id_seq OWNED BY public.labels.id;


--
-- Name: macros; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.macros (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    name character varying NOT NULL,
    visibility integer DEFAULT 0,
    created_by_id bigint,
    updated_by_id bigint,
    actions jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.macros OWNER TO chatwoot_user;

--
-- Name: macros_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.macros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.macros_id_seq OWNER TO chatwoot_user;

--
-- Name: macros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.macros_id_seq OWNED BY public.macros.id;


--
-- Name: mentions; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.mentions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    account_id bigint NOT NULL,
    mentioned_at timestamp without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.mentions OWNER TO chatwoot_user;

--
-- Name: mentions_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.mentions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mentions_id_seq OWNER TO chatwoot_user;

--
-- Name: mentions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.mentions_id_seq OWNED BY public.mentions.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    content text,
    account_id integer NOT NULL,
    inbox_id integer NOT NULL,
    conversation_id integer NOT NULL,
    message_type integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    private boolean DEFAULT false NOT NULL,
    status integer DEFAULT 0,
    source_id character varying,
    content_type integer DEFAULT 0 NOT NULL,
    content_attributes json DEFAULT '{}'::json,
    sender_type character varying,
    sender_id bigint,
    external_source_ids jsonb DEFAULT '{}'::jsonb,
    additional_attributes jsonb DEFAULT '{}'::jsonb,
    processed_message_content text,
    sentiment jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.messages OWNER TO chatwoot_user;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO chatwoot_user;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    content text NOT NULL,
    account_id bigint NOT NULL,
    contact_id bigint NOT NULL,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notes OWNER TO chatwoot_user;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_id_seq OWNER TO chatwoot_user;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: notification_settings; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.notification_settings (
    id bigint NOT NULL,
    account_id integer,
    user_id integer,
    email_flags integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    push_flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.notification_settings OWNER TO chatwoot_user;

--
-- Name: notification_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.notification_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_settings_id_seq OWNER TO chatwoot_user;

--
-- Name: notification_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.notification_settings_id_seq OWNED BY public.notification_settings.id;


--
-- Name: notification_subscriptions; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.notification_subscriptions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    subscription_type integer NOT NULL,
    subscription_attributes jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    identifier text
);


ALTER TABLE public.notification_subscriptions OWNER TO chatwoot_user;

--
-- Name: notification_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.notification_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_subscriptions_id_seq OWNER TO chatwoot_user;

--
-- Name: notification_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.notification_subscriptions_id_seq OWNED BY public.notification_subscriptions.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    user_id bigint NOT NULL,
    notification_type integer NOT NULL,
    primary_actor_type character varying NOT NULL,
    primary_actor_id bigint NOT NULL,
    secondary_actor_type character varying,
    secondary_actor_id bigint,
    read_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    snoozed_until timestamp(6) without time zone,
    last_activity_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    meta jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.notifications OWNER TO chatwoot_user;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO chatwoot_user;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: platform_app_permissibles; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.platform_app_permissibles (
    id bigint NOT NULL,
    platform_app_id bigint NOT NULL,
    permissible_type character varying NOT NULL,
    permissible_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.platform_app_permissibles OWNER TO chatwoot_user;

--
-- Name: platform_app_permissibles_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.platform_app_permissibles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platform_app_permissibles_id_seq OWNER TO chatwoot_user;

--
-- Name: platform_app_permissibles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.platform_app_permissibles_id_seq OWNED BY public.platform_app_permissibles.id;


--
-- Name: platform_apps; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.platform_apps (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.platform_apps OWNER TO chatwoot_user;

--
-- Name: platform_apps_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.platform_apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platform_apps_id_seq OWNER TO chatwoot_user;

--
-- Name: platform_apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.platform_apps_id_seq OWNED BY public.platform_apps.id;


--
-- Name: portals; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.portals (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    custom_domain character varying,
    color character varying,
    homepage_link character varying,
    page_title character varying,
    header_text text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    config jsonb DEFAULT '{"allowed_locales": ["en"]}'::jsonb,
    archived boolean DEFAULT false,
    channel_web_widget_id bigint
);


ALTER TABLE public.portals OWNER TO chatwoot_user;

--
-- Name: portals_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.portals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portals_id_seq OWNER TO chatwoot_user;

--
-- Name: portals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.portals_id_seq OWNED BY public.portals.id;


--
-- Name: portals_members; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.portals_members (
    portal_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.portals_members OWNER TO chatwoot_user;

--
-- Name: related_categories; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.related_categories (
    id bigint NOT NULL,
    category_id bigint,
    related_category_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.related_categories OWNER TO chatwoot_user;

--
-- Name: related_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.related_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.related_categories_id_seq OWNER TO chatwoot_user;

--
-- Name: related_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.related_categories_id_seq OWNED BY public.related_categories.id;


--
-- Name: reporting_events; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.reporting_events (
    id bigint NOT NULL,
    name character varying,
    value double precision,
    account_id integer,
    inbox_id integer,
    user_id integer,
    conversation_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    value_in_business_hours double precision,
    event_start_time timestamp without time zone,
    event_end_time timestamp without time zone
);


ALTER TABLE public.reporting_events OWNER TO chatwoot_user;

--
-- Name: reporting_events_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.reporting_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reporting_events_id_seq OWNER TO chatwoot_user;

--
-- Name: reporting_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.reporting_events_id_seq OWNED BY public.reporting_events.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO chatwoot_user;

--
-- Name: sla_events; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.sla_events (
    id bigint NOT NULL,
    applied_sla_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    account_id bigint NOT NULL,
    sla_policy_id bigint NOT NULL,
    inbox_id bigint NOT NULL,
    event_type integer,
    meta jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sla_events OWNER TO chatwoot_user;

--
-- Name: sla_events_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.sla_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sla_events_id_seq OWNER TO chatwoot_user;

--
-- Name: sla_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.sla_events_id_seq OWNED BY public.sla_events.id;


--
-- Name: sla_policies; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.sla_policies (
    id bigint NOT NULL,
    name character varying NOT NULL,
    first_response_time_threshold double precision,
    next_response_time_threshold double precision,
    only_during_business_hours boolean DEFAULT false,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    description character varying,
    resolution_time_threshold double precision
);


ALTER TABLE public.sla_policies OWNER TO chatwoot_user;

--
-- Name: sla_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.sla_policies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sla_policies_id_seq OWNER TO chatwoot_user;

--
-- Name: sla_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.sla_policies_id_seq OWNED BY public.sla_policies.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_type character varying,
    taggable_id integer,
    tagger_type character varying,
    tagger_id integer,
    context character varying(128),
    created_at timestamp without time zone
);


ALTER TABLE public.taggings OWNER TO chatwoot_user;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.taggings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taggings_id_seq OWNER TO chatwoot_user;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.taggings_id_seq OWNED BY public.taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying,
    taggings_count integer DEFAULT 0
);


ALTER TABLE public.tags OWNER TO chatwoot_user;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO chatwoot_user;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.team_members (
    id bigint NOT NULL,
    team_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.team_members OWNER TO chatwoot_user;

--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.team_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_members_id_seq OWNER TO chatwoot_user;

--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.team_members_id_seq OWNED BY public.team_members.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    allow_auto_assign boolean DEFAULT true,
    account_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.teams OWNER TO chatwoot_user;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teams_id_seq OWNER TO chatwoot_user;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: telegram_bots; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.telegram_bots (
    id integer NOT NULL,
    name character varying,
    auth_key character varying,
    account_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.telegram_bots OWNER TO chatwoot_user;

--
-- Name: telegram_bots_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.telegram_bots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.telegram_bots_id_seq OWNER TO chatwoot_user;

--
-- Name: telegram_bots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.telegram_bots_id_seq OWNED BY public.telegram_bots.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    provider character varying DEFAULT 'email'::character varying NOT NULL,
    uid character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    name character varying NOT NULL,
    display_name character varying,
    email character varying,
    tokens json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    pubsub_token character varying,
    availability integer DEFAULT 0,
    ui_settings jsonb DEFAULT '{}'::jsonb,
    custom_attributes jsonb DEFAULT '{}'::jsonb,
    type character varying,
    message_signature text
);


ALTER TABLE public.users OWNER TO chatwoot_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO chatwoot_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.webhooks (
    id bigint NOT NULL,
    account_id integer,
    inbox_id integer,
    url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    webhook_type integer DEFAULT 0,
    subscriptions jsonb DEFAULT '["conversation_status_changed", "conversation_updated", "conversation_created", "contact_created", "contact_updated", "message_created", "message_updated", "webwidget_triggered"]'::jsonb
);


ALTER TABLE public.webhooks OWNER TO chatwoot_user;

--
-- Name: webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.webhooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.webhooks_id_seq OWNER TO chatwoot_user;

--
-- Name: webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.webhooks_id_seq OWNED BY public.webhooks.id;


--
-- Name: working_hours; Type: TABLE; Schema: public; Owner: chatwoot_user
--

CREATE TABLE public.working_hours (
    id bigint NOT NULL,
    inbox_id bigint,
    account_id bigint,
    day_of_week integer NOT NULL,
    closed_all_day boolean DEFAULT false,
    open_hour integer,
    open_minutes integer,
    close_hour integer,
    close_minutes integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    open_all_day boolean DEFAULT false
);


ALTER TABLE public.working_hours OWNER TO chatwoot_user;

--
-- Name: working_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: chatwoot_user
--

CREATE SEQUENCE public.working_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.working_hours_id_seq OWNER TO chatwoot_user;

--
-- Name: working_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatwoot_user
--

ALTER SEQUENCE public.working_hours_id_seq OWNED BY public.working_hours.id;


--
-- Name: access_tokens id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.access_tokens ALTER COLUMN id SET DEFAULT nextval('public.access_tokens_id_seq'::regclass);


--
-- Name: account_users id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.account_users ALTER COLUMN id SET DEFAULT nextval('public.account_users_id_seq'::regclass);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: action_mailbox_inbound_emails id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.action_mailbox_inbound_emails ALTER COLUMN id SET DEFAULT nextval('public.action_mailbox_inbound_emails_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: agent_bot_inboxes id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.agent_bot_inboxes ALTER COLUMN id SET DEFAULT nextval('public.agent_bot_inboxes_id_seq'::regclass);


--
-- Name: agent_bots id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.agent_bots ALTER COLUMN id SET DEFAULT nextval('public.agent_bots_id_seq'::regclass);


--
-- Name: applied_slas id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.applied_slas ALTER COLUMN id SET DEFAULT nextval('public.applied_slas_id_seq'::regclass);


--
-- Name: article_embeddings id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.article_embeddings ALTER COLUMN id SET DEFAULT nextval('public.article_embeddings_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.attachments ALTER COLUMN id SET DEFAULT nextval('public.attachments_id_seq'::regclass);


--
-- Name: audits id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.audits ALTER COLUMN id SET DEFAULT nextval('public.audits_id_seq'::regclass);


--
-- Name: automation_rules id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.automation_rules ALTER COLUMN id SET DEFAULT nextval('public.automation_rules_id_seq'::regclass);


--
-- Name: campaigns id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN id SET DEFAULT nextval('public.campaigns_id_seq'::regclass);


--
-- Name: canned_responses id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.canned_responses ALTER COLUMN id SET DEFAULT nextval('public.canned_responses_id_seq'::regclass);


--
-- Name: captain_assistant_responses id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_assistant_responses ALTER COLUMN id SET DEFAULT nextval('public.captain_assistant_responses_id_seq'::regclass);


--
-- Name: captain_assistants id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_assistants ALTER COLUMN id SET DEFAULT nextval('public.captain_assistants_id_seq'::regclass);


--
-- Name: captain_documents id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_documents ALTER COLUMN id SET DEFAULT nextval('public.captain_documents_id_seq'::regclass);


--
-- Name: captain_inboxes id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_inboxes ALTER COLUMN id SET DEFAULT nextval('public.captain_inboxes_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: channel_api id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_api ALTER COLUMN id SET DEFAULT nextval('public.channel_api_id_seq'::regclass);


--
-- Name: channel_email id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_email ALTER COLUMN id SET DEFAULT nextval('public.channel_email_id_seq'::regclass);


--
-- Name: channel_facebook_pages id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_facebook_pages ALTER COLUMN id SET DEFAULT nextval('public.channel_facebook_pages_id_seq'::regclass);


--
-- Name: channel_instagram id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_instagram ALTER COLUMN id SET DEFAULT nextval('public.channel_instagram_id_seq'::regclass);


--
-- Name: channel_line id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_line ALTER COLUMN id SET DEFAULT nextval('public.channel_line_id_seq'::regclass);


--
-- Name: channel_sms id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_sms ALTER COLUMN id SET DEFAULT nextval('public.channel_sms_id_seq'::regclass);


--
-- Name: channel_telegram id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_telegram ALTER COLUMN id SET DEFAULT nextval('public.channel_telegram_id_seq'::regclass);


--
-- Name: channel_twilio_sms id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_twilio_sms ALTER COLUMN id SET DEFAULT nextval('public.channel_twilio_sms_id_seq'::regclass);


--
-- Name: channel_twitter_profiles id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_twitter_profiles ALTER COLUMN id SET DEFAULT nextval('public.channel_twitter_profiles_id_seq'::regclass);


--
-- Name: channel_web_widgets id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_web_widgets ALTER COLUMN id SET DEFAULT nextval('public.channel_web_widgets_id_seq'::regclass);


--
-- Name: channel_whatsapp id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_whatsapp ALTER COLUMN id SET DEFAULT nextval('public.channel_whatsapp_id_seq'::regclass);


--
-- Name: contact_inboxes id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.contact_inboxes ALTER COLUMN id SET DEFAULT nextval('public.contact_inboxes_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: conversation_participants id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.conversation_participants ALTER COLUMN id SET DEFAULT nextval('public.conversation_participants_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: copilot_messages id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.copilot_messages ALTER COLUMN id SET DEFAULT nextval('public.copilot_messages_id_seq'::regclass);


--
-- Name: copilot_threads id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.copilot_threads ALTER COLUMN id SET DEFAULT nextval('public.copilot_threads_id_seq'::regclass);


--
-- Name: csat_survey_responses id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.csat_survey_responses ALTER COLUMN id SET DEFAULT nextval('public.csat_survey_responses_id_seq'::regclass);


--
-- Name: custom_attribute_definitions id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.custom_attribute_definitions ALTER COLUMN id SET DEFAULT nextval('public.custom_attribute_definitions_id_seq'::regclass);


--
-- Name: custom_filters id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.custom_filters ALTER COLUMN id SET DEFAULT nextval('public.custom_filters_id_seq'::regclass);


--
-- Name: custom_roles id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.custom_roles ALTER COLUMN id SET DEFAULT nextval('public.custom_roles_id_seq'::regclass);


--
-- Name: dashboard_apps id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.dashboard_apps ALTER COLUMN id SET DEFAULT nextval('public.dashboard_apps_id_seq'::regclass);


--
-- Name: data_imports id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.data_imports ALTER COLUMN id SET DEFAULT nextval('public.data_imports_id_seq'::regclass);


--
-- Name: email_templates id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.email_templates ALTER COLUMN id SET DEFAULT nextval('public.email_templates_id_seq'::regclass);


--
-- Name: folders id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folders_id_seq'::regclass);


--
-- Name: inbox_members id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.inbox_members ALTER COLUMN id SET DEFAULT nextval('public.inbox_members_id_seq'::regclass);


--
-- Name: inboxes id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.inboxes ALTER COLUMN id SET DEFAULT nextval('public.inboxes_id_seq'::regclass);


--
-- Name: installation_configs id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.installation_configs ALTER COLUMN id SET DEFAULT nextval('public.installation_configs_id_seq'::regclass);


--
-- Name: integrations_hooks id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.integrations_hooks ALTER COLUMN id SET DEFAULT nextval('public.integrations_hooks_id_seq'::regclass);


--
-- Name: labels id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.labels ALTER COLUMN id SET DEFAULT nextval('public.labels_id_seq'::regclass);


--
-- Name: macros id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.macros ALTER COLUMN id SET DEFAULT nextval('public.macros_id_seq'::regclass);


--
-- Name: mentions id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.mentions ALTER COLUMN id SET DEFAULT nextval('public.mentions_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: notification_settings id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notification_settings ALTER COLUMN id SET DEFAULT nextval('public.notification_settings_id_seq'::regclass);


--
-- Name: notification_subscriptions id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notification_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.notification_subscriptions_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: platform_app_permissibles id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.platform_app_permissibles ALTER COLUMN id SET DEFAULT nextval('public.platform_app_permissibles_id_seq'::regclass);


--
-- Name: platform_apps id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.platform_apps ALTER COLUMN id SET DEFAULT nextval('public.platform_apps_id_seq'::regclass);


--
-- Name: portals id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.portals ALTER COLUMN id SET DEFAULT nextval('public.portals_id_seq'::regclass);


--
-- Name: related_categories id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.related_categories ALTER COLUMN id SET DEFAULT nextval('public.related_categories_id_seq'::regclass);


--
-- Name: reporting_events id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.reporting_events ALTER COLUMN id SET DEFAULT nextval('public.reporting_events_id_seq'::regclass);


--
-- Name: sla_events id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.sla_events ALTER COLUMN id SET DEFAULT nextval('public.sla_events_id_seq'::regclass);


--
-- Name: sla_policies id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.sla_policies ALTER COLUMN id SET DEFAULT nextval('public.sla_policies_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.taggings ALTER COLUMN id SET DEFAULT nextval('public.taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: team_members id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.team_members ALTER COLUMN id SET DEFAULT nextval('public.team_members_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: telegram_bots id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.telegram_bots ALTER COLUMN id SET DEFAULT nextval('public.telegram_bots_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: webhooks id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.webhooks ALTER COLUMN id SET DEFAULT nextval('public.webhooks_id_seq'::regclass);


--
-- Name: working_hours id; Type: DEFAULT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.working_hours ALTER COLUMN id SET DEFAULT nextval('public.working_hours_id_seq'::regclass);


--
-- Data for Name: access_tokens; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.access_tokens (id, owner_type, owner_id, token, created_at, updated_at) FROM stdin;
1	User	5	h6seQjaHiGDgcAWxnkn7bksi	2025-06-04 04:48:06.036578	2025-06-04 04:48:06.036578
2	AgentBot	1	Et9u1XsqyCmk2CUBRpEe7Z4W	2025-06-04 04:52:10.62972	2025-06-04 04:52:10.62972
3	PlatformApp	1	VwhEEuwtp8vM4WFkiFqiqH9f	2025-06-04 04:53:11.18083	2025-06-04 04:53:11.18083
\.


--
-- Data for Name: account_users; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.account_users (id, account_id, user_id, role, inviter_id, created_at, updated_at, active_at, availability, auto_offline, custom_role_id) FROM stdin;
1	1	5	1	\N	2025-06-04 04:48:06.072077	2025-06-24 06:39:08.711127	2025-06-24 06:39:08.706912	0	t	\N
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.accounts (id, name, created_at, updated_at, locale, domain, support_email, feature_flags, auto_resolve_duration, limits, custom_attributes, status, internal_attributes, settings) FROM stdin;
1	Landing Pad Support Account	2025-06-04 04:48:05.873546	2025-06-04 04:49:46.333719	0	\N	\N	4398079541127	\N	{}	{}	0	{}	{}
\.


--
-- Data for Name: action_mailbox_inbound_emails; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.action_mailbox_inbound_emails (id, status, message_id, message_checksum, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	avatar	User	5	1	2025-06-04 04:50:37.162083
2	image	ActiveStorage::VariantRecord	1	2	2025-06-04 04:50:38.025123
3	avatar	User	4	3	2025-06-04 04:51:30.06982
4	image	ActiveStorage::VariantRecord	2	4	2025-06-04 04:51:30.550301
5	avatar	AgentBot	1	5	2025-06-04 04:52:10.633914
6	image	ActiveStorage::VariantRecord	3	6	2025-06-04 04:52:11.262689
7	image	ActiveStorage::VariantRecord	4	7	2025-06-04 04:52:15.741381
10	logo	Portal	1	49	2025-06-04 08:39:47.100905
13	avatar	Inbox	1	52	2025-06-04 10:10:00.620184
14	image	ActiveStorage::VariantRecord	6	53	2025-06-04 10:12:07.086842
17	logo	Portal	2	56	2025-06-06 02:24:09.343674
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, byte_size, checksum, created_at, service_name) FROM stdin;
1	2lv2dlgvj2d5ihp21nwxpa7wf10q	icon-max.png	image/png	{"identified":true,"width":1536,"height":1536,"analyzed":true}	90922	blIqdu03aI2CrZm1AYdDlg==	2025-06-04 04:50:37.160429	local
2	v2qli8gn0zxbc10rcnigtjg5jgph	icon-max.png	image/png	{"identified":true,"width":250,"height":250,"analyzed":true}	6938	fOT6XqiAzPFJkDh8UhXGAQ==	2025-06-04 04:50:38.024055	local
3	ku9lz9v9gd5oyu74s082umm5p5xc	icon-max.png	image/png	{"identified":true,"width":1536,"height":1536,"analyzed":true}	90922	blIqdu03aI2CrZm1AYdDlg==	2025-06-04 04:51:30.068775	local
4	ir1az9qa930thc0qpvsov3r45m00	icon-max.png	image/png	{"identified":true,"width":250,"height":250,"analyzed":true}	6938	fOT6XqiAzPFJkDh8UhXGAQ==	2025-06-04 04:51:30.54931	local
5	fkow8qrv2sgkel8sad7ky3gu24p2	wisa.png	image/png	{"identified":true,"width":2940,"height":2940,"analyzed":true}	2451537	i93XatsiWoxrkU9yRD18gw==	2025-06-04 04:52:10.63285	local
6	sl2hpaich2ri0zqqiiytmxnlgoo8	wisa.png	image/png	{"identified":true,"width":250,"height":250,"analyzed":true}	31706	oNRdb5b1rf77N2cQbViwBQ==	2025-06-04 04:52:11.261448	local
7	ybivyft0i6jgvzz9e6broxgw70y1	wisa.png	image/png	{"identified":true,"width":800,"height":800,"analyzed":true}	253252	f1j4z/f1NRzp2+FjUCdfYw==	2025-06-04 04:52:15.740473	local
8	z5eqzlpezogeiyrms5mc87tms3iw	image.png	image/png	{"identified":true}	757653	w2gwZ5EZyUMg2MQV2xzIww==	2025-06-04 08:06:23.274597	local
9	woh7c7fc769q32cp26a69zhfe8m1	image.png	image/png	{"identified":true}	197353	9HSMHWCUFCCokRcTHb2BPA==	2025-06-04 08:09:27.492814	local
10	o8u5znho973q6sgt6nddds30yya9	image.png	image/png	{"identified":true}	935198	WgVJoYmClOc7l9i9AqdytQ==	2025-06-04 08:09:32.52359	local
11	3nixyn03n9lfh8qob3d0ekc86dik	image.png	image/png	{"identified":true}	937722	s9y2x3yWBId0ex1SkKvNRA==	2025-06-04 08:09:36.591006	local
12	z2j3ucfbb35ihgp1xgtjjkp8bboa	image.png	image/png	{"identified":true}	185183	qPVWlU2s4sJrkr5N4k0WWg==	2025-06-04 08:09:51.566048	local
13	ealn4hv1ie9ya2i0lmlt65jpq8ne	image.png	image/png	{"identified":true}	188720	p/zvYPz9QBDPz/z9aBtrRA==	2025-06-04 08:10:03.423873	local
14	blj6dk1u576zvcg129t8xjsj89ia	image.png	image/png	{"identified":true}	185454	zmeQTaCHuYXZT9kyr0Tvew==	2025-06-04 08:10:17.863827	local
15	or5uacqalj8tkwlw42zuky2eo9mb	image.png	image/png	{"identified":true}	801532	Afn87k9hELd1q5VT5mqnXQ==	2025-06-04 08:14:13.743822	local
16	gjly8qv71tqfak6oaeyeiow28l38	image.png	image/png	{"identified":true}	744762	dyRmi4rAZluSTmmRhh4TVQ==	2025-06-04 08:16:23.5468	local
17	y9pqhsg57enylrce5c7f0eekzrnd	image.png	image/png	{"identified":true}	1532432	4YIZbNbmR1c/pI6Ei+NKZQ==	2025-06-04 08:18:25.830948	local
18	7nhdy3nohhmkz1fk5axwo7movj37	image.png	image/png	{"identified":true}	768960	yTQsIwXJo1faypJ5PlgYzQ==	2025-06-04 08:18:35.570966	local
19	13x2dp62b3hn02b3rabek1qi8sws	image.png	image/png	{"identified":true}	850391	4OqEFcFiLBIiTfioj/D3vQ==	2025-06-04 08:18:46.264733	local
20	kr5aqyf9odp0ova9hnc49ntkngp4	image.png	image/png	{"identified":true}	661310	n/mYmc3iOOS+4uW+06XkRA==	2025-06-04 08:18:58.537986	local
21	2brxxkva1l7h6lkvnm4up9149s7k	image.png	image/png	{"identified":true}	825537	/Sj9z/edcp1hzGbcctAD6g==	2025-06-04 08:19:11.591175	local
22	3b0zcwhm4rlj58uy3v54h9rj19yb	image.png	image/png	{"identified":true}	533308	Bd5VCj9Ld7AV2pdCr58h8g==	2025-06-04 08:19:34.369129	local
23	9xxv1vfizduoupgv5uj5jbyuvfgc	image.png	image/png	{"identified":true}	146180	HuzWd6VqFiKGGprPxVt2hQ==	2025-06-04 08:20:48.935256	local
24	4o8z9xd8twggd1ooyy49swxnqimk	image.png	image/png	{"identified":true}	126224	wBROUbiJi2sxP/B2ZXFM/A==	2025-06-04 08:21:02.130103	local
25	nbyq235lvdm0xf87h05lilxjena6	image.png	image/png	{"identified":true}	129445	Gt9pO4DySeHHiJtsXrVgig==	2025-06-04 08:21:16.38018	local
26	b9x5hdp5r8pmemuj7hsfsj4rto3d	image.png	image/png	{"identified":true}	655878	WFF+mxxaL/a52fEXxNSPGQ==	2025-06-04 08:29:36.043151	local
27	059jsm10xac4d6pwbp97xftwx46y	image.png	image/png	{"identified":true}	615572	zMkjr2UHY0rBPMUzG4Jy1A==	2025-06-04 08:29:54.985697	local
28	jfc2gn2k9knozq8l20zxvzu1n32s	image.png	image/png	{"identified":true}	553834	5YHpbTLSddSOQFioUXkImQ==	2025-06-04 08:30:07.385432	local
29	a4v42v8fsofbhkna8vn2vsuex7jx	image.png	image/png	{"identified":true}	254572	EBCTLsDkqz9qUTlcA8s5OQ==	2025-06-04 08:30:16.55901	local
30	u4hy85mauvu2558t8y1jyyduacih	image.png	image/png	{"identified":true}	736970	+D0lkTqkY7LiZOmYC7+IYg==	2025-06-04 08:30:46.744967	local
31	w7srlmbt9r32ku46afur0kijgcc5	image.png	image/png	{"identified":true}	167269	WoBTaTPHUE5/CJGl5W6dqA==	2025-06-04 08:30:53.795731	local
32	v8evt6h2z7rsk3g0z0bv81g719zu	image.png	image/png	{"identified":true}	505680	Ub7760XBXYWIG/4uY6ijqQ==	2025-06-04 08:31:00.890795	local
33	toms5uw0ehgd8mafxqojmj1qms6x	image.png	image/png	{"identified":true}	804375	LZtpS4MMlpV6cjtSF9jt3Q==	2025-06-04 08:31:10.692485	local
34	im2cnk6s1lanud4xqxg7606ay6ep	image.png	image/png	{"identified":true}	412334	6k72tJSHVoRGPlsKzA/gWQ==	2025-06-04 08:31:19.763034	local
35	zh76eoh46ni19dk2fem4zwfy6v7d	image.png	image/png	{"identified":true}	1239540	okLSZbcz9NYagQBhm3hLJQ==	2025-06-04 08:32:31.872385	local
36	i644w854oxyqmatpg9kasppamkya	image.png	image/png	{"identified":true}	1394106	us04K23uNnhOwfOByRocsw==	2025-06-04 08:32:42.79164	local
37	jd90yx7ak7vhn36dfgm4ri00nmp9	image.png	image/png	{"identified":true}	1100446	bEFqjjpOJAJdaOW4LmOWuA==	2025-06-04 08:32:52.438726	local
38	0gunw3sxsjp8bves3d150ntosp2p	image.png	image/png	{"identified":true}	112609	YwQmBuDE0CYGx7xXe8O37A==	2025-06-04 08:33:44.018162	local
39	7gpsg1iy5jaf6qc9pu2e4g1pm2q2	image.png	image/png	{"identified":true}	74681	yCRsJCcJPG4IqHgEYgdnhQ==	2025-06-04 08:33:53.76492	local
40	4phor2ljqlxrrk7pte9k5re05nb6	image.png	image/png	{"identified":true}	90768	oiTuE7HwV5ifjLOAq6W7iw==	2025-06-04 08:34:04.469506	local
41	8bp2n6qpo53k0zou3a9oap567o5g	image.png	image/png	{"identified":true}	118444	fhaBgeAE42g5nZ/OMGM2Ig==	2025-06-04 08:34:16.328961	local
42	p5ruolverxt5mvbblsu9xfsy2eky	image.png	image/png	{"identified":true}	266886	MdW+Hy+5/7SxKiPIkd2HlA==	2025-06-04 08:34:29.421149	local
43	d0tfzl0tvmelmk2biljl32kttxk2	image.png	image/png	{"identified":true}	1618477	gz35E2eV0NHR3m/KSbv33A==	2025-06-04 08:35:04.828901	local
44	4wwqg0wqll4fhouwqk4108ng5afb	image.png	image/png	{"identified":true}	1469416	DI71zbk3Op+O4faiEVZGcw==	2025-06-04 08:35:17.840256	local
45	h0hk53apqrtvvdspelnydtsllszb	image.png	image/png	{"identified":true}	997033	N5/RKO3HNf7EMJs6T5cM7A==	2025-06-04 08:35:30.31318	local
46	vjf31jglvzx4anf1c3lkkl2pwxoo	image.png	image/png	{"identified":true}	419172	iv0uVszCYjvhVIJoh2/edw==	2025-06-04 08:35:39.026319	local
49	06m6hfbhhvp9vux2fiwbhsa9n7oq	icon-max.png	image/png	{"identified":true,"width":1536,"height":1536,"analyzed":true}	90922	blIqdu03aI2CrZm1AYdDlg==	2025-06-04 08:39:46.206097	local
52	ic4r3ns8p3ydzcy67qu5bmk1fmfp	avatar@2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	39164	Iq1fPjr84a4ya2LSgL3Y2g==	2025-06-04 10:10:00.618968	local
53	buixog3it2c9tjaflu8dmorj9nbb	icon-max.png	image/png	{"identified":true,"width":800,"height":800,"analyzed":true}	32741	6jvBP4+MahIbGfU/lDQBfw==	2025-06-04 10:12:07.085869	local
56	qy1s2z71npy0p8vwxyzlt4egoziv	icon-max.png	image/png	{"identified":true,"width":1536,"height":1536,"analyzed":true}	90922	blIqdu03aI2CrZm1AYdDlg==	2025-06-06 02:24:06.336903	local
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
1	1	P5v6kS02U7Ei4rbw/mo/MWxXjvQ=
2	3	P5v6kS02U7Ei4rbw/mo/MWxXjvQ=
3	5	P5v6kS02U7Ei4rbw/mo/MWxXjvQ=
4	5	oVj7i/n+6fv54/e/IrAmwBJg5hA=
6	1	oVj7i/n+6fv54/e/IrAmwBJg5hA=
\.


--
-- Data for Name: agent_bot_inboxes; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.agent_bot_inboxes (id, inbox_id, agent_bot_id, status, created_at, updated_at, account_id) FROM stdin;
\.


--
-- Data for Name: agent_bots; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.agent_bots (id, name, description, outgoing_url, created_at, updated_at, account_id, bot_type, bot_config) FROM stdin;
1	Wisa AgentBot	Wisa AgentBot description	https://wisaoutgoin.url	2025-06-04 04:52:10.626944	2025-06-04 04:52:50.622155	1	0	{}
\.


--
-- Data for Name: applied_slas; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.applied_slas (id, account_id, sla_policy_id, conversation_id, created_at, updated_at, sla_status) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2025-06-02 10:43:04.176729	2025-06-02 10:43:04.176729
schema_sha1	37bec84f1f5a094301c33916c5072018597d78df	2025-06-02 10:43:04.182271	2025-06-02 10:43:04.182271
\.


--
-- Data for Name: article_embeddings; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.article_embeddings (id, article_id, term, embedding, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.articles (id, account_id, portal_id, category_id, folder_id, title, description, content, status, views, created_at, updated_at, author_id, associated_article_id, meta, slug, "position", locale) FROM stdin;
3	1	1	3	\N	Projects	\N	Projects are the bread and butter of Landing Pad Cloud. Every card represents a project.	1	\N	2025-06-04 08:08:34.941596	2025-06-04 08:28:22.014196	5	\N	{}	1749024514-projects	80	en
2	1	1	3	\N	Dashboard Overview	\N	1. **Workspaces** / **Sub Accounts:** lets you structure your projects in sub-accounts. Best used for the client's sub-accounts.\n\n2. **Team Members:** lets you invite team members to work together on projects.\n\n3. **Account related options:** access profile settings, sign out link.\n\n4. **Publishing options:** access the publishing options for your project.\n\n5. **Edit project:** starts the Landing Pad builder for the selected project.\n\n6. **Project title:** edit the project title in place.\n\n7. **Preview:** lets you preview your project in a new browser tab.\n\n8. **Create a new project:** creates a new project in Landing Pad Cloud.	1	\N	2025-06-04 08:07:07.21535	2025-06-04 08:28:28.318934	5	\N	{}	1749024427-dashboard-overview	90	en
1	1	1	3	\N	Workspaces	\N	Called Workspaces or SubAccounts, this functionality allows you to separate clients on different areas. You can think of them as folders.\n\n[image]\n\nIt is especially important if you work with multiple clients because all the team members that you’ll invite (most likely the client at least) they’ll have access to all the projects in that sub account. The invitations happen at the sub account level, not at the project level. \n\nYou can rename or delete sub-accounts by hovering one and choosing from the icons on the right side. You can only delete sub accounts that have no projects.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--64bd75bb15a5c234b18f487080cb0b9e016053a2/image.png)\n\nThis functionality helps with being organised as well as separate personal projects from client work. 	1	\N	2025-06-04 08:05:36.948065	2025-06-04 08:28:36.99829	5	\N	{"tags": [], "title": "", "description": ""}	1749024336-workspaces	100	en
22	1	2	18	\N	Internal Developer Ecosystem	\N	## Overview\n\nThe **Landing Pad** infrastructure is designed as a central, secure, and smart command hub to power our internal tools, service access & automation. This documentation outlines the current architecture and a scalable vision for future development, allowing any developer onboarding to navigate and contribute to the ecosystem with clarity.\n\n---\n\n## Current Services & Structure\n\n```\n|  Subdomain   | Description                                                        \n|--------------|---------------------------------------------------------------|\nstatus.landingpad.digital    | Uptime Kuma – monitors health and uptime of all key services.\n\nsupport.landingpad.digital   | Chatwoot – current support system. Considering Zammad as an alternative.\n\nanalytics.landingpad.digital | Matomo – privacy-friendly analytics platform.\n\nn8n.landingpad.digital       | n8n – internal automation workflows, located under /smart.\n\nstripe.landingpad.digital    | Stripe APIs – handles free trial payment flows and integration.\n```\n\n---\n\n## Planned Additions & Recommendations\n\n```\n|  Subdomain   | Purpose | Suggested Tool | Notes |                                                        \n|--------------|---------|----------------|--------------------------------------|\n| vault.landingpad.digital | Secure password and credential manager | Bitwarden via Vaultwarden | Centralised & secure credential sharing for internal tools and services. |\n\n| dashboard.landingpad.digital | Customisable dashboard or launchpad for services | Dashy, Homarr, or Heimdall | Developers can choose based on team needs. Consider API widgets and iframe previews. |\n\n| portainer.landingpad.digital | Docker & container management | Portainer | For overseeing Docker containers, volumes, networks & stacks. Optional admin role access. |\n\n| docs.landingpad.digital (or dev but optional) | Internal documentation & SOPs or custom Markdown viewer | Can centralise onboarding & dev guides |\n```\n\n---\n\n## Vision & Principles\n\n* **Modular and future-ready:** Subdomain-based architecture encourages separation of concerns and ease of scaling.\n\n* **Developer empowerment:** Future devs are encouraged to install and maintain tools that best serve their workflows.\n\n* **Security-first:** Central credential management (via Bitwarden), strict role access, and optional 2FA support are recommended across services.\n\n* **Automation-ready:** n8n is available and expandable for service-to-service automations, alerts, syncing, etc.\n\n---\n\n## Notes for Future Developers\n\n* You are empowered to choose the most effective dashboarding and monitoring tools to manage services and workflows.\n\n* Bitwarden (Vaultwarden) is strongly recommended for password/secret management, especially if additional services are added over time.\n\n* If transitioning from **Chatwoot to Zammad**, ensure a plan for data migration and agent access consistency.\n\n* Be mindful of cross-service integration opportunities (e.g., n8n ↔ Matomo, Portainer ↔ Uptime Kuma).|	1	10	2025-06-09 04:35:22.664615	2025-06-09 04:56:01.963856	5	\N	{}	1749443722-landing-pad-internal-developer-ecosystem	10	en
5	1	1	3	\N	Leads	\N	The Leads functionality is tightly linked with the Contact form. All the contact forms that users are submitting are saved in the Leads section of that project no matter if you set up marketing integrations like Mailchimp, Drip, etc.\n\nLeads can be accessed from here:\n\n[image]\n\nThey look like this:\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBGQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--22aaa1b74000add6ae8b1d6377a03f56c0598bbd/image.png)\n\nThis is where the leads are saved when you put a contact form on your Landing Pad page(s) and a visitor of your website submits the form.\n\nIf you have the PRO that gives you integrations, and you have let's say MailChimp setup, then the lead will go to MailChimp but also is saved in your Dashboard for future reference.\n\nHere is a list with all the integrations that you can setup in Landing Pad Cloud. \n\nYou can Export or Delete leads from the two buttons on the bottom.	1	\N	2025-06-04 08:13:51.746865	2025-06-04 08:27:47.784214	5	\N	{}	1749024831-leads	60	en
4	1	1	3	\N	Team Members & Roles	\N	Lets you invite team members to work together on projects. An email will be sent to the user you invite, they need to click a link to accept the invite. They’ll need an account on Landing Pad to join if they don’t have one they can create one for free.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--76235a2d2ee4b89fa324b6d36ef6972de46df4f5/image.png)\n\nThe users will be invited based on Roles that restrict certain things that they can do in Landing Pad Cloud.\n\nThe **Owner** has full control.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--2f7993a336ed00e5d4fa8e3b369198fe7c12c19f/image.png)\n\n**Viewer**\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--4a94d2ad5f4d4461aa9f9cf24ad8d2c3c0b8dbae/image.png)\n\n**Editor**\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--eb33c8f108eb9ef7bec85ac7d848d712b076a1b3/image.png)\n\n**Designer**\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--44ad36e87df22f8730a5c5cb75236f8ebf23c0e9/image.png)\n\n**Manager**\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--37a9ea37064de0ee1f68b657ec1834a45160587e/image.png)\n\nThe invited team members can access all the projects created in the sub account so as a best practice you’ll want every client on a separate sub account if you don’t want to give access to all your projects.\n\nThe team members **functionality is included only for PRO & Premium** plans. You can invite unlimited team members with Premium.	1	\N	2025-06-04 08:09:04.56107	2025-06-04 08:28:13.071501	5	\N	{}	1749024544-team-members-roles	70	en
15	1	2	13	\N	How to Create a Stripe Trial Setup	\N	#### **Setting Up a No-Card-Upfront Stripe 14-Day Trial Environment**\n\n##### 1. Overview\n\nThis guide walks you through creating a lightweight backend service to start Stripe subscriptions with a 14-day trial — no credit card required — and a simple HTML test interface.\n\n##### 2. Folder Structure\n\n```\n/stripe\n├── index.js\n├── .env\n└── test.html\n```\n\n##### 3. Requirements\n\n* Node.js and npm installed\n\n* Stripe secret key\n\n* Your Stripe product price ID\n\n##### 4. Installation\n\n```\nnpm init -y\nnpm install express stripe cors dotenv\n```\n\n##### 5. Configure `.env`\n\n```\nSTRIPE_SECRET_KEY=sk_test_...\nPRICE_ID_PRO=price_...\n```\n\n6.  `index.js`:\n\n```\nconst express = require('express');\nconst app = express();\nconst cors = require('cors');\nrequire('dotenv').config();\nconst stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);\n\napp.use(cors());\napp.use(express.json());\n\napp.post('/start-free-trial', async (req, res) => {\n  try {\n    const { email, firstName, lastName } = req.body;\n\n    const customer = await stripe.customers.create({\n      email,\n      name: `${firstName} ${lastName}`,\n      description: '14-day trial customer',\n    });\n\n    const subscription = await stripe.subscriptions.create({\n      customer: customer.id,\n      items: [{ price: process.env.PRICE_ID_PRO }],\n      trial_period_days: 14,\n    });\n\n    res.json({\n      message: '✅ Free trial started!',\n      customerId: customer.id,\n      subscriptionId: subscription.id,\n      email,\n      firstName,\n      lastName,\n    });\n  } catch (err) {\n    console.error('❌ Error:', err.message);\n    res.status(500).json({ error: 'Failed to start free trial.' });\n  }\n});\n\napp.listen(3000, () => {\n  console.log('✅ Server running on http://localhost:3000');\n});\n```\n\n##### 7.  `free-trial.html`:\n\n```\n<!DOCTYPE html>\n<html>\n  <body>\n    <h2>Start Free Trial</h2>\n    <form id="trial-form">\n      <input type="text" id="firstName" placeholder="First Name" required />\n      <input type="text" id="lastName" placeholder="Last Name" required />\n      <input type="email" id="email" placeholder="Email" required />\n      <button type="submit">Start Free Trial</button>\n    </form>\n\n    <script>\n      document.getElementById('trial-form').addEventListener('submit', async (e) => {\n        e.preventDefault();\n        const firstName = document.getElementById('firstName').value;\n        const lastName = document.getElementById('lastName').value;\n        const email = document.getElementById('email').value;\n\n        const res = await fetch('https://billing.landingpad.digital/start-free-trial', {\n          method: 'POST',\n          headers: { 'Content-Type': 'application/json' },\n          body: JSON.stringify({ email, firstName, lastName }),\n        });\n\n        const data = await res.json();\n        alert(data.message);\n        console.log(data);\n      });\n    </script>\n  </body>\n</html>\n```\n\n##### 6. Run the server\n\n```\nnode index.js\n```\n\n##### 7. Test locally\n\nOpen `free-trial.html` in your browser	1	3	2025-06-05 08:18:52.69786	2025-06-05 09:01:50.504993	5	\N	{}	1749111532-how-to-create-a-stripe-trial-setup	10	en
6	1	1	11	\N	Contact form integrations	\N	Use the form integrations to connect your contact form with different marketing apps that let you collect and automate leads. You can also connect an email app that will let you send your leads on your email. Multiple apps can be set at once. \n\nThese are the current contact form integrations we have in Landing Pad. Click on any for a step by step tutorial on how to set everything up:\n\n**Email:** \n\n* [Email Notification](https://support.brizy.io/hc/en-us/articles/360043383792)\n\n**Apps:** \n\n* [Mailchimp](https://support.brizy.io/hc/en-us/articles/360043381952)\n\n* [Sendinblue](https://support.brizy.io/hc/en-us/articles/360043865331)\n\n* [Zapier](https://support.brizy.io/hc/en-us/articles/360044066291)\n\n* [Campaign Monitor](https://support.brizy.io/hc/en-us/articles/360043428472)\n\n* [Convert Kit](https://support.brizy.io/hc/en-us/articles/360043959911)\n\n* [Active Campaign](https://support.brizy.io/hc/en-us/articles/360043478352)\n\n* [Get Response](https://support.brizy.io/hc/en-us/articles/360043923871)\n\n* [Mailjet](https://support.brizy.io/hc/en-us/articles/360043514032)\n\n* [e-goi](https://support.brizy.io/hc/en-us/articles/360043958971)\n\n* [HubSpot](https://support.brizy.io/hc/en-us/articles/360043974891)\n\n* [MailerLite](https://support.brizy.io/hc/en-us/articles/360043975951)\n\n* [Drip](https://support.brizy.io/hc/en-us/articles/360043979091)\n\n**reCAPTCHA**\n\n* [reCAPTCHA](https://support.brizy.io/hc/en-us/articles/360043630952)\n\n \n\n**Keep in mind:** Any contact form that is connected with an app integration also saves the leads in your Leads section of your Landing Pad Cloud project.\n\nThis is accessible from your Landing Pad Cloud Dashboard - [More about Leads](https://support.brizy.io/hc/en-us/articles/360036495831).\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBGUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--18f0731c9a46035486b1bda13b1d9f24ef928710/image.png)	1	\N	2025-06-04 08:15:53.898202	2025-06-04 08:27:30.767957	5	\N	{}	1749024953-form-integrations	110	en
7	1	1	11	\N	Email Notification	\N	The email notification app will send you an email every time a new lead is generated. In other words, every time the contact form is successful submitted.\n\nHere is how you can set it up. \n\n**Step 1.** Access the App Integrations on the button of any contact form element in the Landing Pad builder\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBGZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--89ef2f05c688d3c399b1ef59205a218702c915f7/image.png)\n\n**Step 2.** On the Email tab click on Email Notification\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBGdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--a76e8519baf8ec2c9f68ab699be7f7a5431a6659/image.png)\n\n**Step 3.** Give us the email you want to receive the notification on. You can input multiple emails separated by comas. \n\nSet the email subject and give your form a name then click on Continue.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBHQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--c986f97cbf67688db727cb7b4864da1c9f0ee681/image.png)\n\n**Step 4**. You are done. Your form is connected with the Email notification app. Every time the form will be successful submitted you'll receive an email. \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBHUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--40521368d15ae73ae937adfaf6a35386a34b16be/image.png)\n\n**Keep in mind:** You can set a custom template for your notification email. We are also generating short-codes for your fields so you can include the lead info in the email. \n\n**Important:** You can format your email using HTML, use **<br>** to create a new line and **<strong></strong>** to bold certain words. Here is an example:\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBHdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--9aa83c472a996ac61749cc03d44de7673e6b1853/image.png)\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBHZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--934197d0896ca56e484cb47c9247faf7eb44fbc4/image.png)	1	\N	2025-06-04 08:17:50.517115	2025-06-04 08:27:05.716617	5	\N	{}	1749025070-email-notification	100	en
23	1	2	18	\N	Domain & SSL Setup Summary	\N	#### Summary\n\nThe domain `landingpad.digital` has been successfully configured with HTTPS and connected to our CMS. The SSL certificate was issued via Let's Encrypt and is auto-renewed by Certbot.\n\n---\n\n#### Domain Configuration\n\nHost | Record Type | Value\n\n`@` (root) | A         |   `34.237.47.210`\n\n`www`        | CNAME   |`casa.landingpad-digital.site`\n\n* The A record points to our server where the CMS is hosted.\n\n* The CNAME for `www` subdomain routes traffic to CMS.\n\n---\n\n#### 🔒 SSL Certificate\n\n* **Issued by:** Let’s Encrypt (via Certbot)\n\n* **Domains Covered:**\n\n  * `landingpad.digital`\n\n  * `www.landingpad.digital`\n\n* **Certificate path:**\n\n  * Full chain: `/etc/letsencrypt/live/landingpad.digital/fullchain.pem`\n\n  * Private key: `/etc/letsencrypt/live/landingpad.digital/privkey.pem`\n\n* **Expiry:** 8 September 2025\n\n* **Auto-renewal:** Enabled (via cron job set up by Certbot)\n\n---\n\n#### ⚙️ Server Configuration (Nginx)\n\nCertificate is deployed to the Nginx config located at:\n\n```\n/etc/nginx/sites-enabled/landingpad.digital\n```\n\nCheck certificate status via:\n\n```\ncurl -v https://landingpad.digital\n```\n\n---\n\n#### Troubleshooting Tips\n\n* **DNS issues:** Use `nslookup landingpad.digital` and `nslookup www.landingpad.digital` to verify propagation.\n\n* **SSL errors:** Check `/var/log/letsencrypt/letsencrypt.log` or Nginx error logs.\n\n* **Nginx restart:** After changes, always run:\n\n  ```\n  sudo nginx -t && sudo systemctl reload nginx\n  ```\n\n---\n\n#### Notes\n\n* CMS is connected to `landingpad.digital`.\n\n* Public-facing site (CMS page) is shown on `www.landingpad.digital`.\n\n* Temporary placeholder (`<h1>Landing Pad Digital coming soon</h1>`) is currently active and deployed.\n\n---	1	\N	2025-06-11 04:42:18.018788	2025-06-11 04:45:55.099957	5	\N	{}	1749616938-domain-ssl-setup-summary	40	en
16	1	2	13	\N	Stripe Free Trial Implementation Guide	\N	## **Overview**\n\nThis document outlines how to implement a **14-day free trial** using Stripe’s API without requiring upfront payment details. The solution includes:  \n✅ HTML form for user signup  \n✅ Node.js backend handling Stripe subscriptions  \n✅ Nginx reverse proxy setup\n\n---\n\n## **Implementation Steps**\n\n### **Backend Setup (Node.js)**\n\n#### **Prerequisites**\n\n* Node.js v16+\n\n* Stripe account ([Dashboard](https://dashboard.stripe.com/test/apikeys))\n\n* **`.env`** file with:\n\n  ```\n  STRIPE_SECRET_KEY=sk_test_your_key_here\n  PRICE_ID_PRO=price_your_pro_plan_id\n  ```\n\n#### **Install Dependencies**\n\n```\nnpm install express cors stripe dotenv\n```\n\n#### **`index.js` (Stripe Integration)**\n\n```\nconst express = require('express');\nconst app = express();\nconst cors = require('cors');\nrequire('dotenv').config();\nconst stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);\n\napp.use(cors({ origin: 'https://landingpad.digital' }));\napp.use(express.json());\n\n// Free Trial Endpoint\napp.post('/start-free-trial', async (req, res) => {\n  try {\n    const { email, firstName, lastName } = req.body;\n    \n    const customer = await stripe.customers.create({\n      email,\n      name: `${firstName} ${lastName}`,\n      metadata: { signup_method: "14-day-trial" } // Optional tracking\n    });\n\n    const subscription = await stripe.subscriptions.create({\n      customer: customer.id,\n      items: [{ price: process.env.PRICE_ID_PRO }],\n      trial_period_days: 14,\n    });\n\n    res.json({ \n      success: true,\n      message: "Free trial started!",\n      customerId: customer.id \n    });\n  } catch (err) {\n    res.status(500).json({ error: err.message });\n  }\n});\n\napp.listen(3002, '0.0.0.0', () => {\n  console.log("✅ Stripe server running on port 3002");\n});\n```\n\n---\n\n### **Frontend (HTML/JS)**\n\n#### **`free-trial.html`**\n\n```\n<!DOCTYPE html>\n<html>\n<body>\n  <h2>Start Your 14-Day Free Trial</h2>\n  <form id="trial-form">\n    <input type="email" id="email" placeholder="Email" required>\n    <input type="text" id="firstName" placeholder="First Name" required>\n    <input type="text" id="lastName" placeholder="Last Name" required>\n    <button type="submit">Start Trial</button>\n  </form>\n\n  <script>\n    document.getElementById('trial-form').addEventListener('submit', async (e) => {\n      e.preventDefault();\n      const email = document.getElementById('email').value;\n      const firstName = document.getElementById('firstName').value;\n      const lastName = document.getElementById('lastName').value;\n\n      try {\n        const res = await fetch('/start-free-trial', {\n          method: 'POST',\n          headers: { 'Content-Type': 'application/json' },\n          body: JSON.stringify({ email, firstName, lastName }),\n        });\n        const data = await res.json();\n        alert(data.message);\n      } catch (err) {\n        alert("Error: " + err.message);\n      }\n    });\n  </script>\n</body>\n</html>\n```\n\n---\n\n### **Nginx Configuration**\n\n#### **`/etc/nginx/sites-available/stripe`**\n\n```\nserver {\n    listen 443 ssl;\n    server_name stripe.landingpad.digital;\n\n    ssl_certificate /path/to/cert.pem;\n    ssl_certificate_key /path/to/key.pem;\n\n    root /var/www/stripe;\n    index free-trial.html;\n\n    location / {\n        try_files $uri $uri/ /free-trial.html;\n    }\n\n    location /start-free-trial {\n        proxy_pass http://localhost:3002;\n        proxy_http_version 1.1;\n        proxy_set_header Host $host;\n    }\n}\n```\n\n**Apply changes:**\n\n```\nsudo nginx -t && sudo systemctl restart nginx\n```\n\n---\n\n## **Testing Guide**\n\n### **Local Testing**\n\n```\ncurl -X POST http://localhost:3002/start-free-trial \\\n  -H "Content-Type: application/json" \\\n  -d '{"email":"test@test.com","firstName":"Test","lastName":"User"}'\n```\n\n**Expected Response:**\n\n```\n{\n  "success": true,\n  "message": "Free trial started!",\n  "customerId": "cus_XXXX"\n}\n```\n\n### **Browser Testing**\n\n1. Visit **`https://stripe.landingpad.digital/free-trial.html`**\n\n2. Submit the form → Check for:\n\n   * Success alert\n\n   * New customer in [Stripe Dashboard](https://dashboard.stripe.com/test/customers)\n\n### **Stripe Dashboard Verification**\n\n* **Customers**: Should show new signups with **`14-day-trial`** metadata.\n\n* **Subscriptions**: Should list trials with **`trialing`** status.\n\n---\n\n## **Troubleshooting**\n\n**Issue | Solution**\n\n**`403 Forbidden` | Verify CORS origin matches your domain**\n\n**`500 Server Error`**`|`**Check Node.js logs for Stripe API errorsNames not savingEnsure**\n\n**`firstName`/`lastName`** | **are sent in POST request**\n\n---\n\n## **Additional Resources**\n\n* [Stripe Subscriptions API](https://stripe.com/docs/api/subscriptions)\n\n* [Stripe Trial Periods](https://stripe.com/docs/billing/subscriptions/trials)\n\n* [Landing Pad API](https://admin.landingpad-builder.cloud/api/doc/v2) 	1	5	2025-06-06 02:34:33.958026	2025-06-11 05:18:26.384278	5	\N	{}	1749177273-stripe-free-trial-implementation-guide	20	en
12	1	1	5	\N	How to create custom anchor links in Menus to link to specific blocks in the page	\N	If you are creating a landing page and want custom links in the Menu that point to different blocks in the page, here is how to add them:\n\n**Step 1**. Go to CMS (hamburger icon)> Project Settings - Menu tab \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBLdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6cc5fb136f0438703bd579435c95ca15322c1bed/image.png)\n\n**Step 2.** Select the menu you want to add the custom links to, from the drop down\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--cb656def33ca1700137fa98059f666626b3510bb/image.png)\n\n**Step 3**. Add Custom links from the sidebar.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--44d46ed5a34facbf2f046453e04ad56f7c048e4d/image.png)\n\n**Step 4**. Click on the Settings icon and add the anchor link in the Anchor field. For example, if you have named the Contact block as Contact, your anchor link will be #Contact. \n\nIn the Page Title field, please give a name for your anchor link. Your website visitors will click on this name to go to the specific block. Click on 'Save Changes' at the bottom to save your menu.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--92e9667a6262d170a29c4091f6cf14d11d05fdd0/image.png)\n\nThe block name is the name you give to your block from the block advanced settings. \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--062d00b8b0e8c4fba5ed20c59c28b0333de33496/image.png)	1	\N	2025-06-04 08:33:20.764016	2025-06-04 08:34:44.017957	5	\N	{}	1749026000-how-to-create-custom-anchor-links-in-menus-to-link-to-specific-blocks-in-the-page	50	en
13	1	1	5	\N	How to add a header global block on all your pages	\N	A multi page website needs a global header menu on all the pages that can be modified from any page you are working on. Here is how to do it:\n\n**Step 1**. Set up a header block with the Menu element you want.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1d27c84f92bee4940da0b4354e4eeb0daa5eb121/image.png)\n\n**Step 2**. Transform the block in a Global block, then update the page.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b2fa9ea476cdad68984fa55bce721c3f75e98831/image.png)\n\n**Step 3**. Go to Settings > Pages and click the Edit page icon to jump to the next page on your website. \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--30b26d5b773706ebff9eaa52e10ef844fbc0d181/image.png)\n\n**Step 4**. Add the header from the global blocks \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1cea70e9f93697c3e865d6996242de0adbb3a9b6/image.png)\n\n**Step 5**. Repeat step 3 and step 4 until you add the global header on all your pages. Once that is done you can edit the header from any page and the changes will apply across your website.	1	\N	2025-06-04 08:35:00.481835	2025-06-04 10:20:35.705192	5	\N	{}	1749026100-how-to-add-a-header-global-block-on-all-your-pages	80	en
24	1	2	18	\N	Cookie Consent Management – Implementation Guide	\N	**Tool Used**: [CookieYes](https://www.cookieyes.com/)  \n**Purpose**: To comply with privacy regulations and provide users with clear control over their personal data and tracking preferences.\n\n---\n\n### Tool Overview\n\nCookieYes is a consent management platform integrated into the Landing Pad Digital platform to:\n\n* Display a cookie consent banner.\n\n* Manage and categorise cookies.\n\n* Control loading of third-party services/scripts based on consent.\n\n* Handle user preferences and reconsent.\n\n---\n\n### Consent Configuration Summary\n\n**Do you collect personal data?**  Yes – with user consent\n\n**Method:** Explicit consent via popup before activating cookies\n\n**Purposes of data collection:**\n\n✔ Marketing/Promotional  \n✔ Creating user accounts  \n✔ Processing payments  \n✔ Support  \n✔ User feedback  \n✔ Account management  \n✔ Dispute resolution, etc.\n\n**Third-party services used**\n\n✔ Stripe (billing)  \n✔ Matomo (analytics)  \n✔ Chatwoot (support)  \n✔ Sponsors\n\n**Consent expiration:** 365 days\n\n**Consent reload action:** YES – reloads page on consent to apply changes immediately\n\n**Data retention:** 90 days to 2 years after user accounts remain idle\n\n**External links to third-party sites:** YES – used in help docs, payment flows, privacy policies & account features\n\n---\n\n### How Consent Works on the Platform\n\n1. **Banner Display**:  \n   A banner appears on first visit or after consent expires (365 days), prompting users to accept, reject or customise cookie preferences.\n\n2. **User Choice Handling**:\n\n   * Cookies and scripts are blocked until consent is given.\n\n   * Categories include **Necessary**, **Analytics**, **Marketing**, **Functional**, and **Support**.\n\n   * Third-party scripts (Matomo, Chatwoot, Stripe, etc.) only run if the relevant category is accepted.\n\n3. **Page Reload**:  \n   The page **reloads automatically** after the user saves their consent preferences to ensure proper script reinitialisation.\n\n4. **Consent Logging**:  \n   Consent is recorded and stored for audit purposes (if enabled on CookieYes dashboard).\n\n---\n\n### Developer Implementation Notes\n\n* **Scripts are categorised** using CookieYes’ HTML attributes like `data-cookieyes-category="analytics"` or via GTM integration if in use.\n\n* Third-party services are conditionally loaded after consent using either:\n\n  * CookieYes' auto-blocking functionality (preferred for simplicity) **or**\n\n  * Manual JS control if advanced logic is required.\n\n* **Matomo tracking** respects user preference: activated only if consent for analytics is granted.\n\n* **Chatwoot widget** will appear only when consent for functional/support cookies is accepted.\n\n* **Stripe scripts** are tied to essential and/or payment processing categories.\n\n---\n\n### Compliance Coverage\n\nThis setup aims to meet the requirements of:\n\n* **Thailand’s PDPA**\n\n* **GDPR (for EU users)**\n\n* **Global best practices** for cookie consent, transparency & data protection.\n\n---\n\n### Optional Enhancements\n\n* Enable **multi-language banners** for international reach.\n\n* Display a **Consent Preferences** link in the footer so users can update settings anytime.\n\n* Set **custom triggers** via `window.cookieyes` API for advanced use cases (e.g., single-page apps, n8n triggers).\n\n---	1	1	2025-06-12 10:52:26.969493	2025-06-12 10:57:12.226687	5	\N	{}	1749725546-cookie-consent-management-implementation-guide	50	en
17	1	2	14	\N	Matomo Analytics Integration Documentation	\N	    **1. Overview**\n\n* This document provides technical details on how Matomo (formerly Piwik) analytics tracking is implemented on **`landingpad.digital`** and its subdomains.\n\n  ### **Key Features**\n\n  * Cross-subdomain tracking (**`*.landingpad.digital`**)\n\n  * Page view & link click tracking\n\n  * Custom dimension for hostname tracking\n\n  * No-script fallback for users without JavaScript\n\n  ---\n\n  ## **2. Implementation Details**\n\n  ### **2.1. Tracking Script**\n\n  The Matomo tracking code is injected into the **`<head>`** section of all pages.\n\n  #### **Code Snippet**\n\n  ```\n  <!-- Matomo -->\n  <script type="text/javascript">\n    var _paq = window._paq = window._paq || [];\n    _paq.push(['setCustomDimension', 1, location.hostname]); \n    _paq.push(["setCookieDomain", "*.landingpad.digital"]);\n    _paq.push(["setDomains", ["*.landingpad.digital"]]);\n    _paq.push(['trackPageView']);\n    _paq.push(['enableLinkTracking']);\n    (function() {\n      var u="//analytics.landingpad.digital/";\n      _paq.push(['setTrackerUrl', u+'matomo.php']);\n      _paq.push(['setSiteId', '1']);\n      var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];\n      g.type='text/javascript'; g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);\n    })();\n  </script>\n  <noscript>\n    <p><img src="//analytics.landingpad.digital/matomo.php?idsite=1&amp;rec=1" style="border:0" alt="" /></p>\n  </noscript>\n  <!-- End Matomo Code -->\n  ```\n\n  #### **Breakdown of Key Functions**\n\n* `setCustomDimension(1, location.hostname)`**Tracks the hostname (e.g., `subdomain.landingpad.digital`**)\n\n* `setCookieDomain("*.landingpad.digital")`**Ensures cookies work across all subdomains**\n\n* `setDomains(["*.landingpad.digital"])`**Enables cross-subdomain tracking**\n\n* `trackPageView()`**Logs the current page view**\n\n* `enableLinkTracking()`**Tracks outbound & download links**\n\n* `setTrackerUrl()`**Sets the Matomo server endpoint**\n\n* `setSiteId('1')` **Identifies the website in Matomo’s dashboard**\n\n  ---\n\n  ## **3. Configuration Settings**\n\n  ### **3.1. Cross-Subdomain Tracking**\n\n  * **Cookie Domain:** **`*.landingpad.digital`**\n\n  * **Domains Tracked:** All subdomains under **`landingpad.digital`**\n\n  ### **3.2. Data Collected**\n\n  * Page views\n\n  * Referrers\n\n  * User interactions (clicks, downloads)\n\n  * Custom dimension (hostname)\n\n  ### **3.3. No-Script Fallback**\n\n  * If JavaScript is disabled, a tracking pixel (**`matomo.php?idsite=1&rec=1`**) is used instead.\n\n  ---\n\n  ## **4. Developer Guidelines**\n\n  ### **4.1. Where to Place the Code**\n\n  * **Recommended:** Inside **`<head>`** for accurate tracking.\n\n  * **Alternative:** Before the closing **`</body>`** tag (if performance is a concern).\n\n  ### **4.2. Modifying Tracking Logic**\n\n  * To add more custom dimensions:\n\n    ```\n    _paq.push(['setCustomDimension', 2, 'Additional Data']);\n    ```\n\n  * To exclude specific pages from tracking:\n\n    ```\n    if (window.location.pathname !== '/private-page') {\n      _paq.push(['trackPageView']);\n    }\n    ```\n\n  ### **4.3. Debugging & Testing**\n\n  1. **Check Browser Console** for Matomo-related errors.\n\n  2. **Verify Cookies** (**`_pk_*`**) are set under **`*.landingpad.digital`**.\n\n  3. **Use Matomo Tag Manager Debugger** (if applicable).\n\n  ---\n\n  ## **5. Compliance & Privacy**\n\n  ### **5.1. GDPR Considerations**\n\n  * Ensure user consent is obtained before tracking (if applicable).\n\n  * Matomo supports anonymized tracking (IP masking).\n\n  ### **5.2. Data Retention**\n\n  * Configured in Matomo server settings (default: 25 months).\n\n  ---\n\n  ## **6. Troubleshooting**\n\n  **Issue | Possible Fix**\n\n* No data in Matomo dashboard |Check if **`matomo.js`** is loading (Network tab).\n\n* Cross-domain tracking failing | Verify **`setCookieDomain`** and **`setDomains`** are correct.\n\n* Duplicate tracking | Ensure the script is not loaded multiple times.\n\n  ---\n\n  ## **7. References**\n\n  * [Matomo JavaScript Tracking Guide](https://matomo.org/docs/javascript-tracking/)\n\n  * [Cross-Domain Tracking Documentation](https://matomo.org/docs/tracking-javascript-guide/#cross-domain-tracking)	1	\N	2025-06-06 02:39:00.247978	2025-06-06 02:44:51.000872	5	\N	{}	1749177540-matomo-analytics-integration-documentation	10	en
18	1	2	15	\N	Chatwoot Self-Hosted Installation Guide (Docker)	\N	### ✅ Prerequisites\n\n* Docker & Docker Compose installed\n\n* Domain name configured with SSL (e.g. `support.landingpad.digital`)\n\n* Mail server credentials (SMTP)\n\n* `.env` file configured for production\n\n---\n\n### 📂 Project Structure\n\n```\nproject-root/ \n├── docker-compose.yml \n├── Dockerfile.chatwoot \n├── docker/ \n│ └── entrypoints/ \n│ └── rails.sh \n├── .env\n```\n\n---\n\n### 🚀 Installation Steps\n\n#### 1. Clone Chatwoot & Set Up Docker\n\n```\ngit clone https://github.com/chatwoot/chatwoot.git cd chatwoot\n```\n\n> If you're using a custom fork, update the remote.\n\n---\n\n#### 2. Define Your `.env` Configuration\n\nCreate a `.env` file with production settings. Example:\n\n```\nRAILS_ENV=production \nNODE_ENV=production \nINSTALLATION_ENV=docker \nSECRET_KEY_BASE=your_secure_key \nFRONTEND_URL=https://support.landingpad.digital MAILER_SENDER_EMAIL=support@landingpad.digital \nSMTP_ADDRESS=smtp.mailgun.org \nSMTP_PORT=587 \nSMTP_USERNAME=postmaster@yourdomain.com \nSMTP_PASSWORD=your_password \nREDIS_PASSWORD=your_secure_redis_pass \n```\n\n> Replace with actual values. Use dotenv-linter to validate.\n\n---\n\n#### 3. Build and Start Services\n\n```\ndocker-compose build docker-compose up -d\n```\n\n---\n\n#### 4. Prepare the Database\n\n```\ndocker-compose run --rm rails bundle exec rails db:chatwoot_prepare\n```\n\nThis runs:\n\n* `db:create`\n\n* `db:migrate`\n\n* `db:seed`\n\n> ⚠️ Don’t re-run this unless intentionally resetting the database.\n\n---\n\n#### 5. Precompile Assets\n\n```\ndocker-compose run --rm rails bundle exec rails assets:precompile\n```\n\n> Required for production performance.\n\n---\n\n#### 6. Visit Your Instance\n\n* Go to: `https://yourdomain.com/installation/onboarding`\n\n* Complete the setup wizard (create admin, configure widget)\n\n---\n\n### 🧠 Customisation Notes\n\n#### 🖼️ Logo / Branding\n\n* Branding features are **paid-only**\n\n* Workaround: Inject CSS via `CUSTOM_CSS` in `.env`\n\n* Logo override: Place new logo in `/app/public/assets/logo.png` (requires image rebuilding)\n\n---\n\n#### 🧹 Cache & Redis Reset\n\nTo clear cache and Redis data:\n\n```\ndocker-compose exec redis redis-cli FLUSHALL\n```\n\n---\n\n### 🔄 Rebuild Steps\n\nWhen changes are made to `.env`, CSS, or assets:\n\n```\ndocker-compose down docker-compose build docker-compose run --rm rails bundle exec rails assets:precompile docker-compose up -d\n```\n\n---\n\n### 🔗 Helpful Commands\n\nTask Command\n\nRails Console `docker-compose exec rails rails c `\n\nLog Tail `docker-compose logs -f rails`\n\nRedis CLI `docker-compose exec redis redis-cli`\n\nSidekiq Logs `docker-compose logs -f sidekiq`\n\n---\n\n### 📤 Moving Files Between Server & Local\n\nTo copy assets from the container to your local machine:\n\n```\n# Copy from container to host docker cp chatwoot-rails-1:/app/public ./tmp/public # From host to local machine scp -r user@remote:/path/to/tmp/public ~/Desktop/Projects/docker/support/\n```\n\n---\n\n### ✅ Final Notes\n\n* Don't run `db:setup` unless you want a full reset\n\n* Use secure values for all `.env` secrets\n\n* Restart the app after major changes to `.env` or assets\n\n* For custom Help Centre, API access is available to render your own frontend	1	1	2025-06-06 02:45:26.021124	2025-06-06 02:49:04.520357	5	\N	{}	1749177926-chatwoot-self_hosted-installation-guide-docker	10	en
25	1	2	18	\N	Nextcloud (Cloud) Setup for Landing Pad Digital	\N	# Nextcloud (Cloud) Setup for Landing Pad Digital\n\n## Overview\n\nThis document outlines the infrastructure and configuration of the self-hosted Nextcloud instance (`cloud.landingpad.digital`), currently managed via Docker on our VPS. The setup includes persistent volumes, reverse proxy via Nginx, HTTPS with Let's Encrypt & a MariaDB backend.\n\n---\n\n## Stack Summary\n\nComponent | Technology | Notes \n\n* App  | Nextcloud | Official Docker image \n\n* Database | MariaDB 10.11 | Running in a separate container \n\n* Proxy | Nginx | Manual config with SSL and virtual hosts \n\n* SSL/TLS  | Certbot / Let's Encrypt  | Manually issued certificates\n\n* Domain  | `cloud.landingpad.digital`  | Managed via external DNS \n\n* Storage  | Docker Volumes  | Persisted across restarts \n\n* Network  |  Custom Docker Network  |  Isolated per app\n\n---\n\n## Docker Compose Configuration\n\n**File:** `~/docker/cloud/docker-compose.yml`\n\n```\nservices:\n  db:\n    image: mariadb:10.11\n    container_name: cloud_db_container\n    restart: always\n    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW\n    volumes:\n      - db:/var/lib/mysql\n    environment:\n      - MYSQL_ROOT_PASSWORD=HgqvQTcr2HRS\n      - MYSQL_PASSWORD=P1jWygQXzD0\n      - MYSQL_DATABASE=nextcloud\n      - MYSQL_USER=nextcloud\n    networks:\n      - nextcloud-net\n\n  app:\n    image: nextcloud\n    container_name: cloud_container\n    ports:\n      - "8082:80"\n    restart: always\n    depends_on:\n      - db\n    networks:\n      - nextcloud-net\n    volumes:\n      - cloud:/var/www/html\n    environment:\n      - MYSQL_PASSWORD=P1jWygQXzD0\n      - MYSQL_DATABASE=nextcloud\n      - MYSQL_USER=nextcloud\n      - MYSQL_HOST=db\n      - VIRTUAL_HOST=cloud.landingpad.digital\n      - LETSENCRYPT_HOST=cloud.landingpad.digital\n      - LETSENCRYPT_EMAIL=dev@landingpad.digital\n\nvolumes:\n  db:\n  cloud:\n\nnetworks:\n  nextcloud-net:\n```\n\n---\n\n## Nginx Configuration\n\n**File:** `/etc/nginx/sites-available/cloud.landingpad.digital`\n\n```\nserver {\n    listen 80;\n    server_name cloud.landingpad.digital;\n\n    location / {\n        proxy_pass http://localhost:8082;\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n        proxy_set_header X-Forwarded-Proto $scheme;\n    }\n}\n\nserver {\n    listen 443 ssl;\n    server_name cloud.landingpad.digital;\n\n    ssl_certificate /etc/letsencrypt/live/cloud.landingpad.digital/fullchain.pem;\n    ssl_certificate_key /etc/letsencrypt/live/cloud.landingpad.digital/privkey.pem;\n\n    location / {\n        proxy_pass http://localhost:8082;\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n        proxy_set_header X-Forwarded-Proto $scheme;\n    }\n}\n```\n\n**Commands:**\n\n```\nsudo ln -s /etc/nginx/sites-available/cloud.landingpad.digital /etc/nginx/sites-enabled/\nsudo nginx -t\nsudo systemctl restart nginx\n```\n\n---\n\n## SSL Certificate Setup\n\nWe manually issued certificates using Certbot:\n\n```\nsudo certbot certonly --nginx -d cloud.landingpad.digital \\\n  -m dev@landingpad.digital --agree-tos --no-eff-email\n```\n\nEnsure DNS points correctly before issuing.\n\n---\n\n## Admin Setup Note\n\nDuring initial setup, Nextcloud required admin user creation via web UI.\n\n**Common error fixed:**\n\nIf error like:\n\n```\nSQLSTATE[HY000] [2002] php_network_getaddresses: getaddrinfo for db failed\n```\n\nEnsure `MYSQL_HOST=db` in `docker-compose.yml` and service name is correct.\n\n---\n\n## Data Backup Plan (Suggested)\n\nUse a cronjob or n8n automation to:\n\n1. Dump MariaDB to `.sql`.\n\n2. Tar the `cloud` volume (Nextcloud data).\n\n3. Optionally upload to external S3/Drive using `rclone`.\n\n> Detailed script available upon request.\n\n---\n\n## Health Check\n\nCheck container status:\n\n```\ndocker ps | grep cloud\n```\n\nRestart containers:\n\n```\ndocker-compose down && docker-compose up -d\n```\n\n---\n\n## Useful Links\n\n* Nextcloud Docs: <https://docs.nextcloud.com/>\n\n* Let's Encrypt Docs: <https://letsencrypt.org/docs/>\n\n* n8n Integration: <https://n8n.io/integrations/nextcloud>	1	1	2025-06-13 11:29:22.868382	2025-06-13 11:42:57.586771	5	\N	{}	1749814162-cloud-setup	60	en
8	1	1	11	\N	Webhooks	\N	This is how Wikipedia defines webhooks: A webhook in web development is a method of augmenting or altering the behavior of a web page or web application with custom callbacks. These callbacks may be maintained, modified, and managed by third-party users and developers who may not necessarily be affiliated with the originating website or application.\n\nThere are two ways your apps can communicate for information: polling and webhooks. Polling is when you go asking the app for some information every time. Webhooks are when the app automatically sends the information over to a specific URL every time it's available.\n\nWebhooks are basically automated messages containing an information payload sent from Brizy Cloud when something happens. They are sent to a unique URL that you can set up.\n\nWebhooks are similar to APIs—but simpler. An API is a full language for an app with functions or calls to add, edit, and retrieve data. The difference is, with an API, you have to do the work yourself. If you build an application that connects to another with an API, your application will need to have ways to ask the other app for new data when it needs it.\n\nWebhooks, on the other hand, are for one specific part of an app, and they're automated. In other words, a webhook is a simple, one-to-one connection that runs automatically.\n\nIn Landing Pad Cloud we offer webhooks for all your Assets including custom Assets:\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBIQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f41d7553cc8ab17dba85af93291387fad34b4724/image.png)\n\nAnd Actions on Create, Update and Delete.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBIUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e27b395f5da410904925225ac9a5e9673c77acc9/image.png)\n\nThis means that when the [Asset] (Page, Blog, etc) is [Action] (Created, Updated, Deleted), we automatically send a payload with all the information for that specific Asset to your selected custom URL. \n\nThe information sent is signed and you can find the key on the Webhooks listing page.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBIZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--992b3344bc510ab4a3a8d9a5e2f8d4b242d0e800/image.png)\n\nYou use this signature ID to verify and validate that the data comes from us. 	1	\N	2025-06-04 08:20:43.476742	2025-06-04 08:25:49.355062	5	\N	{}	1749025243-webhooks	90	en
9	1	1	5	\N	How to create multiple pages for your website	\N	f you are not creating a landing page (one page), you'll want to know how to create multiple pages for your website. Here is how to do it:\n\n**Step 1**. In the builder, access the Settings from the left sidebar & go to Assets > Pages\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBIdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--44f88fa94c52077fa66f853c7582da444b3c6869/image.png)\n\n**Step 2**. Press the Add New Page button at the bottom to add a new page.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBJQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--635b95df82a1bb766a598f16ab4f89f7d8ec07de/image.png)\n\n**Step 3**. Press the Settings icon to edit the page title, the slug and SEO meta description.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBJUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--13eae583cf869f8551c7ff28d983d27e21d8997c/image.png)\n\n**Step 4**. Press the Edit Page icon to jump and edit that page.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBJZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b1f4c3c25b9ff3e61b21f7d97ce8255c82f39a3e/image.png)	1	\N	2025-06-04 08:29:32.514377	2025-06-04 08:30:27.239849	5	\N	{}	1749025772-how-to-create-multiple-pages-for-your-website	20	en
20	1	2	16	\N	API Documentation Reference	\N	This document outlines the main endpoints for interacting with the LPD Builder API. It covers all core modules and provides a summary of available operations. For in-depth details including parameters and example responses, refer to the official documentation:  \n[🔗 Landing Pad Builder API Docs](https://admin.landingpad-builder.cloud/api/doc/v2)\n\n---\n\n## Postman Collection\n\nWe maintain a curated Postman collection named [**`LPD_Builder_API`**](https://landingpaddigital.postman.co/workspace/LandingPadDigital's-Workspace\\~e715854d-787c-4d61-81db-f9d9eef47a6d/collection/45110238-3dfaedd2-02ac-4a2e-8b77-e6c9c4d2bcee) which includes ready-to-use examples for:\n\n* **GET** and **POST** requests\n\n* **Export project**\n\n* **Download project as ZIP**\n\n🔐 The password to access the collection is stored securely in [**Vault (Bitwarden)**](https://vault.bitwarden.com/#/vault?organizationId=05580724-a03d-4b36-aefe-b2a70041b6b3&itemId=d6accde8-568f-4502-8a12-b2e30048096d&action=view).\n\nThis collection is an excellent resource for developers to:\n\n* Quickly explore endpoints\n\n* Test requests with real data\n\n* Understand expected inputs and outputs\n\n---\n\n## API Modules & Endpoints\n\n### 🔹 Domain\n\n```\nGET /api/{version}/projects/{project}/domains \nPOST /api/{version}/projects/{project}/domains \nDELETE /api/{version}/projects/{project}/domains/{domain} \nPUT /api/{version}/projects/{project}/domains/{domain} \nGET /api/{version}/projects/{project}/domains/{domain}/dns\n```\n\n### 🔹 Media\n\n```\n\nDELETE /api/{version}/projects/{project}/media \nGET /api/{version}/projects/{project}/media\nPOST /api/{version}/projects/{project}/media \nGET /api/{version}/projects/{project}/media/{media}\nPATCH /api/{version}/projects/{project}/media/{media}\n```\n\n### 🔹 Page\n\n```\nGET /api/{version}/projects/{project}/pages \nPOST /api/{version}/projects/{project}/pages \nGET /api/{version}/projects/{project}/pages/{page}/html \nPOST /api/{version}/projects/{project}/pages/{page}/updates\n```\n\n### 🔹 Post\n\n```\nGET /api/{version}/projects/{project}/posts\n```\n\n### 🔹 Project\n\n```\nGET /api/{version}/projects \nPOST /api/{version}/projects \nDELETE /api/{version}/projects/{project} \nGET /api/{version}/projects/{project}\nPATCH /api/{version}/projects/{project}\n\n\nPOST /api/{version}/projects/{project}/duplicates\nGET /api/{version}/projects/{project}/html/download\nGET /api/{version}/projects/{project}/html/export\n\nGET /api/{version}/projects/{project}/leads/\nGET /api/{version}/projects/{project}/leads/export\n\nPATCH /api/{version}/projects/{project}/restore/\nGET /api/{version}/projects/{project}/sync/download\n```\n\n### 🔹 Team Member\n\n```\nGET /api/{version}/projects/{project}/team-members \nPOST /api/{version}/projects/{project}/team-members \nDELETE /api/{version}/projects/{project}/team-members/{member} \nPUT /api/{version}/projects/{project}/team-members/{member}\n\nGET /api/{version}/team-members \nPOST /api/{version}/team-members \nDELETE  /api/{version}/team_members/{team_member}\nPATCH /api/{version}/team_members/{team_member}\n```\n\n### 🔹 Template\n\n```\nGET /api/{version}/template_categories\nGET /api/{version}/templates\n```\n\n### 🔹 User\n\n```\nGET /api/{version}/users \nPOST /api/{version}/users \nDELETE /api/{version}/users/{id} \nGET /api/{version}/users/{id} \nPATCH /api/{version}/users/{id} \n```\n\n### 🔹 Webhook\n\n```\nGET /api/{version}/projects/{project}/webhooks \nPOST /api/{version}/projects/{project}/webhooks \nDELETE /api/{version}/projects/{project}/webhooks/{webhook} \nPATCH /api/{version}/projects/{project}/webhooks/{webhook}\n```\n\n### 🔹 Workspace\n\n```\nGET /api/{version}/workspaces \nPOST /api/{version}/workspaces \nGET /api/{version}/workspaces/count\nDELETE /api/{version}/workspaces/{workspace} \nPUT /api/{version}/workspaces/{workspace}\n```	1	4	2025-06-06 04:10:56.760035	2025-06-06 05:15:18.839836	5	\N	{}	1749183056-api-documentation-reference	40	en
10	1	1	5	\N	How to create a Menu and add pages into it	\N	You'll need a Menu on your multi page website. Here is how to create it:\n\n**Step 1**. Click the gear Settings icon in the left sidebar and go to Menu tab\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBJdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--01584a15b91735aced733353185259104e756a12/image.png)\n\n**Step 2**. Create a new menu. \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBKQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--0cddf6aa20af2df6f127a007eb723706a19b5e76/image.png)\n\n**Step 3**. Select the pages you want in your Menu and press the Add to Menu button \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBKUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--62964859304fe43a352eee91c0f9b9c84e88a967/image.png)\n\n**Step 4**. Drag and drop pages to reorder or create dropdown menus  \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBKZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--7ee664bde762345873f9051d703b7bf1e382ae6e/image.png)\n\n**Step 5**. Click the Settings icon to edit Navigation Label and more.\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBKdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--ac33eb20fb0557ca4bad34df14aea6313e0f1665/image.png)	1	\N	2025-06-04 08:30:42.892544	2025-06-04 08:31:41.096705	5	\N	{}	1749025842-how-to-create-a-menu-and-add-pages-into-it	30	en
11	1	1	5	\N	How to add a Menu element on your page	\N	Once you [create the pages](https://support.brizy.io/hc/en-us/articles/360042155751) and [add them in a menu](https://support.brizy.io/hc/en-us/articles/360042156511), you'll want to add that menu on your pages on your website. Here is how to do it:\n\n**Step 1**. Locate the Menu element in the builder\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBLQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e092cf319c3b2f1a37e3fea7f9aa21df4032bd8b/image.png)\n\n**Step 2**. Drag the Menu element on the page\n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBLUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--dc5c8be803da812a39c4ab58b22d56692f51c2b5/image.png)\n\n**Step 3**. In the Menu element options, select the menu you want to display. \n\n![](https://support.landingpad.digital/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBLZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f4393e513a8a4415fcc77c2404462bd3d4abb68c/image.png)\n\n**Important:** If the name of your menu doesn't appear in the list, update your page and hit a refresh, then try again.	1	\N	2025-06-04 08:31:57.742361	2025-06-04 08:33:03.535356	5	\N	{}	1749025917-how-to-add-a-menu-element-on-your-page	40	en
14	1	1	1	\N	Landing Pad Roadmap	\N	**Transparency, progress, and your voice—all in one place.**  \n[**View the Public Roadmap on Trello →**](https://trello.com/b/LwVXo2ZA/landing-pad-roadmap)\n\nWe’re thrilled to introduce our **public roadmap** for Landing Pad: an open window into what we’re building, improving and dreaming up next. This is our way of staying connected with you, our users and making sure you’re always in the loop about what’s coming down the runway.\n\n## 🚀 Why a Public Roadmap?\n\nOur goal is to keep you informed and involved. Whether you're an active user, a curious observer or someone considering joining us, we want you to see what we’re working on and what you can expect in the near future.\n\n## 🛠 How It Works\n\nThe roadmap lives on Trello and is divided into clear and easy-to-follow columns that reflect our current development journey:\n\n### 💡 Suggest a Feature\n\nGot a brilliant idea? We'd love to hear it.  \nThis is where we collect fresh feature ideas and wishlist items. Nothing is too small or too big to be considered.  \n👉 **You can vote directly on Trello** to help us prioritise what matters most to you!\n\n### 🧭 Queue\n\nThis column shows what’s queued for development.  \nFeatures in this stage have been greenlit and are being shaped up for the next sprint. Exciting times ahead!\n\n### 🔧 In Progress\n\nThese items are actively being worked on by our development team.  \nIt’s the “we’re building this right now” column: so you can see what’s close to launch.\n\n### ✅ Done\n\nHere you’ll find the features and improvements that are already available in Landing Pad.  \nWe’re proud of the progress we've made and always appreciate your feedback on what’s live.\n\n---\n\n## 🗳️ Help Us Prioritise\n\nYour input directly influences what we build next. Simply visit the [**Trello board**](https://trello.com/b/LwVXo2ZA/landing-pad-roadmap), explore the cards and **vote on the features you care about most**. Want to share an idea that’s not on the board yet? Feel free to drop us a message through our support channel.\n\n---\n\n## 💬 We’d Love Your Feedback\n\nThis roadmap is a living, breathing space: just like our product. If you have thoughts, suggestions or even questions about any item, please don’t hesitate to reach out.\n\nWe’re building **Landing Pad** with you & for you. Thank you for being part of the journey!\n\nWith gratitude 🙏  \nThe Landing Pad Team 🚀	1	\N	2025-06-05 06:57:28.464293	2025-06-05 07:02:22.052405	5	\N	{}	1749106648-landing-pad-public-roadmap	10	en
21	1	2	17	\N	N8N Integration Guide	\N	This documentation explains how to properly configure n8n with OAuth2 providers (like Google) when running behind an Nginx reverse proxy.\n\n---\n\n## **1. Prerequisites**\n\n* Running n8n instance (**`docker-compose`** recommended)\n\n* Nginx as reverse proxy with SSL (Let's Encrypt)\n\n* Registered OAuth app with your provider (Google, GitHub, etc.)\n\n* Domain pointing to your server (e.g., **`n8n.yourdomain.com`**)\n\n---\n\n## **2. Core Configuration**\n\n### **A. n8n Environment Variables (`.env`)**\n\nEnsure these are set in your **`docker-compose.yml`** or **`.env`** file:\n\n```\n# Base URL (MUST match your public domain)\nN8N_HOST=n8n.yourdomain.com\nN8N_PORT=5678\nN8N_PROTOCOL=https\n\n# OAuth Callback URL (NO port number)\nWEBHOOK_URL=https://n8n.yourdomain.com\n\n# Security (required for OAuth)\nN8N_SECURE_COOKIE=true\nVUE_APP_URL_BASE_API=https://n8n.yourdomain.com\n```\n\n### **B. Docker-Compose Example**\n\n```\nservices:\n  n8n:\n    image: n8nio/n8n\n    environment:\n      - N8N_HOST=${N8N_HOST}\n      - N8N_PORT=${N8N_PORT}\n      - N8N_PROTOCOL=https\n      - WEBHOOK_URL=${WEBHOOK_URL}\n      - N8N_SECURE_COOKIE=true\n    ports:\n      - "5678:5678"\n    volumes:\n      - ~/.n8n:/home/node/.n8n\n```\n\n---\n\n## **3. Nginx Reverse Proxy Setup**\n\n### **A. Required Headers**\n\n```\nserver {\n    server_name n8n.yourdomain.com;\n\n    location / {\n        proxy_pass http://localhost:5678;\n        \n        # Critical headers for OAuth\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n        proxy_set_header X-Forwarded-Proto $scheme;\n\n        # WebSocket support (for real-time features)\n        proxy_http_version 1.1;\n        proxy_set_header Upgrade $http_upgrade;\n        proxy_set_header Connection "upgrade";\n    }\n\n    # SSL configuration (Let's Encrypt)\n    listen 443 ssl;\n    ssl_certificate /etc/letsencrypt/live/n8n.yourdomain.com/fullchain.pem;\n    ssl_certificate_key /etc/letsencrypt/live/n8n.yourdomain.com/privkey.pem;\n    include /etc/letsencrypt/options-ssl-nginx.conf;\n    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;\n}\n\n# HTTP → HTTPS redirect\nserver {\n    listen 80;\n    server_name n8n.yourdomain.com;\n    return 301 https://$host$request_uri;\n}\n```\n\n### **B. Apply & Test**\n\n```\nsudo nginx -t && sudo systemctl restart nginx\n```\n\n---\n\n## **4. OAuth Provider Setup (Google Example)**\n\n### **A. Google Cloud Console Steps**\n\n1. Go to [**Google Cloud Console**](https://console.cloud.google.com/)\n\n2. Navigate to **APIs & Services → Credentials**\n\n3. Under **OAuth consent screen**:\n\n   * Add **`https://n8n.yourdomain.com`** to **Authorized domains**\n\n4. Under **Credentials**:\n\n   * Add to **Authorized redirect URIs**:\n\n     text\n\n     Copy\n\n     Download\n\n     ```\n     https://n8n.yourdomain.com/rest/oauth2-credential/callback\n     ```\n\n   * Add to **Authorized JavaScript origins**:\n\n     text\n\n     Copy\n\n     Download\n\n     ```\n     https://n8n.yourdomain.com\n     ```\n\n### **B. Common Mistakes**\n\n❌ **Incorrect callback URL**\n\n* **Wrong**: **`https://n8n.yourdomain.com:5678/rest/oauth2-credential/callback`**\n\n* **Correct**: **`https://n8n.yourdomain.com/rest/oauth2-credential/callback`**\n\n❌ **Missing `X-Forwarded-Proto`**\n\n* Nginx **must** pass the HTTPS scheme to n8n.\n\n❌ **Self-signed certificates**\n\n* Google OAuth **requires valid SSL** (use Let’s Encrypt).\n\n---\n\n## **5. Debugging OAuth Issues**\n\n### **A. Check n8n Logs**\n\n```\ndocker-compose logs -f | grep -i oauth\n```\n\n### **B. Verify Headers**\n\n```\ncurl -I https://n8n.yourdomain.com/rest/oauth2-credential/callback\n```\n\nLook for:\n\n```\nX-Forwarded-Proto: https\nHost: n8n.yourdomain.com\n```\n\n### **C. Test Manually**\n\n1. Open Chrome Incognito → Dev Tools (F12)\n\n2. Attempt OAuth login while monitoring:\n\n   * **Network tab** for **`401`** errors\n\n   * **Console tab** for CORS issues\n\n---\n\n## **6. Final Checklist**\n\n✅ **n8n config** uses public domain (no **`:5678`** in URLs)  \n✅ **Nginx** forwards **`X-Forwarded-Proto`** and **`Host`** correctly  \n✅ **Google OAuth** has exact callback URL (HTTPS, no port)  \n✅ **No mixed content** (all resources load via HTTPS)  \n✅ **Time sync** between server and Docker container\n\n---\n\n## **Appendix: Reset Everything**\n\n```\n# Wipe n8n data (careful!)\ndocker-compose down -v\nrm -rf ~/.n8n/*\n\n# Restart fresh\ndocker-compose up -d\n```\n\n---\n\n**Need Help?**\n\n* Check [n8n OAuth Docs](https://docs.n8n.io/integrations/oauth/)\n\n* Access[ ](https://n8n.io/slack)[n8n Landing Pad Smart Automations](https://n8n.landingpad.digital/)	1	\N	2025-06-06 11:02:08.711326	2025-06-06 11:05:37.826504	5	\N	{}	1749207728-n8_n-o_auth-integration-guide	40	en
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.attachments (id, file_type, external_url, coordinates_lat, coordinates_long, message_id, account_id, created_at, updated_at, fallback_title, extension, meta) FROM stdin;
\.


--
-- Data for Name: audits; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.audits (id, auditable_id, auditable_type, associated_id, associated_type, user_id, user_type, username, action, audited_changes, version, comment, remote_address, request_uuid, created_at) FROM stdin;
1	1	AccountUser	1	Account	\N	\N	\N	create	{"role": 1, "user_id": 5, "account_id": 1, "inviter_id": null, "availability": 0}	1	\N	171.4.217.6	298465c1-8f43-4fd6-aeb7-afe834198552	2025-06-04 04:48:06.091881
2	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	1	\N	171.4.217.6	9fce6539-f9a7-4156-ab3b-784e6df7cfd1	2025-06-04 04:48:41.073298
3	1	Account	1	Account	5	User	support@landingpad.digital	update	{"name": ["Landing Pad Digital", "Landing Pad Support Account"], "feature_flags": [5222713261967, 4398079541127]}	1	\N	171.4.217.6	5a1da2e8-bf10-40ed-88ff-ebbf43ed3da3	2025-06-04 04:49:46.335229
4	1	Inbox	1	Account	5	User	support@landingpad.digital	create	{"name": "Landing Pad", "timezone": "UTC", "portal_id": null, "account_id": 1, "channel_id": 1, "csat_config": {}, "channel_type": "Channel::WebWidget", "business_name": null, "email_address": null, "greeting_enabled": false, "greeting_message": "", "sender_name_type": 0, "csat_survey_enabled": false, "enable_email_collect": true, "out_of_office_message": null, "working_hours_enabled": false, "auto_assignment_config": {}, "enable_auto_assignment": true, "lock_to_single_conversation": false, "allow_messages_after_resolved": true}	1	\N	171.4.217.6	f81b1921-caba-4522-b1dd-d8a5344af7dd	2025-06-04 05:13:13.246966
5	1	InboxMember	1	Account	5	User	support@landingpad.digital	create	{"id": 1, "user_id": 5, "inbox_id": 1}	1	\N	171.4.217.6	0f878c17-4b66-40a8-b5f4-cd8b3b36eb16	2025-06-04 05:13:26.508212
6	1	Inbox	1	Account	5	User	support@landingpad.digital	update	{"business_name": [null, "support@landingpad.digital"]}	2	\N	171.4.217.6	669c6516-7299-4879-9c4f-217aa1fa3b32	2025-06-04 05:13:52.178451
7	1	Inbox	1	Account	5	User	support@landingpad.digital	update	{"portal_id": [null, 1]}	3	\N	171.4.217.6	1b101f3e-c552-44f2-b662-718c70b13b9b	2025-06-04 05:14:01.890538
8	1	Inbox	1	Account	5	User	support@landingpad.digital	update	{"timezone": ["UTC", "Asia/Bangkok"], "out_of_office_message": [null, ""], "working_hours_enabled": [false, true]}	4	\N	171.4.217.6	5bed8f52-59fa-4130-b0ae-2a152e3d2edf	2025-06-04 05:14:33.168125
9	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	2	\N	171.4.217.6	680da4a8-46c1-46bc-9b80-1a77437c0403	2025-06-04 09:37:00.706349
10	5	User	1	Account	5	User	support@landingpad.digital	sign_out	\N	3	\N	171.4.217.6	95e73c09-d0db-43d4-85a6-7346a55837e8	2025-06-04 09:39:53.394473
11	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	4	\N	171.4.217.6	3fbba023-6e00-46fe-8331-dcfcb0e50dad	2025-06-04 09:40:11.390291
12	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	5	\N	171.4.217.6	3a9cc8c3-e0b0-4cb7-a217-54c13c776f70	2025-06-04 09:52:39.831101
13	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	6	\N	171.4.217.6	0a2d7229-4574-4e20-8910-310931a66dd1	2025-06-04 10:05:47.592897
14	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	7	\N	171.4.250.227	d5798ead-f4eb-43a8-b83e-a2e5d8fed5c2	2025-06-12 10:49:59.819387
15	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	8	\N	171.4.219.229	9a215550-d1ff-4f75-a6d6-173629c77636	2025-06-24 06:30:29.954728
16	5	User	1	Account	5	User	support@landingpad.digital	sign_in	\N	9	\N	171.4.219.229	4e50ccdb-150d-45f3-b2b0-28ea3fe77cc1	2025-06-24 06:30:49.272331
\.


--
-- Data for Name: automation_rules; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.automation_rules (id, account_id, name, description, event_name, conditions, actions, created_at, updated_at, active) FROM stdin;
\.


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.campaigns (id, display_id, title, description, message, sender_id, enabled, account_id, inbox_id, trigger_rules, created_at, updated_at, campaign_type, campaign_status, audience, scheduled_at, trigger_only_during_business_hours) FROM stdin;
\.


--
-- Data for Name: canned_responses; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.canned_responses (id, account_id, short_code, content, created_at, updated_at) FROM stdin;
4	1	busy	We're sorry, but all of our agents are busy right now. One of them will be with you as soon as possible.	2025-06-11 05:03:06.341993	2025-06-11 05:03:06.341993
2	1	hi	Hi, My name is [your name]. How can I help you today?	2025-06-11 05:02:12.591958	2025-06-11 05:03:21.395307
3	1	hi-again	Hi [customer name]. Nice to see you again! How can I help you today?	2025-06-11 05:02:41.0523	2025-06-11 05:03:30.418516
5	1	angry	I apologise for the experience. I have raised a ticket for that. Please wait for the next email from us.	2025-06-11 05:04:35.087093	2025-06-11 05:04:35.087093
\.


--
-- Data for Name: captain_assistant_responses; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.captain_assistant_responses (id, question, answer, embedding, assistant_id, documentable_id, account_id, created_at, updated_at, status, documentable_type) FROM stdin;
\.


--
-- Data for Name: captain_assistants; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.captain_assistants (id, name, account_id, description, created_at, updated_at, config) FROM stdin;
\.


--
-- Data for Name: captain_documents; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.captain_documents (id, name, external_link, content, assistant_id, account_id, created_at, updated_at, status) FROM stdin;
\.


--
-- Data for Name: captain_inboxes; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.captain_inboxes (id, captain_assistant_id, inbox_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.categories (id, account_id, portal_id, name, description, "position", created_at, updated_at, locale, slug, parent_category_id, associated_category_id, icon) FROM stdin;
1	1	1	Website Builder		\N	2025-06-04 08:02:15.147638	2025-06-04 08:02:15.147638	en	website-builder	\N	\N	
2	1	1	AI Website Builder		\N	2025-06-04 08:02:25.980227	2025-06-04 08:02:25.980227	en	ai-website-builder	\N	\N	
3	1	1	The Dashboard		\N	2025-06-04 08:23:28.850645	2025-06-04 08:23:28.850645	en	dashboard	\N	\N	
4	1	1	Publishing		\N	2025-06-04 08:23:40.361992	2025-06-04 08:23:40.361992	en	publishing	\N	\N	
5	1	1	Navigation		\N	2025-06-04 08:23:51.167591	2025-06-04 08:23:51.167591	en	navigation	\N	\N	
6	1	1	Settings		\N	2025-06-04 08:24:12.29261	2025-06-04 08:24:12.29261	en	settings	\N	\N	
7	1	1	Blogging		\N	2025-06-04 08:24:18.480123	2025-06-04 08:24:18.480123	en	blogging	\N	\N	
8	1	1	Projects		\N	2025-06-04 08:24:25.460361	2025-06-04 08:24:25.460361	en	projects	\N	\N	
9	1	1	Advanced Custom Fields & Assets		\N	2025-06-04 08:24:34.90462	2025-06-04 08:24:34.90462	en	advanced-custom-fields-assets	\N	\N	
10	1	1	Web Stories		\N	2025-06-04 08:24:42.701047	2025-06-04 08:24:42.701047	en	web-stories	\N	\N	
11	1	1	Form Integrations		\N	2025-06-04 08:24:50.739484	2025-06-04 08:24:50.739484	en	form-integrations	\N	\N	
13	1	2	Stripe		\N	2025-06-05 08:18:36.434761	2025-06-05 08:18:36.434761	en	stripe	\N	\N	
14	1	2	Analytics	Delivered via Matomo	\N	2025-06-06 02:27:17.156706	2025-06-06 02:27:54.898593	en	analytics	\N	\N	
15	1	2	Support	Delivered via Chatwoot	\N	2025-06-06 02:27:34.474813	2025-06-06 02:28:13.342514	en	support	\N	\N	
16	1	2	API		\N	2025-06-06 03:54:31.063063	2025-06-06 03:54:31.063063	en	api	\N	\N	
17	1	2	Automation		\N	2025-06-06 11:03:32.915293	2025-06-06 11:03:32.915293	en	automation	\N	\N	
18	1	2	Infrastructure		\N	2025-06-09 04:32:01.245605	2025-06-09 04:32:01.245605	en	infrastructure	\N	\N	
\.


--
-- Data for Name: channel_api; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_api (id, account_id, webhook_url, created_at, updated_at, identifier, hmac_token, hmac_mandatory, additional_attributes) FROM stdin;
\.


--
-- Data for Name: channel_email; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_email (id, account_id, email, forward_to_email, created_at, updated_at, imap_enabled, imap_address, imap_port, imap_login, imap_password, imap_enable_ssl, smtp_enabled, smtp_address, smtp_port, smtp_login, smtp_password, smtp_domain, smtp_enable_starttls_auto, smtp_authentication, smtp_openssl_verify_mode, smtp_enable_ssl_tls, provider_config, provider) FROM stdin;
\.


--
-- Data for Name: channel_facebook_pages; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_facebook_pages (id, page_id, user_access_token, page_access_token, account_id, created_at, updated_at, instagram_id) FROM stdin;
\.


--
-- Data for Name: channel_instagram; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_instagram (id, access_token, expires_at, account_id, instagram_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: channel_line; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_line (id, account_id, line_channel_id, line_channel_secret, line_channel_token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: channel_sms; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_sms (id, account_id, phone_number, provider, provider_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: channel_telegram; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_telegram (id, bot_name, account_id, bot_token, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: channel_twilio_sms; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_twilio_sms (id, phone_number, auth_token, account_sid, account_id, created_at, updated_at, medium, messaging_service_sid, api_key_sid) FROM stdin;
\.


--
-- Data for Name: channel_twitter_profiles; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_twitter_profiles (id, profile_id, twitter_access_token, twitter_access_token_secret, account_id, created_at, updated_at, tweets_enabled) FROM stdin;
\.


--
-- Data for Name: channel_web_widgets; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_web_widgets (id, website_url, account_id, created_at, updated_at, website_token, widget_color, welcome_title, welcome_tagline, feature_flags, reply_time, hmac_token, pre_chat_form_enabled, pre_chat_form_options, hmac_mandatory, continuity_via_email) FROM stdin;
1	landingpad.digital	1	2025-06-04 05:13:13.19817	2025-06-04 05:13:13.19817	8TxSxxjnmFRuUAErvtoDg9Wy	#009CE0	Hiya!	We make it simple to connect with us. Ask us anything, or share your feedback.	7	0	eVYb4zWk2ptEMyw4qpcTUrcd	f	{"pre_chat_fields": [{"name": "emailAddress", "type": "email", "label": "Email Id", "enabled": false, "required": true, "field_type": "standard"}, {"name": "fullName", "type": "text", "label": "Full name", "enabled": false, "required": false, "field_type": "standard"}, {"name": "phoneNumber", "type": "text", "label": "Phone number", "enabled": false, "required": false, "field_type": "standard"}], "pre_chat_message": "Share your queries or comments here."}	f	t
\.


--
-- Data for Name: channel_whatsapp; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.channel_whatsapp (id, account_id, phone_number, provider, provider_config, created_at, updated_at, message_templates, message_templates_last_updated) FROM stdin;
\.


--
-- Data for Name: contact_inboxes; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.contact_inboxes (id, contact_id, inbox_id, source_id, created_at, updated_at, hmac_verified, pubsub_token) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.contacts (id, name, email, phone_number, account_id, created_at, updated_at, additional_attributes, identifier, custom_attributes, last_activity_at, contact_type, middle_name, last_name, location, country_code, blocked) FROM stdin;
\.


--
-- Data for Name: conversation_participants; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.conversation_participants (id, account_id, user_id, conversation_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.conversations (id, account_id, inbox_id, status, assignee_id, created_at, updated_at, contact_id, display_id, contact_last_seen_at, agent_last_seen_at, additional_attributes, contact_inbox_id, uuid, identifier, last_activity_at, team_id, campaign_id, snoozed_until, custom_attributes, assignee_last_seen_at, first_reply_created_at, priority, sla_policy_id, waiting_since, cached_label_list) FROM stdin;
\.


--
-- Data for Name: copilot_messages; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.copilot_messages (id, copilot_thread_id, user_id, account_id, message_type, message, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: copilot_threads; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.copilot_threads (id, title, user_id, account_id, uuid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: csat_survey_responses; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.csat_survey_responses (id, account_id, conversation_id, message_id, rating, feedback_message, contact_id, assigned_agent_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: custom_attribute_definitions; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.custom_attribute_definitions (id, attribute_display_name, attribute_key, attribute_display_type, default_value, attribute_model, account_id, created_at, updated_at, attribute_description, attribute_values, regex_pattern, regex_cue) FROM stdin;
\.


--
-- Data for Name: custom_filters; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.custom_filters (id, name, filter_type, query, account_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: custom_roles; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.custom_roles (id, name, description, account_id, permissions, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dashboard_apps; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.dashboard_apps (id, title, content, account_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: data_imports; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.data_imports (id, account_id, data_type, status, processing_errors, total_records, processed_records, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_templates; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.email_templates (id, name, body, account_id, template_type, locale, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.folders (id, account_id, category_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: inbox_members; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.inbox_members (id, user_id, inbox_id, created_at, updated_at) FROM stdin;
1	5	1	2025-06-04 05:13:26.490911	2025-06-04 05:13:26.490911
\.


--
-- Data for Name: inboxes; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.inboxes (id, channel_id, account_id, name, created_at, updated_at, channel_type, enable_auto_assignment, greeting_enabled, greeting_message, email_address, working_hours_enabled, out_of_office_message, timezone, enable_email_collect, csat_survey_enabled, allow_messages_after_resolved, auto_assignment_config, lock_to_single_conversation, portal_id, sender_name_type, business_name, csat_config) FROM stdin;
1	1	1	Landing Pad	2025-06-04 05:13:13.220658	2025-06-04 10:10:00.621004	Channel::WebWidget	t	f		\N	t		Asia/Bangkok	t	f	t	{}	f	1	0	support@landingpad.digital	{}
\.


--
-- Data for Name: installation_configs; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.installation_configs (id, name, serialized_value, created_at, updated_at, locked) FROM stdin;
1	INSTALLATION_NAME	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: Chatwoot\\n"	2025-06-02 10:43:04.245457	2025-06-02 10:43:04.245457	t
2	LOGO_THUMBNAIL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: \\"/brand-assets/logo_thumbnail.svg\\"\\n"	2025-06-02 10:43:04.250889	2025-06-02 10:43:04.250889	t
3	LOGO	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: \\"/brand-assets/logo.svg\\"\\n"	2025-06-02 10:43:04.255147	2025-06-02 10:43:04.255147	t
4	LOGO_DARK	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: \\"/brand-assets/logo_dark.svg\\"\\n"	2025-06-02 10:43:04.259533	2025-06-02 10:43:04.259533	t
5	BRAND_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: https://www.chatwoot.com\\n"	2025-06-02 10:43:04.262929	2025-06-02 10:43:04.262929	t
6	WIDGET_BRAND_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: https://www.chatwoot.com\\n"	2025-06-02 10:43:04.266066	2025-06-02 10:43:04.266066	t
7	BRAND_NAME	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: Chatwoot\\n"	2025-06-02 10:43:04.269652	2025-06-02 10:43:04.269652	t
8	TERMS_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: https://www.chatwoot.com/terms-of-service\\n"	2025-06-02 10:43:04.27295	2025-06-02 10:43:04.27295	t
9	PRIVACY_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: https://www.chatwoot.com/privacy-policy\\n"	2025-06-02 10:43:04.276136	2025-06-02 10:43:04.276136	t
10	DISPLAY_MANIFEST	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: true\\n"	2025-06-02 10:43:04.27889	2025-06-02 10:43:04.27889	t
11	ENABLE_ACCOUNT_SIGNUP	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: false\\n"	2025-06-02 10:43:04.281568	2025-06-02 10:43:04.281568	f
12	CREATE_NEW_ACCOUNT_FROM_DASHBOARD	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: false\\n"	2025-06-02 10:43:04.284285	2025-06-02 10:43:04.284285	f
13	HCAPTCHA_SITE_KEY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.287285	2025-06-02 10:43:04.287285	f
14	HCAPTCHA_SERVER_KEY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.290365	2025-06-02 10:43:04.290365	f
15	INSTALLATION_EVENTS_WEBHOOK_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.293214	2025-06-02 10:43:04.293214	f
16	DIRECT_UPLOADS_ENABLED	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: false\\n"	2025-06-02 10:43:04.320103	2025-06-02 10:43:04.320103	f
17	MAILER_INBOUND_EMAIL_DOMAIN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.323939	2025-06-02 10:43:04.323939	f
18	MAILER_SUPPORT_EMAIL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.326814	2025-06-02 10:43:04.326814	f
19	FB_APP_ID	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.330747	2025-06-02 10:43:04.330747	f
20	FB_VERIFY_TOKEN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.333502	2025-06-02 10:43:04.333502	f
21	FB_APP_SECRET	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.336383	2025-06-02 10:43:04.336383	f
22	IG_VERIFY_TOKEN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.339679	2025-06-02 10:43:04.339679	f
23	FACEBOOK_API_VERSION	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: v17.0\\n"	2025-06-02 10:43:04.343052	2025-06-02 10:43:04.343052	f
24	ENABLE_MESSENGER_CHANNEL_HUMAN_AGENT	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: false\\n"	2025-06-02 10:43:04.345785	2025-06-02 10:43:04.345785	f
25	AZURE_APP_ID	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.348686	2025-06-02 10:43:04.348686	f
26	AZURE_APP_SECRET	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.352048	2025-06-02 10:43:04.352048	f
27	CAPTAIN_OPEN_AI_API_KEY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.354905	2025-06-02 10:43:04.354905	f
28	CAPTAIN_OPEN_AI_MODEL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.357645	2025-06-02 10:43:04.357645	f
29	CAPTAIN_FIRECRAWL_API_KEY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.360764	2025-06-02 10:43:04.360764	f
30	CAPTAIN_CLOUD_PLAN_LIMITS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.363565	2025-06-02 10:43:04.363565	t
31	CHATWOOT_INBOX_TOKEN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.366513	2025-06-02 10:43:04.366513	f
32	CHATWOOT_INBOX_HMAC_KEY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.369631	2025-06-02 10:43:04.369631	f
33	CHATWOOT_CLOUD_PLANS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.373429	2025-06-02 10:43:04.373429	t
34	CHATWOOT_CLOUD_PLAN_FEATURES	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.376272	2025-06-02 10:43:04.376272	t
35	DEPLOYMENT_ENV	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: self-hosted\\n"	2025-06-02 10:43:04.379226	2025-06-02 10:43:04.379226	t
36	ANALYTICS_TOKEN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.382193	2025-06-02 10:43:04.382193	t
37	CLEARBIT_API_KEY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.385714	2025-06-02 10:43:04.385714	t
38	DASHBOARD_SCRIPTS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.38851	2025-06-02 10:43:04.38851	t
39	BLOCKED_EMAIL_DOMAINS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.391149	2025-06-02 10:43:04.391149	t
40	INACTIVE_WHATSAPP_NUMBERS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: ''\\n"	2025-06-02 10:43:04.394096	2025-06-02 10:43:04.394096	t
41	INSTALLATION_PRICING_PLAN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: community\\n"	2025-06-02 10:43:04.396939	2025-06-02 10:43:04.396939	t
42	INSTALLATION_PRICING_PLAN_QUANTITY	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: 0\\n"	2025-06-02 10:43:04.400192	2025-06-02 10:43:04.400192	t
46	ACCOUNT_SECURITY_NOTIFICATION_WEBHOOK_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.413118	2025-06-02 10:43:04.413118	t
47	API_CHANNEL_NAME	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.416671	2025-06-02 10:43:04.416671	t
48	API_CHANNEL_THUMBNAIL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.419712	2025-06-02 10:43:04.419712	t
49	LOGOUT_REDIRECT_LINK	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: \\"/app/login\\"\\n"	2025-06-02 10:43:04.422621	2025-06-02 10:43:04.422621	f
50	DISABLE_USER_PROFILE_UPDATE	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: false\\n"	2025-06-02 10:43:04.425246	2025-06-02 10:43:04.425246	f
44	CHATWOOT_SUPPORT_SCRIPT_URL	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: https://app.chatwoot.com\\n"	2025-06-02 10:43:04.407326	2025-06-02 12:00:10.827212	t
51	FIREBASE_PROJECT_ID	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.428022	2025-06-02 10:43:04.428022	f
52	FIREBASE_CREDENTIALS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.432238	2025-06-02 10:43:04.432238	f
53	LINEAR_CLIENT_ID	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.43552	2025-06-02 10:43:04.43552	f
54	LINEAR_CLIENT_SECRET	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.439078	2025-06-02 10:43:04.439078	f
55	SHOPIFY_CLIENT_ID	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.443469	2025-06-02 10:43:04.443469	f
56	SHOPIFY_CLIENT_SECRET	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.446199	2025-06-02 10:43:04.446199	f
57	INSTAGRAM_APP_ID	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.448897	2025-06-02 10:43:04.448897	f
58	INSTAGRAM_APP_SECRET	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.451847	2025-06-02 10:43:04.451847	f
59	INSTAGRAM_VERIFY_TOKEN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n"	2025-06-02 10:43:04.455517	2025-06-02 10:43:04.455517	f
60	ENABLE_INSTAGRAM_CHANNEL_HUMAN_AGENT	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: false\\n"	2025-06-02 10:43:04.458853	2025-06-02 10:43:04.458853	f
61	INSTAGRAM_API_VERSION	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: v22.0\\n"	2025-06-02 10:43:04.462081	2025-06-02 10:43:04.462081	t
62	ACCOUNT_LEVEL_FEATURE_DEFAULTS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue:\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: inbound_emails\\n  display_name: Inbound Emails\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: channel_email\\n  display_name: Email Channel\\n  enabled: true\\n  help_url: https://chwt.app/hc/email\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: channel_facebook\\n  display_name: Facebook Channel\\n  enabled: true\\n  help_url: https://chwt.app/hc/fb\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: channel_twitter\\n  display_name: Twitter Channel\\n  enabled: true\\n  deprecated: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: ip_lookup\\n  display_name: IP Lookup\\n  enabled: false\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: disable_branding\\n  display_name: Disable Branding\\n  enabled: false\\n  premium: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: email_continuity_on_api_channel\\n  display_name: Email Continuity on API Channel\\n  enabled: false\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: help_center\\n  display_name: Help Center\\n  enabled: true\\n  help_url: https://chwt.app/hc/help-center\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: agent_bots\\n  display_name: Agent Bots\\n  enabled: true\\n  help_url: https://chwt.app/hc/agent-bots\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: macros\\n  display_name: Macros\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: agent_management\\n  display_name: Agent Management\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: team_management\\n  display_name: Team Management\\n  enabled: true\\n  help_url: https://chwt.app/hc/teams\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: inbox_management\\n  display_name: Inbox Management\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: labels\\n  display_name: Labels\\n  enabled: true\\n  help_url: https://chwt.app/hc/labels\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: custom_attributes\\n  display_name: Custom Attributes\\n  enabled: true\\n  help_url: https://chwt.app/hc/custom-attributes\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: automations\\n  display_name: Automations\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: canned_responses\\n  display_name: Canned Responses\\n  enabled: true\\n  help_url: https://chwt.app/hc/canned\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: integrations\\n  display_name: Integrations\\n  enabled: true\\n  help_url: https://chwt.app/hc/integrations\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: voice_recorder\\n  display_name: Voice Recorder\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: mobile_v2\\n  display_name: Mobile App V2\\n  enabled: false\\n  deprecated: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: channel_website\\n  display_name: Website Channel\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: campaigns\\n  display_name: Campaigns\\n  enabled: true\\n  help_url: https://chwt.app/hc/campaigns\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: reports\\n  display_name: Reports\\n  enabled: true\\n  help_url: https://chwt.app/hc/reports\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: crm\\n  display_name: CRM\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: auto_resolve_conversations\\n  display_name: Auto Resolve Conversations\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: custom_reply_email\\n  display_name: Custom Reply Email\\n  enabled: false\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: custom_reply_domain\\n  display_name: Custom Reply Domain\\n  enabled: false\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: audit_logs\\n  display_name: Audit Logs\\n  enabled: false\\n  premium: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: response_bot\\n  display_name: Response Bot\\n  enabled: false\\n  premium: true\\n  deprecated: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: message_reply_to\\n  display_name: Message Reply To\\n  enabled: false\\n  help_url: https://chwt.app/hc/reply-to\\n  deprecated: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: insert_article_in_reply\\n  display_name: Insert Article in Reply\\n  enabled: false\\n  deprecated: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: inbox_view\\n  display_name: Inbox View\\n  enabled: false\\n  chatwoot_internal: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: sla\\n  display_name: SLA\\n  enabled: false\\n  premium: true\\n  help_url: https://chwt.app/hc/sla\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: help_center_embedding_search\\n  display_name: Help Center Embedding Search\\n  enabled: false\\n  premium: true\\n  chatwoot_internal: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: linear_integration\\n  display_name: Linear Integration\\n  enabled: false\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: captain_integration\\n  display_name: Captain\\n  enabled: false\\n  premium: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: custom_roles\\n  display_name: Custom Roles\\n  enabled: false\\n  premium: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: chatwoot_v4\\n  display_name: Chatwoot V4\\n  enabled: false\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: report_v4\\n  display_name: Report V4\\n  enabled: true\\n  deprecated: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: contact_chatwoot_support_team\\n  display_name: Contact Chatwoot Support Team\\n  enabled: true\\n  chatwoot_internal: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: shopify_integration\\n  display_name: Shopify Integration\\n  enabled: false\\n  chatwoot_internal: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: search_with_gin\\n  display_name: Search messages with GIN\\n  enabled: false\\n  chatwoot_internal: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: channel_instagram\\n  display_name: Instagram Channel\\n  enabled: true\\n- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  name: crm_integration\\n  display_name: CRM Integration\\n  enabled: false\\n"	2025-06-02 10:43:04.467887	2025-06-02 10:43:04.467887	t
63	VAPID_KEYS	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\n  public_key: BG5PyaVBVpAgggsBTunh1sOmUcTc0aOW8TNLjeJEvPicFJLkkEiRkK7uDDbAlw_bcNqfRKq_rejAVNAeyJJKUIY=\\n  private_key: CWhfZ5DbzniCAd52q53-zo0LDMmJ8qqn_LY_juwn3CI=\\n"	2025-06-02 10:46:49.29672	2025-06-02 10:46:49.29672	t
64	INSTALLATION_IDENTIFIER	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: 5dcfc2d6-eb8d-44c6-afe1-a6d23de5a558\\n"	2025-06-02 12:00:03.908362	2025-06-02 12:00:03.908362	t
43	CHATWOOT_SUPPORT_WEBSITE_TOKEN	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: buziVV8JZbYzuFskjTstyKXG\\n"	2025-06-02 10:43:04.403647	2025-06-02 12:00:10.81876	t
45	CHATWOOT_SUPPORT_IDENTIFIER_HASH	"--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\\nvalue: e061e17538c44b4fd9a20f930203396f16d116abdc69b834bc94b9ab24a41f9a\\n"	2025-06-02 10:43:04.410302	2025-06-02 12:00:10.823685	t
65	ONBOARDING_STEPS	{"value": []}	2025-06-04 04:43:10.055755	2025-06-04 04:43:10.055755	t
\.


--
-- Data for Name: integrations_hooks; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.integrations_hooks (id, status, inbox_id, account_id, app_id, hook_type, reference_id, access_token, created_at, updated_at, settings) FROM stdin;
\.


--
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.labels (id, title, description, color, show_on_sidebar, account_id, created_at, updated_at) FROM stdin;
1	billing-query	Query about billing	#2DE5CF	t	1	2025-06-04 05:12:01.677097	2025-06-04 05:12:01.677097
2	premium_customer	This customer's issue is to be resolved on priority	#3266C0	t	1	2025-06-04 05:12:22.343445	2025-06-04 05:12:22.343445
\.


--
-- Data for Name: macros; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.macros (id, account_id, name, visibility, created_by_id, updated_by_id, actions, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mentions; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.mentions (id, user_id, conversation_id, account_id, mentioned_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.messages (id, content, account_id, inbox_id, conversation_id, message_type, created_at, updated_at, private, status, source_id, content_type, content_attributes, sender_type, sender_id, external_source_ids, additional_attributes, processed_message_content, sentiment) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.notes (id, content, account_id, contact_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_settings; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.notification_settings (id, account_id, user_id, email_flags, created_at, updated_at, push_flags) FROM stdin;
1	1	5	2	2025-06-04 04:48:06.112423	2025-06-04 04:48:06.112423	2
\.


--
-- Data for Name: notification_subscriptions; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.notification_subscriptions (id, user_id, subscription_type, subscription_attributes, created_at, updated_at, identifier) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.notifications (id, account_id, user_id, notification_type, primary_actor_type, primary_actor_id, secondary_actor_type, secondary_actor_id, read_at, created_at, updated_at, snoozed_until, last_activity_at, meta) FROM stdin;
\.


--
-- Data for Name: platform_app_permissibles; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.platform_app_permissibles (id, platform_app_id, permissible_type, permissible_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: platform_apps; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.platform_apps (id, name, created_at, updated_at) FROM stdin;
1	Landing Pad Platform-APP	2025-06-04 04:53:11.178524	2025-06-04 04:53:11.178524
\.


--
-- Data for Name: portals; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.portals (id, account_id, name, slug, custom_domain, color, homepage_link, page_title, header_text, created_at, updated_at, config, archived, channel_web_widget_id) FROM stdin;
1	1	Landing Pad | Support	user-guide	\N	#8226DE	https://landingpad.digital/?utm_source=support&utm_medium=internal&utm_campaign=help-center	Landing Pad Support & Help Center	User Guide & Help Center	2025-06-04 04:54:01.378922	2025-06-05 02:13:18.530263	{"default_locale": "en", "allowed_locales": ["en"]}	f	\N
2	1	Landing Pad | Developer Hub	developer-hub	\N	#8226DE	https://www.landingpad.digital	Landing Pad | Developer Hub	Integrations, Setup & Performance Docs	2025-06-05 07:58:06.708624	2025-06-06 02:24:39.913569	{"default_locale": "en", "allowed_locales": ["en"]}	f	\N
\.


--
-- Data for Name: portals_members; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.portals_members (portal_id, user_id) FROM stdin;
\.


--
-- Data for Name: related_categories; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.related_categories (id, category_id, related_category_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reporting_events; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.reporting_events (id, name, value, account_id, inbox_id, user_id, conversation_id, created_at, updated_at, value_in_business_hours, event_start_time, event_end_time) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.schema_migrations (version) FROM stdin;
20250514045638
20230426130150
20230503101201
20230509101256
20230510060828
20230510113208
20230515051424
20230523104139
20230525085402
20230608040738
20230612103936
20230614044633
20230620132319
20230620212340
20230706090122
20230714054138
20230727065605
20230801180936
20230905060223
20231011041615
20231013072802
20231114111614
20231129091149
20231201014644
20231211010807
20231219000743
20231219073832
20231223033019
20231223040257
20240124054340
20240124084032
20240129080827
20240131040316
20240207103014
20240213131252
20240215065844
20240216055809
20240306201954
20240319062553
20240322071629
20240415210313
20240515201632
20240516003531
20240726220747
20240923215335
20241217041352
20250104200055
20250104210328
20250105001414
20250105005821
20250107030743
20250108031358
20250108211541
20250116000103
20250116061033
20250207040150
20250228185548
20250315202035
20250326034635
20250402233933
20250410061725
20250416182131
20250421082927
20250421085134
20250512231036
20250512231037
\.


--
-- Data for Name: sla_events; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.sla_events (id, applied_sla_id, conversation_id, account_id, sla_policy_id, inbox_id, event_type, meta, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sla_policies; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.sla_policies (id, name, first_response_time_threshold, next_response_time_threshold, only_during_business_hours, account_id, created_at, updated_at, description, resolution_time_threshold) FROM stdin;
\.


--
-- Data for Name: taggings; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.taggings (id, tag_id, taggable_type, taggable_id, tagger_type, tagger_id, context, created_at) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.tags (id, name, taggings_count) FROM stdin;
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.team_members (id, team_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.teams (id, name, description, allow_auto_assign, account_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: telegram_bots; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.telegram_bots (id, name, auth_key, account_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.users (id, provider, uid, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, name, display_name, email, tokens, created_at, updated_at, pubsub_token, availability, ui_settings, custom_attributes, type, message_signature) FROM stdin;
4	email	dev@landingpad.digital	a2	\N	\N	\N	0	\N	\N	\N	\N	\N	2025-06-04 04:46:41	\N	\N	Landing Pad Dev User	Landing Pad Dev DisplayName	dev@landingpad.digital	\N	2025-06-04 04:46:41.830218	2025-06-04 04:51:30.070621	\N	0	{}	{}	SuperAdmin	\N
5	email	support@landingpad.digital	$2a$11$BvDFZ/jfIm4Y7DupRvOGo.Rv8Evg3N4Es5XXNGE9gxQ2PlUQNUp4m	\N	\N	\N	8	2025-06-24 06:30:29.922249	2025-06-12 10:49:59.542664	171.4.219.229	171.4.250.227	\N	2025-06-04 04:48:06	\N	\N	Landing Pad Support Team	Support Team DisplayName	support@landingpad.digital	"{\\"gccA9e2ppO2KBIxgq8mGaw\\":{\\"token\\":\\"$2a$10$Mgr/hT7bA1b0P9XvrgLf8OucwJvFOJlgsMumJPmkrU5O/D653FlkW\\",\\"expiry\\":1754282921},\\"v5ieVYcFvKghCbfcM0KVxQ\\":{\\"token\\":\\"$2a$10$YzbVpBSPK3oV1xOcJaJHwOCeK3rfdusKeRMeQuQNCSDOCfbHFyDEK\\",\\"expiry\\":1754300411},\\"K_PvvhTYVviE0EJKMYm7IA\\":{\\"token\\":\\"$2a$10$3uKUklr0434llUbLnlsKIO/0MjdRpvFnFL6q7PDko.pAkyIUnJbqq\\",\\"expiry\\":1754301159},\\"5AVKqdu1ROQacn2_lOvbqg\\":{\\"token\\":\\"$2a$10$GHv7B9yWqcsK.vlyL1jevO79IezHeI3GzDsJgTtea7YZU0JbJtFZG\\",\\"expiry\\":1754301947},\\"JiR2qeW0ID4lSiz65oKyOg\\":{\\"token\\":\\"$2a$10$H8fmJQJhESX4AOjGpzs9u.OmbtERloQvEnIoGvxhXI4LTsNm0iWAq\\",\\"expiry\\":1754995799},\\"DpacRrygAbFjG2Ki3f6iHA\\":{\\"token\\":\\"$2a$10$.jtjvNBuTiipB4jEGMWbKOwyyVxx7.T76PnBLSfKnwfOBSla0Twe.\\",\\"expiry\\":1756017029},\\"hBWSF-UHgytZPCK8wMOvig\\":{\\"token\\":\\"$2a$10$SmxX4aUSNLpNv2Ff7EcLbO6BLJ2NF4jGQyNpLhE3ILQsnYAtrb5ca\\",\\"expiry\\":1756017049}}"	2025-06-04 04:48:06.027998	2025-06-24 06:30:49.26482	nEJyvkLEj7rg9Nq9Qf9a1PtY	0	{"last_active_locale_code": "en", "last_active_portal_slug": "developer-hub"}	{}	SuperAdmin	\N
\.


--
-- Data for Name: webhooks; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.webhooks (id, account_id, inbox_id, url, created_at, updated_at, webhook_type, subscriptions) FROM stdin;
\.


--
-- Data for Name: working_hours; Type: TABLE DATA; Schema: public; Owner: chatwoot_user
--

COPY public.working_hours (id, inbox_id, account_id, day_of_week, closed_all_day, open_hour, open_minutes, close_hour, close_minutes, created_at, updated_at, open_all_day) FROM stdin;
1	1	1	0	t	\N	\N	\N	\N	2025-06-04 05:13:13.235566	2025-06-04 05:13:13.235566	f
7	1	1	6	t	\N	\N	\N	\N	2025-06-04 05:13:13.244719	2025-06-04 05:13:13.244719	f
2	1	1	1	f	9	0	18	0	2025-06-04 05:13:13.238671	2025-06-04 05:15:00.845062	f
3	1	1	2	f	9	0	18	0	2025-06-04 05:13:13.239829	2025-06-04 05:15:00.84719	f
4	1	1	3	f	9	0	18	0	2025-06-04 05:13:13.240898	2025-06-04 05:15:00.849198	f
5	1	1	4	f	9	0	18	0	2025-06-04 05:13:13.24257	2025-06-04 05:15:00.851035	f
6	1	1	5	f	9	0	18	0	2025-06-04 05:13:13.243618	2025-06-04 05:15:06.021351	f
\.


--
-- Name: access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.access_tokens_id_seq', 3, true);


--
-- Name: account_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.account_users_id_seq', 1, true);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.action_mailbox_inbound_emails_id_seq', 1, false);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 17, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 56, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 6, true);


--
-- Name: agent_bot_inboxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.agent_bot_inboxes_id_seq', 1, false);


--
-- Name: agent_bots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.agent_bots_id_seq', 1, true);


--
-- Name: applied_slas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.applied_slas_id_seq', 1, false);


--
-- Name: article_embeddings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.article_embeddings_id_seq', 1, false);


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.articles_id_seq', 26, true);


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.attachments_id_seq', 1, false);


--
-- Name: audits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.audits_id_seq', 16, true);


--
-- Name: automation_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.automation_rules_id_seq', 1, false);


--
-- Name: camp_dpid_seq_1; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.camp_dpid_seq_1', 1, false);


--
-- Name: campaigns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.campaigns_id_seq', 1, false);


--
-- Name: canned_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.canned_responses_id_seq', 5, true);


--
-- Name: captain_assistant_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.captain_assistant_responses_id_seq', 1, false);


--
-- Name: captain_assistants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.captain_assistants_id_seq', 1, false);


--
-- Name: captain_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.captain_documents_id_seq', 1, false);


--
-- Name: captain_inboxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.captain_inboxes_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.categories_id_seq', 18, true);


--
-- Name: channel_api_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_api_id_seq', 1, false);


--
-- Name: channel_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_email_id_seq', 1, false);


--
-- Name: channel_facebook_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_facebook_pages_id_seq', 1, false);


--
-- Name: channel_instagram_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_instagram_id_seq', 1, false);


--
-- Name: channel_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_line_id_seq', 1, false);


--
-- Name: channel_sms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_sms_id_seq', 1, false);


--
-- Name: channel_telegram_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_telegram_id_seq', 1, false);


--
-- Name: channel_twilio_sms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_twilio_sms_id_seq', 1, false);


--
-- Name: channel_twitter_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_twitter_profiles_id_seq', 1, false);


--
-- Name: channel_web_widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_web_widgets_id_seq', 1, true);


--
-- Name: channel_whatsapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.channel_whatsapp_id_seq', 1, false);


--
-- Name: contact_inboxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.contact_inboxes_id_seq', 1, false);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, false);


--
-- Name: conv_dpid_seq_1; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.conv_dpid_seq_1', 1, false);


--
-- Name: conversation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.conversation_participants_id_seq', 1, false);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.conversations_id_seq', 1, false);


--
-- Name: copilot_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.copilot_messages_id_seq', 1, false);


--
-- Name: copilot_threads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.copilot_threads_id_seq', 1, false);


--
-- Name: csat_survey_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.csat_survey_responses_id_seq', 1, false);


--
-- Name: custom_attribute_definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.custom_attribute_definitions_id_seq', 1, false);


--
-- Name: custom_filters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.custom_filters_id_seq', 1, false);


--
-- Name: custom_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.custom_roles_id_seq', 1, false);


--
-- Name: dashboard_apps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.dashboard_apps_id_seq', 1, false);


--
-- Name: data_imports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.data_imports_id_seq', 1, false);


--
-- Name: email_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.email_templates_id_seq', 1, false);


--
-- Name: folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.folders_id_seq', 1, false);


--
-- Name: inbox_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.inbox_members_id_seq', 1, true);


--
-- Name: inboxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.inboxes_id_seq', 1, true);


--
-- Name: installation_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.installation_configs_id_seq', 65, true);


--
-- Name: integrations_hooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.integrations_hooks_id_seq', 1, false);


--
-- Name: labels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.labels_id_seq', 2, true);


--
-- Name: macros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.macros_id_seq', 1, false);


--
-- Name: mentions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.mentions_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- Name: notification_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.notification_settings_id_seq', 1, true);


--
-- Name: notification_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.notification_subscriptions_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: platform_app_permissibles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.platform_app_permissibles_id_seq', 1, false);


--
-- Name: platform_apps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.platform_apps_id_seq', 1, true);


--
-- Name: portals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.portals_id_seq', 2, true);


--
-- Name: related_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.related_categories_id_seq', 1, false);


--
-- Name: reporting_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.reporting_events_id_seq', 1, false);


--
-- Name: sla_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.sla_events_id_seq', 1, false);


--
-- Name: sla_policies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.sla_policies_id_seq', 1, false);


--
-- Name: taggings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.taggings_id_seq', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- Name: team_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.team_members_id_seq', 1, false);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.teams_id_seq', 1, false);


--
-- Name: telegram_bots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.telegram_bots_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.webhooks_id_seq', 1, false);


--
-- Name: working_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatwoot_user
--

SELECT pg_catalog.setval('public.working_hours_id_seq', 7, true);


--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);


--
-- Name: account_users account_users_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.account_users
    ADD CONSTRAINT account_users_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: action_mailbox_inbound_emails action_mailbox_inbound_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.action_mailbox_inbound_emails
    ADD CONSTRAINT action_mailbox_inbound_emails_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: agent_bot_inboxes agent_bot_inboxes_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.agent_bot_inboxes
    ADD CONSTRAINT agent_bot_inboxes_pkey PRIMARY KEY (id);


--
-- Name: agent_bots agent_bots_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.agent_bots
    ADD CONSTRAINT agent_bots_pkey PRIMARY KEY (id);


--
-- Name: applied_slas applied_slas_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.applied_slas
    ADD CONSTRAINT applied_slas_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: article_embeddings article_embeddings_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.article_embeddings
    ADD CONSTRAINT article_embeddings_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: automation_rules automation_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.automation_rules
    ADD CONSTRAINT automation_rules_pkey PRIMARY KEY (id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: canned_responses canned_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.canned_responses
    ADD CONSTRAINT canned_responses_pkey PRIMARY KEY (id);


--
-- Name: captain_assistant_responses captain_assistant_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_assistant_responses
    ADD CONSTRAINT captain_assistant_responses_pkey PRIMARY KEY (id);


--
-- Name: captain_assistants captain_assistants_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_assistants
    ADD CONSTRAINT captain_assistants_pkey PRIMARY KEY (id);


--
-- Name: captain_documents captain_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_documents
    ADD CONSTRAINT captain_documents_pkey PRIMARY KEY (id);


--
-- Name: captain_inboxes captain_inboxes_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.captain_inboxes
    ADD CONSTRAINT captain_inboxes_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: channel_api channel_api_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_api
    ADD CONSTRAINT channel_api_pkey PRIMARY KEY (id);


--
-- Name: channel_email channel_email_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_email
    ADD CONSTRAINT channel_email_pkey PRIMARY KEY (id);


--
-- Name: channel_facebook_pages channel_facebook_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_facebook_pages
    ADD CONSTRAINT channel_facebook_pages_pkey PRIMARY KEY (id);


--
-- Name: channel_instagram channel_instagram_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_instagram
    ADD CONSTRAINT channel_instagram_pkey PRIMARY KEY (id);


--
-- Name: channel_line channel_line_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_line
    ADD CONSTRAINT channel_line_pkey PRIMARY KEY (id);


--
-- Name: channel_sms channel_sms_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_sms
    ADD CONSTRAINT channel_sms_pkey PRIMARY KEY (id);


--
-- Name: channel_telegram channel_telegram_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_telegram
    ADD CONSTRAINT channel_telegram_pkey PRIMARY KEY (id);


--
-- Name: channel_twilio_sms channel_twilio_sms_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_twilio_sms
    ADD CONSTRAINT channel_twilio_sms_pkey PRIMARY KEY (id);


--
-- Name: channel_twitter_profiles channel_twitter_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_twitter_profiles
    ADD CONSTRAINT channel_twitter_profiles_pkey PRIMARY KEY (id);


--
-- Name: channel_web_widgets channel_web_widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_web_widgets
    ADD CONSTRAINT channel_web_widgets_pkey PRIMARY KEY (id);


--
-- Name: channel_whatsapp channel_whatsapp_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.channel_whatsapp
    ADD CONSTRAINT channel_whatsapp_pkey PRIMARY KEY (id);


--
-- Name: contact_inboxes contact_inboxes_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.contact_inboxes
    ADD CONSTRAINT contact_inboxes_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: conversation_participants conversation_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.conversation_participants
    ADD CONSTRAINT conversation_participants_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: copilot_messages copilot_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.copilot_messages
    ADD CONSTRAINT copilot_messages_pkey PRIMARY KEY (id);


--
-- Name: copilot_threads copilot_threads_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.copilot_threads
    ADD CONSTRAINT copilot_threads_pkey PRIMARY KEY (id);


--
-- Name: csat_survey_responses csat_survey_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.csat_survey_responses
    ADD CONSTRAINT csat_survey_responses_pkey PRIMARY KEY (id);


--
-- Name: custom_attribute_definitions custom_attribute_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.custom_attribute_definitions
    ADD CONSTRAINT custom_attribute_definitions_pkey PRIMARY KEY (id);


--
-- Name: custom_filters custom_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.custom_filters
    ADD CONSTRAINT custom_filters_pkey PRIMARY KEY (id);


--
-- Name: custom_roles custom_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.custom_roles
    ADD CONSTRAINT custom_roles_pkey PRIMARY KEY (id);


--
-- Name: dashboard_apps dashboard_apps_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.dashboard_apps
    ADD CONSTRAINT dashboard_apps_pkey PRIMARY KEY (id);


--
-- Name: data_imports data_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.data_imports
    ADD CONSTRAINT data_imports_pkey PRIMARY KEY (id);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (id);


--
-- Name: folders folders_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_pkey PRIMARY KEY (id);


--
-- Name: inbox_members inbox_members_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.inbox_members
    ADD CONSTRAINT inbox_members_pkey PRIMARY KEY (id);


--
-- Name: inboxes inboxes_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.inboxes
    ADD CONSTRAINT inboxes_pkey PRIMARY KEY (id);


--
-- Name: installation_configs installation_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.installation_configs
    ADD CONSTRAINT installation_configs_pkey PRIMARY KEY (id);


--
-- Name: integrations_hooks integrations_hooks_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.integrations_hooks
    ADD CONSTRAINT integrations_hooks_pkey PRIMARY KEY (id);


--
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id);


--
-- Name: macros macros_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.macros
    ADD CONSTRAINT macros_pkey PRIMARY KEY (id);


--
-- Name: mentions mentions_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.mentions
    ADD CONSTRAINT mentions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notification_settings notification_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notification_settings
    ADD CONSTRAINT notification_settings_pkey PRIMARY KEY (id);


--
-- Name: notification_subscriptions notification_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notification_subscriptions
    ADD CONSTRAINT notification_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: platform_app_permissibles platform_app_permissibles_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.platform_app_permissibles
    ADD CONSTRAINT platform_app_permissibles_pkey PRIMARY KEY (id);


--
-- Name: platform_apps platform_apps_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.platform_apps
    ADD CONSTRAINT platform_apps_pkey PRIMARY KEY (id);


--
-- Name: portals portals_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.portals
    ADD CONSTRAINT portals_pkey PRIMARY KEY (id);


--
-- Name: related_categories related_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.related_categories
    ADD CONSTRAINT related_categories_pkey PRIMARY KEY (id);


--
-- Name: reporting_events reporting_events_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.reporting_events
    ADD CONSTRAINT reporting_events_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sla_events sla_events_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.sla_events
    ADD CONSTRAINT sla_events_pkey PRIMARY KEY (id);


--
-- Name: sla_policies sla_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.sla_policies
    ADD CONSTRAINT sla_policies_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: telegram_bots telegram_bots_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.telegram_bots
    ADD CONSTRAINT telegram_bots_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (id);


--
-- Name: working_hours working_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT working_hours_pkey PRIMARY KEY (id);


--
-- Name: associated_index; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX associated_index ON public.audits USING btree (associated_type, associated_id);


--
-- Name: attribute_key_model_index; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX attribute_key_model_index ON public.custom_attribute_definitions USING btree (attribute_key, attribute_model, account_id);


--
-- Name: auditable_index; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX auditable_index ON public.audits USING btree (auditable_type, auditable_id, version);


--
-- Name: by_account_user; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX by_account_user ON public.notification_settings USING btree (account_id, user_id);


--
-- Name: conv_acid_inbid_stat_asgnid_idx; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX conv_acid_inbid_stat_asgnid_idx ON public.conversations USING btree (account_id, inbox_id, status, assignee_id);


--
-- Name: idx_cap_asst_resp_on_documentable; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX idx_cap_asst_resp_on_documentable ON public.captain_assistant_responses USING btree (documentable_id, documentable_type);


--
-- Name: index_access_tokens_on_owner_type_and_owner_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_access_tokens_on_owner_type_and_owner_id ON public.access_tokens USING btree (owner_type, owner_id);


--
-- Name: index_access_tokens_on_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_access_tokens_on_token ON public.access_tokens USING btree (token);


--
-- Name: index_account_users_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_account_users_on_account_id ON public.account_users USING btree (account_id);


--
-- Name: index_account_users_on_custom_role_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_account_users_on_custom_role_id ON public.account_users USING btree (custom_role_id);


--
-- Name: index_account_users_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_account_users_on_user_id ON public.account_users USING btree (user_id);


--
-- Name: index_accounts_on_status; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_accounts_on_status ON public.accounts USING btree (status);


--
-- Name: index_action_mailbox_inbound_emails_uniqueness; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_action_mailbox_inbound_emails_uniqueness ON public.action_mailbox_inbound_emails USING btree (message_id, message_checksum);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_agent_bots_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_agent_bots_on_account_id ON public.agent_bots USING btree (account_id);


--
-- Name: index_applied_slas_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_applied_slas_on_account_id ON public.applied_slas USING btree (account_id);


--
-- Name: index_applied_slas_on_account_sla_policy_conversation; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_applied_slas_on_account_sla_policy_conversation ON public.applied_slas USING btree (account_id, sla_policy_id, conversation_id);


--
-- Name: index_applied_slas_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_applied_slas_on_conversation_id ON public.applied_slas USING btree (conversation_id);


--
-- Name: index_applied_slas_on_sla_policy_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_applied_slas_on_sla_policy_id ON public.applied_slas USING btree (sla_policy_id);


--
-- Name: index_article_embeddings_on_embedding; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_article_embeddings_on_embedding ON public.article_embeddings USING ivfflat (embedding);


--
-- Name: index_articles_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_articles_on_account_id ON public.articles USING btree (account_id);


--
-- Name: index_articles_on_associated_article_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_articles_on_associated_article_id ON public.articles USING btree (associated_article_id);


--
-- Name: index_articles_on_author_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_articles_on_author_id ON public.articles USING btree (author_id);


--
-- Name: index_articles_on_portal_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_articles_on_portal_id ON public.articles USING btree (portal_id);


--
-- Name: index_articles_on_slug; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_articles_on_slug ON public.articles USING btree (slug);


--
-- Name: index_articles_on_status; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_articles_on_status ON public.articles USING btree (status);


--
-- Name: index_articles_on_views; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_articles_on_views ON public.articles USING btree (views);


--
-- Name: index_attachments_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_attachments_on_account_id ON public.attachments USING btree (account_id);


--
-- Name: index_attachments_on_message_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_attachments_on_message_id ON public.attachments USING btree (message_id);


--
-- Name: index_audits_on_created_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_audits_on_created_at ON public.audits USING btree (created_at);


--
-- Name: index_audits_on_request_uuid; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_audits_on_request_uuid ON public.audits USING btree (request_uuid);


--
-- Name: index_automation_rules_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_automation_rules_on_account_id ON public.automation_rules USING btree (account_id);


--
-- Name: index_campaigns_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_campaigns_on_account_id ON public.campaigns USING btree (account_id);


--
-- Name: index_campaigns_on_campaign_status; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_campaigns_on_campaign_status ON public.campaigns USING btree (campaign_status);


--
-- Name: index_campaigns_on_campaign_type; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_campaigns_on_campaign_type ON public.campaigns USING btree (campaign_type);


--
-- Name: index_campaigns_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_campaigns_on_inbox_id ON public.campaigns USING btree (inbox_id);


--
-- Name: index_campaigns_on_scheduled_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_campaigns_on_scheduled_at ON public.campaigns USING btree (scheduled_at);


--
-- Name: index_captain_assistant_responses_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_assistant_responses_on_account_id ON public.captain_assistant_responses USING btree (account_id);


--
-- Name: index_captain_assistant_responses_on_assistant_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_assistant_responses_on_assistant_id ON public.captain_assistant_responses USING btree (assistant_id);


--
-- Name: index_captain_assistant_responses_on_status; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_assistant_responses_on_status ON public.captain_assistant_responses USING btree (status);


--
-- Name: index_captain_assistants_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_assistants_on_account_id ON public.captain_assistants USING btree (account_id);


--
-- Name: index_captain_documents_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_documents_on_account_id ON public.captain_documents USING btree (account_id);


--
-- Name: index_captain_documents_on_assistant_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_documents_on_assistant_id ON public.captain_documents USING btree (assistant_id);


--
-- Name: index_captain_documents_on_assistant_id_and_external_link; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_captain_documents_on_assistant_id_and_external_link ON public.captain_documents USING btree (assistant_id, external_link);


--
-- Name: index_captain_documents_on_status; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_documents_on_status ON public.captain_documents USING btree (status);


--
-- Name: index_captain_inboxes_on_captain_assistant_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_inboxes_on_captain_assistant_id ON public.captain_inboxes USING btree (captain_assistant_id);


--
-- Name: index_captain_inboxes_on_captain_assistant_id_and_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_captain_inboxes_on_captain_assistant_id_and_inbox_id ON public.captain_inboxes USING btree (captain_assistant_id, inbox_id);


--
-- Name: index_captain_inboxes_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_captain_inboxes_on_inbox_id ON public.captain_inboxes USING btree (inbox_id);


--
-- Name: index_categories_on_associated_category_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_categories_on_associated_category_id ON public.categories USING btree (associated_category_id);


--
-- Name: index_categories_on_locale; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_categories_on_locale ON public.categories USING btree (locale);


--
-- Name: index_categories_on_locale_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_categories_on_locale_and_account_id ON public.categories USING btree (locale, account_id);


--
-- Name: index_categories_on_parent_category_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_categories_on_parent_category_id ON public.categories USING btree (parent_category_id);


--
-- Name: index_categories_on_slug_and_locale_and_portal_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_categories_on_slug_and_locale_and_portal_id ON public.categories USING btree (slug, locale, portal_id);


--
-- Name: index_channel_api_on_hmac_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_api_on_hmac_token ON public.channel_api USING btree (hmac_token);


--
-- Name: index_channel_api_on_identifier; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_api_on_identifier ON public.channel_api USING btree (identifier);


--
-- Name: index_channel_email_on_email; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_email_on_email ON public.channel_email USING btree (email);


--
-- Name: index_channel_email_on_forward_to_email; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_email_on_forward_to_email ON public.channel_email USING btree (forward_to_email);


--
-- Name: index_channel_facebook_pages_on_page_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_channel_facebook_pages_on_page_id ON public.channel_facebook_pages USING btree (page_id);


--
-- Name: index_channel_facebook_pages_on_page_id_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_facebook_pages_on_page_id_and_account_id ON public.channel_facebook_pages USING btree (page_id, account_id);


--
-- Name: index_channel_instagram_on_instagram_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_instagram_on_instagram_id ON public.channel_instagram USING btree (instagram_id);


--
-- Name: index_channel_line_on_line_channel_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_line_on_line_channel_id ON public.channel_line USING btree (line_channel_id);


--
-- Name: index_channel_sms_on_phone_number; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_sms_on_phone_number ON public.channel_sms USING btree (phone_number);


--
-- Name: index_channel_telegram_on_bot_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_telegram_on_bot_token ON public.channel_telegram USING btree (bot_token);


--
-- Name: index_channel_twilio_sms_on_account_sid_and_phone_number; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_twilio_sms_on_account_sid_and_phone_number ON public.channel_twilio_sms USING btree (account_sid, phone_number);


--
-- Name: index_channel_twilio_sms_on_messaging_service_sid; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_twilio_sms_on_messaging_service_sid ON public.channel_twilio_sms USING btree (messaging_service_sid);


--
-- Name: index_channel_twilio_sms_on_phone_number; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_twilio_sms_on_phone_number ON public.channel_twilio_sms USING btree (phone_number);


--
-- Name: index_channel_twitter_profiles_on_account_id_and_profile_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_twitter_profiles_on_account_id_and_profile_id ON public.channel_twitter_profiles USING btree (account_id, profile_id);


--
-- Name: index_channel_web_widgets_on_hmac_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_web_widgets_on_hmac_token ON public.channel_web_widgets USING btree (hmac_token);


--
-- Name: index_channel_web_widgets_on_website_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_web_widgets_on_website_token ON public.channel_web_widgets USING btree (website_token);


--
-- Name: index_channel_whatsapp_on_phone_number; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_channel_whatsapp_on_phone_number ON public.channel_whatsapp USING btree (phone_number);


--
-- Name: index_contact_inboxes_on_contact_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contact_inboxes_on_contact_id ON public.contact_inboxes USING btree (contact_id);


--
-- Name: index_contact_inboxes_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contact_inboxes_on_inbox_id ON public.contact_inboxes USING btree (inbox_id);


--
-- Name: index_contact_inboxes_on_inbox_id_and_source_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_contact_inboxes_on_inbox_id_and_source_id ON public.contact_inboxes USING btree (inbox_id, source_id);


--
-- Name: index_contact_inboxes_on_pubsub_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_contact_inboxes_on_pubsub_token ON public.contact_inboxes USING btree (pubsub_token);


--
-- Name: index_contact_inboxes_on_source_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contact_inboxes_on_source_id ON public.contact_inboxes USING btree (source_id);


--
-- Name: index_contacts_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_account_id ON public.contacts USING btree (account_id);


--
-- Name: index_contacts_on_account_id_and_last_activity_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_account_id_and_last_activity_at ON public.contacts USING btree (account_id, last_activity_at DESC NULLS LAST);


--
-- Name: index_contacts_on_blocked; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_blocked ON public.contacts USING btree (blocked);


--
-- Name: index_contacts_on_lower_email_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_lower_email_account_id ON public.contacts USING btree (lower((email)::text), account_id);


--
-- Name: index_contacts_on_name_email_phone_number_identifier; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_name_email_phone_number_identifier ON public.contacts USING gin (name public.gin_trgm_ops, email public.gin_trgm_ops, phone_number public.gin_trgm_ops, identifier public.gin_trgm_ops);


--
-- Name: index_contacts_on_nonempty_fields; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_nonempty_fields ON public.contacts USING btree (account_id, email, phone_number, identifier) WHERE (((email)::text <> ''::text) OR ((phone_number)::text <> ''::text) OR ((identifier)::text <> ''::text));


--
-- Name: index_contacts_on_phone_number_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_contacts_on_phone_number_and_account_id ON public.contacts USING btree (phone_number, account_id);


--
-- Name: index_conversation_participants_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversation_participants_on_account_id ON public.conversation_participants USING btree (account_id);


--
-- Name: index_conversation_participants_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversation_participants_on_conversation_id ON public.conversation_participants USING btree (conversation_id);


--
-- Name: index_conversation_participants_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversation_participants_on_user_id ON public.conversation_participants USING btree (user_id);


--
-- Name: index_conversation_participants_on_user_id_and_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_conversation_participants_on_user_id_and_conversation_id ON public.conversation_participants USING btree (user_id, conversation_id);


--
-- Name: index_conversations_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_account_id ON public.conversations USING btree (account_id);


--
-- Name: index_conversations_on_account_id_and_display_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_conversations_on_account_id_and_display_id ON public.conversations USING btree (account_id, display_id);


--
-- Name: index_conversations_on_assignee_id_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_assignee_id_and_account_id ON public.conversations USING btree (assignee_id, account_id);


--
-- Name: index_conversations_on_campaign_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_campaign_id ON public.conversations USING btree (campaign_id);


--
-- Name: index_conversations_on_contact_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_contact_id ON public.conversations USING btree (contact_id);


--
-- Name: index_conversations_on_contact_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_contact_inbox_id ON public.conversations USING btree (contact_inbox_id);


--
-- Name: index_conversations_on_first_reply_created_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_first_reply_created_at ON public.conversations USING btree (first_reply_created_at);


--
-- Name: index_conversations_on_id_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_id_and_account_id ON public.conversations USING btree (account_id, id);


--
-- Name: index_conversations_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_inbox_id ON public.conversations USING btree (inbox_id);


--
-- Name: index_conversations_on_priority; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_priority ON public.conversations USING btree (priority);


--
-- Name: index_conversations_on_status_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_status_and_account_id ON public.conversations USING btree (status, account_id);


--
-- Name: index_conversations_on_status_and_priority; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_status_and_priority ON public.conversations USING btree (status, priority);


--
-- Name: index_conversations_on_team_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_team_id ON public.conversations USING btree (team_id);


--
-- Name: index_conversations_on_uuid; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_conversations_on_uuid ON public.conversations USING btree (uuid);


--
-- Name: index_conversations_on_waiting_since; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_conversations_on_waiting_since ON public.conversations USING btree (waiting_since);


--
-- Name: index_copilot_messages_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_copilot_messages_on_account_id ON public.copilot_messages USING btree (account_id);


--
-- Name: index_copilot_messages_on_copilot_thread_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_copilot_messages_on_copilot_thread_id ON public.copilot_messages USING btree (copilot_thread_id);


--
-- Name: index_copilot_messages_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_copilot_messages_on_user_id ON public.copilot_messages USING btree (user_id);


--
-- Name: index_copilot_threads_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_copilot_threads_on_account_id ON public.copilot_threads USING btree (account_id);


--
-- Name: index_copilot_threads_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_copilot_threads_on_user_id ON public.copilot_threads USING btree (user_id);


--
-- Name: index_copilot_threads_on_uuid; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_copilot_threads_on_uuid ON public.copilot_threads USING btree (uuid);


--
-- Name: index_csat_survey_responses_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_csat_survey_responses_on_account_id ON public.csat_survey_responses USING btree (account_id);


--
-- Name: index_csat_survey_responses_on_assigned_agent_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_csat_survey_responses_on_assigned_agent_id ON public.csat_survey_responses USING btree (assigned_agent_id);


--
-- Name: index_csat_survey_responses_on_contact_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_csat_survey_responses_on_contact_id ON public.csat_survey_responses USING btree (contact_id);


--
-- Name: index_csat_survey_responses_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_csat_survey_responses_on_conversation_id ON public.csat_survey_responses USING btree (conversation_id);


--
-- Name: index_csat_survey_responses_on_message_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_csat_survey_responses_on_message_id ON public.csat_survey_responses USING btree (message_id);


--
-- Name: index_custom_attribute_definitions_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_custom_attribute_definitions_on_account_id ON public.custom_attribute_definitions USING btree (account_id);


--
-- Name: index_custom_filters_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_custom_filters_on_account_id ON public.custom_filters USING btree (account_id);


--
-- Name: index_custom_filters_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_custom_filters_on_user_id ON public.custom_filters USING btree (user_id);


--
-- Name: index_custom_roles_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_custom_roles_on_account_id ON public.custom_roles USING btree (account_id);


--
-- Name: index_dashboard_apps_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_dashboard_apps_on_account_id ON public.dashboard_apps USING btree (account_id);


--
-- Name: index_dashboard_apps_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_dashboard_apps_on_user_id ON public.dashboard_apps USING btree (user_id);


--
-- Name: index_data_imports_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_data_imports_on_account_id ON public.data_imports USING btree (account_id);


--
-- Name: index_email_templates_on_name_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_email_templates_on_name_and_account_id ON public.email_templates USING btree (name, account_id);


--
-- Name: index_inbox_members_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_inbox_members_on_inbox_id ON public.inbox_members USING btree (inbox_id);


--
-- Name: index_inbox_members_on_inbox_id_and_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_inbox_members_on_inbox_id_and_user_id ON public.inbox_members USING btree (inbox_id, user_id);


--
-- Name: index_inboxes_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_inboxes_on_account_id ON public.inboxes USING btree (account_id);


--
-- Name: index_inboxes_on_channel_id_and_channel_type; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_inboxes_on_channel_id_and_channel_type ON public.inboxes USING btree (channel_id, channel_type);


--
-- Name: index_inboxes_on_portal_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_inboxes_on_portal_id ON public.inboxes USING btree (portal_id);


--
-- Name: index_installation_configs_on_name; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_installation_configs_on_name ON public.installation_configs USING btree (name);


--
-- Name: index_installation_configs_on_name_and_created_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_installation_configs_on_name_and_created_at ON public.installation_configs USING btree (name, created_at);


--
-- Name: index_labels_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_labels_on_account_id ON public.labels USING btree (account_id);


--
-- Name: index_labels_on_title_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_labels_on_title_and_account_id ON public.labels USING btree (title, account_id);


--
-- Name: index_macros_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_macros_on_account_id ON public.macros USING btree (account_id);


--
-- Name: index_mentions_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_mentions_on_account_id ON public.mentions USING btree (account_id);


--
-- Name: index_mentions_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_mentions_on_conversation_id ON public.mentions USING btree (conversation_id);


--
-- Name: index_mentions_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_mentions_on_user_id ON public.mentions USING btree (user_id);


--
-- Name: index_mentions_on_user_id_and_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_mentions_on_user_id_and_conversation_id ON public.mentions USING btree (user_id, conversation_id);


--
-- Name: index_messages_on_account_created_type; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_account_created_type ON public.messages USING btree (account_id, created_at, message_type);


--
-- Name: index_messages_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_account_id ON public.messages USING btree (account_id);


--
-- Name: index_messages_on_account_id_and_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_account_id_and_inbox_id ON public.messages USING btree (account_id, inbox_id);


--
-- Name: index_messages_on_additional_attributes_campaign_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_additional_attributes_campaign_id ON public.messages USING gin (((additional_attributes -> 'campaign_id'::text)));


--
-- Name: index_messages_on_content; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_content ON public.messages USING gin (content public.gin_trgm_ops);


--
-- Name: index_messages_on_conversation_account_type_created; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_conversation_account_type_created ON public.messages USING btree (conversation_id, account_id, message_type, created_at);


--
-- Name: index_messages_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_conversation_id ON public.messages USING btree (conversation_id);


--
-- Name: index_messages_on_created_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_created_at ON public.messages USING btree (created_at);


--
-- Name: index_messages_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_inbox_id ON public.messages USING btree (inbox_id);


--
-- Name: index_messages_on_sender_type_and_sender_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_sender_type_and_sender_id ON public.messages USING btree (sender_type, sender_id);


--
-- Name: index_messages_on_source_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_messages_on_source_id ON public.messages USING btree (source_id);


--
-- Name: index_notes_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notes_on_account_id ON public.notes USING btree (account_id);


--
-- Name: index_notes_on_contact_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notes_on_contact_id ON public.notes USING btree (contact_id);


--
-- Name: index_notes_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notes_on_user_id ON public.notes USING btree (user_id);


--
-- Name: index_notification_subscriptions_on_identifier; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_notification_subscriptions_on_identifier ON public.notification_subscriptions USING btree (identifier);


--
-- Name: index_notification_subscriptions_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notification_subscriptions_on_user_id ON public.notification_subscriptions USING btree (user_id);


--
-- Name: index_notifications_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notifications_on_account_id ON public.notifications USING btree (account_id);


--
-- Name: index_notifications_on_last_activity_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notifications_on_last_activity_at ON public.notifications USING btree (last_activity_at);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_notifications_on_user_id ON public.notifications USING btree (user_id);


--
-- Name: index_platform_app_permissibles_on_permissibles; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_platform_app_permissibles_on_permissibles ON public.platform_app_permissibles USING btree (permissible_type, permissible_id);


--
-- Name: index_platform_app_permissibles_on_platform_app_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_platform_app_permissibles_on_platform_app_id ON public.platform_app_permissibles USING btree (platform_app_id);


--
-- Name: index_portals_members_on_portal_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_portals_members_on_portal_id ON public.portals_members USING btree (portal_id);


--
-- Name: index_portals_members_on_portal_id_and_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_portals_members_on_portal_id_and_user_id ON public.portals_members USING btree (portal_id, user_id);


--
-- Name: index_portals_members_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_portals_members_on_user_id ON public.portals_members USING btree (user_id);


--
-- Name: index_portals_on_channel_web_widget_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_portals_on_channel_web_widget_id ON public.portals USING btree (channel_web_widget_id);


--
-- Name: index_portals_on_custom_domain; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_portals_on_custom_domain ON public.portals USING btree (custom_domain);


--
-- Name: index_portals_on_slug; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_portals_on_slug ON public.portals USING btree (slug);


--
-- Name: index_related_categories_on_category_id_and_related_category_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_related_categories_on_category_id_and_related_category_id ON public.related_categories USING btree (category_id, related_category_id);


--
-- Name: index_related_categories_on_related_category_id_and_category_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_related_categories_on_related_category_id_and_category_id ON public.related_categories USING btree (related_category_id, category_id);


--
-- Name: index_reporting_events_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_reporting_events_on_account_id ON public.reporting_events USING btree (account_id);


--
-- Name: index_reporting_events_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_reporting_events_on_conversation_id ON public.reporting_events USING btree (conversation_id);


--
-- Name: index_reporting_events_on_created_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_reporting_events_on_created_at ON public.reporting_events USING btree (created_at);


--
-- Name: index_reporting_events_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_reporting_events_on_inbox_id ON public.reporting_events USING btree (inbox_id);


--
-- Name: index_reporting_events_on_name; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_reporting_events_on_name ON public.reporting_events USING btree (name);


--
-- Name: index_reporting_events_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_reporting_events_on_user_id ON public.reporting_events USING btree (user_id);


--
-- Name: index_resolved_contact_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_resolved_contact_account_id ON public.contacts USING btree (account_id) WHERE (((email)::text <> ''::text) OR ((phone_number)::text <> ''::text) OR ((identifier)::text <> ''::text));


--
-- Name: index_sla_events_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_sla_events_on_account_id ON public.sla_events USING btree (account_id);


--
-- Name: index_sla_events_on_applied_sla_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_sla_events_on_applied_sla_id ON public.sla_events USING btree (applied_sla_id);


--
-- Name: index_sla_events_on_conversation_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_sla_events_on_conversation_id ON public.sla_events USING btree (conversation_id);


--
-- Name: index_sla_events_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_sla_events_on_inbox_id ON public.sla_events USING btree (inbox_id);


--
-- Name: index_sla_events_on_sla_policy_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_sla_events_on_sla_policy_id ON public.sla_events USING btree (sla_policy_id);


--
-- Name: index_sla_policies_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_sla_policies_on_account_id ON public.sla_policies USING btree (account_id);


--
-- Name: index_taggings_on_context; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_context ON public.taggings USING btree (context);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_tag_id ON public.taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_taggable_id ON public.taggings USING btree (taggable_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON public.taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_taggings_on_taggable_type; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_taggable_type ON public.taggings USING btree (taggable_type);


--
-- Name: index_taggings_on_tagger_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_tagger_id ON public.taggings USING btree (tagger_id);


--
-- Name: index_taggings_on_tagger_id_and_tagger_type; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_taggings_on_tagger_id_and_tagger_type ON public.taggings USING btree (tagger_id, tagger_type);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_tags_on_name ON public.tags USING btree (name);


--
-- Name: index_team_members_on_team_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_team_members_on_team_id ON public.team_members USING btree (team_id);


--
-- Name: index_team_members_on_team_id_and_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_team_members_on_team_id_and_user_id ON public.team_members USING btree (team_id, user_id);


--
-- Name: index_team_members_on_user_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_team_members_on_user_id ON public.team_members USING btree (user_id);


--
-- Name: index_teams_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_teams_on_account_id ON public.teams USING btree (account_id);


--
-- Name: index_teams_on_name_and_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_teams_on_name_and_account_id ON public.teams USING btree (name, account_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_pubsub_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_users_on_pubsub_token ON public.users USING btree (pubsub_token);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_uid_and_provider; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_users_on_uid_and_provider ON public.users USING btree (uid, provider);


--
-- Name: index_webhooks_on_account_id_and_url; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX index_webhooks_on_account_id_and_url ON public.webhooks USING btree (account_id, url);


--
-- Name: index_working_hours_on_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_working_hours_on_account_id ON public.working_hours USING btree (account_id);


--
-- Name: index_working_hours_on_inbox_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX index_working_hours_on_inbox_id ON public.working_hours USING btree (inbox_id);


--
-- Name: reporting_events__account_id__name__created_at; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX reporting_events__account_id__name__created_at ON public.reporting_events USING btree (account_id, name, created_at);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX taggings_idx ON public.taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: taggings_idy; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX taggings_idy ON public.taggings USING btree (taggable_id, taggable_type, tagger_id, context);


--
-- Name: tags_name_trgm_idx; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX tags_name_trgm_idx ON public.tags USING gin (lower((name)::text) public.gin_trgm_ops);


--
-- Name: uniq_email_per_account_contact; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX uniq_email_per_account_contact ON public.contacts USING btree (email, account_id);


--
-- Name: uniq_identifier_per_account_contact; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX uniq_identifier_per_account_contact ON public.contacts USING btree (identifier, account_id);


--
-- Name: uniq_primary_actor_per_account_notifications; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX uniq_primary_actor_per_account_notifications ON public.notifications USING btree (primary_actor_type, primary_actor_id);


--
-- Name: uniq_secondary_actor_per_account_notifications; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX uniq_secondary_actor_per_account_notifications ON public.notifications USING btree (secondary_actor_type, secondary_actor_id);


--
-- Name: uniq_user_id_per_account_id; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX uniq_user_id_per_account_id ON public.account_users USING btree (account_id, user_id);


--
-- Name: unique_permissibles_index; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE UNIQUE INDEX unique_permissibles_index ON public.platform_app_permissibles USING btree (platform_app_id, permissible_id, permissible_type);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX user_index ON public.audits USING btree (user_id, user_type);


--
-- Name: vector_idx_knowledge_entries_embedding; Type: INDEX; Schema: public; Owner: chatwoot_user
--

CREATE INDEX vector_idx_knowledge_entries_embedding ON public.captain_assistant_responses USING ivfflat (embedding);


--
-- Name: accounts accounts_after_insert_row_tr; Type: TRIGGER; Schema: public; Owner: chatwoot_user
--

CREATE TRIGGER accounts_after_insert_row_tr AFTER INSERT ON public.accounts FOR EACH ROW EXECUTE FUNCTION public.accounts_after_insert_row_tr();


--
-- Name: accounts camp_dpid_before_insert; Type: TRIGGER; Schema: public; Owner: chatwoot_user
--

CREATE TRIGGER camp_dpid_before_insert AFTER INSERT ON public.accounts FOR EACH ROW EXECUTE FUNCTION public.camp_dpid_before_insert();


--
-- Name: campaigns campaigns_before_insert_row_tr; Type: TRIGGER; Schema: public; Owner: chatwoot_user
--

CREATE TRIGGER campaigns_before_insert_row_tr BEFORE INSERT ON public.campaigns FOR EACH ROW EXECUTE FUNCTION public.campaigns_before_insert_row_tr();


--
-- Name: conversations conversations_before_insert_row_tr; Type: TRIGGER; Schema: public; Owner: chatwoot_user
--

CREATE TRIGGER conversations_before_insert_row_tr BEFORE INSERT ON public.conversations FOR EACH ROW EXECUTE FUNCTION public.conversations_before_insert_row_tr();


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: inboxes fk_rails_a1f654bf2d; Type: FK CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.inboxes
    ADD CONSTRAINT fk_rails_a1f654bf2d FOREIGN KEY (portal_id) REFERENCES public.portals(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: chatwoot_user
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- PostgreSQL database dump complete
--

