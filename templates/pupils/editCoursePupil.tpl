{strip}
{if $addDoc}
{assign var="headerSection" value="Add Pupil" scope="global"}
{else}
{assign var="headerSection" value="Edit Pupil" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{assign var="backURL" value="pupils/" scope="global"}
{assign var="backText" value="Back to pupils" scope="global"}
{include file="assets/back-button.tpl"}
<div class="card border-primary">
    <div class="card-header bg-primary">{$headerSection}</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group row">
                <label for="name" class="col-md-3 control-label"><span class="text-danger">*</span> Name:</label>
                <div class="col-md-9"><input type="text" name="required[name]" id="name" value="{$pupilInfo.name}" size="9" placeholder="Name" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-md-3 control-label"><span class="text-danger">*</span> Email:</label>
                <div class="col-md-9"><input type="text" name="required[email]" id="email" value="{$pupilInfo.email}" size="9" placeholder="Email Address" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="submitbtn">{$headerSection}</label><button id="submitbtn" class="btn btn-success" type="submit">{$headerSection}</button></div>
            </div>
        </form>
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}