{strip}
<div class="row">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {$courseInfo.name}</span></h1>
    </div>
    <div class="col-12">
        <h3 class="no-margin-t">{$courseInfo.name}</h3>
        {if $courseInfo.description}<p>{$courseInfo.description}</p>{/if}
    </div>
</div>
<div class="row">
    <div class="col-12 col-sm-4 col-md-3 col-lg-2 text-center">
        <div class="card course-panel">
            <a href="{$courseRoot}{$courseInfo.url}/info">
                <span class="fa fa-fw fa-list fa-3x"></span><br />
                Course Info
            </a>
        </div>
    </div>
    {if $readingList || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-md-3 col-lg-2 text-center">
        <div class="card course-panel">
            <a href="{$courseRoot}{$courseInfo.url}/reading-list">
                <span class="fa fa-fw fa-book fa-3x"></span><br />
                Reading List
            </a>
        </div>
    </div>{/if}
    {if $CourseVideos || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-md-3 col-lg-2 text-center">
        <div class="card course-panel">
            <a href="{$courseRoot}{$courseInfo.url}/videos">
                <span class="fa fa-fw fa-play-circle-o fa-3x"></span><br />
                Videos
            </a>
        </div>
    </div>{/if}
    {if $courseDocs || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-md-3 col-lg-2 text-center">
        <div class="card course-panel">
            <a href="{$courseRoot}{$courseInfo.url}/course-documents">
                <span class="fa fa-fw fa-files-o fa-3x"></span><br />
                Course Documents
            </a>
        </div>
    </div>{/if}
    {if $courseTests || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-md-3 col-lg-2 text-center">
        <div class="card course-panel">
            <a href="{$courseRoot}{$courseInfo.url}/tests">
                <span class="fa fa-fw fa-pencil-square-o fa-3x"></span><br />
                My Tests{if $userDetails.isHeadOffice && $submissionCount.unmarked > 1} <span class="badge badge-danger">{$submissionCount.unmarked}</span>{/if}
            </a>
        </div>
    </div>{/if}
    {if $userDetails.isHeadOffice}
        <div class="col-12 col-sm-4 col-md-3 col-lg-2 text-center">
            <div class="card course-panel">
                <a href="{$courseRoot}{$courseInfo.url}/pupils">
                    <span class="fa fa-fw fa-users fa-3x"></span><br />
                    Course Pupils
                </a>
            </div>
        </div>
    {/if}
    {*
    Glossary
    Polls
    My Tracker
    *}
</div>
{/strip}