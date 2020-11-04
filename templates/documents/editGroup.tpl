{strip}
{if $addGroup}
{assign var="headerSection" value="Add Document Group" scope="global"}
{else}
{assign var="headerSection" value="Edit Document Group" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{assign var="backURL" value="course-documents/groups/" scope="global"}
{assign var="backText" value="Back to groups" scope="global"}
{include file="assets/back-button.tpl"}
<div class="card border-primary">
    <div class="card-header bg-primary">{$headerSection}</div>
    <div class="card-body pb-0">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group row{if $error && !$smarty.post.group_name} has-error{/if}">
                <label for="group_name" class="col-md-3 control-label"><span class="text-danger">*</span> Name:</label>
                <div class="col-md-9"><input type="text" name="group_name" id="group_name" value="{$groupinfo.name}" size="9" placeholder="Document group name" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="submitbtn">Submit</label><button id="submitbtn" class="btn btn-success" type="submit">{$headerSection}</button></div>
            </div>
        </form>
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}