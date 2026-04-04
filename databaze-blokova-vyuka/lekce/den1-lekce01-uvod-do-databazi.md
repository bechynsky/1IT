# Den 1 – Lekce 1: Úvod do databází (90 min)

## Cíle lekce

- Pochopit, co je databáze a proč ji používáme
- Znát základní pojmy: tabulka, řádek, sloupec, primární klíč, cizí klíč
- Rozumět rozdílu mezi relační databází a tabulkovým procesorem (Excel)
- Připojit se k Azure SQL Database z VS Code

---

## 1. Co je databáze (20 min)

Databáze je organizovaný soubor dat uložený elektronicky. Na rozdíl od souborů (CSV, Excel) nabízí databáze efektivní vyhledávání, konzistenci dat a současný přístup mnoha uživatelů.

### Proč nepoužíváme jen Excel?

| Vlastnost | Excel | Relační databáze |
|---|---|---|
| Počet řádků | ~1 milion | miliardy |
| Současný přístup | problematický | běžný |
| Konzistence dat | žádná kontrola | integritní omezení |
| Dotazování | filtry, vzorce | jazyk SQL |
| Bezpečnost | soubor celý nebo nic | práva na úrovni tabulek/řádků |

### Příklady použití databází v praxi

- E-shop: produkty, objednávky, zákazníci
- Sociální síť: uživatelé, příspěvky, komentáře
- Bankovní systém: účty, transakce
- Školní systém: studenti, předměty, hodnocení

### Jazyk SQL a dodavatelé databází

Pro práci s relačními databázemi se používá standardizovaný jazyk **SQL** (Structured Query Language). Standard spravuje organizace **ISO/IEC** a průběžně se aktualizuje (SQL-92, SQL:1999, SQL:2016, SQL:2023 …).

Každý dodavatel databáze však přidává **vlastní rozšíření** nad rámec standardu – liší se syntaxe některých příkazů, datové typy i pokročilé funkce. Základní příkazy (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) jsou ale velmi podobné napříč všemi systémy.

| Dodavatel | Databázový systém | Poznámka |
|---|---|---|
| Microsoft | **SQL Server / Azure SQL** | rozšíření T-SQL |
| Oracle | **Oracle Database** | rozšíření PL/SQL |
| Open source | **PostgreSQL** | PL/pgSQL, velmi blízko standardu |
| Open source | **MySQL / MariaDB** | široce používané pro webové aplikace |
| SQLite | **SQLite** | embedded databáze (mobily, prohlížeče) |

> V této výuce pracujeme s **Microsoft SQL Server** (Azure SQL Database) a používáme dialekt **T-SQL**.

---

## 2. Základní pojmy (25 min)

### Relační databáze

Relační databáze ukládá data do **tabulek** (relací), které jsou navzájem propojené pomocí klíčů.

### Tabulka, řádek, sloupec

Představte si tabulku jako list v Excelu:

- **Tabulka** (table) = celý list – představuje jednu entitu (např. zákazníci)
- **Řádek** (row) = jeden záznam (např. konkrétní zákazník Jan Novák)
- **Sloupec** (column) = vlastnost/atribut (např. jméno, e-mail, telefon)

Příklad tabulky `SalesLT.Customer`:

| CustomerID | FirstName | LastName | EmailAddress |
|---|---|---|---|
| 1 | Orlando | Gee | orlando0@adventure-works.com |
| 2 | Keith | Harris | keith0@adventure-works.com |
| 3 | Donna | Carreras | donna0@adventure-works.com |

### Primární klíč (Primary Key)

Primární klíč jednoznačně identifikuje každý řádek v tabulce. Nesmí se opakovat a nesmí být prázdný (NULL).

- V tabulce `SalesLT.Customer` je primární klíč sloupec `CustomerID`
- Každý zákazník má unikátní číslo

### Cizí klíč (Foreign Key)

Cizí klíč je sloupec, který odkazuje na primární klíč jiné tabulky. Vytváří tak **vazbu** (vztah) mezi tabulkami.

- V tabulce `SalesLT.SalesOrderHeader` sloupec `CustomerID` odkazuje na `SalesLT.Customer.CustomerID`
- To znamená: každá objednávka patří jednomu zákazníkovi

### Schéma (Schema)

Schéma je logický kontejner pro tabulky a další databázové objekty. Slouží k organizaci a řízení přístupu.

- `SalesLT` – schéma se vzorovými daty (máte právo pouze číst)
- `studentXX` – vaše vlastní schéma (můžete vytvářet tabulky a zapisovat data)

### Datové typy

Každý sloupec má definovaný datový typ. Nejčastější:

