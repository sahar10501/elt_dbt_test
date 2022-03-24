
with __dbt__cte__boards_limits_attachments_perboard_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards_limits_attachments"
select
    _airbyte_attachments_hashid,
    jsonb_extract_path_text(perboard, 'status') as status,
    jsonb_extract_path_text(perboard, 'warnAt') as warnat,
    jsonb_extract_path_text(perboard, 'disableAt') as disableat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards_limits_attachments" as table_alias
-- perboard at boards/limits/attachments/perBoard
where 1 = 1
and perboard is not null

),  __dbt__cte__boards_limits_attachments_perboard_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_limits_attachments_perboard_ab1
select
    _airbyte_attachments_hashid,
    cast(status as 
    varchar
) as status,
    cast(warnat as 
    bigint
) as warnat,
    cast(disableat as 
    bigint
) as disableat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_limits_attachments_perboard_ab1
-- perboard at boards/limits/attachments/perBoard
where 1 = 1

),  __dbt__cte__boards_limits_attachments_perboard_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_limits_attachments_perboard_ab2
select
    md5(cast(coalesce(cast(_airbyte_attachments_hashid as 
    varchar
), '') || '-' || coalesce(cast(status as 
    varchar
), '') || '-' || coalesce(cast(warnat as 
    varchar
), '') || '-' || coalesce(cast(disableat as 
    varchar
), '') as 
    varchar
)) as _airbyte_perboard_hashid,
    tmp.*
from __dbt__cte__boards_limits_attachments_perboard_ab2 tmp
-- perboard at boards/limits/attachments/perBoard
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__boards_limits_attachments_perboard_ab3
select
    _airbyte_attachments_hashid,
    status,
    warnat,
    disableat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_perboard_hashid
from __dbt__cte__boards_limits_attachments_perboard_ab3
-- perboard at boards/limits/attachments/perBoard from "bzr_etl_task".public."boards_limits_attachments"
where 1 = 1
