# Online Elektronikai Webáruház – PHP + SQL Server

Ez a projekt egy **online elektronikai webáruház** alapját valósítja meg **natív PHP 8**,
**Microsoft SQL Server**, **Twig template engine** és **MVC architektúra** használatával.

---

## 🧱 Technológiai stack

**Backend**

- PHP 8.x (natív, OOP)
- PDO + `sqlsrv` driver
- MVC architektúra
- Twig template engine
- Composer

**Adatbázis**

- Microsoft SQL Server (Developer Edition)
- SQL Server Management Studio (SSMS)
- Foreign key-k, CHECK constraint-ek, indexek

**Frontend**

- HTML5
- Twig templating
- CSS3
- Vanilla JavaScript

**Webszerver**

- Apache (XAMPP)
- VirtualHost + `public/` webroot
- `mod_rewrite` (.htaccess)

---

## 📁 Projekt struktúra

```
webshop/
│
├─ public/
│   ├─ index.php
│   ├─ .htaccess
│   └─ assets/
│       ├─ css/
│       └─ js/
│
├─ src/
│   ├─ Controllers/
│   │   └─ ProductController.php
│   │
│   ├─ Repositories/
│   │   ├─ ProductRepository.php
│   │   └─ ProductRepository.php
│   │
│   ├─ Database/
│   │   └─ Db.php
│   │
│   └─ View/
│       ├─ base.twig
│       └─ products.twig
│
├─ config/
│   └─ config.php
│
├─ vendor/
├─ composer.json
└─ README.md
```

---

## ⚙️ Telepítés

### 1️⃣ Előfeltételek

- PHP 8.2+
- XAMPP (Apache)
- Microsoft SQL Server Developer Edition
- SQL Server Management Studio (SSMS)
- Composer

---

### 2️⃣ Adatbázis

SSMS-ben futtasd a mellékelt SQL scriptet, amely:

- létrehozza a `webshop` adatbázist
- létrehozza a táblákat
- beállítja a kapcsolódó kulcsokat és indexeket

---

### 3️⃣ Apache VirtualHost (ajánlott)

**`C:/xampp/apache/conf/extra/httpd-vhosts.conf`**

```apache
<VirtualHost *:80>
    ServerName webshop.local
    DocumentRoot "C:/xampp/htdocs/webshop/public"

    <Directory "C:/xampp/htdocs/webshop/public">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

---

### 4️⃣ hosts fájl

Admin joggal nyisd meg:

```
C:\Windows\System32\drivers\etc\hosts
```

Add hozzá:

```
127.0.0.1   webshop.local
```

---

### 5️⃣ .htaccess (routing)

**`public/.htaccess`**

```apache
RewriteEngine On

RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]

RewriteRule ^ index.php [L]
```

---

### 6️⃣ Composer függőségek

A projekt gyökerében futtasd:

```bash
composer install
```

---

### 7️⃣ Konfiguráció

**`config/config.php`**

```php
return [
    'db' => [
        'server'   => 'localhost',
        'database' => 'webshop',
        'username' => 'webshop_user',
        'password' => 'JELSZO'
    ]
];
```

---

## ▶️ Futtatás

Böngészőben:

```
http://webshop.local
http://webshop.local/products
```
