<?php
namespace App\Repositories;

use App\Database\Db;

class ProductRepository
{
    public function search(?string $q, ?int $categoryId): array
    {
        $sql = "
            SELECT t.Id, t.Nev, t.Ar, t.Keszlet, k.Nev AS Kategoria
            FROM Termekek t
            JOIN Kategoriak k ON k.Id = t.KategoriaId
            WHERE 1=1
        ";

        $params = [];

        if ($q !== null && $q !== '') {
            $sql .= " AND t.Nev LIKE :q";
            $params['q'] = '%' . $q . '%';
        }

        if ($categoryId !== null) {
            $sql .= " AND t.KategoriaId = :cat";
            $params['cat'] = $categoryId;
        }

        $sql .= " ORDER BY t.Nev";

        $stmt = Db::getConnection()->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    public function findByIds(array $ids): array
    {
        if (count($ids) === 0) return [];

        // Prepared IN lista (biztonságos)
        $placeholders = implode(',', array_fill(0, count($ids), '?'));

        $sql = "
            SELECT t.Id, t.Nev, t.Ar, t.Keszlet, k.Nev AS Kategoria
            FROM Termekek t
            JOIN Kategoriak k ON k.Id = t.KategoriaId
            WHERE t.Id IN ($placeholders)
        ";

        $stmt = \App\Database\Db::getConnection()->prepare($sql);
        $stmt->execute(array_values($ids));
        return $stmt->fetchAll();
    }

    public function findByIdsCheckout(array $ids): array
    {
        if (count($ids) === 0) return [];

        $placeholders = implode(',', array_fill(0, count($ids), '?'));

        $sql = "
            SELECT Id, Nev, Ar, Keszlet
            FROM Termekek
            WHERE Id IN ($placeholders)
        ";

        $stmt = \App\Database\Db::getConnection()->prepare($sql);
        $stmt->execute(array_values($ids));
        return $stmt->fetchAll();
    }

    public function adminList(): array
    {
        $sql = "
            SELECT t.Id, t.Nev, t.Ar, t.Keszlet, t.KategoriaId, k.Nev AS Kategoria
            FROM Termekek t
            JOIN Kategoriak k ON k.Id = t.KategoriaId
            ORDER BY t.Id DESC
        ";
        return \App\Database\Db::getConnection()->query($sql)->fetchAll();
    }

    public function findById(int $id): ?array
    {
        $sql = "SELECT TOP 1 * FROM Termekek WHERE Id = :id";
        $stmt = \App\Database\Db::getConnection()->prepare($sql);
        $stmt->execute(['id' => $id]);
        $row = $stmt->fetch();
        return $row ?: null;
    }

    public function createProduct(string $name, ?string $desc, float $price, int $stock, int $categoryId): int
    {
        $sql = "
            INSERT INTO Termekek (Nev, Leiras, Ar, Keszlet, KategoriaId)
            OUTPUT INSERTED.Id AS id
            VALUES (:nev, :leiras, :ar, :keszlet, :kat);
        ";
        $stmt = \App\Database\Db::getConnection()->prepare($sql);
        $stmt->execute([
            'nev' => $name,
            'leiras' => $desc,
            'ar' => $price,
            'keszlet' => $stock,
            'kat' => $categoryId
        ]);
        return (int)$stmt->fetch()['id'];
    }

    public function updateProduct(int $id, string $name, ?string $desc, float $price, int $stock, int $categoryId): void
    {
        $sql = "
            UPDATE Termekek
            SET Nev=:nev, Leiras=:leiras, Ar=:ar, Keszlet=:keszlet, KategoriaId=:kat
            WHERE Id=:id
        ";
        $stmt = \App\Database\Db::getConnection()->prepare($sql);
        $stmt->execute([
            'id' => $id,
            'nev' => $name,
            'leiras' => $desc,
            'ar' => $price,
            'keszlet' => $stock,
            'kat' => $categoryId
        ]);
    }

    public function deleteProduct(int $id): void
    {
        $sql = "DELETE FROM Termekek WHERE Id = :id";
        $stmt = \App\Database\Db::getConnection()->prepare($sql);
        $stmt->execute(['id' => $id]);
    }


}
