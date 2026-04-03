# Den 1 – Lekce 4: Vazby mezi tabulkami – JOIN (90 min)

## Cíle lekce

- Pochopit vazby mezi tabulkami (1:N, M:N)
- Používat INNER JOIN pro spojení tabulek
- Používat LEFT JOIN pro zachování všech řádků z levé tabulky
- Kombinovat JOIN s WHERE, GROUP BY a ORDER BY

---

## 1. Proč potřebujeme JOIN (10 min)

V relační databázi jsou data rozložena do více tabulek, aby se zamezilo redundanci (opakování dat). Například:

- Tabulka `SalesLT.SalesOrderHeader` obsahuje objednávky, ale jen `CustomerID` (číslo zákazníka)
- Pokud chceme vidět **jméno zákazníka** u objednávky, musíme tabulky **spojit**

Bez JOINu bychom viděli jen čísla:

```sql
-- Vidíme CustomerID, ale ne jméno
SELECT SalesOrderID, CustomerID, OrderDate
FROM SalesLT.SalesOrderHeader;
```

S JOINem spojíme data ze dvou tabulek do jednoho výsledku.

---

## 2. INNER JOIN (25 min)

`INNER JOIN` vrátí pouze řádky, kde existuje shoda v obou tabulkách.

### Syntaxe

```sql
SELECT sloupce
FROM tabulka1
INNER JOIN tabulka2 ON tabulka1.klíč = tabulka2.klíč;
```

### Objednávky se jmény zákazníků

```sql
SELECT
    o.SalesOrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    o.TotalDue
FROM SalesLT.SalesOrderHeader AS o
INNER JOIN SalesLT.Customer AS c ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;
```

Vysvětlení:
- `SalesLT.SalesOrderHeader AS o` – tabulku objednávek pojmenujeme zkratkou `o`
- `SalesLT.Customer AS c` – tabulku zákazníků pojmenujeme zkratkou `c`
- `ON o.CustomerID = c.CustomerID` – spojovací podmínka (cizí klíč = primární klíč)

### Produkty s názvem kategorie

Tabulka `SalesLT.Product` obsahuje jen `ProductCategoryID`. Pomocí JOINu doplníme název kategorie:

```sql
SELECT
    p.Name AS NazevProduktu,
    p.ListPrice,
    pc.Name AS Kategorie
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
ORDER BY pc.Name, p.ListPrice DESC;
```

### Položky objednávek s názvy produktů

```sql
SELECT
    od.SalesOrderID,
    p.Name AS Produkt,
    od.OrderQty AS Pocet,
    od.UnitPrice AS Cena,
    od.OrderQty * od.UnitPrice AS Celkem
FROM SalesLT.SalesOrderDetail AS od
INNER JOIN SalesLT.Product AS p ON od.ProductID = p.ProductID
ORDER BY od.SalesOrderID;
```

---

## 3. Spojení více tabulek (15 min)

Lze spojit i tři a více tabulek řetězením `JOIN`:

### Objednávky: zákazník + položky + produkty

```sql
SELECT
    c.FirstName + ' ' + c.LastName AS Zakaznik,
    o.SalesOrderID AS CisloObjednavky,
    o.OrderDate AS DatumObjednavky,
    p.Name AS Produkt,
    od.OrderQty AS Pocet,
    od.UnitPrice AS CenaZaKus
FROM SalesLT.SalesOrderHeader AS o
INNER JOIN SalesLT.Customer AS c
    ON o.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderDetail AS od
    ON o.SalesOrderID = od.SalesOrderID
INNER JOIN SalesLT.Product AS p
    ON od.ProductID = p.ProductID
ORDER BY c.LastName, o.SalesOrderID;
```

### Produkty s kategorií a nadřazenou kategorií

Tabulka `SalesLT.ProductCategory` má sloupec `ParentProductCategoryID`, který odkazuje sama na sebe (hierarchie):

```sql
SELECT
    p.Name AS Produkt,
    p.ListPrice AS Cena,
    child.Name AS Podkategorie,
    parent.Name AS HlavniKategorie
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS child
    ON p.ProductCategoryID = child.ProductCategoryID
INNER JOIN SalesLT.ProductCategory AS parent
    ON child.ParentProductCategoryID = parent.ProductCategoryID
ORDER BY parent.Name, child.Name, p.Name;
```

---

## 4. LEFT JOIN (15 min)

`LEFT JOIN` vrátí **všechny** řádky z levé tabulky a z pravé tabulky připojí odpovídající řádky. Pokud shoda neexistuje, sloupce z pravé tabulky budou `NULL`.

### Syntaxe

```sql
SELECT sloupce
FROM leva_tabulka
LEFT JOIN prava_tabulka ON leva_tabulka.klíč = prava_tabulka.klíč;
```

### Všichni zákazníci včetně těch bez objednávek

