
with __dbt__cte__boards_memberships_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards"

select
    _airbyte_boards_hashid,
    jsonb_extract_path_text(_airbyte_nested_data, 'id') as "id",
    jsonb_extract_path_text(_airbyte_nested_data, 'idMember') as idmember,
    jsonb_extract_path_text(_airbyte_nested_data, 'memberType') as membertype,
    jsonb_extract_path_text(_airbyte_nested_data, 'deactivated') as deactivated,
    jsonb_extract_path_text(_airbyte_nested_data, 'unconfirmed') as unconfirmed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards" as table_alias
-- memberships at boards/memberships
cross join jsonb_array_elements(
        case jsonb_typeof(memberships)
        when 'array' then memberships
        else '[]' end
    ) as _airbyte_nested_data
where 1 = 1
and memberships is not null

),  __dbt__cte__boards_memberships_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_memberships_ab1
select
    _airbyte_boards_hashid,
    cast("id" as 
    varchar
) as "id",
    cast(idmember as 
    varchar
) as idmember,
    cast(membertype as 
    varchar
) as membertype,
    cast(deactivated as boolean) as deactivated,
    cast(unconfirmed as boolean) as unconfirmed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_memberships_ab1
-- memberships at boards/memberships
where 1 = 1

)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_memberships_ab2
select
    md5(cast(coalesce(cast(_airbyte_boards_hashid as 
    varchar
), '') || '-' || coalesce(cast("id" as 
    varchar
), '') || '-' || coalesce(cast(idmember as 
    varchar
), '') || '-' || coalesce(cast(membertype as 
    varchar
), '') || '-' || coalesce(cast(deactivated as 
    varchar
), '') || '-' || coalesce(cast(unconfirmed as 
    varchar
), '') as 
    varchar
)) as _airbyte_memberships_hashid,
    tmp.*
from __dbt__cte__boards_memberships_ab2 tmp
-- memberships at boards/memberships
where 1 = 1
