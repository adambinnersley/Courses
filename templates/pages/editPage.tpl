{strip}
{if $addPage}
{assign var="headerSection" value="Add Page" scope="global"}
{else}
{assign var="headerSection" value="Edit Page" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{assign var="backURL" value="info/" scope="global"}
{assign var="backText" value="Back to Pages" scope="global"}
{include file="assets/back-button.tpl"}
<div class="card border-primary">
    <div class="card-header bg-primary font-weight-bold">{$headerSection}</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group row">
                <label for="title" class="col-md-2 control-label">Title:</label>
                <div class="col-md-10"><input type="text" name="title" id="title" class="form-control" value="{$page.title}" /></div>
            </div>
            {if $subpages}<div class="form-group row">
                <label for="subpage" class="col-md-2 control-label">Subpage of:</label>
                <div class="col-md-10">
                    <select name="subpage" id="subpage" class="form-control">
                        <option value="0">None</option>
                        <optgroup label="Select Page">
                        {foreach $subpages as $pages}
                            <option value="{$pages.page_id}"{if $page.subpage == $pages.page_id} selected="selected"{/if}>{$pages.order}) {$pages.title}</option>
                        {/foreach}
                        </optgroup>
                    </select>
                </div>
            </div>{/if}
            <div class="form-group row">
                <label for="content" class="col-md-2 control-label">Content:</label>
                <div class="col-md-10"><textarea name="content" id="content" class="form-control wysiwyg" rows="20">{$page.content}</textarea></div>
            </div>
            <div class="text-center"><input type="submit" name="submit" id="submit" value="{$headerSection}" class="btn btn-success btn-lg" /></div>
        </form>
    </div>
</div>
{include file="assets/back-button.tpl"}
{/strip}