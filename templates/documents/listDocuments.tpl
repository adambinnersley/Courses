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
<div class="row">
    {assign var="first" value=1}
    {foreach $documents as $doc}
        {if $group != $doc.group && $doc.group}{if !$first}</ul></div></div>{/if}<div class="col-md-4 col-sm-6"><div class="card"><div class="card-header">{$doc.group}</div>{if $userDetails.isHeadOffice}<ul class="list-group">{/if}{/if}

        {assign var="group" value=$doc.group}
        {if $userDetails.isHeadOffice}<li class="list-group-item">{/if}<a href="/student/learning/{$courseInfo.url}/documents/{$doc.file}" title="{$doc.link_text}" target="_blank"{if !$userDetails.isHeadOffice} class="list-group-item"{/if}>{$doc.link_text}{if $doc.description}<br /><small>{$doc.description}</small>{/if}</a>{if $userDetails.isHeadOffice}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/edit/{$doc.id}" title="Edit item" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/course-documents/delete/{$doc.id}" title="Delete item" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a></div></li>{/if}
        {assign var="first" value=false}
    {/foreach}
    {if $userDetails.isHeadOffice}</ul>{/if}
        </div>
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}