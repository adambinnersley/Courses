<?php

namespace Courses\Quiz;

class Submission extends Test{
    
    /**
     * Adds a answer to the database for a given user
     * @param int $userID This should be the users ID
     * @param int $userType This should be the user type
     * @param int $questionID This should be the unique question ID
     * @param mixed $userAnswer This should be the answer the user has given
     * @param int $type This should be the type of question answered
     * @return boolean If the answer has been inserted into the database will return true else will return false
     */
    public function addUserAnswer($userID, $userType, $questionID, $userAnswer, $type = 1){
        if($userAnswer){
            if($type == 2){
                $mark = $this->markMultipleChoice($questionID, $userAnswer);
                $userAnswer = serialize($userAnswer);
            }
            return $this->db->insert($this->config->table_course_test_answers, ['user_id' => intval($userID), 'user_type' => intval($userType), 'question_id' => intval($questionID), 'answer' => $userAnswer, 'answer_type' => intval($type), 'score' => intval($mark['score']), 'marked' => intval($mark['marked'])]);
        }
        return false;
    }
    
    /**
     * Deletes a users answers for a given test
     * @param int $testID This should be the test ID that you are deleting the user answers for
     * @param int $userID This should be the users ID
     * @param int $userType This should be the users type
     */
    public function deleteUserAnswers($testID, $userID, $userType){
        $this->db->query("DELETE FROM `".$this->config->table_course_test_answers."` USING `".$this->config->table_course_test_answers."`, `".$this->config->table_course_test_questions."` WHERE `".$this->config->table_course_test_answers."`.`user_id` = ? AND `".$this->config->table_course_test_answers."`.`user_type` = ? AND `".$this->config->table_course_test_answers."`.`question_id` = `".$this->config->table_course_test_questions."`.`question_id` AND `".$this->config->table_course_test_questions."`.`test_id` = ?;", [$userID, $userType, $testID]);
    }
    
    /**
     * If the question has multiple correct answers this function should be called
     * @param array $answers This should be an array of the question answers
     * @param array $userAnswer The array of the users answers
     * @param int $score This should be the maximum score for the question
     * @param int $partial If the user is given a partial score for each correct answer
     * @return int The score that the user has been awarded will be returned
     */
    private function markMultiAnswerQuestion($answers, $userAnswer, $score = 1, $partial = 0){
        $numanswers = 0;
        $numcorrect = 0;
        foreach($answers as $i => $answer){
            if($answer['correct']){
                $numanswers++;
                if($userAnswer[$i] == 1){$numcorrect++;}
            }
        }
        if($partial == 1){return intval(($score / $numanswers) * $numcorrect);}
        elseif($numanswers == $numcorrect){return intval($score);}
        else{return 0;}
        
    }
    
    /**
     * Counts the number of submissions by a course ID
     * @param int $courseID This should be the course ID
     * @return array
     */
    public function countSubmissionByCourse($courseID){
        $submission['total'] = $this->db->query("SELECT count(*) FROM `".$this->config->table_course_test_status."`, `".$this->config->table_course_tests."` WHERE `".$this->config->table_course_test_status."`.`status` >= ? AND `".$this->config->table_course_test_status."`.`test_id` = `".$this->config->table_course_tests."`.`test_id` AND `".$this->config->table_course_tests."`.`course_id` = ?;", [1, $courseID]);
        $submission['unmarked'] = $this->db->query("SELECT count(*) FROM `".$this->config->table_course_test_status."`, `".$this->config->table_course_tests."` WHERE `".$this->config->table_course_test_status."`.`status` = ? AND `".$this->config->table_course_test_status."`.`test_id` = `".$this->config->table_course_tests."`.`test_id` AND `".$this->config->table_course_tests."`.`course_id` = ? AND `".$this->config->table_course_tests."`.`self_assessed` = 0;", [1, $courseID]);
        return $submission;
    }
    
