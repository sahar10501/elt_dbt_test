
with __dbt__cte__boards_limits_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards"
select
    _airbyte_boards_hashid,
    
        jsonb_extract_path(table_alias.limits, 'attachments')
     as attachments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards" as table_alias
-- limits at boards/limits
where 1 = 1
and limits is not null

),  __dbt__cte__boards_limits_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_limits_ab1
select
    _airbyte_boards_hashid,
    cast(attachments as 
    jsonb
) as attachments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_limits_ab1
-- limits at boards/limits
where 1 = 1

),  __dbt__cte__boards_limits_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_limits_ab2
select
    md5(cast(coalesce(cast(_airbyte_boards_hashid as 
    varchar
), '') || '-' || coalesce(cast(attachments as 
    varchar
), '') as 
    varchar
)) as _airbyte_limits_hashid,
    tmp.*
from __dbt__cte__boards_limits_ab2 tmp
-- limits at boards/limits
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__boards_limits_ab3
select
    _airbyte_boards_hashid,
    attachments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_limits_hashid
from __dbt__cte__boards_limits_ab3
-- limits at boards/limits from "bzr_etl_task".public."boards"
where 1 = 1
