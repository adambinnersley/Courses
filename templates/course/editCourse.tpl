{strip}
{if $addCourse}
{assign var="headerSection" value="Add New Course" scope="global"}
{else}
{assign var="headerSection" value="Edit Course" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
<div class="card border-primary">
    <div class="card-header bg-primary font-weight-bold">{if $addCourse}Add{else}Edit{/if} Course</div>
    <div class="card-body">
        <form method="post" action="" enctype="multipart/form-data" class="form-horizontal">
            <div class="form-group row">
                <label for="name" class="col-md-2 control-label">Name:</label>
                <div class="col-md-10"><input type="text" name="name" id="name" class="form-control" value="{if $addCourse}{$smarty.post.name}{else}{$courseInfo.name}{/if}" /></div>
            </div>
            <div class="form-group row">
                <label for="url" class="col-md-2 control-label">URL:</label>
                <div class="col-md-10"><input type="text" name="url" id="url" class="form-control" value="{if $addCourse}{$smarty.post.url}{else}{$courseInfo.url}{/if}" /></div>
            </div>
            <div class="form-group row">
                <label for="description" class="col-md-2 control-label">Description:</label>
                <div class="col-md-10"><textarea name="description" id="description" class="form-control" rows="5">{if $addCourse}{$smarty.post.description}{else}{$courseInfo.description}{/if}</textarea></div>
            </div>
            <div class="form-group row">
                <label for="image" class="col-md-2 control-label">Image:</label>
                <div class="col-md-10">{if !$addCourse && $courseInfo.image}<img src=""{/if}<input type="file" name="image" id="image" /></div>
            </div>
            <div class="form-group row">
                <label for="name" class="col-md-2 control-label">Status:</label>
                <div class="col-md-10">
                    <select name="active" id="active" class="form-control">
                        <option value="0"{if !$addCourse && $courseInfo.active != 1} selected="selected"{/if}>Disabled</option>
                        <option value="1"{if $addCourse || $courseInfo.active == 1} selected="selected"{/if}>Active</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <strong>Automatically enrol:</strong>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_pdis]" value="1"{if $courseInfo.enrol_pdis == 1} checked="checked"{/if} />
                            PDIs
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_learners]" value="1"{if $courseInfo.enrol_learners == 1} checked="checked"{/if} />
                            Learner Drivers
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_instructors]" value="1"{if $courseInfo.enrol_instructors == 1} checked="checked"{/if} />
                            Instructors
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_tutors]" value="1"{if $courseInfo.enrol_tutors == 1} checked="checked"{/if} />
                            Tutors
                        </label>
                    </div>
                    <strong>Manually enrol:</strong>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="additional[enrol_individuals]" value="1"{if $courseInfo.enrol_individuals == 1} checked="checked"{/if} />
                            Individuals
                        </label>
                    </div>
                </div>
            </div>
            <div class="text-center"><input type="submit" name="submit" id="submit" value="{if $addCourse}Add{else}Edit{/if} Page" class="btn btn-success btn-lg" /></div>
        </form>
    </div>
</div>
{/strip}