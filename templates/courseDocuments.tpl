{strip}
{assign var="headerSection" value="Course Documents" scope="global"}
{include file="assets/page-header.tpl"}
{include file="assets/back-button.tpl"}
{assign var="title" value=$headerSection scope="global"}
{if $userDetails.isHeadOffice}
    <div class="row">
        <div class="col-12 text-right">
            <a href="/student/learning/{$courseInfo.url}/course-documents/groups/" title="Add new item" class="btn btn-info"><span class="fa fa-edit fa-fw"></span> Edit Groups</a> <a href="/student/learning/{$courseInfo.url}/course-documents/add" title="Add new item" class="btn btn-success"><span class="fa fa-plus fa-fw"></span> Add new document</a>
        </div>
    </div>
{/if}
{include file="documents/listDocuments.tpl"}
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}