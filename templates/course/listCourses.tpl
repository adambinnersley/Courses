{strip}
{if !$userDetails.isHeadOffice}
{assign var="headerSection" value="My Courses" scope="global"}
{else}
{assign var="headerSection" value="Courses" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{if $userDetails.isHeadOffice}
<div class="row">
    <div class="col-12">
        <a href="/student/learning/add" title="Add Course" class="btn btn-success float-right"><span class="fa fa-plus"></span> Add Course</a>
    </div>
</div>
{/if}
<div class="row" id="course-list">
    {if $courses}
        {foreach $courses as $course}
            <div class="col-md-4 col-sm-6">
                <div class="card course-module">
                    <div class="card-body">
                        <img src="{if $course.image}/student/learning/images/{$course.url}{else}/images/courses/course-default.png{/if}" alt="{$course.name}" class="d-block mx-auto img-fluid" />
                        <h3>{$course.name}</h3>
                        {if $course.description}<p>{$course.description|strip_tags|substr:0:120}{if $course.description|strip_tags|strlen > 120}...{/if}</p>{/if}
                    </div>
                    <div class="card-footer">
                        <div class="row">
                            {if $userDetails.isHeadOffice}
                                <div class="col-6"><a href="/student/learning/{$course.url}/" title="{$course.name}" class="btn btn-success btn-block">View<span class="d-none d-md-inline-block">&nbsp;Course</span></a></div>
                                <div class="col-6"><a href="/student/learning/edit/{$course.id}" title="Edit Course" class="btn btn-warning btn-block">Edit<span class="d-none d-md-inline-block">&nbsp;Course</span></a></div>
                            {else}
                            <div class="col-12"><a href="/student/learning/{$course.url}/" title="{$course.name}" class="btn btn-success btn-block">View Course</a></div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    {else}
        <div class="col-md-12 text-center">You are currently not assigned to any courses</div>
    {/if}
</div>
{/strip}