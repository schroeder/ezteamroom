{let use_url_translation=ezini('URLTranslator','Translation')|eq('enabled')
     is_update=false()}
{section loop=$object.versions}{section show=and($:item.status|eq(3),$:item.version|ne($object.current_version))}{set is_update=true()}{/section}{/section}
{section show=$is_update}
{if $object.name|ne( '' )}
{set-block scope=root variable=subject}{$object.content_class.name|wash} {'"%name" was updated'|i18n('ezteamroom/collaboration', '', hash( '%name', $object.name|wash ))} [{ezini("SiteSettings","SiteURL")} - {$object.main_node.parent.name|wash}]{/set-block}
{else}
{set-block scope=root variable=subject}{$object.content_class.name|wash} {'was updated'|i18n('ezteamroom/collaboration', '', hash( '%name', $object.name|wash ))} [{ezini("SiteSettings","SiteURL")} - {$object.main_node.parent.name|wash}]{/set-block}
{/if}
{set-block scope=root variable=from}{concat($object.current.creator.name|wash,' <', $sender, '>')}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=reply_to}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
{"This email is to inform you that an updated item has been published at %sitename."|i18n('ezteamroom/collaboration','',hash('%sitename',ezini("SiteSettings","SiteURL")))}
{"The item can be viewed by using the URL below."|i18n('ezteamroom/collaboration')}

{$object.name|wash} - {$object.current.creator.name|wash} (Owner: {$object.owner.name|wash})
{section-else}
{if $object.name|ne( '' )}
{set-block scope=root variable=subject}{$object.content_class.name|wash} {'"%name" was published'|i18n('ezteamroom/collaboration', '', hash( '%name', $object.name|wash ))} [{ezini("SiteSettings","SiteURL")} - {$object.main_node.parent.name|wash}]{/set-block}
{else}
{set-block scope=root variable=subject}{$object.content_class.name|wash} {'was published'|i18n('ezteamroom/collaboration' )} [{ezini("SiteSettings","SiteURL")} - {$object.main_node.parent.name|wash}]{/set-block}
{/if}
{set-block scope=root variable=from}{concat($object.owner.name,' <', $sender, '>')}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=reply_to}{concat('<node.',$object.main_node.parent_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.parent.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
{"This email is to inform you that a new item has been published at %sitename."|i18n('ezteamroom/collaboration','',hash('%sitename',ezini("SiteSettings","SiteURL")))}
{"The item can be viewed by using the URL below."|i18n('ezteamroom/collaboration')}

{$object.name|wash} - {$object.owner.name|wash}
{/section}

http://{ezini("SiteSettings","SiteURL")}{cond( $use_url_translation, $object.main_node.url_alias|ezurl(no),
                                               true(), concat( "/content/view/full/", $object.main_node_id )|ezurl(no) )}


{"If you do not want to continue receiving these notifications,
change your settings at:"|i18n('ezteamroom/collaboration')}
http://{ezini("SiteSettings","SiteURL")}{concat("notification/settings/")|ezurl(no)}

--
{"%sitename notification system"
 |i18n('ezteamroom/collaboration',,
       hash('%sitename',ezini("SiteSettings","SiteURL")))}
{/let}
