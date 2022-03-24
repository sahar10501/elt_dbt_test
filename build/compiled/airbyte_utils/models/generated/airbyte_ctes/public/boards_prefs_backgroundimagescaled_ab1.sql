
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
