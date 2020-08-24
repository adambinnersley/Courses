{strip}
{assign var="headerSection" value="Course Documents" scope="global"}
{include file="assets/page-header.tpl"}
{if $userDetails.isHeadOffice && !$add && !$delete && !$smarty.get.editgroup && !$smarty.get.deletegroup}
    <div class="row">
        <div class="col-12">
            <a href="/student/learning/{$courseInfo.url}/course-documents/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new document</a>
        </div>
    </div>
{/if}
{if $add || $edit || $delete || $smarty.get.editgroup || $smarty.get.deletegroup}
    {assign var="backURL" value="course-documents/" scope="global"}
    {assign var="backText" value="Back to documents" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
{if $add || $edit || $smarty.get.editgroup || $smarty.get.deletegroup}
    <div class="row">
        {if $doc_groups}
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">{if $edit}Edit{else}Add{/if} document</div>
                <div class="card-body">
                    <form method="post" action="" enctype="multipart/form-data" class="form-horizontal">
                        <div class="form-group form-inline">
                            <label for="document" class="col-md-3 control-label">Document</label>
                            <div class="col-md-9">
                                <input type="file" name="document" id="document" />
                            </div>
                        </div>
                        <div class="form-group{if $error && !$doc_group} has-error{/if}">
                            <label for="doc_title" class="col-md-3 control-label"><span class="text-danger">*</span> Group:</label>
                            <div class="col-md-9">
                            <select name="doc_group" id="doc_group" class="form-control">
                                {foreach $doc_groups as $group}
                                    <option value="{$group.id}"{if $group.id == $item.group_id} selected="selected"{/if}>{$group.name}</option>
                                {/foreach}
                            </select>
                            </div>
                        </div>
                        <div class="form-group{if $error && !$doc_title} has-error{/if}">
                            <label for="link_text" class="col-md-3 control-label"><span class="text-danger">*</span> Document Title:</label>
                            <div class="col-md-9"><input type="text" name="link_text" id="link_text" value="{if $smarty.post.link_text}{$smarty.post.link_text}{else}{$item.link_text}{/if}" size="9" placeholder="Document title (text to display)" class="form-control" /></div>
                        </div>
                        <div class="form-group">
                            <label for="doc_desc" class="col-md-3 control-label">Description:</label>
                            <div class="col-md-9"><textarea name="doc_desc" id="doc_desc" cols="3" placeholder="Document description" class="form-control">{if $smarty.post.doc_desc}{$smarty.post.doc_desc}{else}{$item.description}{/if}</textarea></div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="submitbtn">Submit</label><input name="submitform" id="submitbtn" class="btn btn-success" type="submit" value="{if $edit}Edit{else}Add{/if} Document" /></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        {/if}
        <div class="col-md-6">
            {include file="documents/addGroup.tpl"}
            {include file="documents/listGroups.tpl"}
        </div>
    </div>
{else}
    <div class="row">
        {assign var="first" value=1}
        {foreach $documents as $doc}
            {if $group != $doc.group && $doc.group}{if !$first}</ul></div></div>{/if}<div class="col-md-4 col-sm-6"><div class="card"><div class="card-header">{$doc.group}</div>{if $userDetails.isHeadOffice}<ul class="list-group">{/if}{/if}

            {assign var="group" value=$doc.group}
            {if $userDetails.isHeadOffice}<li class="list-group-item">{/if}<a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.course_id}/{$doc.file}" title="{$doc.link_text}" target="_blank"{if !$userDetails.isHeadOffice} class="list-group-item"{/if}>{$doc.link_text}</a>{if $userDetails.isHeadOffice}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.id}/edit" title="Edit item" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.id}/delete" title="Delete item" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a></div></li>{/if}
            {assign var="first" value=false}
        {/foreach}
        {if $userDetails.isHeadOffice}</ul>{/if}
            </div>
        </div>
    </div>
{/if}
{include file="assets/back-button.tpl"}
{/strip}