```sql
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.SalesOrderID,
    o.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS o ON c.CustomerID = o.CustomerID
ORDER BY o.SalesOrderID;
```

Zákazníci bez objednávky mají v sloupcích `SalesOrderID` a `TotalDue` hodnotu `NULL`.

### Nalezení zákazníků BEZ objednávek

```sql
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS o ON c.CustomerID = o.CustomerID
WHERE o.SalesOrderID IS NULL;
```

Tento vzor (`LEFT JOIN` + `WHERE ... IS NULL`) se často používá k nalezení záznamů bez odpovídajících vazeb.

---

## 5. JOIN s agregací (10 min)

JOIN a GROUP BY se kombinují, když chcete agregovat data z propojených tabulek:

### Celková útrata každého zákazníka (se jménem)

```sql
SELECT
    c.FirstName + ' ' + c.LastName AS Zakaznik,
    COUNT(o.SalesOrderID) AS PocetObjednavek,
    ISNULL(SUM(o.TotalDue), 0) AS CelkovaUtrata
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY CelkovaUtrata DESC;
```

### Počet produktů v každé hlavní kategorii

```sql
SELECT
    parent.Name AS HlavniKategorie,
    COUNT(p.ProductID) AS PocetProduktu
FROM SalesLT.ProductCategory AS parent
INNER JOIN SalesLT.ProductCategory AS child
    ON parent.ProductCategoryID = child.ParentProductCategoryID
INNER JOIN SalesLT.Product AS p
    ON child.ProductCategoryID = p.ProductCategoryID
GROUP BY parent.Name
ORDER BY PocetProduktu DESC;
```

---

## 6. Procvičování (15 min)

### Úkol 1: INNER JOIN

1. Zobrazte seznam objednávek s datem, jménem zákazníka a celkovou částkou (`TotalDue`). Seřaďte podle data sestupně.
2. Zobrazte produkty s cenou nad 1000 a jejich kategorii.

### Úkol 2: Více tabulek

3. Pro každou objednávku zobrazte jméno zákazníka, název objednaného produktu a počet kusů.

### Úkol 3: LEFT JOIN

4. Najděte produkty, které nikdy nebyly objednány (nejsou v `SalesOrderDetail`).

### Úkol 4: JOIN + agregace

5. Pro každou kategorii (`ProductCategory.Name`) spočítejte průměrnou cenu produktů. Zobrazte jen kategorie s průměrnou cenou nad 500.

---

### Řešení

<details>
<summary>Klikněte pro zobrazení řešení</summary>

```sql
-- 1. Objednávky se jmény zákazníků
SELECT
    o.SalesOrderID,
    o.OrderDate,
    c.FirstName + ' ' + c.LastName AS Zakaznik,
    o.TotalDue
FROM SalesLT.SalesOrderHeader AS o
INNER JOIN SalesLT.Customer AS c ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;

-- 2. Drahé produkty s kategorií
SELECT
    p.Name AS Produkt,
    p.ListPrice,
    pc.Name AS Kategorie
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice > 1000
ORDER BY p.ListPrice DESC;

-- 3. Objednávky: zákazník, produkt, počet
SELECT
    c.FirstName + ' ' + c.LastName AS Zakaznik,
    o.SalesOrderID,
    p.Name AS Produkt,
    od.OrderQty AS Pocet
FROM SalesLT.SalesOrderHeader AS o
INNER JOIN SalesLT.Customer AS c ON o.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderDetail AS od ON o.SalesOrderID = od.SalesOrderID
INNER JOIN SalesLT.Product AS p ON od.ProductID = p.ProductID
ORDER BY Zakaznik, o.SalesOrderID;

-- 4. Produkty, které nikdy nebyly objednány
SELECT
    p.ProductID,
    p.Name,
    p.ListPrice
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS od ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL
ORDER BY p.Name;

-- 5. Průměrná cena podle kategorie (nad 500)
SELECT
    pc.Name AS Kategorie,
    ROUND(AVG(p.ListPrice), 2) AS PrumernaCena
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
HAVING AVG(p.ListPrice) > 500
ORDER BY PrumernaCena DESC;
```

</details>

---

## Shrnutí lekce

- `INNER JOIN` vrátí pouze řádky se shodou v obou tabulkách
- `LEFT JOIN` vrátí všechny řádky z levé tabulky, i když shoda v pravé neexistuje (NULL)
- Spojovací podmínka `ON` porovnává cizí klíč s primárním klíčem
- Aliasy tabulek (`AS o`, `AS c`) zkracují zápis u JOINů
- Lze řetězit více JOINů pro spojení tří a více tabulek
- `LEFT JOIN` + `WHERE ... IS NULL` najde záznamy bez odpovídající vazby
- JOIN lze kombinovat s `WHERE`, `GROUP BY`, `HAVING` a `ORDER BY`
