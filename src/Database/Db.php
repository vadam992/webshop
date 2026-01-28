<?php
namespace App\Database;

use PDO;
use PDOException;

class Db
{
    private static ?PDO $pdo = null;

    public static function getConnection(): PDO
    {
        if (self::$pdo === null) {
            $config = require __DIR__ . '/../../config/config.php';

            $db = $config['db'];

            self::$pdo = new PDO(
                "sqlsrv:Server={$db['server']};Database={$db['database']};TrustServerCertificate=true",
                $db['username'],
                $db['password'],
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
                ]
            );
        }

        return self::$pdo;
    }
}