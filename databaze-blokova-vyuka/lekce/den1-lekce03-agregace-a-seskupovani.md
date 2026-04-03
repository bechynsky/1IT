# Den 1 – Lekce 3: Agregační funkce a seskupování (90 min)

## Cíle lekce

- Používat agregační funkce COUNT, SUM, AVG, MIN, MAX
- Seskupovat data pomocí GROUP BY
- Filtrovat skupiny pomocí HAVING
- Používat jednoduché výpočty a výrazy ve sloupcích

---

## 1. Agregační funkce (25 min)

Agregační funkce zpracují skupinu řádků a vrátí jednu výslednou hodnotu. Základní agregační funkce:

| Funkce | Popis |
|---|---|
| `COUNT(*)` | počet řádků |
| `COUNT(sloupec)` | počet řádků, kde sloupec není NULL |
| `SUM(sloupec)` | součet hodnot |
| `AVG(sloupec)` | průměr hodnot |
| `MIN(sloupec)` | nejmenší hodnota |
| `MAX(sloupec)` | největší hodnota |

### Příklady nad celou tabulkou

```sql
-- Celkový počet produktů
SELECT COUNT(*) AS PocetProduktu
FROM SalesLT.Product;
```

```sql
-- Nejdražší a nejlevnější produkt
SELECT
    MIN(ListPrice) AS NejlevnejsiCena,
    MAX(ListPrice) AS NejdrazsiCena
FROM SalesLT.Product;
```

```sql
-- Průměrná cena produktů
SELECT
    AVG(ListPrice) AS PrumernaCena
FROM SalesLT.Product;
```

```sql
-- Celková hodnota všech položek objednávek
SELECT
    SUM(OrderQty * UnitPrice) AS CelkovaHodnota
FROM SalesLT.SalesOrderDetail;
```

### COUNT(*) vs COUNT(sloupec)

```sql
-- Rozdíl: COUNT(*) počítá všechny řádky, COUNT(Color) jen ty s barvou
SELECT
    COUNT(*) AS VsechnyProdukty,
    COUNT(Color) AS ProduktysBarvou
FROM SalesLT.Product;
```

### Kombinace s WHERE

Agregační funkce lze kombinovat s `WHERE` pro filtrování řádků před agregací:

```sql
-- Průměrná cena červených produktů
SELECT
    AVG(ListPrice) AS PrumernaCenaCervenych
FROM SalesLT.Product
WHERE Color = 'Red';
```

```sql
-- Počet produktů s cenou nad 1000
SELECT
    COUNT(*) AS PocetDrahychProduktu
FROM SalesLT.Product
WHERE ListPrice > 1000;
```

---

## 2. Seskupování – GROUP BY (25 min)

`GROUP BY` rozdělí řádky do skupin podle hodnot ve sloupci a umožní na každou skupinu aplikovat agregační funkci.

### Pravidlo

Každý sloupec v `SELECT`, který není v agregační funkci, **musí** být uveden v `GROUP BY`.

### Počet produktů podle barvy

```sql
SELECT
    Color,
    COUNT(*) AS PocetProduktu
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY PocetProduktu DESC;
```

Výstup (příklad):

| Color | PocetProduktu |
|---|---|
| Black | 89 |
| Silver | 43 |
| Red | 38 |
| Yellow | 36 |
| Blue | 26 |

### Průměrná cena podle barvy

```sql
SELECT
    Color,
    AVG(ListPrice) AS PrumernaCena,
    MIN(ListPrice) AS NejlevnejsiCena,
    MAX(ListPrice) AS NejdrazsiCena
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY PrumernaCena DESC;
```

### Počet objednávek podle zákazníka

```sql
SELECT
    CustomerID,
    COUNT(*) AS PocetObjednavek,
    SUM(TotalDue) AS CelkovaUtrata
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CelkovaUtrata DESC;
```

### Počet produktů v každé kategorii

```sql
SELECT
    ProductCategoryID,
    COUNT(*) AS PocetProduktu
FROM SalesLT.Product
GROUP BY ProductCategoryID
ORDER BY PocetProduktu DESC;
```

---

## 3. Filtrování skupin – HAVING (15 min)

`HAVING` filtruje skupiny **po** seskupení – na rozdíl od `WHERE`, které filtruje řádky **před** seskupením.

### Rozdíl WHERE vs HAVING

```
SELECT ...
FROM tabulka
WHERE podmínka_na_řádky       -- filtruje PŘED seskupením
GROUP BY sloupce
HAVING podmínka_na_skupiny     -- filtruje PO seskupení
ORDER BY řazení;
```

### Barvy s více než 30 produkty

