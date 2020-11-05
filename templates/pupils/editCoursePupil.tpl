{strip}
{if $addDoc}
{assign var="headerSection" value="Add Pupil" scope="global"}
{else}
{assign var="headerSection" value="Edit Pupil" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{assign var="backURL" value="pupils/" scope="global"}
{assign var="backText" value="Back to documents" scope="global"}
{include file="assets/back-button.tpl"}


{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}