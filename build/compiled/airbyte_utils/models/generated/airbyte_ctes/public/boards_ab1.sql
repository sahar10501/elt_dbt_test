
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public._airbyte_raw_boards
select
    jsonb_extract_path_text(_airbyte_data, 'id') as "id",
    jsonb_extract_path_text(_airbyte_data, 'url') as url,
    jsonb_extract_path_text(_airbyte_data, 'desc') as "desc",
    jsonb_extract_path_text(_airbyte_data, 'name') as "name",
    
        jsonb_extract_path(table_alias._airbyte_data, 'prefs')
     as prefs,
    jsonb_extract_path_text(_airbyte_data, 'closed') as closed,
    jsonb_extract_path(_airbyte_data, 'idTags') as idtags,
    
        jsonb_extract_path(table_alias._airbyte_data, 'limits')
     as limits,
    jsonb_extract_path_text(_airbyte_data, 'pinned') as pinned,
    jsonb_extract_path_text(_airbyte_data, 'starred') as starred,
    jsonb_extract_path_text(_airbyte_data, 'descData') as descdata,
    jsonb_extract_path_text(_airbyte_data, 'ixUpdate') as ixupdate,
    jsonb_extract_path(_airbyte_data, 'powerUps') as powerups,
    jsonb_extract_path_text(_airbyte_data, 'shortUrl') as shorturl,
    jsonb_extract_path_text(_airbyte_data, 'shortLink') as shortlink,
    
        jsonb_extract_path(table_alias._airbyte_data, 'labelNames')
     as labelnames,
    jsonb_extract_path_text(_airbyte_data, 'subscribed') as subscribed,
    jsonb_extract_path(_airbyte_data, 'memberships') as memberships,
    jsonb_extract_path_text(_airbyte_data, 'dateLastView') as datelastview,
    jsonb_extract_path_text(_airbyte_data, 'idEnterprise') as identerprise,
    jsonb_extract_path_text(_airbyte_data, 'idBoardSource') as idboardsource,
    jsonb_extract_path_text(_airbyte_data, 'creationMethod') as creationmethod,
    jsonb_extract_path_text(_airbyte_data, 'idOrganization') as idorganization,
    jsonb_extract_path_text(_airbyte_data, 'enterpriseOwned') as enterpriseowned,
    jsonb_extract_path(_airbyte_data, 'premiumFeatures') as premiumfeatures,
    jsonb_extract_path_text(_airbyte_data, 'templateGallery') as templategallery,
    jsonb_extract_path_text(_airbyte_data, 'dateLastActivity') as datelastactivity,
    jsonb_extract_path_text(_airbyte_data, 'datePluginDisable') as dateplugindisable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public._airbyte_raw_boards as table_alias
-- boards
where 1 = 1
