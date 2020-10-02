{strip}
{if !$userDetails.isHeadOffice}
{assign var="headerSection" value="My Courses" scope="global"}
{else}
{assign var="headerSection" value="Courses" scope="global"}
{/if}
{include file="assets/page-header.tpl"}
{include file="course/listCourses.tpl"}
{/strip}