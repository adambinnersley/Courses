{strip}
{include file="assets/page-header.tpl"}
<div class="row">
    <div class="col-12">
        <h3 class="no-margin-t">{$courseInfo.name}</h3>
        {if $courseInfo.description}<p>{$courseInfo.description}</p>{/if}
    </div>
</div>
<div class="row">
    <div class="col-12 col-sm-4 col-lg-3 col-xl-2 text-center mb-3">
        <div class="card course-panel">
            <a href="/student/learning/{$courseInfo.url}/info/">
                <span class="fa fa-fw fa-list fa-3x"></span><br />
                Course Info
            </a>
        </div>
    </div>
    {if $readingList || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-lg-3 col-xl-2 text-center mb-3">
        <div class="card course-panel">
            <a href="/student/learning/{$courseInfo.url}/reading-list/">
                <span class="fa fa-fw fa-book fa-3x"></span><br />
                Reading List
            </a>
        </div>
    </div>{/if}
    {if $courseVideos || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-lg-3 col-xl-2 text-center mb-3">
        <div class="card course-panel">
            <a href="/student/learning/{$courseInfo.url}/videos/">
                <span class="fa fa-fw fa-film fa-3x"></span><br />
                Videos
            </a>
        </div>
    </div>{/if}
    {if $courseDocs || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-lg-3 col-xl-2 text-center mb-3">
        <div class="card course-panel">
            <a href="/student/learning/{$courseInfo.url}/course-documents/">
                <span class="fa fa-fw fa-file-download fa-3x"></span><br />
                Documents
            </a>
        </div>
    </div>{/if}
    {if $courseTests || $userDetails.isHeadOffice}<div class="col-12 col-sm-4 col-lg-3 col-xl-2 text-center mb-3">
        <div class="card course-panel">
            <a href="/student/learning/{$courseInfo.url}/tests/">
                <span class="fa fa-fw fa-pencil-alt fa-3x"></span><br />
                My Tests{if $userDetails.isHeadOffice && $submissionCount.unmarked > 1} <span class="badge badge-danger">{$submissionCount.unmarked}</span>{/if}
            </a>
        </div>
    </div>{/if}
    {if $userDetails.isHeadOffice}
        <div class="col-12 col-sm-4 col-lg-3 col-xl-2 text-center mb-3">
            <div class="card course-panel">
                <a href="/student/learning/{$courseInfo.url}/pupils/">
                    <span class="fa fa-fw fa-users fa-3x"></span><br />
                    Pupils
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