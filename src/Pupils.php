<?php
namespace Courses;

use DBAL\Database;
use DBAL\Modifiers\Modifier;
use Configuration\Config;
use DateTime;

class Pupils
{
    protected $db;
    protected $config;
    
    protected $instructors_table = 'instructors';
    
    public $bulkUserTypes = [1 => "Learner Drivers", 2 => "PDIs", 3 => "Instructors", 4 => "Tutors"];

    /**
     * Pass an instance of the database to the class
     * @param Database $db This should be an instance of the database
     */
    public function __construct(Database $db, Config $config)
    {
        $this->db = $db;
        $this->config = $config;
    }
    
    /**
     * Adds a pupil to a given course
     * @param int $pupilID This should be the users unique ID
     * @param int|boolean $isInstructor If the pupil is a instructor should set to 1/true or is just a standard pupil need to set to 0/false
     * @param int $courseID This need to be the course that you are assigning the pupil to
     * @param datetime The date in which the user will have access until, If set to NULL no expiry is set
     * @return boolean If the information has been successfully added will return true else will return false
     */
    public function addPupilAccess($pupilID, $isInstructor, $courseID, $expiry = null)
    {
        if ($expiry !== null && DateTime::createFromFormat('Y-m-d H:i:s', $expiry) !== false) {
            $expiry = date('Y-m-d H:i:s', strtotime($expiry));
        }
        if (is_numeric($pupilID) && (is_numeric($isInstructor) || is_bool($isInstructor)) && is_numeric($courseID)) {
            return $this->db->insert($this->config->table_course_access, ['user_id' => Modifier::setNullOnEmpty(boolval($isInstructor) === false ? $pupilID : null), 'instructor_id' => Modifier::setNullOnEmpty(boolval($isInstructor) === false ? null : $pupilID), 'course_id' => $courseID, 'expiry_date' => $expiry]);
        }
        return false;
    }
    
    /**
     * Bulk enrol users onto a course
     * @param int $type This should be the user types that you wish to enrol
     * @param int $courseID This should be the ID of the course that you want to enrol the users onto
     */
    public function bulkEnrol($type, $courseID)
    {
        $users = $this->getUsersByType($type);
        if (is_array($users) && is_numeric($courseID)) {
            foreach ($users as $user) {
                $this->addPupilAccess($user['id'], $user['is_instructor'], $courseID);
            }
        }
    }
    
    /**
     * Returns an array of users by type (see bulkUserTypes array)
     * @param int $type This should be the type ID
     * @return array|boolean If any users exist for the given type they will be returned as an array else will return false
     */
    protected function getUsersByType($type)
    {
        if ($type == 1) {
            return $this->db->query("SELECT `id`, 0 as `is_instructor` FROM `{$this->config->table_users}` WHERE `student` = 1 AND `student_type` => 1;");
        } elseif ($type == 2) {
            return $this->db->query("SELECT `id`, 0 as `is_instructor` FROM `{$this->config->table_users}` WHERE `student` = 1 AND `student_type` => 2;");
        } elseif ($type == 3) {
            return $this->db->query("SELECT `id`, 1 as `is_instructor` FROM `{$this->instructors_table}` WHERE `disabled` = 0;");
        } elseif ($type == 4) {
            return $this->db->query("SELECT `id`, 1 as `is_instructor` FROM `{$this->instructors_table}` WHERE `disabled` = 0 AND `tutor` = 1;");
        }
        return false;
    }
    
    /**
     * Checks to see if the user has access to the given course
     * @param type $pupilID This should be the users unique ID
     * @param int|boolean $isInstructor If the pupil is a instructor should set to 1/true or is just a standard pupil need to set to 0/false
     * @param int $courseID This need to be the course that you are checking access for
     * @return boolean If the user has access to the course will return true else will return false
     */
    public function getPupilAccess($pupilID, $isInstructor, $courseID)
    {
        return boolval($this->db->count($this->config->table_course_access, array_merge($this->getUserWhere($pupilID, $isInstructor), ['course_id' => $courseID])));
    }
    
    /**
     * Remove a given pupil from the given course
     * @param int $pupilID This should be the users unique ID
     * @param int|boolean $isInstructor If the pupil is a instructor should set to 1/true or is just a standard pupil need to set to 0/false
     * @param int $courseID This need to be the course that you are removing the pupil from
     * @return boolean If the record has been removed will return true else will return false
     */
    public function removePupilAccess($pupilID, $isInstructor, $courseID)
    {
        if (is_numeric($pupilID) && is_numeric($courseID)) {
            return $this->db->delete($this->config->table_course_access, array_merge($this->getUserWhere($pupilID, $isInstructor), ['course_id' => $courseID]));
        }
        return false;
    }
    
    /**
     * Checks to see if the user has access to the given course
     * @param type $pupilID This should be the users unique ID
     * @param int|boolean $isInstructor If the pupil is a instructor should set to 1/true or is just a standard pupil need to set to 0/false
     * @param int $courseID This need to be the course that you are checking access for
     * @return boolean If the user has access to the course will return true else will return false
     */
    public function checkPupilAccess($pupilID, $isInstructor, $courseID)
    {
        return $this->getPupilAccess($pupilID, $isInstructor, $courseID);
    }
    
    /**
     * Returns all of the pupils on a given course
     * @param int $courseID This should be the course ID you want to list all of the pupils for
     * @return array|boolean If any pupils exist the information will be returned as an array else will return false
     */
    public function getPupilsOnCourse($courseID)
    {
        return $this->db->query("SELECT * FROM ((SELECT CONCAT(`{$this->config->table_users}`.`firstname`, ' ', `{$this->config->table_users}`.`lastname`) as `name`, `{$this->config->table_users}`.`email`, `{$this->config->table_users}`.`id`, 0 as `is_instructor` FROM `{$this->config->table_users}` WHERE `{$this->config->table_course_access}`.`course_id` = :courseid AND `{$this->config->table_course_access}`.`user_id` = `{$this->config->table_users}`.`id`) UNION (SELECT `{$this->instructors_table}`.`name`, `{$this->instructors_table}`.`email`, `{$this->instructors_table}`.`id`, 1 as `is_instructor` FROM `{$this->config->table_users}` WHERE `{$this->config->table_course_access}`.`course_id` = :courseid AND `{$this->config->table_course_access}`.`is_instructor` = 1 AND `{$this->config->table_course_access}`.`instructor_id` = `{$this->instructors_table}`.`id`)) ORDER BY `name` ASC;", [':courseid' => intval($courseID)]);
    }
    
    /**
     * Lists all of the course IDs that the pupil given is enrolled onto
     * @param int $pupilID This should be the pupils ID
     * @param int|boolean $isInstructor If the pupil is an instructor set this as true/1 else set to false/0 is just a standard learner
     * @return array|false If the pupil is list on any courses will return an array of the enrolled course ID else will return false
     */
    public function getPupilsCoursesList($pupilID, $isInstructor)
    {
        return $this->db->selectAll($this->config->table_course_access, $this->getUserWhere($pupilID, $isInstructor), ['course_id']);
    }
    
    /**
     * Returns the correct field and value to check user access from the database
     * @param int $pupilID This should be the pupils ID
     * @param int|boolean $isInstructor If the pupil is an instructor set this as true/1 else set to false/0 is just a standard learner
     * @return array
     */
    protected function getUserWhere($pupilID, $isInstructor)
    {
        if (boolval($isInstructor) !== true) {
            return ['user_id' => $pupilID];
        } 
        return ['instructor_id' => $pupilID];
    }
}
