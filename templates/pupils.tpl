{strip}
<div class="row" id="course-list">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {$courseInfo.name} <small>/ Course Pupils</small></span></h1>
    </div>
    <div class="col-12">
        <ul class="pager no-margin-t">
            <li class="previous">
                <a href="{if !$add && !$edit && !$delete}./{else}videos{/if}" title="Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}" class="previous">&laquo; Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}</a>
            </li>
        </ul>
    </div>
    {if $userDetails.isHeadOffice && !$add && !$delete}<div class="col-12"><a href="info?addnew=true" title="Add new pupil" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new pupil</a></div>{/if}






    <div class="col-12">
        <ul class="pager no-margin-t">
            <li class="previous">
                <a href="{if !$add && !$edit && !$delete}./{else}videos{/if}" title="Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}" class="previous">&laquo; Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}</a>
            </li>
        </ul>
    </div>
</div>
    
{/strip}