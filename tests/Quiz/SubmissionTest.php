<?php
namespace Courses\Tests\Quiz;

use PHPUnit\Framework\TestCase;
use Courses\Quiz\Submission;
use DBAL\Database;

class SubmissionTest extends TestCase {
    protected $db;
    
    public function setUp() {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
    }
    
    public function tearDown() {
        $this->db = null;
    }
    
    public function testExample() {
        $this->markTestIncomplete();
    }
}