{strip}
{if $addPupil}
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
    <div class="card-header bg-primary font-weight-bold">{$headerSection}</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group row">
                <label for="title" class="col-md-3 control-label"><em class="text-danger">*</em> Title:</label>
                <div class="col-md-9 form-inline"><select name="required[title]" id="title" class="form-control">{foreach $titles as $title}<option value="{$title}"{if $pupilInfo.title == $title} selected="selected"{/if}>{$title}</option>{/foreach}</select></div>
            </div>
            <div class="form-group row">
                <label for="firstname" class="col-md-3 control-label"><span class="text-danger">*</span> First Name:</label>
                <div class="col-md-9"><input type="text" name="required[firstname]" id="firstname" value="{$pupilInfo.firstname}" size="9" placeholder="First Name" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <label for="lastname" class="col-md-3 control-label"><span class="text-danger">*</span> Last Name:</label>
                <div class="col-md-9"><input type="text" name="required[lastname]" id="firstname" value="{$pupilInfo.lastname}" size="9" placeholder="Last Name" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-md-3 control-label"><span class="text-danger">*</span> Email:</label>
                <div class="col-md-9"><input type="text" name="required[email]" id="email" value="{$pupilInfo.email}" size="9" placeholder="Email Address" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <label for="expiry_date" class="col-md-3 control-label">Access Expires:</label>
                <div class="col-md-9"><input type="text" name="additional[expiry_date]" id="expiry_date" value="{$pupilInfo.expiry_date}" size="9" placeholder="Access Expiry Date" class="form-control datepicker" /></div>
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