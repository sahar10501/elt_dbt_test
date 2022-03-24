
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
