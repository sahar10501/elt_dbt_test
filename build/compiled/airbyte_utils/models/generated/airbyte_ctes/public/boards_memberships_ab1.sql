
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
