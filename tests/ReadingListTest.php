<?php
namespace Courses\Tests;

use Courses\ReadingList;

class ReadingListTest extends SetUp
{
    protected $readingList;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->readingList = new ReadingList($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->readingList = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
