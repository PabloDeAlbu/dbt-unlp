{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        item_pk,
        text_value as handle,
        load_datetime
    FROM {{ ref('seed_item_columns_dspacedb')}} i
    INNER JOIN {{ref('mid_item_metadatavalue_dspacedb')}} mv 
        ON i.short_id = mv.short_id 
        AND i.element = mv.element 
        AND i.qualifier = mv.qualifier 
    WHERE i.column = 'handle'
)

SELECT * FROM base