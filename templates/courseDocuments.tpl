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
            <div class="card">
                <div class="card-header">Add Document Group</div>
                <div class="card-body">
                    <form method="post" action="" class="form-horizontal">
                        <div class="form-group{if $error && !$smarty.post.group_name} has-error{/if}">
                            <label for="group_name" class="col-md-3 control-label"><span class="text-danger">*</span> Name:</label>
                            <div class="col-md-9"><input type="text" name="group_name" id="group_name" value="{$group_name}" size="9" placeholder="Document group name" class="form-control" /></div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="submitbtn">Submit</label><input name="submitbtn" id="submitbtn" class="btn btn-success" type="submit" value="Add Group" /></div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card">
                <div class="card-header">Edit Document Groups</div>
                    <ul class="list-group">
                    {foreach $doc_groups as $group}
                        <li class="list-group-item">{$group.name}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/edit/{$group.id}/#editgroup" title="Edit group" class="btn btn-warning btn-xs"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a>{if $group.items == 0} <a href="/student/learning/{$courseInfo.url}/course-documents/delete/{$group.id}/#deletegroup" title="Delete group" class="btn btn-danger btn-xs"><span class="fa fa-trash fa-fw"></span> Delete</a>{/if}</div></li>
                    {/foreach}
                    </ul>
            </div>
            {if $smarty.get.editgroup >= 1 && $groupinfo && $userDetails.isHeadOffice}
            <div class="card border-warning" id="editgroup">
                <div class="card-header">Edit Group</div>
                <div class="card-body">
                    <form method="post" action="" class="form-horizontal">
                        <div class="form-group{if $error && !$smarty.post.group_name} has-error{/if}">
                            <label for="edit_group_name" class="col-md-3 control-label"><span class="text-danger">*</span> Name:</label>
                            <div class="col-md-9"><input type="text" name="edit_group_name" id="edit_group_name" value="{$groupinfo.name}" size="9" placeholder="Document group name" class="form-control" /></div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="editbtn">Submit</label><input name="editbtn" id="editbtn" class="btn btn-success" type="submit" value="Edit Group" /></div>
                        </div>
                    </form>
                </div>
            </div>
            {/if}
            {if $smarty.get.deletegroup >= 1 && $groupinfo && $userDetails.isHeadOffice}
            <div class="card border-danger" id="deletegroup">
                <div class="card-header">Delete Group</div>
                <div class="card-body">
                    <h4 class="text-center">Confirm Delete</h4>
                    <p class="text-center">Are you sure that you want to delete the <strong>{$group.name}</strong> group?</p>
                    <div class="text-center">
                        <form method="post" action="" class="form-inline">
                            <a href="course-documents" title="No, leave it as is" class="btn btn-success">No, leave it as is</a> &nbsp; 
                            <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete document group" />
                        </form>
                    </div>
                </div>
            </div>
            {/if}
        </div>
    </div>
{elseif $delete}
    <div class="row">
        <div class="col-12">
            <h3 class="text-center">Confirm Delete</h3>
            <p class="text-center">Are you sure you wish to delete the <strong>{$item.link_text} <small>({$item.file})</small></strong> document?</p>
            <div class="text-center">
            <form method="post" action="" class="form-inline">
                <a href="/student/learning/{$courseInfo.url}/course-documents/" title="No, return to documents" class="btn btn-success">No, return to documents</a> &nbsp; 
                <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete document" />
            </form>
            </div>
        </div>
    </div>
{else}
    <div class="row">
        {assign var="first" value=1}
        {foreach $documents as $doc}
            {if $group != $doc.group && $doc.group}{if !$first}</ul></div></div>{/if}<div class="col-md-4 col-sm-6"><div class="card"><div class="card-header">{$doc.group}</div>{if $userDetails.isHeadOffice}<ul class="list-group">{/if}{/if}

            {assign var="group" value=$doc.group}
            {if $userDetails.isHeadOffice}<li class="list-group-item">{/if}<a href="{$courseRoot}documents/{$doc.course_id}/{$doc.file}" title="{$doc.link_text}" target="_blank"{if !$userDetails.isHeadOffice} class="list-group-item"{/if}>{$doc.link_text}</a>{if $userDetails.isHeadOffice}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.id}/edit" title="Edit item" class="btn btn-warning btn-xs"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.id}/delete" title="Delete item" class="btn btn-danger btn-xs"><span class="fa fa-trash fa-fw"></span> Delete</a></div></li>{/if}
            {assign var="first" value=false}
        {/foreach}
        {if $userDetails.isHeadOffice}</ul>{/if}
            </div>
        </div>
    </div>
{/if}
{include file="assets/back-button.tpl"}
{/strip}