
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
