<?php
namespace Courses\Tests;

use Courses\Course;

class CourseTest extends SetUp
{
    public $course;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->course = new Course($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->course = null;
    }
    
    /**
     * @covers Courses\Course::__construct
     * @covers Courses\Course::addCourse
     * @covers Courses\Course::checkImageUpload
     * @covers Courses\Course::getCourseByURL
     * @covers Courses\Course::getCourseByID
     * @covers Courses\Course::getCourseName
     */
    public function testAddCourse()
    {
        $this->assertTrue($this->course->addCourse('My New Course', '/my-new-course'));
        $this->assertFalse($this->course->addCourse('My New Course', '/my-new-course'));
        $courseInfo = $this->course->getCourseByURL('/my-new-course');
        $this->assertEquals('My New Course', $this->course->getCourseName($courseInfo['id']));
    }
    
    /**
     * @covers Courses\Course::__construct
     * @covers Courses\Course::editCourse
     * @covers Courses\Course::getCourseByURL
     * @covers Courses\Course::checkImageUpload
     */
    public function testEditCourse()
    {
        $courseInfo = $this->course->getCourseByURL('/my-new-course');
        $this->assertTrue($this->course->editCourse($courseInfo['id'], $courseInfo['name'], $courseInfo['url'], 'This is some new descriptive content'));
        $this->assertFalse($this->course->editCourse($courseInfo['id'], $courseInfo['name'], $courseInfo['url'], 'This is some new descriptive content'));
    }
    
    /**
     * @covers Courses\Course::__construct
     * @covers Courses\Course::deleteCourse
     * @covers Courses\Course::getCourseByURL
     */
    public function testDeleteCourse()
    {
        $courseInfo = $this->course->getCourseByURL('/my-new-course');
        $this->assertTrue($this->course->deleteCourse($courseInfo['id']));
        $this->assertFalse($this->course->deleteCourse($courseInfo['id']));
        $this->assertFalse($this->course->deleteCourse('not a valid id'));
    }
}
