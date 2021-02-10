{strip}
{assign var="backURL" value="tests/" scope="global"}
{assign var="backText" value="Back to Tests" scope="global"}
{include file="assets/back-button.tpl"}
{if $unmarked || $testSubmissions}
    {if $unmarked}
        <div class="card">
            <div class="card-header"><span class="fa fa-pencil-alt fa-fw"></span> Unmarked test submissions</div>
            <table class="table table-striped table-hover mb-0">
                <tr>
                    <th></th>
                    <th class="text-center">Name</th>
                    <th class="text-center">Questions to mark</th>
                    <th></th>
                </tr>
                {foreach $unmarked as $i => $utest}
                    <tr>
                        <td class="text-center">{$i+1}</td>
                        <td class="text-center">{$utest.user_details.title} {$utest.user_details.firstname} {$utest.user_details.lastname}</td>
                        <td class="text-center">{$utest.num_unmarked}</td>
                        <td class="text-center"><a href="/student/learning/{$courseInfo.url}/tests/submissions/{$utest.test_id}/mark/{$utest.id}" title="Mark Test" class="btn btn-success btn-sm">Mark Test</a></td>
                    </tr>
                {/foreach}
            </table>
        </div>
    {/if}
    {if $testSubmissions}
        <div class="card">
            <div class="card-header"><span class="fa fa-check fa-fw"></span> Test submissions</div>
            <table class="table table-striped table-hover mb-0">
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
                        <td class="text-center">{$submission.user_details.title} {$submission.user_details.firstname} {$submission.user_details.lastname}</td>
                        <td class="text-center">{$submission.last_modified|date_format:"%d/%m/%Y %I:%M %p"}</td>
                        <td class="text-center">{if $submission.status == 2}<strong class="text-danger">Failed</strong>{elseif $submission.status == 3}<strong class="text-success">Passed</strong>{/if}</td>
                        <td class="text-center"><a href="/student/learning/{$courseInfo.url}/tests/submissions/{$smarty.get.submissions}/review/{$submission.id}" title="Review Test" class="btn btn-success">Review Test</a></td>
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
        {if $question.question_type != 2}<div class="form-group row">
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
        <div class="form-group row">
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
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}