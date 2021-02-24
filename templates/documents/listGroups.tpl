{strip}
{assign var="headerSection" value="Document Groups" scope="global"}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{if $add || $edit || $delete || $smarty.get.editgroup || $smarty.get.deletegroup}
    {assign var="backURL" value="course-documents/" scope="global"}
    {assign var="backText" value="Back to documents" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
<div class="row">
    <div class="col-12">
        <a href="/student/learning/{$courseInfo.url}/course-documents/groups/add" title="Add new group" class="btn btn-success float-right mb-3"><span class="fa fa-plus fa-fw"></span> Add group</a>
    </div>
</div>
 <div class="card border-primary">
    <div class="card-header bg-primary font-weight-bold">Groups</div>
    {if is_array($doc_groups)}
        <ul class="list-group">
        {foreach $doc_groups as $group}
            <li class="list-group-item">{$group.name}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/groups/edit/{$group.id}/" title="Edit group" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a>{if $group.items == 0} <a href="/student/learning/{$courseInfo.url}/course-documents/groups/delete/{$group.id}/" title="Delete group" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a>{/if}</div></li>
        {/foreach}
        </ul>
    {else}
        <div class="card-body text-center">
            There are currently no document groups
        </div>
    {/if}
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}