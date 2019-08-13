{strip}
<div class="row">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {$courseInfo.name} <small>/ Tests</small></span></h1>
    </div>
    <div class="col-12">
        {if $userDetails.isHeadOffice && !$edit && !$add && !$delete && !$submission}<div class="col-12"><a href="tests?addnew=true" title="Add new test" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new test</a></div>{/if}
        {if !$testdetails || $reviewInfo}
            <a href="{if !$edit && !$add && !$delete && !$testSubmitted && !$submission}./{elseif $submission && ($mark || $review)}tests?submissions={$smarty.get.submissions}{elseif $edit && $questionedit}tests?testid={$questionedit.test_id}&amp;edit=true{else}tests{/if}" title="Back to {if !$edit && !$add && !$delete}course home{else}tests{/if}" class="btn btn-default">&laquo; Back to {if !$edit && !$add && !$delete && !$testSubmitted && !$submission}course home{else}tests{/if}</a>
        {/if}
        {if $tests || $edit || $add || $delete || $submission}
            {if !$edit && !$add && !$delete && !$submission}
                {if !$testdetails}
                    <table class="table table-striped table-hover table-bordered">
                        <tr>
                            <th></th>
                            <th class="text-center">No. Questions</th>
                            <th class="text-center">Pass mark</th>
                            {if !$userDetails.isHeadOffice}<th class="text-center">Score</th>
                            <th class="text-center">Status</th>
                            {else}
                            <th class="text-center">Submissions</th>
                            <th class="text-center"></th>
                            {/if}
                            <th></th>
                        </tr>
                        {foreach $tests as $test}
                            <tr>
                                <td>{$test.name}</td>
                                <td class="text-center">{$test.no_questions}</td>
                                <td class="text-center">{if $test.pass_mark}{$test.pass_mark}/{$test.max_score}{elseif $test.pass_percentage}{$test.pass_percentage}%{elseif $test.self_assessed}Self assessed{/if}</td>
                                {if !$userDetails.isHeadOffice}<td class="text-center">{if $test.results.status == 0 || $test.results.status == 1}0{else}{$test.results.score}{/if}/{$test.max_score}</td>
                                <td class="text-center">
                                    {if $test.results.status == 0}<strong class="text-warning">Incomplete</strong>
                                    {elseif $test.results.status == 1 && !$test.self_assessed}<strong class="text-info">Awaiting marking</strong>
                                    {elseif $test.results.status == 2}<strong class="text-danger">Failed</strong>
                                    {elseif $test.results.status == 3}<strong class="text-success">Passed</strong>
                                    {/if}
                                </td>
                                <td class="text-center">{if $test.results.status >= 2 || ($test.self_assessed && $test.results.status == 1)}<a href="?review={$test.test_id}" title="Review" class="btn btn-info">Review Test</a>{/if}{if $test.results.status == 0 || $test.results.status == 2}<a href="?take={$test.test_id}" title="Take {$test.name}" class="btn btn-success">{if $test.results.status == 2}Retake{else}Start{/if} Test</a>{/if}</td>
                                {else}
                                <td class="text-center">{if $test.submissions.total > 0}{$test.submissions.total} Total{else}None{/if}{if $test.submissions.unmarked >= 1} <div class="badge">{$test.submissions.unmarked} Unmarked</div>{/if}</td>
                                <td class="text-center">{if $test.submissions.total >= 1}<a href="tests?submissions={$test.test_id}" title="Submissions" class="btn btn-info">View Submissions</a>{/if}</td>
                                <td class="text-center"><a href="tests?testid={$test.test_id}&amp;edit=true" title="Edit Page" class="btn btn-warning"><span class="fa fa-pencil fa-fw"></span> Edit</a> <a href="tests?testid={$test.test_id}&amp;delete=true" title="Delete Page" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></td>{/if}
                            </tr>    
                        {/foreach}
                    </table>
                {elseif $testSubmitted && !$testdetails}
                    <div class="alert alert-success">
                        <h4>Test Submitted</h4>
                        <p>Your test has now been submitted and is currently awaiting marking by a member of our team you will be notified by email when your results are available!</p>
                    </div>
                {else}
                    <form method="post" action="" class="form-horizontal">
                    <h3>{$testdetails.name}</h3>
                    {foreach $testdetails.questions as $i => $question}
                        <h4>Q{$i + 1}. {$question.question}</h4>
                        {if $reviewInfo && !$testdetails.self_assessed}<div class="alert alert-info"><strong>Score:</strong> {$reviewInfo[$i].score} out of a possible {$reviewInfo[$i].max_score}{if $reviewInfo[$i].feedback}<br /><strong>Feedback:</strong> {$reviewInfo[$i].feedback}{/if}</div>{/if}
                        {if $question.question_type == 1}
                            {if $reviewInfo}
                            <p><strong>Your answer:</strong> {$reviewInfo[$i].answer}</p>
                            {if $testdetails.self_assessed}<p class="text-danger"><strong>Official answer:</strong> {$question.answers}</p>{/if}
                            {else}
                                <textarea name="question{$i + 1}" id="question{$i + 1}" rows="6" class="form-control"></textarea>
                            {/if}
                        {elseif $question.question_type == 2}
                            {if !$reviewInfo}{assign var="correct" value=0}
                            {foreach $question.answers as $answer}
                                {if $answer.correct}{assign var="correct" value=$correct+1}{/if}
                            {/foreach}
                            <p class="text-danger" id="question{$i + 1}-mark" data-mark="{$correct}"><strong><em>Mark {$correct} answer{if $correct > 1}s{/if}</em></strong></p>{/if}
                            <div class="row">
                            {foreach $question.answers as $a => $answer}
                                <div class="col-sm-6"><label class="question-label{if $reviewInfo} reviewing{/if}{if $reviewInfo[$i].answer|is_array}{if $reviewInfo[$i].answer[$a] == 1}{if $reviewInfo[$i].answers[$a].correct} label-correct{else} label-incorrect{/if}{elseif $reviewInfo[$i].answers[$a].correct} label-selected{/if}{elseif $reviewInfo[$i].answer == $a}{if $reviewInfo[$i].answers[$a].correct} label-correct{else} label-incorrect{/if}{elseif $reviewInfo[$i].answers[$a].correct} label-selected{/if}" for="question{$i + 1}_{$a}"><input type="{if $correct == 1}radio{else}checkbox{/if}" name="{if $correct == 1}question{$i + 1}{else}question{$i + 1}[{$a}]{/if}" id="question{$i + 1}_{$a}" data-question="question{$i + 1}" value="{if $correct == 1}{$a}{else}1{/if}" /> {$answer.answer}</label></div>
                            {/foreach}
                            </div>
                        {/if}
                        <hr />
                    {/foreach}
                    {if !$reviewInfo}<div class="text-center"><input type="submit" name="submit" id="submit" value="Submit Test" class="btn btn-success btn-lg" /></div>{/if}
                    </form>
                    {if !$reviewInfo}<script type="text/javascript">{literal}
