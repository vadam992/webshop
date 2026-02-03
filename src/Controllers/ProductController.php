<?php
namespace App\Controllers;

use App\Repositories\ProductRepository;
use App\Repositories\CategoryRepository;
use Twig\Environment;

class ProductController
{
    public function index(Environment $twig): void
    {
        $q = trim($_GET['q'] ?? '');
        $catRaw = $_GET['category'] ?? '';
        $categoryId = is_numeric($catRaw) ? (int)$catRaw : null;

        $products = (new ProductRepository())->search($q, $categoryId);
        $categories = (new CategoryRepository())->findAll();

        echo $twig->render('products.twig', [
            'products' => $products,
            'categories' => $categories,
            'q' => $q,
            'selectedCategory' => $categoryId
        ]);
    }
}
