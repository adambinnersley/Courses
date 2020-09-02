<?php
namespace Courses\Tests;

use PHPUnit\Framework\TestCase;
use Courses\Documents;
use DBAL\Database;

class DocumentsTest extends TestCase {
    protected $db;
    
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
