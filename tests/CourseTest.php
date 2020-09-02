<?php
namespace Courses\Tests;

use PHPUnit\Framework\TestCase;
use Courses\Course;
use DBAL\Database;

class CourseTest extends TestCase {
    protected $db;
    public $course;
    
    public function setUp(): void {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
    }
    
    public function tearDown(): void {
        $this->db = null;
    }
    
    public function testExample() {
        $this->markTestIncomplete();
    }
}
