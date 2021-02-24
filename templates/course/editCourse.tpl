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
                <div class="col-md-10 form-inline">
                    <select name="active" id="active" class="form-control">
                        <option value="0"{if !$addCourse && $courseInfo.active != 1} selected="selected"{/if}>Disabled</option>
                        <option value="1"{if $addCourse || $courseInfo.active == 1} selected="selected"{/if}>Active</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <strong>Automatically enrol:</strong>
                    <div class="form-check">
                        <input type="checkbox" name="additional[enrol_pdis]" id="enrol_pdis" class="form-check-input" value="1"{if $courseInfo.enrol_pdis == 1} checked="checked"{/if} />
                        <label for="enrol_pdis" class="form-check-label">PDIs</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="additional[enrol_learners]" id="enrol_learners" class="form-check-input" value="1"{if $courseInfo.enrol_learners == 1} checked="checked"{/if} />
                        <label for="enrol_learners" class="form-check-label">Learner Drivers</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="additional[enrol_instructors]" id="enrol_instructors" class="form-check-input" value="1"{if $courseInfo.enrol_instructors == 1} checked="checked"{/if} />
                        <label for="enrol_instructors" class="form-check-label">Instructors</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="additional[enrol_tutors]" id="enrol_tutors" class="form-check-input" value="1"{if $courseInfo.enrol_tutors == 1} checked="checked"{/if} />
                        <label for="enrol_tutors" class="form-check-label">Tutors</label>
                    </div>
                    <strong>Manually enrol:</strong>
                    <div class="form-check">
                        <input type="checkbox" name="additional[enrol_individuals]" id="enrol_individuals" class="form-check-input" value="1"{if $courseInfo.enrol_individuals == 1} checked="checked"{/if} />
                        <label for="enrol_individuals" class="form-check-label">Individuals</label>
                    </div>
                </div>
            </div>
            <div class="text-center"><input type="submit" name="submit" id="submit" value="{if $addCourse}Add{else}Edit{/if} Course" class="btn btn-success btn-lg" /></div>
        </form>
    </div>
</div>
{/strip}