    /**
     * Gets all of the test submissions for a given test
     * @param object This should be an instance of the users class
     * @param int $testID Should be set to the test ID you are retrieving the submissions for
     * @param boolean $marked If you wish to get only the marked tests set to true or for only unmarked tests set to false
     * @return array|boolean Will return the test submissions for the given tests if any exist else will return false
     */
    public function getTestSubmissions($userObject, $testID, $marked = true){        
        $submissions = $this->db->query("SELECT `".$this->config->table_course_test_status."`.* FROM `".$this->config->table_course_test_status."`, `".$this->config->table_course_tests."` WHERE `".$this->config->table_course_tests."`.`self_assessed` = 0 AND `".$this->config->table_course_tests."`.`test_id` = `".$this->config->table_course_test_status."`.`test_id` AND `".$this->config->table_course_test_status."`.`status` ".($marked === true ? ">= 2" : "= 1")." AND `".$this->config->table_course_test_status."`.`test_id` = ? ORDER BY `last_modified` ".($marked === true ? "DESC" : "ASC").";", [$testID]);
        foreach($submissions as $i => $status){
            if($status['user_type'] == 1){$submissions[$i]['user_details'] = $userObject->getUserDetails($status['user_id']);}
            elseif($status['user_type'] == 2){$submissions[$i]['user_details'] = $userObject->getInstuctorDetails($status['user_id']);}
            if(!$marked){$submissions[$i]['num_unmarked'] = count($this->db->query("SELECT * FROM `".$this->config->table_course_test_answers."`, `".$this->config->table_course_test_questions."` WHERE `".$this->config->table_course_test_questions."`.`test_id` = '".$status['test_id']."' AND `".$this->config->table_course_test_questions."`.`question_id` = `".$this->config->table_course_test_answers."`.`question_id` AND `".$this->config->table_course_test_answers."`.`marked` = 0;"));}
        }
        return $submissions;
    }
    
    /**
     * Gets the current status for the user for the given test
     * @param int $testID This should be the test ID
     * @param int $userID This should be the user ID
     * @param int $userType This should be the user type
     * @return array The users test status details will be returned as an array
     */
    public function getTestStatus($testID, $userID, $userType = 1){
        $testStatus = $this->db->select($this->config->table_course_test_status, ['user_id' => intval($userID), 'user_type' => intval($userType), 'test_id' => intval($testID)]);
        if(!$testStatus){
            return ['status' => 0];
        }
        return $testStatus;
    }
    
    /**
     * Gets the status details for the given ID
     * @param int $statusID This should be the unique status id you wish to get the details for
     * @return array|boolean If the id exists the details will be returned as an array else will return false
     */
    public function getStatusInfo($statusID){
        if(is_numeric($statusID)){
            return $this->db->select($this->config->table_course_test_status, ['id' => $statusID]);
        }
        return false;
    }
    
    /**
     * Gets the questions and the users answers for a particular test
     * @param int $testID This should be test ID
     * @param int $userID This should be the user ID of the user you are getting the answers for
     * @param int $userType This should be the user type of the user you are getting the answers for
     * @return array|boolean If answers exist for the current user will return the array of answers and questions else will return false
     */
    public function getQuestionAndAnswers($testID, $userID, $userType = 1){
        $questionInfo = $this->db->query("SELECT * FROM `".$this->config->table_course_test_questions."`, `".$this->config->table_course_test_answers."` WHERE `".$this->config->table_course_test_questions."`.`test_id` = ? AND `".$this->config->table_course_test_questions."`.`question_id` = `".$this->config->table_course_test_answers."`.`question_id` AND `".$this->config->table_course_test_answers."`.`user_id` = ? AND `".$this->config->table_course_test_answers."`.`user_type` = ? ORDER BY `".$this->config->table_course_test_questions."`.`question_order` ASC;", [$testID, $userID, $userType]);
        foreach($questionInfo as $i => $question){
            if($question['answer_type'] == 2){
                $questionInfo[$i]['answers'] = unserialize($question['answers']);
                $questionInfo[$i]['answer'] = unserialize($question['answer']);
            }
        }
        return $questionInfo;
    }    
    
    /**
     * Updates the test status for a given user and test
     * @param int $testID This should be test ID
     * @param int $userID This should be the user ID of the user you are updating the status of
     * @param int $userType This should be the user type of the user you are updating the status of
     * @param int|null $testStatus If the status is already set as numeric, set this here else set as null
     * @return boolean If the status is updated will be set to true else will return false
     */
    public function updateTestStatus($testID, $userID, $userType = 1, $testStatus = NULL){
        $score = 0;
        $max_score = 0;
        $complete = true;
        $userAnswers = $this->getQuestionAndAnswers($testID, $userID, $userType);
        if($userAnswers){
            foreach($userAnswers as $question){
                $max_score = intval($max_score + intval($question['max_score']));
                $score = intval($score + intval($question['score']));
                if($question['marked'] == 0){$testStatus = 1;$complete = false;}
            }
        }
        else{$complete = false;}
        $status = $this->setTestStatus($testID, $score, $max_score, $testStatus, $complete);
        if($this->db->count($this->config->table_course_test_status, ['user_id' => intval($userID), 'user_type' => intval($userType), 'test_id' => intval($testID)])){
            return $this->db->update($this->config->table_course_test_status, ['score' => intval($score), 'status' => intval($status)], ['user_id' => intval($userID), 'user_type' => intval($userType), 'test_id' => intval($testID)]);
        }
        else{
            return $this->db->insert($this->config->table_course_test_status, ['user_id' => intval($userID), 'user_type' => intval($userType), 'test_id' => intval($testID), 'score' => intval($score), 'status' => intval($status)]);
        }
    }
        
