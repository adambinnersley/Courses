<?php

namespace Courses;

use DBAL\Modifiers\Modifier;

class Course extends Pages
{
    public $course_id;
    public $course_info;
    
    public $max_image_width = 500;
    
    /**
     * Returns the path of the template dir
     * @return string
     */
    public function getTemplateDir()
    {
        return dirname(__DIR__).DIRECTORY_SEPARATOR.'templates';
    }
    
    /**
     * Return a list of all of the available courses
     * @param int $active If active is set to 1 will only return the active courses else will return all of them
     * @return array Return a array of all of the available courses
     */
    public function listCourses($active = 1)
    {
        return $this->db->selectAll($this->config->table_courses, ($active == 1 ? ['active' => 1] : []));
    }
    
    /**
     * Gets a list of all of the courses that the current user is associated with
     * @param int $userID This should be the user ID of the person to check what courses they are associated with
     * @param boolean $isInstructor If the user is an instructor set to true else should be false
     * @return array|boolean If the user is associated with any courses an array will be returned else will return false
     */
    public function getUserCourses($userID, $isInstructor = false)
    {
        if (is_numeric($userID)) {
            return $this->db->query("SELECT * FROM `{$this->config->table_courses}`, `{$this->config->table_course_access}` WHERE `{$this->config->table_course_access}`.".($isInstructor === true ? "`instructor_id`" : "`user_id`")." = ? AND `{$this->config->table_courses}`.`id` = `{$this->config->table_course_access}`.`course_id` AND `{$this->config->table_courses}`.`active` = 1;", [$userID]);
        }
        return false;
    }
    
    /**
     * Adds a new course to the database
     * @param string $title This should be the course title
     * @param string $url This should be a unique URL to give to the course
     * @param string|null $content This should be any course description or welcome text that you wish to add
     * @param int $status If the course is to be set to active set this as 1 else set to 0
     * @param file|null $image If you want to add an image to the course this should be set as the content string else should be set to NULL
     * @param array $additional Any additional field which require adding must be added as an array here
     * @return boolean If the course has been added will return true else returns false
     */
    public function addCourse($title, $url, $content = null, $status = 1, $image = null, $additional = [])
    {
        if (!empty($title) && !empty($url) && !$this->getCourseByURL($url)) {
            $additional = array_merge($additional, $this->checkImageUpload($image));
            return $this->db->insert($this->config->table_courses, array_merge(['url' => strtolower($url), 'name' => $title, 'description' => Modifier::setNullOnEmpty($content), 'active' => Modifier::setZeroOnEmpty($status)], $additional));
        }
        return false;
    }
    
    /**
     * Edits a course details in the database
     * @param int $courseID This should be the unique course id for the course you are editing
     * @param string $title This should be the course title
     * @param string $url This should be a unique URL to give to the course
     * @param string|null $content This should be any course description or welcome text that you wish to add
     * @param int $status If the course is to be set to active set this as 1 else set to 0
     * @param file|null $image If you want to add an image to the course this should be set as the content string else should be set to NULL
     * @param array $additional Any additional field which require update must be added as an array here
     * @return boolean If the course has been successfully updated will return true else will return false
     */
    public function editCourse($courseID, $title, $url, $content = null, $status = 1, $image = null, $additional = [])
    {
        if (is_numeric($courseID) && !empty($title) && !empty($url)) {
            $additional = array_merge($additional, $this->checkImageUpload($image));
            $additional['enrol_learners'] = Modifier::setZeroOnEmpty($additional['enrol_learners']);
            $additional['enrol_psis'] = Modifier::setZeroOnEmpty($additional['enrol_psis']);
            $additional['enrol_instructors'] = Modifier::setZeroOnEmpty($additional['enrol_instructors']);
            $additional['enrol_tutors'] = Modifier::setZeroOnEmpty($additional['enrol_tutors']);
            $additional['enrol_individuals'] = Modifier::setZeroOnEmpty($additional['enrol_individuals']);
            return $this->db->update($this->config->table_courses, array_merge(['url' => $url, 'name' => $title, 'description' => $content, 'active' => Modifier::setZeroOnEmpty($status)], $additional), ['id' => $courseID], 1);
        }
        return false;
    }
    