| Datový typ | Popis | Příklad |
|---|---|---|
| `INT` | celé číslo | 42 |
| `NVARCHAR(50)` | textový řetězec (max 50 znaků, Unicode) | 'Jan Novák' |
| `DECIMAL(10,2)` | desetinné číslo | 199.99 |
| `DATE` | datum | '2025-03-15' |
| `DATETIME` | datum a čas | '2025-03-15 14:30:00' |
| `BIT` | logická hodnota (0/1) | 1 |

---

## 3. Architektura naší databáze (10 min)

V této blokové výuce používáme **Azure SQL Database** – cloudovou databázi od Microsoftu. Konkrétně pracujeme se vzorovou databází **AdventureWorksLT**, která simuluje e-shop s outdoor vybavením.

### Klíčové tabulky, se kterými budeme pracovat

```
SalesLT.Customer          – zákazníci
SalesLT.Product           – produkty
SalesLT.ProductCategory   – kategorie produktů
SalesLT.SalesOrderHeader  – hlavičky objednávek
SalesLT.SalesOrderDetail  – položky objednávek
SalesLT.Address           – adresy
```

### Vaše prostředí

- **Přihlášení:** `studentXX` (XX = vaše číslo)
- **Čtení:** schéma `SalesLT` – vzorová data pro dotazy
- **Zápis:** schéma `studentXX` – váš vlastní prostor pro tvorbu tabulek

---

## 4. Připojení k databázi z VS Code (25 min)

### Krok 1: Instalace rozšíření

1. Otevřete VS Code
2. Klikněte na ikonu Extensions (Ctrl+Shift+X)
3. Vyhledejte `mssql` (SQL Server)
4. Nainstalujte rozšíření **SQL Server (mssql)** od Microsoftu

### Krok 2: Vytvoření připojení

1. Stiskněte `Ctrl+Shift+P` a zadejte `MS SQL: Add Connection`
2. Vyplňte údaje:
   - **Server:** `<název-serveru>.database.windows.net`
   - **Database:** `<název-databáze>`
   - **Authentication Type:** SQL Login
   - **User name:** `studentXX`
   - **Password:** (heslo od vyučujícího)
3. Pojmenujte připojení (např. `Škola - AdventureWorks`)

### Krok 3: První dotaz

1. Vytvořte nový soubor `prvni-dotaz.sql`
2. Napište a spusťte následující dotaz (Ctrl+Shift+E):

```sql
-- Ověření připojení - zobrazení prvních 10 zákazníků
SELECT TOP 10
    CustomerID,
    FirstName,
    LastName,
    EmailAddress
FROM SalesLT.Customer;
```

Pokud vidíte tabulku s daty, připojení funguje.

### Krok 4: Ověření vlastního schématu

```sql
-- Ověření, že můžete pracovat ve svém schématu
-- Nahraďte XX vaším číslem
CREATE TABLE studentXX.Test (
    ID INT PRIMARY KEY,
    Poznamka NVARCHAR(100)
);

-- Vložení testovacího záznamu
INSERT INTO studentXX.Test (ID, Poznamka)
VALUES (1, 'Moje první tabulka!');

-- Ověření
SELECT * FROM studentXX.Test;

-- Úklid - smazání testovací tabulky
DROP TABLE studentXX.Test;
```

---

## 5. Procvičování (10 min)

### Úkol 1: Prozkoumejte strukturu databáze

Pomocí panelu SQL Server v levém postranním panelu VS Code si prohlédněte:

1. Jaké tabulky jsou ve schématu `SalesLT`?
2. Jaké sloupce má tabulka `SalesLT.Product`?

### Úkol 2: Spusťte tyto dotazy a podívejte se na výsledky

```sql
-- Kolik zákazníků je v databázi?
SELECT COUNT(*) AS PocetZakazniku FROM SalesLT.Customer;

-- Kolik produktů je v databázi?
SELECT COUNT(*) AS PocetProduktu FROM SalesLT.Product;

-- Zobrazte prvních 5 produktů
SELECT TOP 5 Name, ListPrice FROM SalesLT.Product;
```

---

## Shrnutí lekce

- Databáze je organizovaný soubor dat s pokročilými možnostmi dotazování a zabezpečení
- Relační databáze ukládá data do tabulek propojených klíči
- **Primární klíč** jednoznačně identifikuje řádek, **cizí klíč** vytváří vazbu na jinou tabulku
- **Schéma** organizuje tabulky do logických skupin
- Pro práci s databází používáme jazyk **SQL**
- VS Code s rozšířením mssql umožňuje pohodlnou práci s Azure SQL Database
