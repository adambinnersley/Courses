{strip}
{assign var="headerSection" value="Course Pupils" scope="global"}
{include file="assets/page-header.tpl"}
{if $userDetails.isHeadOffice}<div class="row"><div class="col-12"><a href="/student/learning/{$courseInfo.url}/pupils/add" title="Add new pupil" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new pupil</a></div></div>{/if}
{include file="assets/back-button.tpl"}
{include file="pupils/coursePupils.tpl"}
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}