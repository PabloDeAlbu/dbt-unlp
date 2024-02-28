with base as (
    SELECT map.orgunit_name, map.community_handle, c.community_id
    FROM {{ ref('map_handle_ua') }} map
    INNER JOIN {{ ref('community') }} c ON c.community_handle = map.community_handle
),

final as (
    select * from base
)

select * from final