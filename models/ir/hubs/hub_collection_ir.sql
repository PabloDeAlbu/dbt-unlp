{{ config(materialized='incremental')    }}

{%- set source_model = "stg_collection_ir" -%}
{%- set src_pk = "collection_hk" -%}
{%- set src_nk = "collection_id" -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
