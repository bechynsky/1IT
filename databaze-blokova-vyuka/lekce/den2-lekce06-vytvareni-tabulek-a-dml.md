# Den 2 – Lekce 6: Vytváření tabulek a manipulace s daty (90 min)

## Cíle lekce

- Vytvářet tabulky pomocí CREATE TABLE
- Definovat primární a cizí klíče, datové typy a omezení
- Vkládat data pomocí INSERT
- Aktualizovat data pomocí UPDATE
- Mazat data pomocí DELETE
- Mazat a upravovat tabulky (DROP TABLE, ALTER TABLE)

---

## 1. CREATE TABLE – vytvoření tabulky (25 min)

Příkaz `CREATE TABLE` vytvoří novou tabulku v databázi. Pracujeme ve **vlastním schématu** `studentXX`.

### Základní syntaxe

```sql
CREATE TABLE schema.NazevTabulky (
    NazevSloupce DATOVY_TYP OMEZENI,
    ...
);
```

### Nejčastější datové typy

| Typ | Použití | Příklad |
|---|---|---|
| `INT` | celá čísla | ID, počet kusů |
| `NVARCHAR(n)` | text do n Unicode znaků | jména, e-maily |
| `DECIMAL(p,s)` | přesná desetinná čísla | ceny, měny |
| `DATE` | datum | datum narození |
| `DATETIME2` | datum a čas | čas objednávky |
| `BIT` | logická hodnota 0/1 | aktivní/neaktivní |

### Nejčastější omezení (constraints)

| Omezení | Význam |
|---|---|
| `PRIMARY KEY` | primární klíč – unikátní, nesmí být NULL |
| `NOT NULL` | sloupec nesmí být prázdný |
| `NULL` | sloupec může být prázdný (výchozí) |
| `UNIQUE` | hodnota musí být unikátní v celé tabulce |
| `DEFAULT` | výchozí hodnota při vložení |
| `FOREIGN KEY ... REFERENCES` | cizí klíč – odkaz na jinou tabulku |
| `IDENTITY(1,1)` | automaticky generované číslo (1, 2, 3, ...) |

### Příklad: Tabulka zákazníků

```sql
-- Nahraďte XX vaším číslem studenta
CREATE TABLE studentXX.Zakaznici (
    ZakaznikID INT IDENTITY(1,1) PRIMARY KEY,
    Jmeno NVARCHAR(50) NOT NULL,
    Prijmeni NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Telefon NVARCHAR(20) NULL,
    DatumRegistrace DATE DEFAULT GETDATE()
);
```

Vysvětlení:
- `IDENTITY(1,1)` – automaticky přiděluje ID (začíná od 1, přičítá 1)
- `NOT NULL` – jméno a příjmení jsou povinné
- `UNIQUE` – dva zákazníci nemohou mít stejný e-mail
- `NULL` – telefon je volitelný
- `DEFAULT GETDATE()` – pokud datum neuvedeme, použije se dnešní

### Příklad: Tabulka objednávek s cizím klíčem

```sql
CREATE TABLE studentXX.Objednavky (
    ObjednavkaID INT IDENTITY(1,1) PRIMARY KEY,
    ZakaznikID INT NOT NULL,
    DatumObjednavky DATETIME2 DEFAULT GETDATE(),
    Stav NVARCHAR(20) DEFAULT 'Nova',
    FOREIGN KEY (ZakaznikID) REFERENCES studentXX.Zakaznici(ZakaznikID)
);
```

Cizí klíč `FOREIGN KEY` zajistí, že `ZakaznikID` v objednávce musí existovat v tabulce `Zakaznici`.

### Příklad: Tabulka položek objednávky

```sql
CREATE TABLE studentXX.PolozkyObjednavek (
    PolozkaID INT IDENTITY(1,1) PRIMARY KEY,
    ObjednavkaID INT NOT NULL,
    NazevProduktu NVARCHAR(100) NOT NULL,
    Cena DECIMAL(10,2) NOT NULL,
    Pocet INT NOT NULL DEFAULT 1,
    FOREIGN KEY (ObjednavkaID) REFERENCES studentXX.Objednavky(ObjednavkaID)
);
```

---

## 2. INSERT – vkládání dat (15 min)

### Vložení jednoho řádku

```sql
-- Vložení zákazníka (ID se generuje automaticky)
INSERT INTO studentXX.Zakaznici (Jmeno, Prijmeni, Email, Telefon)
VALUES ('Jan', 'Novák', 'jan.novak@email.cz', '777111222');
```

### Vložení více řádků najednou

```sql
INSERT INTO studentXX.Zakaznici (Jmeno, Prijmeni, Email, Telefon)
VALUES
    ('Eva', 'Malá', 'eva.mala@email.cz', '608333444'),
    ('Petr', 'Černý', 'petr.cerny@email.cz', NULL),
    ('Anna', 'Dvořáková', 'anna.dvorakova@email.cz', '721555666');
```

