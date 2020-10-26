{strip}
{assign var="headerSection" value="Tests" scope="global"}
{include file="assets/page-header.tpl"}

{if $userDetails.isHeadOffice}<div class="col-12"><a href="/student/learning/{$courseInfo.url}/tests/add" title="Add new test" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new test</a></div>{/if}
{if !$testdetails || $reviewInfo}
    {if $add || $edit || $testSubmitted}
        {assign var="backURL" value="tests/" scope="global"}
        {assign var="backText" value="Back to Tests" scope="global"}
    {/if}
    {include file="assets/back-button.tpl"}
{/if}
<div class="row">
    <div class="col-12">
        {if $tests}
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
                            <td class="text-center">{if $test.submissions.total >= 1}<a href="/student/learning/{$courseInfo.url}/tests/submissions/{$test.test_id}" title="Submissions" class="btn btn-info">View Submissions</a>{/if}</td>
                            <td class="text-center"><a href="/student/learning/{$courseInfo.url}/tests/{$test.test_id}/edit" title="Edit Page" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/tests/{$test.test_id}/delete" title="Delete Page" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></td>{/if}
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
        {else}
            <div class="col-md-12 text-center">There are currently no tests for this course</div>
        {/if}
    </div>
</div>
{if !$testdetails || $reviewInfo}
    {assign var="footerBtn" value="true" scope="global"}
    {include file="assets/back-button.tpl"}
{/if}
{/strip}