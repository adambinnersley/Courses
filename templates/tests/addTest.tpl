{strip}
{if isset($edit)}
{assign var="headerSection" value="Edit Test" scope="global"}
{else}
{assign var="headerSection" value="Add Test" scope="global"}
{/if}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{assign var="backURL" value="tests/" scope="global"}
{assign var="backText" value="Back to Tests" scope="global"}
{include file="assets/back-button.tpl"}
<form action="" method="post" class="form-horizontal">
    {if !$questionedit}
        <div class="card mb-3 border-primary">
            <div class="card-header bg-primary text-bold">Test Information</div>
            <div class="card-body">
                <div class="form-group row">
                    <label for="status" class="col-md-3 control-label">Status:</label>
                    <div class="col-md-9 form-inline">
                        <select name="status" id="status" class="form-control">
                            <option value="1"{if ($edit && $testedit.active == 1) || ($add && ($smarty.post.status == 1 || !$smarty.post.status))} selected="selected"{/if}>Active</option>
                            <option value="0"{if ($edit && $testedit.active == 0) || ($add && $smarty.post.status == 0)} selected="selected"{/if}>Disabled</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-md-3 control-label"><span class="text-danger">*</span> Test Name:</label>
                    <div class="col-md-9">
                        <input type="text" name="name" id="name" value="{if $edit}{$testedit.name}{else}{$smarty.post.name}{/if}" class="form-control" placeholder="Test name" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="description" class="col-md-3 control-label">Description:</label>
                    <div class="col-md-9">
                        <textarea name="description" id="description" rows="3" class="form-control" placeholder="Test description">{if $edit}{$testedit.description}{else}{$smarty.post.description}{/if}</textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="description" class="col-md-3 control-label">Pass Type:{$testedit.pass_percentage}</label>
                    <div class="col-md-9 form-inline">
                        <select name="pass_type" id="pass_type" class="form-control">
                            <option value="1"{if ($edit && $testedit.pass_mark) || ($add && (!$smarty.post.pass_type || $smarty.post.pass_type == 1))} selected="selected"{/if}>Total Score</option>
                            <option value="2"{if ($edit && $testedit.pass_percentage) || ($add && $smarty.post.pass_type == 2)} selected="selected"{/if}>Percentage</option>
                            <option value="3"{if ($edit && $testedit.self_assessed) || ($add && $smarty.post.pass_type == 3)} selected="selected"{/if}>Self Assessed</option>
                        </select>
                        <span id="pass_score"{if ($edit && !$testedit.pass_mark) || ($add && ($smarty.post.pass_type && $smarty.post.pass_type != 1))} style="display:none"{/if}> equal to or greater than <input type="text" name="passmark" id="passmark" size="3" placeholder="Score" class="form-control" value="{if $edit && $testedit.pass_mark}{$testedit.pass_mark}{elseif $smarty.post.passmark}{$smarty.post.passmark}{else}1{/if}" /></span>
                        <span id="pass_percentage"{if ($edit && !$testedit.pass_percentage) || ($add && $smarty.post.pass_type != 2)} style="display:none"{/if}> equal to or greater than <input type="text" name="percent" id="percent" size="3" placeholder="Score" class="form-control" value="{if $edit && $testedit.pass_percentage}{$testedit.pass_percentage}{elseif $smarty.post.percent}{$smarty.post.percent}{else}80{/if}" />%</span>
                    </div>
                </div>
                <div class="row text-center">
                    <input type="submit" name="submit" id="submit1" value="Add Test" class="btn btn-success mx-auto" />
                </div>
            </div>
        </div>
        {if $edit}
            <div class="card border-primary">
                <div class="card-header bg-primary text-bold">Questions</div>
                <div class="card-body">
            {foreach $testedit.questions as $question}
                <div class="col-12 text-right mt-2">
                    <a href="/student/learning/{$courseInfo.url}/tests/question/{$question.question_id}/edit" title="Edit Page" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> &nbsp; <a href="/student/learning/{$courseInfo.url}/tests/question/{$question.question_id}/delete" title="Delete Page" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a>
                </div>
                <div class="form-group row">
                    <div class="col-md-3 text-right"><strong>Question {$question.question_order}:</strong></div>
                    <div class="col-md-9">{$question.question}</div>
                </div>
                <div class="form-group row">
                    <div class="col-md-3 text-right"><strong>Max. Question Score:</strong></div>
                    <div class="col-md-9">{$question.max_score}</div>
                </div>
                {if $question.question_type == 2 && $question.allow_partial}
                <div class="form-group row">
                    <div class="col-md-3 text-right"><strong>Partial Score Allowed:</strong></div>
                    <div class="col-md-9">Yes</div>
                </div>
                {/if}
                <div class="form-group row">
                    <div class="col-md-3 text-right"><strong>Type:</strong></div>
                    <div class="col-md-9">
                        {if $question.question_type == 1}Textbox{elseif $question.question_type == 2}Multiple Choice{/if}
                    </div>
                </div>
                {if $question.question_type == 2}
                <div class="form-group row">
                    <div class="col-md-3 text-right"><strong>Answers:</strong></div>
                    <div class="col-md-9">
                        <table class="table table-striped table-bordered table-condensed">
                        {foreach $question.answers as $answer}
                            <tr>
                                <td>{$answer.answer}</td>
                                <td>{if $answer.correct}<strong>Correct</strong>{/if}</td>
                            </tr>
                        {/foreach}
                        </table>
                    </div>
                </div>
                {if $question.explanation}
                    <div class="form-group row">
                        <div class="col-md-3 text-right"><strong>Explanation:</strong></div>
                        <div class="col-md-9">
                            {$question.explanation}
                        </div>
                    </div>
                {/if}
                {elseif $testedit.self_assessed == 1}
                <div class="form-group row">
                    <div class="col-md-3 text-right"><strong>Answer:</strong></div>
                    <div class="col-md-9">
                        {$question.answers}
                    </div>
                </div>
                {/if}
                <hr class="mb-0" />
                {assign var="questionnum" value=$question.question_order + 1}
            {/foreach}
        {else}
        <div class="card border-primary">
            <div class="card-header bg-primary text-bold">
                Questions
            </div>
            <div class="card-body">
                <div class="form-group row">
                    <label class="col-md-3 control-label"><span class="text-danger">*</span> Question 1</label>
                    <div class="col-md-9">
                        <textarea name="questions[1][q]" id="test_q" rows="3" class="form-control" placeholder="Question 1"></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="score" class="col-md-3 control-label"><span class="text-danger">*</span> Max. Question Score</label>
                    <div class="col-md-9 form-inline">
                        <input type="text" name="questions[1][score]" id="score" value="1" placeholder="Score" size="3" maxlength="3" class="form-control" />
                    </div>
                </div>
                <div class="form-group row" id="question_partial_1" style="display:none">
                    <label for="partial" class="col-md-3 control-label"><span class="text-danger">*</span> Allow partial points<br /><small>The user will be awarded a percetage of the points based on the amount of correct answers they give</small></label>
                    <div class="col-md-9 form-inline">
                        <select name="questions[1][partial]" id="partial" class="form-control">
                            <option value="0">No</option>
                            <option value="1">Yes</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-3 control-label"><span class="text-danger">*</span> Answer Type</label>
                    <div class="col-md-9">
                        <div class="radio">
                            <label><input type="radio" name="questions[1][type]" class="question_type" data-question="1" value="1" checked="checked" /> Textbox</label>
                            <label><input type="radio" name="questions[1][type]" class="question_type" data-question="1" value="2" /> Multiple Choice</label>
                        </div>
                    </div>
                </div>
                <div class="form-group row" id="question_self_assess_1" style="display:none">
                    <label class="col-md-3 control-label"> Question 1 Answer</label>
                    <div class="col-md-9">
                         <textarea name="questions[1][answer]" id="test_answer" rows="5" class="form-control" placeholder="Question 1 Answer"></textarea>
                    </div>
                </div>
                <div class="form-group row" id="question_options_1" style="display:none">
                    <label class="col-md-3 control-label"> Question 1 Options</label>
                    <div class="col-md-9">
                        <div class="form-group row">
                            <div class="col-md-9"><input type="text" name="questions[1][answers][1][answer]" value="" class="form-control" placeholder="Answer 1" /></div>
                            <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[1][answers][1][correct]" /> Correct</label></div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-9"><input type="text" name="questions[1][answers][2][answer]" value="" class="form-control" placeholder="Answer 2" /></div>
                            <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[1][answers][2][correct]" /> Correct</label></div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-9"><input type="text" name="questions[1][answers][3][answer]" value="" class="form-control" placeholder="Answer 3" /></div>
                            <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[1][answers][3][correct]" /> Correct</label></div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-9"><input type="text" name="questions[1][answers][4][answer]" value="" class="form-control" placeholder="Answer 4" /></div>
                            <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" value="1" name="questions[1][answers][4][correct]" /> Correct</label></div>
                        </div>
                        <div id="additional_options_1"></div>
                        <div class="form-group row">
                            <div class="col-md-9">
                            <button type="button" id="addOption" data-question="1" class="btn btn-info btn-block">Add another option</button>
                            </div>
                        </div>
                    </div>
                    <label class="col-md-3 control-label"> Explanation</label>
                    <div class="col-md-9"><textarea name="questions[1][explanation]" id="explanation" rows="3" class="form-control" placeholder="Answer explanation"></textarea></div>
                </div>
                <hr />
        {/if}
        <div id="additionalQuestions"></div>
        <div class="form-group row">
            <div class="col-md-12">
            <button type="button" id="addQuestion" class="btn btn-danger">Add Another Question</button>
            </div>
        </div>
        <div class="text-center"{if !$add} style="display:none" id="addNewQuestions"{/if}><input type="submit" name="submit" id="submit" value="{if $add}Create{else}Update{/if} Test" class="btn btn-success btn-lg" /></div>
            </div>
        </div>
        <script type="text/javascript">{literal}
