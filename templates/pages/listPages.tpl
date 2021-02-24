{strip}
{assign var="headerSection" value="Course" scope="global"}
{include file="assets/page-header.tpl"}
{include file="assets/back-button.tpl"}
{assign var="title" value=$headerSection scope="global"}
<div class="row">
    <div class="col-12">
        {if $userDetails.isHeadOffice}<div class="row"><div class="col-12"><a href="/student/learning/{$courseInfo.url}/info/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new page</a></div><p>&nbsp;</p></div>{/if}
        {if $pages}
            <div id="coursePages"{if $userDetails.isHeadOffice} class="course-admin"{/if}>
                <{if $userDetails.isHeadOffice}ul{else}div{/if} class="list-group">
                {foreach $pages as $page}
                {if $userDetails.isHeadOffice}
                    <li class="list-group-item{if $page.subpages} has-sub-list{/if}">
                {/if}
                <a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/" title="{$page.title}" class="{if !$userDetails.isHeadOffice}list-group-item{if $page.progress} list-group-item-success{/if}{else}pl-3{/if}">{$page.order}) {$page.title}</a>
                {if $userDetails.isHeadOffice}
                    <div class="float-right">
                        <a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/edit" title="Edit Page" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a>
                        {if !$page.subpages} &nbsp; <a href="/student/learning/{$courseInfo.url}/info/{$page.page_id}/delete" title="Delete Page" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a>{/if}
                        {if $page.has_prev} &nbsp; <a href="/student/learning/{$courseInfo.url}/move/{$page.page_id}/up" title="Move up" class="btn btn-success btn-sm"><span class="fa fa-angle-up"></span></a> {/if}
                        {if $page.has_next} &nbsp; <a href="/student/learning/{$courseInfo.url}/move/{$page.page_id}/down" title="Move down" class="btn btn-success btn-sm"><span class="fa fa-angle-down"></span></a>{/if}
                    </div>
                {/if}
                {if $page.subpages}{if $userDetails.isHeadOffice}<ul class="list-group">{/if}
                    {foreach $page.subpages as $subpage}
                        {if $userDetails.isHeadOffice}<li class="list-group-item p-2 pl-3">{/if}
                            <a href="/student/learning/{$courseInfo.url}/info/{$subpage.page_id}/" title="{$subpage.title}"{if !$userDetails.isHeadOffice} class="list-group-item"{/if}>{$subpage.order}) {$subpage.title}</a>
                            {if $userDetails.isHeadOffice}
                                <div class="float-right">
                                    <a href="/student/learning/{$courseInfo.url}/info/{$subpage.page_id}/edit" title="Edit Page" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> &nbsp; <a href="/student/learning/{$courseInfo.url}/info/{$subpage.page_id}/delete" title="Delete Page" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a>
                                    {if $subpage.has_prev} &nbsp; <a href="/student/learning/{$courseInfo.url}/move/{$subpage.page_id}/up" title="Move up" class="btn btn-primary btn-sm"><span class="fa fa-angle-up"></span></a> {/if}
                                    {if $subpage.has_next} &nbsp; <a href="/student/learning/{$courseInfo.url}/move/{$subpage.page_id}/down" title="Move down" class="btn btn-primary btn-sm"><span class="fa fa-angle-down"></span></a>{/if}
                                </div>
                            {/if}
                        {if $userDetails.isHeadOffice}</li>{/if}
                    {/foreach}
                {if $userDetails.isHeadOffice}</ul>{/if}
                {/if}
                {if $userDetails.isHeadOffice}</li>{/if}
                {/foreach}
                </{if $userDetails.isHeadOffice}ul{else}div{/if}>
            </div>
            <script type="text/javascript">
            {literal}
            $(function(){
            $('.fa').on('click', function(){
            $('.fa', this).toggleClass('fa-angle-right').toggleClass('fa-angle-down');
            });
            });
            {/literal}
            </script>
            {else}
            <p class="text-center">There is currently no course content, please check back later or contact the course administrator</p>
        {/if}
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}