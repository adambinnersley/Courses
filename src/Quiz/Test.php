<?php

namespace Courses\Quiz;

class Test extends Questions{
    
    /**
     * Get a list of all of the tests for a given course and user
     * @param int $courseID This should be the unique course ID you wish to get the 
     * @param int $userID This should be the users ID
     * @param int $userType The users type as multiple types exist (1 = student, 2 = instructor)
     * @param boolean $active If only active tests should be selected set to true else set to false
     * @return string|boolean If tests exists will return a multi-dimensional array else will return false
     */
    public function getCourseTests($courseID, $userID, $userType = 1, $active = true){
        if(is_numeric($courseID)){
            $where['course_id'] = $courseID;
            if($active){$where['active'] = 1;}
            $tests = $this->db->selectAll($this->config->table_course_tests, $where);
            if(is_array($tests)) {
                foreach($tests as $i => $test) {
                    $tests[$i]['max_score'] = $this->getMaxScore($test['test_id']);
                    $tests[$i]['no_questions'] = $this->db->count($this->config->table_course_test_questions, ['test_id' => $test['test_id']]);
                    $tests[$i]['results'] = $this->getTestStatus($test['test_id'], $userID, $userType);
                    if(!$active){$tests[$i]['submissions'] = $this->countSubmissionsByTest($test['test_id']);}
                }
                return $tests;
            }
        }
        return false;
    }
    
    /**
     * Gets the details for a given test ID
     * @param int $testID This should be the unique tset ID
     * @return array|boolean If the test tests will return the details as part of an array else will return false
     */
    public function getTestName($testID){
        if(is_numeric($testID)){
            return $this->db->select($this->config->table_course_tests, ['test_id' => $testID]);
        }
    }

    /**
     * Updates the details for a given test
     * @param int $testID This should be the test ID of the test you are updating
     * @param string $name The name of the test
     * @param int $status The status of the test if it is active should be set to 1 else set to 0
     * @param int $pass_type This should be the how the test is marked (1 = Total score, 2 = Percentage)
     * @param int|null $passmark If the pass type is set to 1 this should be set to a number else should be null
     * @param int|null $passpercent If the pass type is set to 2 this should be set to a number else should be null
     * @param string|null $description If you wish to provide a description for the test this should be set here else set to null
     * @return boolean If the test has been updated will return true else returns false
     */
    public function updateTestInfo($testID, $name, $status, $pass_type, $passmark = NULL, $passpercent = NULL, $description = NULL){
        if(is_numeric($testID)){
            if(empty($description)){$description = NULL;}
            if($pass_type == 1){$mark = intval($passmark); $percent = NULL; $self_assessed = 0;}
            elseif($pass_type == 2){$mark = NULL; $percent = intval($passpercent); $self_assessed = 0;}
            elseif($pass_type == 3){$mark = NULL; $percent = NULL; $self_assessed = 1;}
            return $this->db->update($this->config->table_course_tests, ['name' => $name, 'description' => $description, 'self_assessed' => intval($self_assessed), 'pass_mark' => $mark, 'pass_percentage' => $percent, 'active' => intval($status)], ['test_id' => intval($testID)], 1);
            
        }
        return false;
    }
    
    /**
     * Adds a complete test to the database including questions
     * @param int $courseID This should be the course that you wish to assign the test to
     * @param string $name The name that you are giving to the course
     * @param int $status If the test should be set to active set to 1 else set to 0
     * @param array $questions This should be the POST data of the questions
     * @param int $pass_type This should be the how the test is marked (1 = Total score, 2 = Percentage)
     * @param int|null $passmark If the pass type is set to 1 this should be set to a number else should be null
     * @param int|null $passpercent If the pass type is set to 2 this should be set to a number else should be null
     * @param string|null $description If you want to set a description for the test set here else set to null
     * @return boolean If the test and questions have been added to the database will return true else returns false
     */
    public function addCompleteTest($courseID, $name, $status, $questions, $pass_type, $passmark = NULL, $passpercent = NULL, $description = NULL){
        if($this->addTestInfo($courseID, $name, $status, $pass_type, $passmark, $passpercent, $description)){
            $testID = $this->db->lastInsertId();
            foreach($questions as $order => $question){
                $this->addQuestion($testID, $question, $order);
            }
            return true;
        }
        return false;
    }
    
