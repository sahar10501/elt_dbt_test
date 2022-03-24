
with __dbt__cte__boards_prefs_backgroundimagescaled_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards_prefs"

select
    _airbyte_prefs_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'url') as url,
    jsonb_extract_path_text(_airbyte_nested_data, 'width') as width,
    jsonb_extract_path_text(_airbyte_nested_data, 'height') as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards_prefs" as table_alias
-- backgroundimagescaled at boards/prefs/backgroundImageScaled
cross join jsonb_array_elements(
        case jsonb_typeof(backgroundimagescaled)
        when 'array' then backgroundimagescaled
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and backgroundimagescaled is not null

),  __dbt__cte__boards_prefs_backgroundimagescaled_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_prefs_backgroundimagescaled_ab1
select
    _airbyte_prefs_hashid,
    cast(url as 
    varchar
) as url,
    cast(width as 
    bigint
) as width,
    cast(height as 
    bigint
) as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_prefs_backgroundimagescaled_ab1
-- backgroundimagescaled at boards/prefs/backgroundImageScaled
where 1 = 1

),  __dbt__cte__boards_prefs_backgroundimagescaled_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_prefs_backgroundimagescaled_ab2
select
    md5(cast(coalesce(cast(_airbyte_prefs_hashid as 
    varchar
), '') || '-' || coalesce(cast(url as 
    varchar
), '') || '-' || coalesce(cast(width as 
    varchar
), '') || '-' || coalesce(cast(height as 
    varchar
), '') as 
    varchar
)) as _airbyte_backgroundimagescaled_hashid,
    tmp.*
from __dbt__cte__boards_prefs_backgroundimagescaled_ab2 tmp
-- backgroundimagescaled at boards/prefs/backgroundImageScaled
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__boards_prefs_backgroundimagescaled_ab3
select
    _airbyte_prefs_hashid,
    url,
    width,
    height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_backgroundimagescaled_hashid
from __dbt__cte__boards_prefs_backgroundimagescaled_ab3
-- backgroundimagescaled at boards/prefs/backgroundImageScaled from "bzr_etl_task".public."boards_prefs"
where 1 = 1