var checked = {};
$("input[type='radio']").click(function(){
    if($(this).parent('.question-label').hasClass('label-selected')){
        $(this).prop("checked", false);
        $(this).parent('.question-label').removeClass('label-selected');
    }
    else{
        $("[id^="+$(this).attr('name')+"]").parent('.question-label').removeClass('label-selected');
        $(this).parent('.question-label').addClass('label-selected');
    }
});

$("input[type='checkbox']").click(function(){
    if(!$(this).is(':checked')){
        checked["num"+$(this).data('question')]--;
        $(this).parent('.question-label').removeClass('label-selected');
    }
    else{
        if(!checked["num"+$(this).data('question')]){
            checked["num"+$(this).data('question')] = 1;
        }
        else{
            checked["num"+$(this).data('question')]++;
        }
        if(checked["num"+$(this).data('question')] > $("#"+$(this).data('question')+"-mark").data('mark')){
            $(this).prop("checked", false);
            checked["num"+$(this).data('question')]--;
            alert('Only '+$("#"+$(this).data('question')+"-mark").data('mark')+' answers can be selected, you must uncheck one of your other answers before you can select this one');
        }
        else{
            $(this).parent('.question-label').addClass('label-selected');
        }
    }
});
{/literal}</script>{/if}
                {/if}
            {elseif $edit || $add}
                <form action="" method="post" class="form-horizontal">
                    {if ($testedit && $edit) || $add}
                        <div class="form-group form-inline">
                            <label for="status" class="col-md-3 control-label">Status:</label>
                            <div class="col-md-9">
                                <select name="status" id="status" class="form-control">
                                    <option value="1"{if ($edit && $testedit.active == 1) || ($add && ($smarty.post.status == 1 || !$smarty.post.status))} selected="selected"{/if}>Active</option>
                                    <option value="0"{if ($edit && $testedit.active == 0) || ($add && $smarty.post.status == 0)} selected="selected"{/if}>Disabled</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name" class="col-md-3 control-label"><span class="text-danger">*</span> Test Name:</label>
                            <div class="col-md-9">
                                <input type="text" name="name" id="name" value="{if $edit}{$testedit.name}{else}{$smarty.post.name}{/if}" class="form-control" placeholder="Test name" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description" class="col-md-3 control-label">Description:</label>
                            <div class="col-md-9">
                                <textarea name="description" id="description" rows="3" class="form-control" placeholder="Test description">{if $edit}{$testedit.description}{else}{$smarty.post.description}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description" class="col-md-3 control-label">Pass Type:</label>
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
                        {if $edit}
                            <div class="text-center"><input type="submit" name="submit" id="submit1" value="Update Test" class="btn btn-success btn-lg" /></div>
                            <h3>Questions</h3>
                            <hr />
                            {foreach $testedit.questions as $question}
                                <div class="row">
                                    <div class="col-md-12">
                                <div class="float-right">
                                    <a href="tests?questionid={$question.question_id}&amp;edit=true" title="Edit Page" class="text-warning"><span class="fa fa-pencil fa-fw"></span> Edit</a> &nbsp; <a href="tests?questionid={$question.question_id}&amp;delete=true" title="Delete Page" class="text-danger"><span class="fa fa-trash fa-fw"></span> Delete</a>
                                </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-3 text-right"><strong>Question {$question.question_order}:</strong></div>
                                    <div class="col-md-9">{$question.question}</div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-3 text-right"><strong>Max. Question Score:</strong></div>
                                    <div class="col-md-9">{$question.max_score}</div>
                                </div>
                                {if $question.question_type == 2 && $question.allow_partial}
                                <div class="form-group">
                                    <div class="col-md-3 text-right"><strong>Partial Score Allowed:</strong></div>
                                    <div class="col-md-9">Yes</div>
                                </div>
                                {/if}
                                <div class="form-group">
                                    <div class="col-md-3 text-right"><strong>Type:</strong></div>
                                    <div class="col-md-9">
                                        {if $question.question_type == 1}Textbox{elseif $question.question_type == 2}Multiple Choice{/if}
                                    </div>
                                </div>
                                {if $question.question_type == 2}
                                <div class="form-group">
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
                                    <div class="form-group">
                                        <div class="col-md-3 text-right"><strong>Explanation:</strong></div>
                                        <div class="col-md-9">
                                            {$question.explanation}
                                        </div>
                                    </div>
                                {/if}
                                {elseif $testedit.self_assessed == 1}
                                <div class="form-group">
                                    <div class="col-md-3 text-right"><strong>Answer:</strong></div>
                                    <div class="col-md-9">
                                        {$question.answers}
                                    </div>
                                </div>
                                {/if}
                                <hr />
                                {assign var="questionnum" value=$question.question_order + 1}
                            {/foreach}
                        {/if}
                        {if $add}
                        <h3>Questions</h3>
                        <hr />
                        <div class="form-group">
                            <label class="col-md-3 control-label"><span class="text-danger">*</span> Question 1</label>
                            <div class="col-md-9">
                                <textarea name="questions[1][q]" id="test_q" rows="3" class="form-control" placeholder="Question 1"></textarea>
                            </div>
                        </div>
                        <div class="form-group form-inline">
                            <label for="score" class="col-md-3 control-label"><span class="text-danger">*</span> Max. Question Score</label>
                            <div class="col-md-9">
                                <input type="text" name="questions[1][score]" id="score" value="1" placeholder="Score" size="3" maxlength="3" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group form-inline" id="question_partial_1" style="display:none">
                            <label for="partial" class="col-md-3 control-label"><span class="text-danger">*</span> Allow partial points<br /><small>The user will be awarded a percetage of the points based on the amount of correct answers they give</small></label>
                            <div class="col-md-9">
                                <select name="questions[1][partial]" id="partial" class="form-control">
                                    <option value="0">No</option>
                                    <option value="1">Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><span class="text-danger">*</span> Answer Type</label>
                            <div class="col-md-9">
                                <div class="radio">
                                    <label><input type="radio" name="questions[1][type]" class="question_type" data-question="1" value="1" checked="checked" /> Textbox</label>
                                    <label><input type="radio" name="questions[1][type]" class="question_type" data-question="1" value="2" /> Multiple Choice</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="question_self_assess_1" style="display:none">
                            <label class="col-md-3 control-label"> Question 1 Answer</label>
                            <div class="col-md-9">
                                 <textarea name="questions[1][answer]" id="test_answer" rows="5" class="form-control" placeholder="Question 1 Answer"></textarea>
                            </div>
                        </div>
                        <div class="form-group" id="question_options_1" style="display:none">
                            <label class="col-md-3 control-label"> Question 1 Options</label>
                            <div class="col-md-9">
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-md-9"><input type="text" name="questions[1][answers][1][answer]" value="" class="form-control" placeholder="Answer 1" /></div>
                                        <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[1][answers][1][correct]" /> Correct</label></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-9"><input type="text" name="questions[1][answers][2][answer]" value="" class="form-control" placeholder="Answer 2" /></div>
                                        <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[1][answers][2][correct]" /> Correct</label></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-9"><input type="text" name="questions[1][answers][3][answer]" value="" class="form-control" placeholder="Answer 3" /></div>
                                        <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[1][answers][3][correct]" /> Correct</label></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-9"><input type="text" name="questions[1][answers][4][answer]" value="" class="form-control" placeholder="Answer 4" /></div>
                                        <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" value="1" name="questions[1][answers][4][correct]" /> Correct</label></div>
                                    </div>
                                    <div id="additional_options_1"></div>
                                    <div class="form-group">
                                        <div class="col-md-9">
                                        <button type="button" id="addOption" data-question="1" class="btn btn-info btn-block">Add another option</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <label class="col-md-3 control-label"> Explanation</label>
                            <div class="col-md-9"><textarea name="questions[1][explanation]" id="explanation" rows="3" class="form-control" placeholder="Answer explanation"></textarea></div>
                        </div>
                        <hr />
                        {/if}
                        <div id="additionalQuestions"></div>
                        <div class="form-group">
                            <div class="col-md-12">
                            <button type="button" id="addQuestion" class="btn btn-danger">Add Another Question</button>
                            </div>
                        </div>
                        <div class="text-center"{if !$add} style="display:none" id="addNewQuestions"{/if}><input type="submit" name="submit" id="submit" value="{if $add}Create{else}Update{/if} Test" class="btn btn-success btn-lg" /></div>
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
    $('#additional_options_'+QuestionID).append("<div class=\"form-group\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+QuestionID+"][answers]["+current["question_"+QuestionID]+"][answer] value=\"\" class=\"form-control\" placeholder=\"Answer "+current["question_"+QuestionID]+"\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" value=\"1\" name=\"questions["+QuestionID+"][answers]["+current["question_"+QuestionID]+"][correct]\" /> Correct</label></div></div>");
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
        $('#additionalQuestions').append("<div class=\"form-group\"><label class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Question "+question+"</label><div class=\"col-md-9\"><textarea name=\"questions["+question+"][q]\" id=\"test_q\" rows=\"3\" class=\"form-control\" placeholder=\"Question "+question+"\"></textarea></div></div><div class=\"form-group form-inline\"><label for=\"score\" class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Max. Question Score</label><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][score]\" id=\"score\" value=\"1\" placeholder=\"Score\" size=\"3\" maxlength=\"3\" class=\"form-control\" /></div></div><div class=\"form-group form-inline\" id=\"question_partial_"+question+"\" style=\"display:none\"><label for=\"partial\" class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Allow partial points<br /><small>The user will be awarded a percetage of the points based on the amount of correct answers they give</small></label><div class=\"col-md-9\"><select name=\"questions["+question+"][partial]\" id=\"partial\" class=\"form-control\"><option value=\"0\">No</option><option value=\"1\">Yes</option></select></div></div><div class=\"form-group\"><label class=\"col-md-3 control-label\"><span class=\"text-danger\">*</span> Answer Type</label><div class=\"col-md-9\"><div class=\"radio\"><label><input type=\"radio\" name=\"questions["+question+"][type]\" class=\"question_type\" value=\"1\" checked=\"checked\" onchange=\"changeType("+question+", 1);\" /> Textbox</label><label><input type=\"radio\" name=\"questions["+question+"][type]\" class=\"question_type\" value=\"2\" onchange=\"changeType("+question+", 2);\" /> Multiple Choice</label></div></div></div><div class=\"form-group\" id=\"question_self_assess_"+question+"\""+($('#pass_type').val() == 3 ? '' : ' style="display:none"')+"><label class=\"col-md-3 control-label\"> Question "+question+" Answer</label><div class=\"col-md-9\"><textarea name=\"questions["+question+"][answer]\" id=\"test_answer\" rows=\"5\" class=\"form-control\" placeholder=\"Question "+question+" Answer\"></textarea></div></div><div class=\"form-group\" id=\"question_options_"+question+"\" style=\"display:none\"><label class=\"col-md-3 control-label\"> Question "+question+" Options</label><div class=\"col-md-9\"><div class=\"row\"><div class=\"form-group\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][1][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 1\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][1][correct]\" value=\"1\" /> Correct</label></div></div><div class=\"form-group\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][2][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 2\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][2][correct]\" value=\"1\" /> Correct</label></div></div><div class=\"form-group\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][3][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 3\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][3][correct]\" value=\"1\" /> Correct</label></div></div><div class=\"form-group\"><div class=\"col-md-9\"><input type=\"text\" name=\"questions["+question+"][answers][4][answer]\" value=\"\" class=\"form-control\" placeholder=\"Answer 4\" /></div><div class=\"col-md-3\"><label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"questions["+question+"][answers][4][correct]\" value=\"1\" /> Correct</label></div></div><div id=\"additional_options_"+question+"\"></div><div class=\"form-group\"><div class=\"col-md-9\"><button type=\"button\" onclick=\"addOptions("+question+");\" class=\"btn btn-info btn-block\">Add another option</button></div></div></div></div><label class=\"col-md-3 control-label\"> Explanation</label><div class=\"col-md-9\"><textarea name=\"questions["+question+"][explanation]\" id=\"explanation"+question+"\" rows=\"3\" class=\"form-control\" placeholder=\"Answer explanation\"></textarea></div></div><hr />");
        $('#addNewQuestions').show();
        current["question_"+question] = 5;
        question++;
    });
});
{/literal}</script>
                    {elseif $edit && $questionedit}
                        <div class="form-group">
                            <label class="col-md-3 control-label"><span class="text-danger">*</span> Question</label>
                            <div class="col-md-9">
                                <textarea name="questions[q]" id="test_q" rows="4" class="form-control" placeholder="Question 1">{$questionedit.question}</textarea>
                            </div>
                        </div>
                        <div class="form-group form-inline">
                            <label for="score" class="col-md-3 control-label"><span class="text-danger">*</span> Max. Question Score</label>
                            <div class="col-md-9">
                                <input type="text" name="questions[score]" id="score" value="{$questionedit.max_score}" placeholder="Score" size="3" maxlength="3" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group form-inline" id="question_partial"{if $questionedit.question_type == 1} style="display:none"{/if}>
                            <label for="partial" class="col-md-3 control-label"><span class="text-danger">*</span> Allow partial points<br /><small>The user will be awarded a percetage of the points based on the amount of correct answers they give</small></label>
                            <div class="col-md-9">
                                <select name="questions[partial]" id="partial" class="form-control">
                                    <option value="0"{if $questionedit.allow_partial != 1} selected="selected"{/if}>No</option>
                                    <option value="1"{if $questionedit.allow_partial == 1} selected="selected"{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"><span class="text-danger">*</span> Answer Type</label>
                            <div class="col-md-9">
                                <div class="radio">
                                    <label><input type="radio" name="questions[type]" class="question_type" value="1"{if $questionedit.question_type == 1} checked="checked"{/if} /> Textbox</label>
                                    <label><input type="radio" name="questions[type]" class="question_type" value="2"{if $questionedit.question_type == 2} checked="checked"{/if} /> Multiple Choice</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="question_self_assess"{if $questionedit.question_type != 1 || $testinfo.self_assessed != 1} style="display:none"{/if}>
                            <label class="col-md-3 control-label"> Question Answer</label>
                            <div class="col-md-9">
                                <textarea name="questions[answer]" id="test_answer" rows="8" class="form-control" placeholder="Question Answer">{$questionedit.answers}</textarea>
                            </div>
                        </div>
                        <div class="form-group" id="question_options"{if $questionedit.question_type == 1} style="display:none"{/if}>
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
                                    <div class="form-group">
                                        <div class="col-md-9"><input type="text" name="questions[answers][{$i}][answer]" value="{$answer.answer}" class="form-control" placeholder="Answer {$i}" /></div>
                                        <div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" name="questions[answers][{$i}][correct]"{if $answer.correct} checked="checked"{/if} /> Correct</label></div>
                                    </div>
                                    {assign var="qnum" value=$qnum+1}
                                {/foreach}
                                <div id="additional_options"></div>
                                <div class="form-group">
                                    <div class="col-md-9">
                                    <button type="button" id="addOption" data-question="1" class="btn btn-info btn-block">Add another option</button>
                                    </div>
                                </div>
                            </div>
                            <label class="col-md-3 control-label"> Explanation</label>
                            <div class="col-md-9"><textarea name="questions[explanation]" id="explanation" rows="3" class="form-control" placeholder="Answer explanation">{$questionedit.explanation}</textarea></div>
                        </div>
                        <div class="form-group text-center">
                            <input type="submit" name="submit" id="submit" value="Update Question" class="btn btn-success btn-lg" />
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
        $('#additional_options').append('<div class="form-group"><div class="col-md-9"><input type="text" name="questions[answers]['+current+'][answer] value="" class="form-control" placeholder="Answer '+current+'" /></div><div class="col-md-3"><label class="checkbox-inline"><input type="checkbox" value="1" name="questions[answers]['+current+'][correct]" /> Correct</label></div></div>');
        current++;
    });
});
{/literal}</script>
                    {/if}
                </form>
            {elseif $submission}
                {if $unmarked || $testSubmissions}
                    {if $unmarked}
                        <div class="card">
                            <div class="card-header"><span class="fa fa-pencil fa-fw"></span> Unmarked test submissions</div>
                            <table class="table table-bordered table-hover">
                                <tr>
                                    <th></th>
                                    <th class="text-center">Name</th>
                                    <th class="text-center">Questions to mark</th>
                                    <th></th>
                                </tr>
                                {foreach $unmarked as $i => $utest}
                                    <tr>
                                        <td class="text-center">{$i+1}</td>
                                        <td class="text-center">{$utest.user_details.title} {$utest.user_details.firstname} {$utest.user_details.surname}</td>
                                        <td class="text-center">{$utest.num_unmarked}</td>
                                        <td class="text-center"><a href="tests?submissions={$smarty.get.submissions}&amp;marktest={$utest.id}" title="Mark Test" class="btn btn-default">Mark Test</a></td>
                                    </tr>
                                {/foreach}
                            </table>
                        </div>
                    {/if}
                    {if $testSubmissions}
                        <div class="card">
                            <div class="card-header"><span class="fa fa-check fa-fw"></span> Test submissions</div>
                            <table class="table table-bordered table-hover">
                                <tr>
                                    <th></th>
                                    <th class="text-center">Name</th>
                                    <th class="text-center">Date Marked</th>
                                    <th class="text-center">Status</th>
                                    <th></th>
                                </tr>
                                {foreach $testSubmissions as $i => $submission}
                                    <tr>
                                        <td class="text-center">{$i+1}</td>
                                        <td class="text-center">{$submission.user_details.title} {$submission.user_details.firstname} {$submission.user_details.surname}</td>
                                        <td class="text-center">{$submission.last_modified|date_format:"%d/%m/%Y %I:%M %p"}</td>
                                        <td class="text-center">{if $submission.status == 2}<strong class="text-danger">Failed</strong>{elseif $submission.status == 3}<strong class="text-success">Passed</strong>{/if}</td>
                                        <td class="text-center"><a href="tests?submissions={$smarty.get.submissions}&amp;reviewtest={$submission.id}" title="Review Test" class="btn btn-default">Review Test</a></td>
                                    </tr>
                                {/foreach}
                            </table>
                        </div>
                    {/if}
                {elseif $mark || $review}
                    <form method="post" action="" class="form-horizontal">
                    {foreach $userinfo as $i => $question}
                        <p><strong>Q{$i + 1}. {$question.question}</strong></p>
                        {if $question.question_type == 1}<p><em class="text-danger">User's answer:</em> {$question.answer}</p><hr style="border-top: dashed 1px;" />
                        {elseif $question.question_type == 2}
                            <div class="alert alert-warning">This question has automatically been marked - <strong>Score: {$question.score}</strong></div>
                            <div class="row">
                            {foreach $question.answers as $a => $answer}
                                <div class="col-sm-6"><label class="question-label reviewing{if $question.answer|is_array}{if $question.answer[$a] == 1}{if $answer.correct} label-correct{else} label-incorrect{/if}{elseif $answer.correct} label-selected{/if}{elseif $question.answer == $a}{if $answer.correct} label-correct{else} label-incorrect{/if}{elseif $answer.correct} label-selected{/if}" for="question{$i + 1}_{$a}"><input type="{if $correct == 1}radio{else}checkbox{/if}" name="{if $correct == 1}question{$i + 1}{else}question{$i + 1}[{$a}]{/if}" id="question{$i + 1}_{$a}" data-question="question{$i + 1}" value="{if $correct == 1}{$a}{else}1{/if}" /> {$answer.answer}</label></div>
                            {/foreach}
                            </div>
                        {/if}
                        {if $question.question_type != 2}<div class="form-group">
                            <label for="score_{$i + 1}" class="col-md-2 control-label">Score</label>
                            <div class="col-md-10 form-inline">
                                <select name="score[{$question.id}]" id="score_{$question.id}" class="form-control">
                                    <option value="unmarked"{if $question.marked == 0} selected="selected"{/if}>Unmarked</option>
                                    {for $i=0 to $question.max_score}
                                        <option value="{$i}"{if $question.score == $i && $question.marked == 1} selected="selected"{/if}>{$i}</option>
                                    {/for}
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="feedback_{$question.id}" class="col-md-2 control-label">Feedback</label>
                            <div class="col-md-10">
                            <textarea name="feedback[{$question.id}]" id="feedback_{$question.id}" class="form-control" placeholder="Feedback">{$question.feedback}</textarea>
                            </div>
                        </div>
                        {/if}
                        <hr />
                    {/foreach}
                    <div class="text-center"><input type="submit" name="submit" id="submit" value="Mark Test" class="btn btn-success btn-lg" /></div>
                    </form>
                {else}
                    <h3 class="text-center">Currently no submissions</h3>
                    <p class="text-center">There are currently no submissions for this test</p>
                {/if}
            {else}
                <h3 class="text-center">Confirm Delete</h3>
                <p class="text-center">Are you sure you wish to delete the {if $smarty.get.questionid}question{else}<strong>{$item.title}</strong> test{/if}?</p>
                <div class="text-center">
                <form method="post" action="" class="form-inline">
                    <a href="tests" title="No, return to test{if !$smarty.get.questionid}s{/if}" class="btn btn-success">No, return to test{if !$smarty.get.questionid}s{/if}</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete {if !$smarty.get.questionid}test{else}question{/if}" />
                </form>
                </div>
            {/if}
        {else}
            <div class="col-md-12 text-center">There are currently no tests for this course</div>
        {/if}
        {if !$testdetails || $reviewInfo}
            <a href="{if !$edit && !$add && !$delete && !$testSubmitted && !$submission}./{elseif $submission && ($mark || $review)}tests?submissions={$smarty.get.submissions}{elseif $edit && $questionedit}tests?testid={$questionedit.test_id}&amp;edit=true{else}tests{/if}" title="Back to {if !$edit && !$add && !$delete}course home{else}tests{/if}"  class="btn btn-default">&laquo; Back to {if !$edit && !$add && !$delete && !$testSubmitted && !$submission}course home{else}tests{/if}</a>
        {/if}
    </div>
</div>
{/strip}