
with __dbt__cte__boards_limits_attachments_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards_limits"
select
    _airbyte_limits_hashid,
    
        jsonb_extract_path(table_alias.attachments, 'perBoard')
     as perboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards_limits" as table_alias
-- attachments at boards/limits/attachments
where 1 = 1
and attachments is not null

),  __dbt__cte__boards_limits_attachments_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_limits_attachments_ab1
select
    _airbyte_limits_hashid,
    cast(perboard as 
    jsonb
) as perboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_limits_attachments_ab1
-- attachments at boards/limits/attachments
where 1 = 1

),  __dbt__cte__boards_limits_attachments_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_limits_attachments_ab2
select
    md5(cast(coalesce(cast(_airbyte_limits_hashid as 
    varchar
), '') || '-' || coalesce(cast(perboard as 
    varchar
), '') as 
    varchar
)) as _airbyte_attachments_hashid,
    tmp.*
from __dbt__cte__boards_limits_attachments_ab2 tmp
-- attachments at boards/limits/attachments
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__boards_limits_attachments_ab3
select
    _airbyte_limits_hashid,
    perboard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_attachments_hashid
from __dbt__cte__boards_limits_attachments_ab3
-- attachments at boards/limits/attachments from "bzr_etl_task".public."boards_limits"
where 1 = 1
