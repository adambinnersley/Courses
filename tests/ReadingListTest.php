<?php
namespace Courses\Tests;

use PHPUnit\Framework\TestCase;
use Courses\ReadingList;
use DBAL\Database;

class ReadingListTest extends TestCase {
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
