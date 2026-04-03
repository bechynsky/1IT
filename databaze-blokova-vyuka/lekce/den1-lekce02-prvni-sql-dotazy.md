# Den 1 – Lekce 2: První SQL dotazy (90 min)

## Cíle lekce

- Naučit se základní strukturu příkazu SELECT
- Filtrovat data pomocí WHERE
- Řadit výsledky pomocí ORDER BY
- Používat aliasy a omezení počtu výsledků

---

## 1. Struktura příkazu SELECT (20 min)

Příkaz `SELECT` je nejpoužívanější SQL příkaz. Používá se k získávání (dotazování) dat z databáze.

### Základní syntaxe

```sql
SELECT sloupce
FROM tabulka
WHERE podmínka
ORDER BY řazení;
```

Pořadí klauzulí je pevně dané a musí se dodržet.

### Výběr všech sloupců

Hvězdička `*` vybere všechny sloupce tabulky:

```sql
-- Všechny sloupce a všechny řádky tabulky Customer
SELECT *
FROM SalesLT.Customer;
```

> **Pozor:** V praxi se `SELECT *` nedoporučuje – načítá zbytečně mnoho dat. Vždy vyjmenujte sloupce, které potřebujete.

### Výběr konkrétních sloupců

```sql
-- Pouze jméno, příjmení a e-mail zákazníků
SELECT
    FirstName,
    LastName,
    EmailAddress
FROM SalesLT.Customer;
```

### Omezení počtu výsledků – TOP

```sql
-- Prvních 10 zákazníků
SELECT TOP 10
    FirstName,
    LastName,
    EmailAddress
FROM SalesLT.Customer;
```

### Aliasy – přejmenování sloupců

Alias dává sloupci srozumitelnější název ve výsledku. Používá se klíčové slovo `AS`:

```sql
SELECT
    FirstName AS Jmeno,
    LastName  AS Prijmeni,
    EmailAddress AS Email
FROM SalesLT.Customer;
```

---

## 2. Filtrování dat – WHERE (25 min)

Klauzule `WHERE` omezuje řádky na ty, které splňují zadanou podmínku.

### Porovnávací operátory

| Operátor | Význam | Příklad |
|---|---|---|
| `=` | rovná se | `Color = 'Red'` |
| `<>` nebo `!=` | nerovná se | `Color <> 'Red'` |
| `>` | větší než | `ListPrice > 100` |
| `<` | menší než | `ListPrice < 50` |
| `>=` | větší nebo rovno | `ListPrice >= 100` |
| `<=` | menší nebo rovno | `ListPrice <= 50` |

### Základní filtrování

```sql
-- Produkty s cenou vyšší než 1000
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
WHERE ListPrice > 1000;
```

```sql
-- Produkty červené barvy
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color = 'Red';
```

### Logické operátory AND, OR, NOT

```sql
-- Červené produkty s cenou nad 500
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color = 'Red'
  AND ListPrice > 500;
```

```sql
-- Produkty červené NEBO černé barvy
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color = 'Red'
   OR Color = 'Black';
```

```sql
-- Produkty, které NEJSOU červené
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE NOT Color = 'Red';
```

### Operátor IN

Operátor `IN` je zkratka pro více podmínek `OR` na stejný sloupec:

```sql
-- Produkty vybraných barev (ekvivalent OR OR OR)
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color IN ('Red', 'Black', 'Silver');
```

### Operátor BETWEEN

```sql
-- Produkty s cenou od 100 do 500 (včetně obou hranic)
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
WHERE ListPrice BETWEEN 100 AND 500;
```

### Operátor LIKE – vyhledávání v textu

Zástupné znaky:
- `%` – libovolný počet libovolných znaků
- `_` – právě jeden libovolný znak

```sql
-- Produkty, jejichž název začíná na 'Mountain'
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
WHERE Name LIKE 'Mountain%';
```

```sql
-- Produkty obsahující slovo 'Bike' kdekoli v názvu
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
WHERE Name LIKE '%Bike%';
```

### Práce s hodnotou NULL

NULL znamená „neznámá hodnota". Pro testování NULL se používá `IS NULL` / `IS NOT NULL`:

```sql
-- Produkty bez barvy (Color je NULL)
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color IS NULL;
```

