<?php

require_once __DIR__ . '/../vendor/autoload.php';

use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use App\Controllers\ProductController;

$loader = new FilesystemLoader(__DIR__ . '/../src/View');
$twig   = new Environment($loader);

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

switch ($path) {
    case '/':
    case '/products':
        (new ProductController())->index($twig);
        break;

    default:
        http_response_code(404);
        echo '404 - Page not found';
}
