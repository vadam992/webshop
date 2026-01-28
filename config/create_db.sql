/* =========================================================
   0) DATABASE
   ========================================================= */
IF DB_ID(N'webshop') IS NULL
BEGIN
    CREATE DATABASE webshop;
END
GO

USE webshop;
GO

/* =========================================================
   1) TABLES
   ========================================================= */

-- Categories (hierarchical)
IF OBJECT_ID(N'dbo.Kategoriak', N'U') IS NOT NULL DROP TABLE dbo.Kategoriak;
GO
CREATE TABLE dbo.Kategoriak
(
    Id               INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Kategoriak PRIMARY KEY,
    Nev              NVARCHAR(100)      NOT NULL,
    SzuloKategoriaId INT                NULL
);
GO

-- Users
IF OBJECT_ID(N'dbo.Felhasznalok', N'U') IS NOT NULL DROP TABLE dbo.Felhasznalok;
GO
CREATE TABLE dbo.Felhasznalok
(
    Id        INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Felhasznalok PRIMARY KEY,
    Nev       NVARCHAR(120)     NOT NULL,
    Email     NVARCHAR(255)     NOT NULL,
    Jelszo    NVARCHAR(255)     NOT NULL,
    Cim       NVARCHAR(400)     NULL,
    Szerepkor NVARCHAR(20)      NOT NULL
        CONSTRAINT CK_Felhasznalok_Szerepkor
        CHECK (Szerepkor IN (N'USER', N'ADMIN'))
);
GO

-- Products
IF OBJECT_ID(N'dbo.Termekek', N'U') IS NOT NULL DROP TABLE dbo.Termekek;
GO
CREATE TABLE dbo.Termekek
(
    Id          INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Termekek PRIMARY KEY,
    Nev         NVARCHAR(200)     NOT NULL,
    Leiras      NVARCHAR(MAX)     NULL,
    Ar          DECIMAL(18,2)     NOT NULL
        CONSTRAINT CK_Termekek_Ar CHECK (Ar >= 0),
    Keszlet     INT              NOT NULL
        CONSTRAINT CK_Termekek_Keszlet CHECK (Keszlet >= 0),
    KategoriaId INT              NOT NULL
);
GO

-- Orders
IF OBJECT_ID(N'dbo.Rendelesek', N'U') IS NOT NULL DROP TABLE dbo.Rendelesek;
GO
CREATE TABLE dbo.Rendelesek
(
    Id            INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Rendelesek PRIMARY KEY,
    FelhasznaloId INT              NOT NULL,
    Datum         DATETIME2(0)      NOT NULL
        CONSTRAINT DF_Rendelesek_Datum DEFAULT (SYSUTCDATETIME()),
    Statusz       NVARCHAR(20)      NOT NULL
        CONSTRAINT CK_Rendelesek_Statusz
        CHECK (Statusz IN (N'PENDING', N'PAID', N'SHIPPED', N'CANCELLED')),
    OsszErtek     DECIMAL(18,2)     NOT NULL
        CONSTRAINT CK_Rendelesek_OsszErtek CHECK (OsszErtek >= 0)
);
GO

-- Order items
IF OBJECT_ID(N'dbo.RendelesTetelek', N'U') IS NOT NULL DROP TABLE dbo.RendelesTetelek;
GO
CREATE TABLE dbo.RendelesTetelek
(
    Id         INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_RendelesTetelek PRIMARY KEY,
    RendelesId INT              NOT NULL,
    TermekId   INT              NOT NULL,
    Mennyiseg  INT              NOT NULL
        CONSTRAINT CK_RendelesTetelek_Mennyiseg CHECK (Mennyiseg > 0),
    Egysegar   DECIMAL(18,2)    NOT NULL
        CONSTRAINT CK_RendelesTetelek_Egysegar CHECK (Egysegar >= 0),

    CONSTRAINT UQ_RendelesTetelek_Rendeles_Termek
        UNIQUE (RendelesId, TermekId)
);
GO

/* =========================================================
   2) FOREIGN KEYS
   ========================================================= */

ALTER TABLE dbo.Kategoriak
ADD CONSTRAINT FK_Kategoriak_Szulo
FOREIGN KEY (SzuloKategoriaId)
REFERENCES dbo.Kategoriak(Id);
GO

ALTER TABLE dbo.Termekek
ADD CONSTRAINT FK_Termekek_Kategoria
FOREIGN KEY (KategoriaId)
REFERENCES dbo.Kategoriak(Id);
GO

ALTER TABLE dbo.Rendelesek
ADD CONSTRAINT FK_Rendelesek_Felhasznalo
FOREIGN KEY (FelhasznaloId)
REFERENCES dbo.Felhasznalok(Id);
GO

ALTER TABLE dbo.RendelesTetelek
ADD CONSTRAINT FK_RendelesTetelek_Rendeles
FOREIGN KEY (RendelesId)
REFERENCES dbo.Rendelesek(Id)
ON DELETE CASCADE;
GO

ALTER TABLE dbo.RendelesTetelek
ADD CONSTRAINT FK_RendelesTetelek_Termek
FOREIGN KEY (TermekId)
REFERENCES dbo.Termekek(Id);
GO

/* =========================================================
   3) INDEXES
   ========================================================= */

CREATE UNIQUE INDEX IX_Felhasznalok_Email
ON dbo.Felhasznalok(Email);
GO

CREATE INDEX IX_Termekek_KategoriaId
ON dbo.Termekek(KategoriaId);
GO

CREATE INDEX IX_Termekek_Nev
ON dbo.Termekek(Nev);
GO

CREATE INDEX IX_Rendelesek_Felhasznalo_Datum
ON dbo.Rendelesek(FelhasznaloId, Datum DESC);
GO

CREATE INDEX IX_RendelesTetelek_RendelesId
ON dbo.RendelesTetelek(RendelesId);
GO

CREATE INDEX IX_RendelesTetelek_TermekId
ON dbo.RendelesTetelek(TermekId);
GO

PRINT N'✅ webshop adatbázis, táblák, kapcsolatok és indexek létrehozva.';
GO
