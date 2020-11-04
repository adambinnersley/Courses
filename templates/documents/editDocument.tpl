{strip}
{if $addDoc}
{assign var="headerSection" value="Add Document" scope="global"}
{else}
{assign var="headerSection" value="Edit Document" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
<div class="card border-primary" id="editgroup">
    <div class="card-header bg-primary">{$headerSection}</div>
    <div class="card-body">
        
    </div>
</div>
{/strip}