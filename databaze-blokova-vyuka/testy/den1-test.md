# Den 1 – Test: Ověření znalostí z prvního dne (45 min)

## Pokyny

- Test pracuje s databází AdventureWorksLT (schéma `SalesLT`)
- Výsledky zapisujte do souboru `den1-test.sql` ve vašem VS Code
- Každý dotaz označte komentářem s číslem úlohy
- Před odevzdáním ověřte, že všechny dotazy fungují bez chyb

---

## Část A: Teorie (odpovězte jako SQL komentáře)

### Otázka 1 (2 body)

Vysvětlete vlastními slovy, co je to primární klíč a cizí klíč. Uveďte příklad z databáze AdventureWorksLT.

```sql
-- A1: Odpovězte zde jako komentář
-- Primární klíč: ...
-- Cizí klíč: ...
-- Příklad: ...
```

### Otázka 2 (1 bod)

Jaký je rozdíl mezi `WHERE` a `HAVING`?

```sql
-- A2: Odpovězte zde jako komentář
-- WHERE: ...
-- HAVING: ...
```

### Otázka 3 (1 bod)

Proč nefunguje porovnání `WHERE Color = NULL`? Jak se správně testuje NULL?

```sql
-- A3: Odpovězte zde jako komentář
```

---

## Část B: Dotazy SELECT a WHERE (12 bodů)

### Úloha 4 (2 body)

Zobrazte jméno (`FirstName`), příjmení (`LastName`) a e-mail (`EmailAddress`) všech zákazníků, jejichž příjmení začíná na písmeno „B". Seřaďte podle příjmení.

```sql
-- B4:
```

### Úloha 5 (2 body)

Zobrazte název (`Name`) a cenu (`ListPrice`) produktů, které jsou žluté (`'Yellow'`) nebo stříbrné (`'Silver'`) a stojí méně než 500. Seřaďte podle ceny sestupně.

```sql
-- B5:
```

### Úloha 6 (3 body)

Zobrazte 3 nejdražší produkty z databáze. Výstup musí obsahovat sloupce `Nazev` (alias pro `Name`) a `Cena` (alias pro `ListPrice`).

```sql
-- B6:
```

### Úloha 7 (2 body)

Kolik produktů nemá vyplněnou barvu (`Color` je NULL)?

```sql
-- B7:
```

### Úloha 8 (3 body)

Kolik stojí nejlevnější a nejdražší produkt? Jaká je průměrná cena? Výstup musí mít sloupce `Nejlevnejsi`, `Nejdrazsi` a `Prumer` (zaokrouhlený na 2 desetinná místa).

```sql
-- B8:
```

---

## Část C: GROUP BY a HAVING (8 bodů)

### Úloha 9 (3 body)

Pro každou barvu produktu spočítejte počet produktů a průměrnou cenu. Nezahrnujte produkty bez barvy. Seřaďte podle počtu produktů sestupně.

```sql
-- C9:
```

### Úloha 10 (2 body)

Najděte velikosti (`Size`), které mají více než 10 produktů. Zobrazte velikost a počet produktů.

```sql
-- C10:
```

### Úloha 11 (3 body)

Pro každého zákazníka, který má objednávku, spočítejte počet objednávek a celkovou útratu (`SUM(TotalDue)`). Zobrazte pouze zákazníky s celkovou útratou nad 50 000.

```sql
-- C11:
```

---

## Část D: JOIN (12 bodů)

### Úloha 12 (3 body)

Zobrazte objednávky (`SalesOrderID`, `OrderDate`) spolu se jménem a příjmením zákazníka. Seřaďte podle data objednávky.

```sql
-- D12:
```

### Úloha 13 (3 body)

Zobrazte název produktu, jeho cenu a název kategorie. Zobrazte pouze produkty s cenou nad 500.

```sql
-- D13:
```

### Úloha 14 (3 body)

Pro každou hlavní kategorii (nadřazená `ProductCategory`) spočítejte počet produktů. Zobrazte název hlavní kategorie a počet. (Tip: potřebujete spojit `Product` → `ProductCategory` jako podkategorie → `ProductCategory` jako nadřazená kategorie.)

```sql
-- D14:
```

### Úloha 15 (3 body)

Najděte zákazníky, kteří nemají žádnou objednávku. Zobrazte jejich jméno a příjmení.

```sql
-- D15:
```

---

## Bodování

| Část | Body |
|---|---|
| A: Teorie | 4 |
| B: SELECT a WHERE | 12 |
| C: GROUP BY a HAVING | 8 |
| D: JOIN | 12 |
| **Celkem** | **36** |

| Hodnocení | Body |
|---|---|
| Výborně | 32–36 |
| Chvalitebně | 27–31 |
| Dobře | 22–26 |
| Dostatečně | 18–21 |
| Nedostatečně | 0–17 |

---

## Vzorová řešení (pro vyučujícího)

<details>
<summary>Klikněte pro zobrazení vzorových řešení</summary>

```sql
-- A1: Primární klíč jednoznačně identifikuje řádek, nesmí být NULL a nesmí se opakovat.
--     Cizí klíč odkazuje na primární klíč jiné tabulky a vytváří vazbu.
--     Příklad: CustomerID je PK v Customer a FK v SalesOrderHeader.

-- A2: WHERE filtruje řádky PŘED seskupením (GROUP BY).
--     HAVING filtruje skupiny PO seskupení.

-- A3: NULL není hodnota, je to absence hodnoty. Operátor = nelze na NULL použít.
--     Správně: WHERE Color IS NULL / IS NOT NULL.

-- B4:
SELECT FirstName, LastName, EmailAddress
FROM SalesLT.Customer
WHERE LastName LIKE 'B%'
ORDER BY LastName;

-- B5:
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Color IN ('Yellow', 'Silver')
  AND ListPrice < 500
ORDER BY ListPrice DESC;

-- B6:
SELECT TOP 3
    Name AS Nazev,
    ListPrice AS Cena
FROM SalesLT.Product
ORDER BY ListPrice DESC;

-- B7:
SELECT COUNT(*) AS ProduktyBezBarvy
FROM SalesLT.Product
WHERE Color IS NULL;

-- B8:
SELECT
    MIN(ListPrice) AS Nejlevnejsi,
    MAX(ListPrice) AS Nejdrazsi,
    ROUND(AVG(ListPrice), 2) AS Prumer
FROM SalesLT.Product;

-- C9:
SELECT
    Color,
    COUNT(*) AS PocetProduktu,
    ROUND(AVG(ListPrice), 2) AS PrumernaCena
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY PocetProduktu DESC;

-- C10:
SELECT
    Size,
    COUNT(*) AS PocetProduktu
FROM SalesLT.Product
WHERE Size IS NOT NULL
GROUP BY Size
HAVING COUNT(*) > 10;

-- C11:
SELECT
    CustomerID,
    COUNT(*) AS PocetObjednavek,
    SUM(TotalDue) AS CelkovaUtrata
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) > 50000
ORDER BY CelkovaUtrata DESC;

-- D12:
SELECT
    o.SalesOrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
FROM SalesLT.SalesOrderHeader AS o
INNER JOIN SalesLT.Customer AS c ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate;

-- D13:
SELECT
    p.Name AS Produkt,
    p.ListPrice AS Cena,
    pc.Name AS Kategorie
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice > 500
ORDER BY p.ListPrice DESC;

-- D14:
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

-- D15:
SELECT
    c.FirstName,
    c.LastName
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS o ON c.CustomerID = o.CustomerID
WHERE o.SalesOrderID IS NULL
ORDER BY c.LastName;
```

</details>
