<?php
namespace Courses\Tests\Quiz;

use PHPUnit\Framework\TestCase;
use Courses\Quiz\Submission;
use DBAL\Database;
use Configuration\Config;

class SubmissionTest extends TestCase {
    protected $db;
    protected $config;
    
    public function setUp(): void {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
        $this->config = new Config($this->db);
    }
    
    public function tearDown(): void {
        $this->db = null;
    }
    
    public function testExample() {
        $this->markTestIncomplete();
    }
}