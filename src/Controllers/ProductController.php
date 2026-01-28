<?php
namespace App\Controllers;

use App\Repositories\ProductRepository;
use Twig\Environment;

class ProductController
{
    public function index(Environment $twig): void
    {
        $repo = new ProductRepository();
        $products = $repo->findAll();

        echo $twig->render('products.twig', [
            'products' => $products
        ]);
    }
}