    /**
     * Deletes the users test statuses
     * @param int $userID This should be the user ID you are deleting the statuses for
     * @param int $userType This should be the user type you are deleting the statuses for
     * @return boolean If the users statuses have been deleted will return true else return false
     */
    public function deleteUserStatus($userID, $userType = 1){
        return $this->db->delete($this->config->table_course_test_status, ['user_id' => intval($userID), 'user_type' => intval($userType)]);
    }
    
    /**
     * Sets the current users test status depending on their answers and marking status
     * @param int $testID This should be the test ID
     * @param int $score The current score the user has
     * @param int $max_score The maximum score possible for the test
     * @param int|null $testStatus If the test status is to be set this should range from 0-3
     * @param boolean $complete If the marking is complete for all question set to true else should be false
     * @return int The current status will be returned (0 = incomplete, 1 - Awaiting marking, 2 = Failed, 3 = Passed)
     */
    private function setTestStatus($testID, $score, $max_score, $testStatus = NULL, $complete = false){
        if($complete){
            $testInfo = $this->getTestName($testID);
            if(($testInfo['pass_mark'] && $score >= $testInfo['pass_mark']) || ($testInfo['pass_percentage'] && ((($score / $max_score) * 100) >= $testInfo['pass_percentage'])) || $testStatus == 3){$status = 3;} // Pass
            elseif(($testInfo['pass_mark'] && $score < $testInfo['pass_mark']) || ($testInfo['pass_percentage'] && ((($score / $max_score) * 100) < $testInfo['pass_percentage'])) || $testStatus == 2){$status = 2;} // Fail
            elseif(!$testInfo['pass_mark'] && !$testInfo['pass_percentage'] && $testStatus == 1){$status = 1;} // Unmarked
        }
        elseif($testStatus == 1){$status = 1;} // Unmarked
        else{$status = 0;} // Incomplete
        return $status;
    }
    
    /**
     * Marks the test question if it is a multiple choice question and not a text answer
     * @param int $questionID This should be the question id to mark
     * @param int|array $userAnswer This should be the users answer for the given question
     * @return array This will return an array containing the users score for the question and also the it has been marked
     */
    private function markMultipleChoice($questionID, $userAnswer){
        $questionInfo = $this->getQuestionInfo($questionID);
        if(is_array($userAnswer)){$correct = $this->markMultiAnswerQuestion($questionInfo['answers'], $userAnswer, $questionInfo['max_score'], $questionInfo['allow_partial']);}
        else{$correct = $this->markSingleAnswer($questionInfo['answers'], $userAnswer, $questionInfo['max_score']);}
        $mark['score'] = intval($correct);
        $mark['marked'] = 1;
        return $mark;
    }
    
    /**
     * If the Question only has 1 correct answer this function should be call to mark the question
     * @param array $answers This should be an array of the question answers
     * @param int $userAnswer This should be the users answer selected
     * @param int $score This should be the maximum score for the question
     * @return int The score that the user has been awarded will be returned
     */
    private function markSingleAnswer($answers, $userAnswer, $score = 1){
        if($answers[intval($userAnswer)]['correct']){return intval($score);}
        else{return 0;}
    }
    
    /**
     * Marks a selected set of answers and add appropriate feedback
     * @param array $scores This should be the scores that have been given to answers
     * @param array $feedback This should be any feedback that have been given to answers
     * @param int $testID This should be the test ID that you are updating scores for
     * @param int $userID This should be the users ID that you are updating scores for
     * @param int $userType This should be the users type that you are updating scores for
     */
    public function markAnswer($scores, $feedback, $testID, $userID, $userType){
        if(is_array($scores)){
            foreach($scores as $i => $score){
                if(is_numeric($score)){
                    if(empty($feedback[$i])){$questionFeedback = NULL;}else{$questionFeedback = $feedback[$i];}
                    $this->db->update($this->config->table_course_test_answers, ['score' => $score, 'marked' => 1, 'feedback' => $questionFeedback], ['id' => $i]);
                }
            }
            $this->updateTestStatus($testID, $userID, $userType);
        }
    }
}