### Ověření vložených dat

```sql
SELECT * FROM studentXX.Zakaznici;
```

### Vložení objednávky

```sql
-- Objednávka pro zákazníka s ID 1
INSERT INTO studentXX.Objednavky (ZakaznikID)
VALUES (1);

-- Ověření (Stav by měl být 'Nova' a datum dnešní)
SELECT * FROM studentXX.Objednavky;
```

### Vložení položek objednávky

```sql
-- Předpokládáme, že objednávka má ID 1
INSERT INTO studentXX.PolozkyObjednavek (ObjednavkaID, NazevProduktu, Cena, Pocet)
VALUES
    (1, 'Klávesnice', 499.90, 1),
    (1, 'Myš', 299.90, 2);

SELECT * FROM studentXX.PolozkyObjednavek;
```

### Co se stane při porušení omezení?

```sql
-- Pokus o duplicitní e-mail (selže – UNIQUE)
INSERT INTO studentXX.Zakaznici (Jmeno, Prijmeni, Email)
VALUES ('Test', 'Duplicitni', 'jan.novak@email.cz');

-- Pokus o neexistujícího zákazníka (selže – FOREIGN KEY)
INSERT INTO studentXX.Objednavky (ZakaznikID)
VALUES (999);

-- Pokus o prázdné jméno (selže – NOT NULL)
INSERT INTO studentXX.Zakaznici (Jmeno, Prijmeni, Email)
VALUES (NULL, 'Test', 'test@email.cz');
```

> Každý z těchto příkazů vyvolá chybu – databáze chrání integritu dat.

---

## 3. UPDATE – aktualizace dat (15 min)

### Syntaxe

```sql
UPDATE schema.Tabulka
SET Sloupec1 = NovaHodnota1,
    Sloupec2 = NovaHodnota2
WHERE podmínka;
```

> **Pozor:** Vždy používejte `WHERE`! Bez WHERE se aktualizují **všechny** řádky.

### Aktualizace telefonu zákazníka

```sql
-- Přidání telefonu Petru Černému (má NULL)
UPDATE studentXX.Zakaznici
SET Telefon = '602777888'
WHERE Prijmeni = 'Černý' AND Jmeno = 'Petr';

-- Ověření
SELECT * FROM studentXX.Zakaznici WHERE Prijmeni = 'Černý';
```

### Aktualizace stavu objednávky

```sql
UPDATE studentXX.Objednavky
SET Stav = 'Odeslana'
WHERE ObjednavkaID = 1;

SELECT * FROM studentXX.Objednavky;
```

### Aktualizace více sloupců najednou

```sql
UPDATE studentXX.Zakaznici
SET Email = 'jan.novak.novy@email.cz',
    Telefon = '777999000'
WHERE ZakaznikID = 1;
```

### Aktualizace s výrazem

```sql
-- Zvýšení ceny všech položek o 10 %
UPDATE studentXX.PolozkyObjednavek
SET Cena = Cena * 1.10
WHERE ObjednavkaID = 1;

SELECT * FROM studentXX.PolozkyObjednavek;
```

---

## 4. DELETE – mazání dat (10 min)

### Syntaxe

```sql
DELETE FROM schema.Tabulka
WHERE podmínka;
```

> **Pozor:** Bez `WHERE` se smažou **všechny** řádky tabulky!

### Smazání konkrétního řádku

```sql
-- Přidáme testovacího zákazníka
INSERT INTO studentXX.Zakaznici (Jmeno, Prijmeni, Email)
VALUES ('Test', 'Smazat', 'smazat@email.cz');

SELECT * FROM studentXX.Zakaznici;

-- Smazání testovacího zákazníka
DELETE FROM studentXX.Zakaznici
WHERE Email = 'smazat@email.cz';

SELECT * FROM studentXX.Zakaznici;
```

### Omezení cizím klíčem

```sql
-- Pokus o smazání zákazníka, který má objednávku (selže – FOREIGN KEY)
DELETE FROM studentXX.Zakaznici
WHERE ZakaznikID = 1;
```

Databáze nedovolí smazat zákazníka, pokud na něj odkazují objednávky. Nejdříve se musí smazat závislé záznamy (položky → objednávky → zákazník).

---

## 5. DROP TABLE a ALTER TABLE (10 min)

### Smazání tabulky

```sql
-- Smaže celou tabulku včetně všech dat
-- Pozor: tabulky se musí mazat v opačném pořadí než se vytvářely (kvůli FK)
DROP TABLE studentXX.PolozkyObjednavek;
DROP TABLE studentXX.Objednavky;
DROP TABLE studentXX.Zakaznici;
```

