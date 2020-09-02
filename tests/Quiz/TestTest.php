<?php
namespace Courses\Tests\Quiz;

use PHPUnit\Framework\TestCase;
use Courses\Quiz\Test;
use DBAL\Database;

class TestTest extends TestCase {
    protected $db;
    protected $quizTest;
    
    public function setUp(): void {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
        $this->quizTest = new Test($this->db);
    }
    
    public function tearDown(): void {
        $this->db = null;
        $this->quizTest = null;
    }
    
    public function testExample() {
        $this->markTestIncomplete();
    }
}
