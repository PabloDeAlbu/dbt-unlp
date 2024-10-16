{{ config(materialized='table') }}

WITH type_snrd AS (
    SELECT
    type_snrd_hk,
    type_snrd as type_snrd
    FROM {{ref('hub_type_snrd_oai')}}
),

{# type_openaire AS (
    SELECT
    type_openaire_hk,
    UPPER(type_openaire) as type_openaire
    FROM {{ref('hub_type_openaire_oai')}}
), #}

map2snrd AS (
    SELECT
        *
    FROM {{ref('seed_types_snrd2types_coar')}}
    ORDER BY type
),

final AS (
    SELECT 
        type_snrd_hk,
        type_snrd,
        type,
        label_es as coar_label_es,
        coar
    FROM type_snrd
    INNER JOIN map2snrd ON type_snrd.type_snrd = map2snrd.type
)

SELECT * FROM final