### Přidání sloupce

```sql
-- Přidání sloupce do existující tabulky
ALTER TABLE studentXX.Zakaznici
ADD Mesto NVARCHAR(50) NULL;
```

### Odebrání sloupce

```sql
ALTER TABLE studentXX.Zakaznici
DROP COLUMN Mesto;
```

---

## 6. Praktické cvičení: Školní knihovna (15 min)

Vytvořte ve svém schématu tabulky pro školní knihovnu z lekce 5 a naplňte je daty.

### Krok 1: Vytvořte tabulky

```sql
-- Tabulka knih
CREATE TABLE studentXX.Knihy (
    KnihaID INT IDENTITY(1,1) PRIMARY KEY,
    Nazev NVARCHAR(200) NOT NULL,
    Autor NVARCHAR(100) NOT NULL,
    RokVydani INT,
    ISBN NVARCHAR(20) UNIQUE
);

-- Tabulka studentů
CREATE TABLE studentXX.Studenti (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Jmeno NVARCHAR(100) NOT NULL,
    Trida NVARCHAR(10) NOT NULL
);

-- Tabulka výpůjček (vazební tabulka M:N)
CREATE TABLE studentXX.Vypujcky (
    VypujckaID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    KnihaID INT NOT NULL,
    DatumVypujcky DATE NOT NULL DEFAULT GETDATE(),
    DatumVraceni DATE NULL,
    FOREIGN KEY (StudentID) REFERENCES studentXX.Studenti(StudentID),
    FOREIGN KEY (KnihaID) REFERENCES studentXX.Knihy(KnihaID)
);
```

### Krok 2: Vložte data

```sql
-- Knihy
INSERT INTO studentXX.Knihy (Nazev, Autor, RokVydani, ISBN) VALUES
    ('Harry Potter a Kámen mudrců', 'J.K. Rowling', 1997, '978-80-0007-890-5'),
    ('Malý princ', 'Antoine de Saint-Exupéry', 1943, '978-80-0001-550-2'),
    ('1984', 'George Orwell', 1949, '978-80-7335-361-0'),
    ('Hobit', 'J.R.R. Tolkien', 1937, '978-80-257-0741-5');

-- Studenti
INSERT INTO studentXX.Studenti (Jmeno, Trida) VALUES
    ('Alice Veselá', '2.A'),
    ('Bob Tichý', '2.B'),
    ('Cyril Rychlý', '2.A');

-- Výpůjčky
INSERT INTO studentXX.Vypujcky (StudentID, KnihaID, DatumVypujcky, DatumVraceni) VALUES
    (1, 1, '2025-09-01', '2025-09-15'),
    (1, 3, '2025-09-10', NULL),
    (2, 2, '2025-09-05', '2025-09-20'),
    (3, 1, '2025-09-16', NULL),
    (3, 4, '2025-09-16', NULL);
```

### Krok 3: Ověřte data dotazy

```sql
-- Všechny knihy
SELECT * FROM studentXX.Knihy;

-- Všechny výpůjčky s názvy knih a jmény studentů
SELECT
    s.Jmeno AS Student,
    k.Nazev AS Kniha,
    v.DatumVypujcky,
    v.DatumVraceni
FROM studentXX.Vypujcky AS v
INNER JOIN studentXX.Studenti AS s ON v.StudentID = s.StudentID
INNER JOIN studentXX.Knihy AS k ON v.KnihaID = k.KnihaID
ORDER BY v.DatumVypujcky;

-- Aktuálně nevrácené knihy
SELECT
    s.Jmeno AS Student,
    k.Nazev AS Kniha,
    v.DatumVypujcky
FROM studentXX.Vypujcky AS v
INNER JOIN studentXX.Studenti AS s ON v.StudentID = s.StudentID
INNER JOIN studentXX.Knihy AS k ON v.KnihaID = k.KnihaID
WHERE v.DatumVraceni IS NULL;

-- Aktualizace: Alice vrátila knihu 1984
UPDATE studentXX.Vypujcky
SET DatumVraceni = GETDATE()
WHERE VypujckaID = 2;
```

---

## Shrnutí lekce

- `CREATE TABLE` vytváří tabulku s definicí sloupců, datových typů a omezení
- `IDENTITY(1,1)` automaticky generuje primární klíč
- `FOREIGN KEY ... REFERENCES` vytváří cizí klíč a vazbu mezi tabulkami
- `INSERT INTO` vkládá nové řádky, lze vložit i více řádků najednou
- `UPDATE ... SET ... WHERE` aktualizuje existující data (vždy s WHERE!)
- `DELETE FROM ... WHERE` maže řádky (vždy s WHERE!)
- Omezení (constraints) chrání integritu dat – databáze odmítne neplatná data
