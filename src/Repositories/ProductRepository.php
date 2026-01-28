<?php
namespace App\Repositories;

use App\Database\Db;
use PDO;

class ProductRepository
{
    public function findAll(): array
    {
        $sql = "
            SELECT 
                t.Id,
                t.Nev,
                t.Ar,
                k.Nev AS Kategoria
            FROM Termekek t
            JOIN Kategoriak k ON k.Id = t.KategoriaId
            ORDER BY t.Nev
        ";

        $stmt = Db::getConnection()->query($sql);
        return $stmt->fetchAll();
    }
}
