{strip}
<div class="row" id="course-list">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {$courseInfo.name} <small>/ Course Pupils</small></span></h1>
    </div>
    <div class="col-12">
        <a href="/student/learning/{$courseInfo.url}/{if $add || $edit || $delete}pupils/{/if}" title="Back to {if $add || $edit || $delete}pupils{else}course home{/if}" class="btn btn-danger">&laquo; Back to {if $add || $edit || $delete}pupils{else}course home{/if}</a>
    </div>
    {if $userDetails.isHeadOffice && !$add && !$delete}<div class="col-12"><a href="/student/learning/{$courseInfo.url}/pupils/add" title="Add new pupil" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new pupil</a></div>{/if}






    <div class="col-12">
        <a href="/student/learning/{$courseInfo.url}/{if $add || $edit || $delete}pupils/{/if}" title="Back to {if $add || $edit || $delete}pupils{else}course home{/if}" class="btn btn-danger">&laquo; Back to {if $add || $edit || $delete}pupils{else}course home{/if}</a>
    </div>
</div>
    
{/strip}