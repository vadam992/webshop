<?php
namespace App\Repositories;

use App\Database\Db;

class CategoryRepository
{
    public function findAll(): array
    {
        $sql = "SELECT Id, Nev, SzuloKategoriaId FROM Kategoriak ORDER BY Nev";
        return Db::getConnection()->query($sql)->fetchAll();
    }
}