```sql
-- Produkty, které mají barvu
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL;
```

> **Důležité:** Porovnání `Color = NULL` nefunguje! Vždy používejte `IS NULL`.

---

## 3. Řazení výsledků – ORDER BY (10 min)

Klauzule `ORDER BY` určuje pořadí řádků ve výsledku.

```sql
-- Produkty seřazené podle ceny od nejlevnějšího
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
ORDER BY ListPrice ASC;
```

```sql
-- Produkty seřazené podle ceny od nejdražšího
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;
```

```sql
-- Řazení podle více sloupců: nejdřív barva, pak cena sestupně
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL
ORDER BY Color ASC, ListPrice DESC;
```

---

## 4. DISTINCT – unikátní hodnoty (5 min)

Klíčové slovo `DISTINCT` odstraní duplicitní řádky z výsledku:

```sql
-- Jaké barvy produktů existují?
SELECT DISTINCT Color
FROM SalesLT.Product
WHERE Color IS NOT NULL
ORDER BY Color;
```

```sql
-- Jaké kombinace barva + velikost existují?
SELECT DISTINCT Color, Size
FROM SalesLT.Product
WHERE Color IS NOT NULL
  AND Size IS NOT NULL
ORDER BY Color, Size;
```

---

## 5. Procvičování (30 min)

### Úkol 1: Základní dotazy

Napište dotazy, které vrátí:

1. Jméno a příjmení všech zákazníků seřazených podle příjmení
2. Názvy a ceny 5 nejdražších produktů
3. Všechny produkty modré barvy (`'Blue'`) s cenou nad 50

### Úkol 2: Filtrování

4. Produkty, jejichž název obsahuje `'Frame'`
5. Produkty s cenou mezi 500 a 1500, seřazené od nejdražšího
6. Zákazníky, kteří nemají vyplněný telefon (`Phone IS NULL`)

### Úkol 3: Kombinované podmínky

7. Produkty červené nebo černé barvy s cenou nad 100, seřazené podle ceny
8. Unikátní barvy produktů, které stojí více než 1000

---

### Řešení

<details>
<summary>Klikněte pro zobrazení řešení</summary>

```sql
-- 1. Zákazníci seřazení podle příjmení
SELECT
    FirstName AS Jmeno,
    LastName AS Prijmeni
FROM SalesLT.Customer
ORDER BY LastName ASC;

-- 2. Top 5 nejdražších produktů
SELECT TOP 5
    Name,
    ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;

-- 3. Modré produkty s cenou nad 50
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color = 'Blue'
  AND ListPrice > 50;

-- 4. Produkty obsahující 'Frame'
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
WHERE Name LIKE '%Frame%';

-- 5. Produkty s cenou 500-1500
SELECT
    Name,
    ListPrice
FROM SalesLT.Product
WHERE ListPrice BETWEEN 500 AND 1500
ORDER BY ListPrice DESC;

-- 6. Zákazníci bez telefonu
SELECT
    FirstName,
    LastName,
    Phone
FROM SalesLT.Customer
WHERE Phone IS NULL;

-- 7. Červené/černé produkty nad 100
SELECT
    Name,
    Color,
    ListPrice
FROM SalesLT.Product
WHERE Color IN ('Red', 'Black')
  AND ListPrice > 100
ORDER BY ListPrice;

-- 8. Unikátní barvy drahých produktů
SELECT DISTINCT Color
FROM SalesLT.Product
WHERE ListPrice > 1000
  AND Color IS NOT NULL;
```

</details>

---

## Shrnutí lekce

- `SELECT` vybírá sloupce, `FROM` určuje tabulku
- `WHERE` filtruje řádky na základě podmínek
- Operátory: `=`, `<>`, `>`, `<`, `>=`, `<=`, `IN`, `BETWEEN`, `LIKE`, `IS NULL`
- Logické operátory `AND`, `OR`, `NOT` kombinují podmínky
- `ORDER BY` řadí výsledky (`ASC` vzestupně, `DESC` sestupně)
- `TOP` omezuje počet vrácených řádků
- `DISTINCT` odstraňuje duplicity
- `AS` přejmenuje sloupec ve výsledku (alias)
