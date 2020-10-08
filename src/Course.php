<?php

namespace Courses;

use DBAL\Database;
use DBAL\Modifiers\Modifier;
use Upload\FileUpload;
use Configuration\Config;

class Course extends FileUpload
{
    protected $db;
    protected $config;

    public $course_id;
    public $course_info;
    
    public $max_image_width = 500;
    
    /**
     * Should provide an instance of the database class to use
     * @param Database $db This should be an instance of the Database class
     */
    public function __construct(Database $db, Config $config)
    {
        $this->db = $db;
        $this->config = $config;
    }
    
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
        if ($active == 1) {
            $where = ['active' => 1];
        } else {
            $where = [];
        }
        return $this->db->selectAll($this->config->table_courses, $where);
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
        if (!empty($title) && !empty($url)) {
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
        if (is_numeric($courseID)) {
            return $this->db->delete($this->config->table_courses, ['id' => $courseID], 1);
        }
        return false;
    }
    
    /**
     * Checks the validity of an image an sets the variables so they can be added to the database
     * @param file|NULL $upload This should be the image file if one is uploaded else should be set as null
     * @return array An array will be returned if the image meets requirements will contain require values else will be empty array
     */
    protected function checkImageUpload($upload)
    {
        $this->setAllowedExtensions(['png', 'jpg', 'jpeg', 'gif']);
        if ($upload['name'] && $this->checkMimeTypes($upload) && $this->fileExtCheck($upload) && $this->fileSizeCheck($upload)) {
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
     * @param file $image This should be the image that has been uploaded
     * @return file The resized image will be returned
     */
    protected function resizeImage($image)
    {
        list($width, $height, $type, $attr) = getimagesize($image["tmp_name"]);
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
        return $this->db->select($this->config->table_courses, ['url' => $course_url]);
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
        if (is_numeric($course_id)) {
            $courseInfo = $this->getCourseByID($course_id);
            return $courseInfo['name'];
        }
        return false;
    }
    
    /**
     * Returns a list of all of the main pages that aren't sub-pages
     * @param int $course_id This should be the course ID that you are getting all of the main pages for
     * @return array|boolean If any main pages exist will return an array of their details else will return false
     */
    public function getMainPages($course_id)
    {
        $pages = $this->db->selectAll($this->config->table_course_content, ['course_id' => $course_id, 'subof' => 'IS NULL'], '*', ['nav_order' => 'ASC']);
        if (!empty($pages)) {
            foreach ($pages as $i => $page) {
                $pages[$i]['order'] = $this->removeZeros($page['nav_order']);
            }
            return $pages;
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
    
    /**
     * Returns a list of the course/individual course page for a course
     * @param int $course_id This should be the ID of the course that you are retrieving course pages for
     * @param int|null $subof If the page id is numeric will return the given page else will simply return all course pages
     * @return boolean|array If the course id and/or page id is correct will return an array of either a list of all pages or the idividual page details
     */
    public function getCoursePages($course_id, $subof = null)
    {
        if (is_numeric($course_id)) {
            $where['course_id'] = $course_id;
            if (is_numeric($subof)) {
                $where['subof'] = intval($subof);
            } else {
                $where['subof'] = 'IS NULL';
            }
            $pageInfo = $this->db->selectAll($this->config->table_course_content, $where, '*', ['nav_order' => 'ASC']);
            foreach ($pageInfo as $i => $page) {
                if (is_null($page['subof'])) {
                    $pageInfo[$i]['subpages'] = $this->getCoursePages($course_id, $page['page_id']);
                    $subof = 'IS NULL';
                }
                $pageInfo[$i]['has_prev'] = $this->db->count($this->config->table_course_content, ['course_id' => $page['course_id'], 'subof' => $subof, 'nav_order' => ['<' => $page['nav_order']]]);
                $pageInfo[$i]['has_next'] = $this->db->count($this->config->table_course_content, ['course_id' => $page['course_id'], 'subof' => $subof, 'nav_order' => ['>' => $page['nav_order']]]);
                $pageInfo[$i]['order'] = $this->removeZeros($page['nav_order']);
            }
            return $pageInfo;
        }
        return false;
    }
    
    /**
     * Add a page to a course
     * @param int $courseID This should be the ID of the course you are adding to page to
     * @param string $title This should be the title you wish to give to the page
     * @param string $content This should be the content you wish to give to the page
     * @return boolean If the page has successfully been added will return true else will return false
     */
    public function addCoursePage($courseID, $title, $content, $subpage = 0)
    {
        if (is_numeric($courseID) && $title && $content) {
            return $this->db->insert($this->config->table_course_content, ['course_id' => $courseID, 'title' => $title, 'content' => $content, 'subof' => Modifier::setNullOnEmpty($subpage), 'nav_order' => $this->formatPageOrder($this->getNextOrderNum($courseID, intval($subpage)), $subpage)]);
        }
        return false;
    }
    
    /**
     * Edits a given course page
     * @param int $pageID This should be the page
     * @param string $title This should be the title you wish to give to the page
     * @param string $content This should be the content you wish to give to the page
     * @return boolean If the page has been successfully updated will return true else will return false
     */
    public function editCoursePage($pageID, $title, $content, $subpage = 0)
    {
        if (is_numeric($pageID) && $title && $content) {
            $currentValue = $this->getPageByID($pageID);
            
            if ($subpage == 0 && $currentValue['subof'] != intval($subpage)) {
                $where = ['nav_order' => $this->formatPageOrder($this->getNextOrderNum($currentValue['course_id']), $subpage)];
                $reorderSub = $currentValue['subof'];
                $reorder = true;
            } elseif (($currentValue['subof'] != intval($subpage)) || ($currentValue['subof'] == null && $currentValue['subof'] != intval($subpage))) {
                $where = ['nav_order' => $this->formatPageOrder($this->getNextOrderNum($currentValue['course_id'], $subpage), $subpage)];
                if ($currentValue['subof'] == null && $currentValue['subof'] != intval($subpage)) {
                    $reorderSub = 0;
                } else {
                    $reorderSub = $currentValue['subof'];
                }
                $reorder = true;
            } else {
                $where = [];
            }
            if ($this->db->update($this->config->table_course_content, array_merge(['title' => $title, 'content' => $content, 'subof' => Modifier::setNullOnEmpty($subpage)], $where), ['page_id' => $pageID], 1)) {
                if ($reorder) {
                    $this->reorderFollowingPages($currentValue['course_id'], $currentValue['nav_order'], $reorderSub);
                }
                return true;
            }
        }
        return false;
    }
    
    /**
     * Generated the order of the page and returns correctly formatted number
     * @param int $order This should be the page order
     * @param int $subpage If the page is a subpage set this as the subpage unique page ID
     * @return int The order number will be returned
     */
    protected function formatPageOrder($order, $subpage)
    {
        if ($subpage >= 1) {
            $subPageInfo = $this->getPageByID($subpage);
            return intval($subPageInfo['nav_order']).'.'.str_pad($order, 3, '0', STR_PAD_LEFT);
        }
        return intval($order);
    }
    
    /**
     * Deletes a page from a course
     * @param int $pageID This should be the unique ID of the page that you wish to delete
     * @return boolean If the page has successfully been deleted will return true else returns false
     */
    public function deleteCoursePage($pageID)
    {
        if (is_numeric($pageID)) {
            $pageInfo = $this->getPageByID($pageID);
            if ($this->db->delete($this->config->table_course_content, ['page_id' => $pageID])) {
                $this->reorderFollowingPages($pageInfo['course_id'], $pageInfo['nav_order'], $pageInfo['subof']);
                return true;
            }
        }
        return false;
    }
    
    /**
     * Gets the next order available to give to a new page
     * @param int $courseID This is the course ID of the page you wish to get the next available order number for
     * @param int $subpage If the page is a subpage set this here should be either set to 0 for no subpage or to the id of the page it is a subpage for
     * @return int This will return the next order number available for the page
     */
    protected function getNextOrderNum($courseID, $subpage = 0)
    {
        if (intval($subpage) === 0) {
            $subpage = 'IS NULL';
        }
        $pageNum = $this->db->count($this->config->table_course_content, ['course_id' => $courseID, 'subof' => $subpage], '*', ['nav_order' => 'DESC']);
        return intval(intval($pageNum) + 1);
    }
    
    /**
     * Rearranges any following pages during the delete process to make sure their are no order gaps
     * @param int $courseID This should be the course ID that the pages are allocated to
     * @param int $followingOrder The navigation order of the page that is being deleted
     * @param int $subpage If you are reordering sub-pages this should be set as the main page sub you are reordering
     * @param boolean $subtract If the following pages should subtract 1 should be set to true else to add a space for a new page set to false
     */
    protected function reorderFollowingPages($courseID, $followingOrder, $subpage = 0, $subtract = true)
    {
        if (intval($subpage) === 0) {
            $subpage = 'IS NULL';
        }
        foreach ($this->db->selectAll($this->config->table_course_content, ['course_id' => $courseID, 'subof' => $subpage, 'nav_order' => ['>=', $followingOrder]], '*', ['nav_order' => $subtract ? 'ASC' : 'DESC']) as $page) {
            if ($subpage >= 1) {
                $pageValue = 0.001;
            } else {
                $pageValue = 1;
            }
            if ($subtract) {
                $neworder = ($page['nav_order'] - $pageValue);
            } else {
                $neworder = ($page['nav_order'] + $pageValue);
            }
            $this->db->update($this->config->table_course_content, ['nav_order' => $neworder], ['page_id' => $page['page_id']]);
        }
    }
    
    /**
     * Change the page order and either move a page up or down in the order
     * @param int $pageID This should be the page ID of the page you are moving
     * @param string $dir If you want to move the page up set this as up else set to down
     * @return boolean If the page has been moved will return true else returns false
     */
    public function changePageOrder($pageID, $dir = 'up')
    {
        $mainPage = false;
        $pageInfo = $this->getPageByID($pageID);
        if (intval($pageInfo['subof']) === 0) {
            $pageInfo['subof'] = 'IS NULL';
            $mainPage = true;
        }
        $nextPage = $this->db->select($this->config->table_course_content, ['course_id' => $pageInfo['course_id'], 'subof' => $pageInfo['subof'], 'nav_order' => [($dir === 'up' ? '<' : '>'), $pageInfo['nav_order']]], '*', ['nav_order' => ($dir === 'up' ? 'DESC' : 'ASC')]);
        if (isset($pageInfo['nav_order']) && isset($nextPage['nav_order'])) {
            if ($this->updatePageOrder($pageInfo['page_id'], $pageInfo['nav_order'], $nextPage['nav_order'], $mainPage) && $this->updatePageOrder($nextPage['page_id'], $nextPage['nav_order'], $pageInfo['nav_order'], $mainPage)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Updates the page order and its sub-pages
     * @param type $pageID This should be the page ID that you are updating
     * @param type $oldOrder The old order number that the page had
     * @param type $newOrder The new order to assign to the page
     * @param type $isMain If the page is a main page make sure sub-pages are reordered too
     * @return boolean If the queries are executed successfully will return true else will return false
     */
    protected function updatePageOrder($pageID, $oldOrder, $newOrder, $isMain = false)
    {
        $update = $this->db->update($this->config->table_course_content, ['nav_order' => $newOrder], ['page_id' => $pageID], 1);
        if ($isMain === false) {
            return $update;
        }
        $num = ($newOrder - $oldOrder);
        $subpages = $this->db->selectAll($this->config->table_course_content, ['subof' => $pageID]);
        if (!empty($subpages)) {
            foreach ($subpages as $page) {
                $this->db->update($this->config->table_course_content, ['nav_order' => ($page['nav_order'] + $num)], ['page_id' => $page['page_id']], 1);
            }
        }
        return true;
    }

    /**
     * Get Page information by the page ID
     * @param int $pageID This should be the page id that you are wanting the information for
     * @return array|boolean If the page exist the details will be returned as an array else will return false
     */
    public function getPageByID($pageID)
    {
        $pageInfo = $this->db->select($this->config->table_course_content, ['page_id' => $pageID]);
        $pageInfo['next_page'] = $this->getNextPage($pageInfo);
        $pageInfo['prev_page'] = $this->getPreviousPage($pageInfo);
        $pageInfo['order'] = $this->removeZeros($pageInfo['nav_order']);
        return $pageInfo;
    }
    
    /**
     * Finds and returns the next page based on the variables give
     * @param int $courseID This should be the course ID
     * @param int $navOrder The current navigation order or the order that you are wanting to find above/below
     * @param string $dir If you are wanting pages greater than this should be set to '>' else should be set to '<'
     * @return array|boolean If any pages exist the next page information will be returned as an array else will return false
     */
    protected function findNextPageID($courseID, $navOrder = 0, $dir = '>')
    {
        return $this->db->select($this->config->table_course_content, ['course_id' => $courseID, 'nav_order' => [$dir, $navOrder]], ['page_id'], ['nav_order' => ($dir == '>' ? 'ASC' : 'DESC')]);
    }
    
    /**
     * Gets the next page in the sequence
     * @param int $currentPage This should be the current pages page ID
     * @param string $dir This should be set to either next or previous, depending on the direction you want the next page to be retrieved from
     * @return int|boolean If a next page exists will return its page_id else if no more pages will return false
     */
    protected function getNextPage($currentPage, $dir = 'next')
    {
        $nextPage = $this->findNextPageID($currentPage['course_id'], $currentPage['nav_order'], ($dir !== 'next' ? '<' : '>'));
        if (!empty($nextPage)) {
            return intval($nextPage['page_id']);
        }
        return false;
    }
    
    /**
     * Gets the previous page in the sequence
     * @param int $pageID This should be the current pages page ID
     * @return int|boolean If a previous page exists will return its page_id else if no more pages will return false
     */
    protected function getPreviousPage($pageID)
    {
        return $this->getNextPage($pageID, 'previous');
    }
    
    /**
     * Removes unnecessary zeros from a decimal number
     * @param string $value This should be the original decimal number
     * @return string This will be the decimal number with the leading zeros removed
     */
    private function removeZeros($value)
    {
        return str_replace(['.000', '.00', '.0'], ['', '.', '.'], $value);
    }
}
