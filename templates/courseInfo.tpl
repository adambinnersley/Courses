{strip}
{assign var="headerSection" value="Course" scope="global"}
{if $edit || $add}
    {assign var="style" value='<link rel="stylesheet" type="text/css" href="/css/student/wysiwyg.css" />' scope="global"}
    {assign var="extrascript" value='<script type="text/javascript" src="/js/student/summernote.min.js"></script>' scope="global"}
{/if}
{include file="assets/page-header.tpl"}
{if $add || $edit || $delete || $page}
    {assign var="backURL" value="info/" scope="global"}
    {assign var="backText" value="Back to page list" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
<div class="row">
    <div class="col-12">
        {if $userDetails.isHeadOffice && !$add && !$edit && !$delete && !$smarty.get.pageid}<div class="row"><div class="col-12"><a href="/student/learning/{$courseInfo.url}/info/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new page</a></div><p>&nbsp;</p></div>{/if}
        {if $pages && !$add && !$delete}
            {if $pages}
                {include file="pages/listPages.tpl"}
            {/if}
        {elseif $page && !$delete}
            {if !$edit && !$delete && !$add}
            <div class="row">
                <div class="col-12">
                    {if $page.prev_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.prev_page}/" title="Previous Page" class="btn btn-info float-left"><span class="fa fa-angle-left fa-fw"></span> Previous <span class="d-none d-sm-inline-block">Page</span></a>&nbsp;{/if}
                    {if $page.next_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.next_page}/" title="Next Page" class="btn btn-info float-right">Next <span class="d-none d-sm-inline-block">Page</span> <span class="fa fa-angle-right fa-fw"></span></a>{/if}
                </div>
            </div>
            {/if}
            {if $userDetails.isHeadOffice && !$edit && !$delete && !$add}
                <div class="row"><div class="col-12"><div class="float-right"><a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/edit" title="Edit Page" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/delete" title="Delete Page" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></div></div></div>
            {/if}
            {if $edit}<form method="post" action="" class="form-horizontal">{/if}
                
            {if !$edit}<h3>{$page.order}) {else}<div class="form-group"><label for="title" class="col-md-2 control-label">Title:</label><div class="col-md-10"><input type="text" name="title" id="title" class="form-control" value="{/if}{$page.title}{if $edit}" /></div></div>{else}</h3>{/if}
            {if $edit && !$page.subpages}
            <div class="form-group">
                <label for="subpage" class="col-md-2 control-label">Subpage of:</label>
                <div class="col-md-10">
                    <select name="subpage" id="subpage" class="form-control">
                        <option value="0">None</option>
                        <optgroup label="Select Page">
                        {foreach $subpages as $subpageof}
                            {if $page.page_id != $subpageof.page_id}<option value="{$subpageof.page_id}"{if $subpageof.page_id == $page.subof} selected="selected"{/if}>{$subpageof.order}) {$subpageof.title}</option>{/if}
                        {/foreach}
                        </optgroup>
                    </select>
                </div>
            </div>{/if}
            {if !$edit}{$page.content}{else}<div class="form-group"><label for="content" class="col-md-2 control-label">Content:</label><div class="col-md-10"><textarea name="content" id="content" class="form-control" rows="20">{$page.content}</textarea></div></div>{/if}
            
            {if $edit}
                <div class="text-center"><input type="submit" name="submit" id="submit" value="Update Page" class="btn btn-success btn-lg" /></div>
                </form>
            {else}
                <em><small class="float-right">Last updated: {$page.last_updated|date_format:"d/m/Y H:i:s"}</small></em>
            {/if}
            {if !$edit && !$delete && !$add}<div class="row">
                <div class="col-12">
                    {if $page.prev_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.prev_page}/" title="Previous Page" class="btn btn-info float-left"><span class="fa fa-angle-left fa-fw"></span> Previous<span class="hidden-xs"> Page</span></a>{/if}
                    {if $page.next_page}<a href="/student/learning/{$courseInfo.url}/info/{$page.next_page}/" title="Next Page" class="btn btn-info float-right">Next<span class="hidden-xs"> Page</span> <span class="fa fa-angle-right fa-fw"></span></a>{/if}
                </div>
            </div>{/if}
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
        {elseif $add}
            {include file="pages/addPage.tpl"}
        {elseif $userDetails.isHeadOffice && $delete}
            {include file="pages/deletePage.tpl"}
        {else}
            <p class="text-center">There is currently no course content, please check back later or contact the course administrator</p>
        {/if}
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{if ($edit || $add) && $userDetails.isHeadOffice}
    <script type="text/javascript">{literal}$(document).ready(function(){$("#content").summernote({minHeight:300,maxHeight:null,focus:true});});{/literal}</script>
{/if}
{/strip}