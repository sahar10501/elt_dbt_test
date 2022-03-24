
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "bzr_etl_task".public."boards"
select
    _airbyte_boards_hashid,
    jsonb_extract_path_text(prefs, 'voting') as voting,
    jsonb_extract_path_text(prefs, 'canBeOrg') as canbeorg,
    jsonb_extract_path_text(prefs, 'comments') as "comments",
    jsonb_extract_path_text(prefs, 'selfJoin') as selfjoin,
    jsonb_extract_path_text(prefs, 'canInvite') as caninvite,
    jsonb_extract_path_text(prefs, 'cardAging') as cardaging,
    jsonb_extract_path_text(prefs, 'hideVotes') as hidevotes,
    jsonb_extract_path_text(prefs, 'background') as background,
    jsonb_extract_path_text(prefs, 'cardCovers') as cardcovers,
    jsonb_extract_path_text(prefs, 'isTemplate') as istemplate,
    jsonb_extract_path_text(prefs, 'canBePublic') as canbepublic,
    jsonb_extract_path_text(prefs, 'invitations') as invitations,
    jsonb_extract_path_text(prefs, 'canBePrivate') as canbeprivate,
    jsonb_extract_path_text(prefs, 'backgroundTile') as backgroundtile,
    jsonb_extract_path_text(prefs, 'backgroundImage') as backgroundimage,
    jsonb_extract_path_text(prefs, 'canBeEnterprise') as canbeenterprise,
    jsonb_extract_path_text(prefs, 'permissionLevel') as permissionlevel,
    jsonb_extract_path_text(prefs, 'backgroundTopColor') as backgroundtopcolor,
    jsonb_extract_path_text(prefs, 'calendarFeedEnabled') as calendarfeedenabled,
    jsonb_extract_path_text(prefs, 'backgroundBrightness') as backgroundbrightness,
    jsonb_extract_path_text(prefs, 'backgroundBottomColor') as backgroundbottomcolor,
    jsonb_extract_path(prefs, 'backgroundImageScaled') as backgroundimagescaled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "bzr_etl_task".public."boards" as table_alias
-- prefs at boards/prefs
where 1 = 1
and prefs is not null
