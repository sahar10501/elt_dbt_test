
with __dbt__cte__boards_prefs_ab1 as (

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

),  __dbt__cte__boards_prefs_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__boards_prefs_ab1
select
    _airbyte_boards_hashid,
    cast(voting as 
    varchar
) as voting,
    cast(canbeorg as boolean) as canbeorg,
    cast("comments" as 
    varchar
) as "comments",
    cast(selfjoin as boolean) as selfjoin,
    cast(caninvite as boolean) as caninvite,
    cast(cardaging as 
    varchar
) as cardaging,
    cast(hidevotes as boolean) as hidevotes,
    cast(background as 
    varchar
) as background,
    cast(cardcovers as boolean) as cardcovers,
    cast(istemplate as boolean) as istemplate,
    cast(canbepublic as boolean) as canbepublic,
    cast(invitations as 
    varchar
) as invitations,
    cast(canbeprivate as boolean) as canbeprivate,
    cast(backgroundtile as boolean) as backgroundtile,
    cast(backgroundimage as 
    varchar
) as backgroundimage,
    cast(canbeenterprise as boolean) as canbeenterprise,
    cast(permissionlevel as 
    varchar
) as permissionlevel,
    cast(backgroundtopcolor as 
    varchar
) as backgroundtopcolor,
    cast(calendarfeedenabled as boolean) as calendarfeedenabled,
    cast(backgroundbrightness as 
    varchar
) as backgroundbrightness,
    cast(backgroundbottomcolor as 
    varchar
) as backgroundbottomcolor,
    backgroundimagescaled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__boards_prefs_ab1
-- prefs at boards/prefs
where 1 = 1

),  __dbt__cte__boards_prefs_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__boards_prefs_ab2
select
    md5(cast(coalesce(cast(_airbyte_boards_hashid as 
    varchar
), '') || '-' || coalesce(cast(voting as 
    varchar
), '') || '-' || coalesce(cast(canbeorg as 
    varchar
), '') || '-' || coalesce(cast("comments" as 
    varchar
), '') || '-' || coalesce(cast(selfjoin as 
    varchar
), '') || '-' || coalesce(cast(caninvite as 
    varchar
), '') || '-' || coalesce(cast(cardaging as 
    varchar
), '') || '-' || coalesce(cast(hidevotes as 
    varchar
), '') || '-' || coalesce(cast(background as 
    varchar
), '') || '-' || coalesce(cast(cardcovers as 
    varchar
), '') || '-' || coalesce(cast(istemplate as 
    varchar
), '') || '-' || coalesce(cast(canbepublic as 
    varchar
), '') || '-' || coalesce(cast(invitations as 
    varchar
), '') || '-' || coalesce(cast(canbeprivate as 
    varchar
), '') || '-' || coalesce(cast(backgroundtile as 
    varchar
), '') || '-' || coalesce(cast(backgroundimage as 
    varchar
), '') || '-' || coalesce(cast(canbeenterprise as 
    varchar
), '') || '-' || coalesce(cast(permissionlevel as 
    varchar
), '') || '-' || coalesce(cast(backgroundtopcolor as 
    varchar
), '') || '-' || coalesce(cast(calendarfeedenabled as 
    varchar
), '') || '-' || coalesce(cast(backgroundbrightness as 
    varchar
), '') || '-' || coalesce(cast(backgroundbottomcolor as 
    varchar
), '') || '-' || coalesce(cast(backgroundimagescaled as 
    varchar
), '') as 
    varchar
)) as _airbyte_prefs_hashid,
    tmp.*
from __dbt__cte__boards_prefs_ab2 tmp
-- prefs at boards/prefs
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__boards_prefs_ab3
select
    _airbyte_boards_hashid,
    voting,
    canbeorg,
    "comments",
    selfjoin,
    caninvite,
    cardaging,
    hidevotes,
    background,
    cardcovers,
    istemplate,
    canbepublic,
    invitations,
    canbeprivate,
    backgroundtile,
    backgroundimage,
    canbeenterprise,
    permissionlevel,
    backgroundtopcolor,
    calendarfeedenabled,
    backgroundbrightness,
    backgroundbottomcolor,
    backgroundimagescaled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_prefs_hashid
from __dbt__cte__boards_prefs_ab3
-- prefs at boards/prefs from "bzr_etl_task".public."boards"
where 1 = 1
