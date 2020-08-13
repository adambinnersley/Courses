{strip}
<div class="row" id="course-list">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {if !$userDetails.isHeadOffice}My {/if}Courses</span></h1>
    </div>
{if $userDetails.isHeadOffice && !$add && !$edit}
    <div class="col-12">
        <a href="add" title="Add Course" class="btn btn-success float-right"><span class="fa fa-plus"></span> Add Course</a>
    </div>
</div>
<div class="row" id="course-list">
{/if}
{if $add || $edit}
    <div class="col-md-12">
        <h3>{if $edit}Edit{else}Create a new{/if} course</h3>
        <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
            <div class="form-group">
                <label for="title" class="col-md-3 control-label">Course name <span class="text-danger">*</span></label>
                <div class="col-md-9">
                    <input type="text" name="title" id="title" class="form-control" value="{if $courseDetails}{$courseDetails.name}{else}{$smarty.post.title}{/if}" placeholder="Course title" /> 
                </div>
            </div>
            <div class="form-group">
                <label for="url" class="col-md-3 control-label">Course URL <span class="text-danger">*</span></label>
                <div class="col-md-9">
                    <input type="text" name="url" id="url" class="form-control" value="{if $courseDetails}{$courseDetails.url}{else}{$smarty.post.url}{/if}" placeholder="Course URL" /> 
                </div>
            </div>
            <div class="form-group form-inline">
                <label for="url" class="col-md-3 control-label">Status</label>
                <div class="col-md-9">
                    <select name="status" id="status" class="form-control">
                        <option value="1"{if !$courseDetails || $courseDetails.active == 1} selected="selected"{/if}>Active</option>
                        <option value="0"{if $courseDetails.active == 2} selected="selected"{/if}>Disabled</option>
                    </select>
                </div>
            </div>
            <div class="form-group form-inline">
                <label for="image" class="col-md-3 control-label">Image</label>
                <div class="col-md-9">
                    <input type="file" name="image" id="image" />
                </div>
            </div>
            <div class="form-group">
                <label for="description" class="col-md-3 control-label">Course description / Welcome text</label>
                <div class="col-md-9">
                    <textarea name="description" id="description" cols="6" class="form-control" placeholder="Description / Welcome text">{if $courseDetails}{$courseDetails.description}{else}{$smarty.post.description}{/if}</textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <h4>Automatically enrol:</h4>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_pdis]" value="1"{if $courseDetails.enrol_pdis == 1} checked="checked"{/if} />
                            PDIs
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_learners]" value="1"{if $courseDetails.enrol_learners == 1} checked="checked"{/if} />
                            Learner Drivers
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_instructors]" value="1"{if $courseDetails.enrol_instructors == 1} checked="checked"{/if} />
                            Instructors
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_tutors]" value="1"{if $courseDetails.enrol_tutors == 1} checked="checked"{/if} />
                            Tutors
                        </label>
                    </div>
                    <h4>Manually enrol:</h4>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_individuals]" value="1"{if $courseDetails.enrol_individuals == 1} checked="checked"{/if} />
                            Individuals
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group text-center">
                <input type="submit" name="submit" id="submit" value="{if $edit}Update{else}Add{/if} Course" class="btn btn-success btn-lg" />
            </div>
        </form>
    </div>
{elseif $courses}
    {foreach $courses as $course}
        <div class="col-md-4 col-sm-6">
            <div class="card course-module">
                <div class="card-body">
                    <img src="{if $course.image}{$courseRoot}images/{$course.url}{else}/images/courses/course-default.png{/if}" alt="{$course.name}" class="d-block mx-auto img-fluid" />
                    <h3>{$course.name}</h3>
                    {if $course.description}<p>{$course.description|strip_tags|substr:0:120}{if $course.description|strip_tags|strlen > 120}...{/if}</p>{/if}
                </div>
                <div class="card-footer">
                    <div class="row">
                        {if $userDetails.isHeadOffice}
                            <div class="col-6"><a href="{$courseRoot}{$course.url}/" title="{$course.name}" class="btn btn-success btn-block">View<span class="d-none d-md-inline-block">&nbsp;Course</span></a></div>
                            <div class="col-6"><a href="?editcourse={$course.id}" title="Edit Course" class="btn btn-warning btn-block">Edit<span class="d-none d-md-inline-block">&nbsp;Course</span></a></div>
                        {else}
                        <div class="col-12"><a href="{$courseRoot}{$course.url}/" title="{$course.name}" class="btn btn-success btn-block">View Course</a></div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
{elseif !$userDetails.isHeadOffice}
    <div class="col-md-12 text-center">You are currently not assigned to any courses</div>
{/if}
</div>
{/strip}