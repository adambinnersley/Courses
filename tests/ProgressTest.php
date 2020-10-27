<?php
namespace Courses\Tests;

use Courses\Progress;

class ProgressTest extends SetUp
{
    protected $progress;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->progress = new Progress($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->progress = null;
    }
    
    public function testExample(): void
    {
        $this->markTestIncomplete();
    }
}
