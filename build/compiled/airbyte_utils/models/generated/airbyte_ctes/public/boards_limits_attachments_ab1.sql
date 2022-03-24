
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