var current = {};
current["question_1"] = 5;
var question = {/literal}{if $edit}{$questionnum}{else}2{/if}{literal};

function changeType(QuestionID, value){
if(value != 1){
$('#question_partial_'+QuestionID).show();
$('#question_options_'+QuestionID).show();
$('#question_self_assess_'+QuestionID).hide();
}else{
$('#question_partial_'+QuestionID).hide();
$('#question_options_'+QuestionID).hide();
if($('#pass_type').val() == 3){$('#question_self_assess_'+QuestionID).show();}
}
}

function addOptions(QuestionID){
$('#additional_options_'+QuestionID).append("<div class=\"form-group row\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+QuestionID+"][answers]["+current["question_"+QuestionID]+"][answer] value=\"\" class=\"form-control\" placeholder=\"Answer "+current["question_"+QuestionID]+"\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" value=\"1\" name=\"questions["+QuestionID+"][answers]["+current["question_"+QuestionID]+"][correct]\" /> Correct</label></div></div>");
current["question_"+QuestionID]++;
}
$(document).ready(function(){
$('#pass_type').change(function(){
if($(this).val() == 1){$('#pass_score').show();$('#pass_percentage').hide();}
else if($(this).val() == 2){$('#pass_score').hide();$('#pass_percentage').show();}
else{$('#pass_score').hide();$('#pass_percentage').hide();}

if($(this).val() == 3){$('[id^="question_self_assess_"]').show();}
else{$('[id^="question_self_assess_"]').hide();}
});

$('.question_type').change(function(){
changeType($(this).data('question'), $(this).val());
});

$('#addOption').click(function(){
addOptions($(this).data('question'));
});

$('#addQuestion').click(function(){
$('#additionalQuestions').append("<div class=\"form-group row\"><label class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Question "+question+"</label><div class=\"col-md-9\"><textarea name=\"questions["+question+"][q]\" id=\"test_q\" rows=\"3\" class=\"form-control\" placeholder=\"Question "+question+"\"></textarea></div></div><div class=\"form-group row\"><label for=\"score\" class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Max. Question Score</label><div class=\"col-md-9 form-inline\"><input type=\"text\" name=\"questions["+question+"][score]\" id=\"score\" value=\"1\" placeholder=\"Score\" size=\"3\" maxlength=\"3\" class=\"form-control\" /></div></div><div class=\"form-group row\" id=\"question_partial_"+question+"\" style=\"display:none\"><label for=\"partial\" class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Allow partial points<br /><small>The user will be awarded a percetage of the points based on the amount of correct answers they give</small></label><div class=\"col-md-9 form-inline\"><select name=\"questions["+question+"][partial]\" id=\"partial\" class=\"form-control\"><option value=\"0\">No</option><option value=\"1\">Yes</option></select></div></div><div class=\"form-group row\"><label class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Answer Type</label><div class=\"col-md-9\"><div class=\"radio\"><label><input type=\"radio\" name=\"questions["+question+"][type]\" class=\"question_type\" value=\"1\" checked=\"checked\" onchange=\"changeType("+question+", 1);\" /> Textbox</label><label><input type=\"radio\" name=\"questions["+question+"][type]\" class=\"question_type\" value=\"2\" onchange=\"changeType("+question+", 2);\" /> Multiple Choice</label></div></div></div><div class=\"form-group row\" id=\"question_self_assess_"+question+"\""+($('#pass_type').val() == 3 ? '' : ' style="display:none"')+"><label class=\"col-md-3 control-label\"> Question "+question+" Answer</label><div class=\"col-md-9\"><textarea name=\"questions["+question+"][answer]\" id=\"test_answer\" rows=\"5\" class=\"form-control\" placeholder=\"Question "+question+" Answer\"></textarea></div></div><div class=\"form-group row\" id=\"question_options_"+question+"\" style=\"display:none\"><label class=\"col-md-3 control-label\"> Question "+question+" Options</label><div class=\"col-md-9\"><div class=\"form-group row\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][1][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 1\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][1][correct]\" value=\"1\" /> Correct</label></div></div><div class=\"form-group row\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][2][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 2\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][2][correct]\" value=\"1\" /> Correct</label></div></div><div class=\"form-group row\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][3][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 3\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][3][correct]\" value=\"1\" /> Correct</label></div></div><div class=\"form-group row\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][4][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 4\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][4][correct]\" value=\"1\" /> Correct</label></div></div><div id=\"additional_options_"+question+"\"></div><div class=\"form-group row\"><div class=\"col-md-9\"><button type=\"button\" onclick=\"addOptions("+question+");\" class=\"btn btn-info btn-block\">Add another option</button></div></div></div><label class=\"col-md-3 control-label\"> Explanation</label><div class=\"col-md-9\"><textarea name=\"questions["+question+"][explanation]\" id=\"explanation"+question+"\" rows=\"3\" class=\"form-control\" placeholder=\"Answer explanation\"></textarea></div></div><hr />");
$('#addNewQuestions').show();
current["question_"+question] = 5;
question++;
});
});
{/literal}</script>
    {else}
        <div class="form-group row">
            <label class="col-md-3 control-label"><span class="text-danger">*</span> Question</label>
            <div class="col-md-9">
                <textarea name="questions[q]" id="test_q" rows="4" class="form-control" placeholder="Question 1">{$questionedit.question}</textarea>
            </div>
        </div>
        <div class="form-group row">
            <label for="score" class="col-md-3 control-label"><span class="text-danger">*</span> Max. Question Score</label>
            <div class="col-md-9 form-inline">
                <input type="text" name="questions[score]" id="score" value="{$questionedit.max_score}" placeholder="Score" size="3" maxlength="3" class="form-control" />
            </div>
        </div>
        <div class="form-group row" id="question_partial"{if $questionedit.question_type == 1} style="display:none"{/if}>
            <label for="partial" class="col-md-3 control-label"><span class="text-danger">*</span> Allow partial points<br /><small>The user will be awarded a percetage of the points based on the amount of correct answers they give</small></label>
            <div class="col-md-9 form-inline">
                <select name="questions[partial]" id="partial" class="form-control">
                    <option value="0"{if $questionedit.allow_partial != 1} selected="selected"{/if}>No</option>
                    <option value="1"{if $questionedit.allow_partial == 1} selected="selected"{/if}>Yes</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-md-3 control-label"><span class="text-danger">*</span> Answer Type</label>
            <div class="col-md-9">
                <div class="radio">
                    <label><input type="radio" name="questions[type]" class="question_type" value="1"{if $questionedit.question_type == 1} checked="checked"{/if} /> Textbox</label>
                    <label><input type="radio" name="questions[type]" class="question_type" value="2"{if $questionedit.question_type == 2} checked="checked"{/if} /> Multiple Choice</label>
                </div>
            </div>
        </div>
        <div class="form-group row" id="question_self_assess"{if $questionedit.question_type != 1 || $testinfo.self_assessed != 1} style="display:none"{/if}>
            <label class="col-md-3 control-label"> Question Answer</label>
            <div class="col-md-9">
                <textarea name="questions[answer]" id="test_answer" rows="8" class="form-control" placeholder="Question Answer">{$questionedit.answers}</textarea>
            </div>
        </div>
        <div class="form-group row" id="question_options"{if $questionedit.question_type == 1} style="display:none"{/if}>
            <label class="col-md-3 control-label"> Question Options</label>
            <div class="col-md-9">
                {if $questionedit.question_type == 1}
                    {$questionedit.answers[1] = ['answer' => '']}
                    {$questionedit.answers[2] = ['answer' => '']}
                    {$questionedit.answers[3] = ['answer' => '']}
                    {$questionedit.answers[4] = ['answer' => '']}
                {/if}
                {assign var="qnum" value=1}
                {foreach $questionedit.answers as $i => $answer}
                    <div class="form-group row">
                        <div class="col-md-9"><input type="text" name="questions[answers][{$i}][answer]" value="{$answer.answer}" class="form-control" placeholder="Answer {$i}" /></div>
                        <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[answers][{$i}][correct]"{if $answer.correct} checked="checked"{/if} /> Correct</label></div>
                    </div>
                    {assign var="qnum" value=$qnum+1}
                {/foreach}
                <div id="additional_options"></div>
                <div class="form-group row">
                    <div class="col-md-9">
                    <button type="button" id="addOption" data-question="1" class="btn btn-info btn-block">Add another option</button>
                    </div>
                </div>
            </div>
            <label class="col-md-3 control-label"> Explanation</label>
            <div class="col-md-9"><textarea name="questions[explanation]" id="explanation" rows="3" class="form-control" placeholder="Answer explanation">{$questionedit.explanation}</textarea></div>
        </div>
        <div class="form-group row text-center">
            <input type="submit" name="submit" id="submit" value="Update Question" class="btn btn-success mx-auto" />
        </div>
        <script type="text/javascript">{literal}
var current = {/literal}{$qnum}{literal};

$(document).ready(function(){
$('.question_type').change(function(){
if($(this).val() != 1){
$('#question_partial').show();
$('#question_options').show();
}else{
$('#question_partial').hide();
$('#question_options').hide();
}
});

$('#addOption').click(function(){
$('#additional_options').append('<div class="form-group row"><div class="col-md-9"><input type="text" name="questions[answers]['+current+'][answer] value="" class="form-control" placeholder="Answer '+current+'" /></div><div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" value="1" name="questions[answers]['+current+'][correct]" /> Correct</label></div></div>');
current++;
});
});
{/literal}</script>
    {/if}
</form>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}