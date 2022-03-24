
with __dbt__cte__boards_labelnames_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards"
select
    _airbyte_boards_hashid,
    jsonb_extract_path_text(labelnames, 'red') as red,
    jsonb_extract_path_text(labelnames, 'sky') as sky,
    jsonb_extract_path_text(labelnames, 'blue') as blue,
    jsonb_extract_path_text(labelnames, 'lime') as lime,
    jsonb_extract_path_text(labelnames, 'pink') as pink,
    jsonb_extract_path_text(labelnames, 'black') as black,
    jsonb_extract_path_text(labelnames, 'green') as green,
    jsonb_extract_path_text(labelnames, 'orange') as orange,
    jsonb_extract_path_text(labelnames, 'purple') as purple,
    jsonb_extract_path_text(labelnames, 'yellow') as yellow,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards" as table_alias
-- labelnames at boards/labelNames
where 1 = 1
and labelnames is not null

),  __dbt__cte__boards_labelnames_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_labelnames_ab1
select
    _airbyte_boards_hashid,
    cast(red as 
    varchar
) as red,
    cast(sky as 
    varchar
) as sky,
    cast(blue as 
    varchar
) as blue,
    cast(lime as 
    varchar
) as lime,
    cast(pink as 
    varchar
) as pink,
    cast(black as 
    varchar
) as black,
    cast(green as 
    varchar
) as green,
    cast(orange as 
    varchar
) as orange,
    cast(purple as 
    varchar
) as purple,
    cast(yellow as 
    varchar
) as yellow,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_labelnames_ab1
-- labelnames at boards/labelNames
where 1 = 1

),  __dbt__cte__boards_labelnames_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_labelnames_ab2
select
    md5(cast(coalesce(cast(_airbyte_boards_hashid as 
    varchar
), '') || '-' || coalesce(cast(red as 
    varchar
), '') || '-' || coalesce(cast(sky as 
    varchar
), '') || '-' || coalesce(cast(blue as 
    varchar
), '') || '-' || coalesce(cast(lime as 
    varchar
), '') || '-' || coalesce(cast(pink as 
    varchar
), '') || '-' || coalesce(cast(black as 
    varchar
), '') || '-' || coalesce(cast(green as 
    varchar
), '') || '-' || coalesce(cast(orange as 
    varchar
), '') || '-' || coalesce(cast(purple as 
    varchar
), '') || '-' || coalesce(cast(yellow as 
    varchar
), '') as 
    varchar
)) as _airbyte_labelnames_hashid,
    tmp.*
from __dbt__cte__boards_labelnames_ab2 tmp
-- labelnames at boards/labelNames
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__boards_labelnames_ab3
select
    _airbyte_boards_hashid,
    red,
    sky,
    blue,
    lime,
    pink,
    black,
    green,
    orange,
    purple,
    yellow,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_labelnames_hashid
from __dbt__cte__boards_labelnames_ab3
-- labelnames at boards/labelNames from "bzr_etl_task".public."boards"
where 1 = 1
