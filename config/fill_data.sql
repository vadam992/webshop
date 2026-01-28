USE webshop;

/* =========================================================
   CLEANUP (ONLY categories + products)
   ========================================================= */
DELETE FROM dbo.Termekek;
DELETE FROM dbo.Kategoriak;

/* =========================================================
   CATEGORIES
   ========================================================= */
DECLARE 
    @Laptopok INT,
    @Okostelefonok INT,
    @TV INT,
    @Hang INT,
    @Konzol INT,

    @Ultrabook INT,
    @GamerLaptop INT,
    @Android INT,
    @Iphone INT,
    @OLED INT,
    @QLED INT,
    @Fules INT,
    @Hangszoro INT,
    @Soundbar INT;

-- Main categories
INSERT INTO dbo.Kategoriak (Nev, SzuloKategoriaId) VALUES
(N'Laptopok', NULL),
(N'Okostelefonok', NULL),
(N'TV és kijelzők', NULL),
(N'Hangtechnika', NULL),
(N'Játékkonzolok', NULL);

SELECT @Laptopok       = Id FROM dbo.Kategoriak WHERE Nev = N'Laptopok';
SELECT @Okostelefonok  = Id FROM dbo.Kategoriak WHERE Nev = N'Okostelefonok';
SELECT @TV             = Id FROM dbo.Kategoriak WHERE Nev = N'TV és kijelzők';
SELECT @Hang           = Id FROM dbo.Kategoriak WHERE Nev = N'Hangtechnika';
SELECT @Konzol         = Id FROM dbo.Kategoriak WHERE Nev = N'Játékkonzolok';

-- Subcategories
INSERT INTO dbo.Kategoriak (Nev, SzuloKategoriaId) VALUES
(N'Ultrabook', @Laptopok),
(N'Gamer laptop', @Laptopok),
(N'Android', @Okostelefonok),
(N'iPhone', @Okostelefonok),
(N'OLED TV', @TV),
(N'QLED TV', @TV),
(N'Fülhallgatók', @Hang),
(N'Hangszórók', @Hang),
(N'Soundbar', @Hang);

SELECT @Ultrabook   = Id FROM dbo.Kategoriak WHERE Nev = N'Ultrabook';
SELECT @GamerLaptop = Id FROM dbo.Kategoriak WHERE Nev = N'Gamer laptop';
SELECT @Android     = Id FROM dbo.Kategoriak WHERE Nev = N'Android';
SELECT @Iphone      = Id FROM dbo.Kategoriak WHERE Nev = N'iPhone';
SELECT @OLED        = Id FROM dbo.Kategoriak WHERE Nev = N'OLED TV';
SELECT @QLED        = Id FROM dbo.Kategoriak WHERE Nev = N'QLED TV';
SELECT @Fules       = Id FROM dbo.Kategoriak WHERE Nev = N'Fülhallgatók';
SELECT @Hangszoro   = Id FROM dbo.Kategoriak WHERE Nev = N'Hangszórók';
SELECT @Soundbar    = Id FROM dbo.Kategoriak WHERE Nev = N'Soundbar';

PRINT N'✅ Kategóriák feltöltve';

/* =========================================================
   PRODUCTS
   ========================================================= */
INSERT INTO dbo.Termekek (Nev, Leiras, Ar, Keszlet, KategoriaId) VALUES
(N'ASUS ZenBook 14 OLED', N'14" OLED kijelző, könnyű és gyors ultrabook.', 399999, 12, @Ultrabook),
(N'Dell XPS 13', N'Prémium ultrabook, kiváló minőség.', 459999, 6, @Ultrabook),
(N'Lenovo Yoga Slim 7', N'Vékony ház, hosszú üzemidő.', 319999, 18, @Ultrabook),

(N'ASUS ROG Strix 15', N'Erős GPU, 144Hz kijelző.', 649999, 4, @GamerLaptop),
(N'Lenovo Legion 5', N'Kiváló hűtés, gamer teljesítmény.', 529999, 9, @GamerLaptop),

(N'Samsung Galaxy S24', N'Csúcskategóriás Android telefon.', 389999, 20, @Android),
(N'Google Pixel 8', N'Tiszta Android, kiváló kamera.', 299999, 14, @Android),

(N'iPhone 15', N'Erős teljesítmény, hosszú támogatás.', 419999, 11, @Iphone),
(N'iPhone 15 Pro', N'Prémium kivitel, fejlett kamerák.', 549999, 7, @Iphone),

(N'LG OLED 55"', N'55" OLED TV, tökéletes fekete.', 499999, 8, @OLED),
(N'Samsung QLED 55"', N'Nagy fényerő, HDR.', 399999, 10, @QLED),

(N'Sony WH-1000XM5', N'Zajszűrős fejhallgató.', 119999, 15, @Fules),
(N'JBL Charge 5', N'Hordozható Bluetooth hangszóró.', 59999, 25, @Hangszoro),
(N'Samsung Soundbar Q600', N'Dolby Atmos támogatás.', 149999, 7, @Soundbar);

PRINT N'✅ Termékek feltöltve';
