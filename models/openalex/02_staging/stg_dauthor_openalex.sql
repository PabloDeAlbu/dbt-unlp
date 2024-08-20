{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 
  'openalex': 'dauthor'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  dauthor_hk: id
  orcid_hk: orcid
  dauthor_orcid_hk:
    - id
    - orcid
  dauthor_hashdiff:
    is_hashdiff: true
    columns:
      - id
      - orcid
      - display_name
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