```sql
SELECT
    Color,
    COUNT(*) AS PocetProduktu
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*) > 30
ORDER BY PocetProduktu DESC;
```

### Zákazníci s útratou nad 10 000

```sql
SELECT
    CustomerID,
    COUNT(*) AS PocetObjednavek,
    SUM(TotalDue) AS CelkovaUtrata
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) > 10000
ORDER BY CelkovaUtrata DESC;
```

### Kombinace WHERE a HAVING

```sql
-- Počet produktů s cenou nad 100, seskupených podle barvy,
-- zobrazit jen barvy s více než 5 takovými produkty
SELECT
    Color,
    COUNT(*) AS PocetProduktu,
    AVG(ListPrice) AS PrumernaCena
FROM SalesLT.Product
WHERE ListPrice > 100
  AND Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*) > 5
ORDER BY PrumernaCena DESC;
```

---

## 4. Výpočty ve sloupcích (10 min)

V `SELECT` můžete používat matematické výrazy a vytvářet tak vypočítané sloupce:

```sql
-- Výpočet celkové ceny za položku objednávky
SELECT
    SalesOrderID,
    ProductID,
    OrderQty,
    UnitPrice,
    OrderQty * UnitPrice AS CelkovaCena
FROM SalesLT.SalesOrderDetail;
```

```sql
-- Výpočet ceny se slevou
SELECT
    SalesOrderID,
    ProductID,
    UnitPrice,
    UnitPriceDiscount,
    UnitPrice * (1 - UnitPriceDiscount) AS CenaPoSleve
FROM SalesLT.SalesOrderDetail
WHERE UnitPriceDiscount > 0;
```

```sql
-- Zaokrouhlení průměrné ceny na 2 desetinná místa
SELECT
    Color,
    ROUND(AVG(ListPrice), 2) AS PrumernaCena
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY PrumernaCena DESC;
```

---

## 5. Procvičování (15 min)

### Úkol 1: Agregace

1. Kolik různých barev produktů existuje? (Tip: `COUNT(DISTINCT Color)`)
2. Jaká je celková hodnota (součet `TotalDue`) všech objednávek?
3. Kolik objednávek je v tabulce `SalesLT.SalesOrderHeader`?

### Úkol 2: GROUP BY

4. Kolik produktů má každá velikost (`Size`)? Seřaďte sestupně podle počtu.
5. Pro každou kategorii (`ProductCategoryID`) zjistěte průměrnou a maximální cenu produktů.

### Úkol 3: HAVING

6. Najděte barvy, jejichž průměrná cena je vyšší než 500.
7. Najděte zákazníky, kteří mají více než 1 objednávku.

---

### Řešení

<details>
<summary>Klikněte pro zobrazení řešení</summary>

```sql
-- 1. Počet různých barev
SELECT COUNT(DISTINCT Color) AS PocetBarev
FROM SalesLT.Product;

-- 2. Celková hodnota objednávek
SELECT SUM(TotalDue) AS CelkovaHodnota
FROM SalesLT.SalesOrderHeader;

-- 3. Počet objednávek
SELECT COUNT(*) AS PocetObjednavek
FROM SalesLT.SalesOrderHeader;

-- 4. Produkty podle velikosti
SELECT
    Size,
    COUNT(*) AS PocetProduktu
FROM SalesLT.Product
WHERE Size IS NOT NULL
GROUP BY Size
ORDER BY PocetProduktu DESC;

-- 5. Průměrná a maximální cena podle kategorie
SELECT
    ProductCategoryID,
    ROUND(AVG(ListPrice), 2) AS PrumernaCena,
    MAX(ListPrice) AS MaxCena
FROM SalesLT.Product
GROUP BY ProductCategoryID
ORDER BY PrumernaCena DESC;

-- 6. Barvy s průměrnou cenou nad 500
SELECT
    Color,
    ROUND(AVG(ListPrice), 2) AS PrumernaCena
FROM SalesLT.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING AVG(ListPrice) > 500
ORDER BY PrumernaCena DESC;

-- 7. Zákazníci s více než 1 objednávkou
SELECT
    CustomerID,
    COUNT(*) AS PocetObjednavek
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(*) > 1
ORDER BY PocetObjednavek DESC;
```

</details>

---

## Shrnutí lekce

- Agregační funkce (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) pracují nad skupinou řádků
- `GROUP BY` seskupí řádky podle hodnoty sloupce a umožní agregaci na skupinu
- `HAVING` filtruje skupiny **po** seskupení (na rozdíl od `WHERE`)
- Pořadí klauzulí: `SELECT` → `FROM` → `WHERE` → `GROUP BY` → `HAVING` → `ORDER BY`
- Ve sloupcích lze použít matematické výrazy a funkce jako `ROUND()`
