
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