    /**
     * Delete a course from the database
     * @param int $courseID This should be the courses unique ID
     * @return boolean Returns true if successfully deleted else returns false
     */
    public function deleteCourse($courseID)
    {
        return $this->db->delete($this->config->table_courses, ['id' => $courseID], 1);
    }
    
    /**
     * Checks the validity of an image an sets the variables so they can be added to the database
     * @param file|NULL $upload This should be the image file if one is uploaded else should be set as null
     * @return array An array will be returned if the image meets requirements will contain require values else will be empty array
     */
    protected function checkImageUpload($upload)
    {
        $this->setAllowedExtensions(['png', 'jpg', 'jpeg', 'gif']);
        if (isset($upload['name']) && $this->checkMimeTypes($upload) && $this->fileExtCheck($upload) && $this->fileSizeCheck($upload)) {
            $image = [];
            $resized = $this->resizeImage($upload);
            $image['image'] = file_get_contents($resized);
            $image['image_name'] = $upload['name'];
            $image['image_size'] = filesize($resized);
            $image['image_type'] = $upload['type'];
            return $image;
        }
        return [];
    }
    
    /**
     * Resizes the uploaded image to meet the maximum size requirements
     * @param array $image This should be the image that has been uploaded
     * @return string The resized image will be returned
     */
    protected function resizeImage($image)
    {
        list($width, $height, $type) = getimagesize($image["tmp_name"]);
        if ($width > $this->max_image_width) {
            $new_height = intval($height * ($this->max_image_width / $width));
            if ($type == 1) {
                $imgt = "ImageGIF";
                $imgcreatefrom = "ImageCreateFromGIF";
            } elseif ($type == 2) {
                $imgt = "ImageJPEG";
                $imgcreatefrom = "ImageCreateFromJPEG";
            } else {
                $imgt = "ImagePNG";
                $imgcreatefrom = "ImageCreateFromPNG";
            }
            $old_image = $imgcreatefrom($image["tmp_name"]);
            imagealphablending($old_image, true);
            $new_image = imagecreatetruecolor($this->max_image_width, $new_height);
            imagealphablending($new_image, false);
            imagesavealpha($new_image, true);
            imagecopyresized($new_image, $old_image, 0, 0, 0, 0, $this->max_image_width, $new_height, $width, $height);
            $imgt($new_image, sys_get_temp_dir().$image['name']);
            return sys_get_temp_dir().$image['name'];
        } else {
            return $image["tmp_name"];
        }
    }
    /**
     * Get the course details by the URL
     * @param string $course_url This should be the unique URL given to the course
     * @return array|boolean If the course URL is correct the course details will be returned else will return false
     */
    public function getCourseByURL($course_url)
    {
        return $this->db->select($this->config->table_courses, ['url' => strtolower($course_url)]);
    }
    
    /**
     * Gets the course details based on the given course ID
     * @param int $course_id This should be the unique ID given to the course
     * @return array|boolean If the course ID is correct the course details will be returned else will return false
     */
    public function getCourseByID($course_id)
    {
        return $this->db->select($this->config->table_courses, ['id' => $course_id]);
    }
    
    /**
     * Retrieves the name of the course based on the course ID given
     * @param int $course_id This should be the unique course ID that you wish to get the name of the course for
     * @return string|boolean Will return the name of the course if the ID exists else will return false
     */
    public function getCourseName($course_id)
    {
        $courseInfo = $this->getCourseByID($course_id);
        if (is_array($courseInfo)) {
            return $courseInfo['name'];
        }
        return false;
    }
    
    /**
     * Sets the details for a course page
     * @param string $name This should be the name of the course
     * @param string $description This should be any description of the course
     * @param int $active If the course is active set as 1 else set to 0
     * @param int|null $id If updating an existing course details set as the course ID else should be set to null
     * @return boolean If the course details are inserted/updated successfully will return true else will return false
     */
    public function setCourseDetails($name, $description, $active = 1, $id = null)
    {
        $values = ['name' => $name, 'description' => $description, 'active' => $active];
        if (is_numeric($id)) {
            return $this->db->update($this->config->table_courses, $values, ['id' => $id]);
        } else {
            return $this->db->insert($this->config->table_courses, $values);
        }
    }
}
