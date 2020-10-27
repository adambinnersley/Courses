<?php
namespace Courses\Tests;

use PHPUnit\Framework\TestCase;
use DBAL\Database;
use Configuration\Config;

abstract class SetUp extends TestCase{
    protected $db;
    protected $config;
    
    public function setUp(): void
    {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
        if (!$this->db->isConnected()) {
             $this->markTestSkipped(
                 'No local database connection is available'
             );
        }
        $this->db->query(file_get_contents(dirname(dirname(__FILE__)).'/vendor/adamb/config/database/database_mysql.sql'));
        $this->db->query(file_get_contents(dirname(dirname(__FILE__)).'/database/database.sql'));
        $this->config = new Config($this->db);
    }
    
    public function tearDown(): void
    {
        $this->db = null;
        $this->config = null;
    }
    
}
