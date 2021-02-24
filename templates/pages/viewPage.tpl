{strip}
{assign var="headerSection" value="Course Page" scope="global"}
{include file="assets/page-header.tpl"}
{assign var="backURL" value="info/" scope="global"}
{assign var="backText" value="Back to page list" scope="global"}
{include file="assets/back-button.tpl"}
<div class="row mb-3">
    <div class="col-12">
        {if $page.prev_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.prev_page}/" title="Previous Page" class="btn btn-info float-left"><span class="fa fa-angle-left fa-fw"></span> Previous <span class="d-none d-sm-inline-block">Page</span></a>&nbsp;{/if}
        {if $page.next_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.next_page}/" title="Next Page" class="btn btn-info float-right">Next <span class="d-none d-sm-inline-block">Page</span> <span class="fa fa-angle-right fa-fw"></span></a>{/if}
    </div>
</div>
<div class="row">
    <div class="col-12">
{if $userDetails.isHeadOffice}
    <div class="row"><div class="col-12"><div class="float-right"><a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/edit" title="Edit Page" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/delete" title="Delete Page" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></div></div></div>
{/if}

<h3>{$page.order}) {$page.title}</h3>
    {$page.content}
    <em><small class="float-right">Last updated: {$page.last_updated|date_format:"d/m/Y H:i:s"}</small></em>
</div>
</div>
<div class="row mt-3">
    <div class="col-12">
        {if $page.prev_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.prev_page}/" title="Previous Page" class="btn btn-info float-left"><span class="fa fa-angle-left fa-fw"></span> Previous<span class="hidden-xs"> Page</span></a>{/if}
        {if $page.next_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.next_page}/" title="Next Page" class="btn btn-info float-right">Next<span class="hidden-xs"> Page</span> <span class="fa fa-angle-right fa-fw"></span></a>{/if}
    </div>
</div>
{if !$userDetails.isHeadOffice}<script type="text/javascript">
    {literal}
    var start = {/literal}{if $userPageProgress.time_spent}{$userPageProgress.time_spent}{else}0{/if}{literal};

    timer = setInterval(function(){
        start++;
    }, 1000);

    $(window).blur(function(){
        clearInterval(timer);
        timer = false;
    });

    $(window).focus(function(){
        if(!timer){
            timer = setInterval(function(){
                start++;
            }, 1000);
        }
    });

    $(window).unload(function(){
        $.ajax({
            type: 'POST',
            url: 'pagetime',
            async: false,
            data: {pageID: {/literal}{$page.page_id}{literal},timeSpent: start}
        });
    });
    {/literal}
</script>{/if}
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}