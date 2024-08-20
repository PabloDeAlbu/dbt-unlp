{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 
  'openalex': 'work'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
  effective_from: publication_date
  start_date: publication_date
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  work_hk: id
  doi_hk: doi
  work_doi_hk:
    - id
    - doi
  mag_hk: mag
  work_mag_hk:
    - id
    - mag
  pmid_hk: pmid
  work_pmid_hk:
    - id
    - pmid
  pmcid_hk: pmcid
  work_pmcid_hk:
    - id
    - pmcid
  type_hk: type
  work_type_hk:
    - id
    - type
  language_hk: language
  work_language_hk:
    - id
    - language
  work_hashdiff:
    is_hashdiff: true
    columns:
      - id
      - doi
      - title
      - display_name
      - publication_year
      - publication_date
      - language
      - type
      - countries_distinct_count
      - institutions_distinct_count
      - fwci
      - has_fulltext
      - fulltext_origin
      - cited_by_count
      - is_retracted
      - is_paratext
      - locations_count
      - referenced_works_count
      - updated_date
      - created_date
      - mag
      - openalex
      - pmcid
      - pmid
      - any_repository_has_fulltext
      - is_oa
      - oa_status
      - oa_url
      - cited_by_percentile_year_max
      - cited_by_percentile_year_min
      - citation_normalized_percentile_is_in_top_10_percent
      - citation_normalized_percentile_is_in_top_1_percent
      - citation_normalized_percentile_value
      - primary_location_source_id
      - apc_list_currency
      - apc_list_provenance
      - apc_list_value
      - apc_list_value_usd
      - apc_paid_currency
      - apc_paid_provenance
      - apc_paid_value
      - apc_paid_value_usd
      - primary_topic_id
      - indexed_in_arxiv
      - indexed_in_doaj
      - indexed_in_crossref
      - indexed_in_pubmed

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