    /**
     * Adds a new test's details to the database
     * @param int $courseID This should be course the test is assigned to
     * @param string $name The name of the test
     * @param int $status If the test is active should be set to 1 else set to 0 
     * @param int $pass_type This should be the how the test is marked (1 = Total score, 2 = Percentage)
     * @param int|null $passmark If the pass type is set to 1 this should be set to a number else should be null
     * @param int|null $passpercent If the pass type is set to 2 this should be set to a number else should be null
     * @param string|null $description This should be any description for the test that you wish to add else should be set to null
     * @return boolean If the course has been added to the database will return true
     */
    protected function addTestInfo($courseID, $name, $status, $pass_type, $passmark = NULL, $passpercent = NULL, $description = NULL){
        if(is_numeric($courseID)){
            if(empty($description)){$description = NULL;}
            if($pass_type == 1){$mark = intval($passmark); $percent = NULL; $self_assessed = 0;}
            elseif($pass_type == 2){$mark = NULL; $percent = intval($passpercent); $self_assessed = 0;}
            elseif($pass_type == 3){$mark = NULL; $percent = NULL; $self_assessed = 1;}
            return $this->db->insert($this->config->table_course_tests, ['course_id' => intval($courseID), 'name' => $name, 'description' => $description, 'self_assessed' => intval($self_assessed), 'pass_mark' => $mark, 'pass_percentage' => $percent, 'active' => $status]);
        }
        return false;
    }
    
    /**
     * Gets the test details and questions for a given test ID
     * @param int $testID This should be the test ID that you are getting the information for
     * @return array|boolean This will return a multi-dimensional array if the test exists else will return false 
     */
    public function getTestInformation($testID){
        $testInfo = $this->getTestName($testID);
        if($testInfo){
            $testInfo['questions'] = $this->getTestQuestions($testID);
            return $testInfo;
        }
        return false;
    }
    
    /**
     * Deletes a test and its questions based on a given test ID
     * @param int $testID This should be the unique test ID
     * @return boolean If the test information has been deleted, will return true else returns false
     */
    public function deleteTest($testID){
        if(is_numeric($testID)){
            if($this->db->delete($this->config->table_course_tests, ['test_id' => $testID], 1)){
                $this->db->delete($this->config->table_course_test_questions, ['test_id' => $testID]);
                return true;
            }
        }
        return false;
    }
    /**
     * Gets the total number of submissions and unmarked submission for a given test
     * @param int $testID This should be the test ID
     * @return array An array containing the total number of submissions and unmarked submission will be returned
     */
    public function countSubmissionsByTest($testID){
        $submission['total'] = intval($this->db->query("SELECT count(*) as `count` FROM `{$this->config->table_course_test_status}`, `{$this->config->table_course_tests}` WHERE `{$this->config->table_course_test_status}`.`status` >= ? AND `{$this->config->table_course_test_status}`.`test_id` = `{$this->config->table_course_tests}`.`test_id` AND `{$this->config->table_course_tests}`.`test_id` = ?;", [1, $testID])[0]['count']);
        $submission['unmarked'] = intval($this->db->query("SELECT count(*) as `count` FROM `{$this->config->table_course_test_status}`, `{$this->config->table_course_tests}` WHERE `{$this->config->table_course_test_status}`.`status` = ? AND `{$this->config->table_course_test_status}`.`test_id` = `{$this->config->table_course_tests}`.`test_id` AND `{$this->config->table_course_tests}`.`test_id` = ? AND `{$this->config->table_course_tests}`.`self_assessed` = 0;", [1, $testID])[0]['count']);
        return $submission;
    }
}
