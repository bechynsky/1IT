# Den 2 – Test: Ověření znalostí z druhého dne (45 min)

## Pokyny

- Část A a B řešte v souboru `den2-test.sql`
- Část C řešte v souboru `den2-test.py`
- Pracujte ve svém schématu `studentXX`
- Před odevzdáním ověřte, že všechny dotazy/skripty fungují bez chyb

---

## Část A: Teorie normalizace (6 bodů)

### Otázka 1 (2 body)

Vysvětlete, co je to normalizace databáze a proč je důležitá.

```sql
-- A1: Odpovězte zde jako komentář
```

### Otázka 2 (2 body)

Popište jednu z normálních forem (1NF, 2NF nebo 3NF) a uveďte příklad porušení.

```sql
-- A2: Odpovězte zde jako komentář
```

### Otázka 3 (2 body)

Jaký je rozdíl mezi vazbou 1:N a M:N? Jak se v databázi řeší vazba M:N?

```sql
-- A3: Odpovězte zde jako komentář
```

---

## Část B: SQL – Vytváření tabulek a DML (18 bodů)

### Úloha 4 (4 body)

Vytvořte ve svém schématu tabulku `Filmy` s následujícími sloupci:
- `FilmID` – celé číslo, primární klíč, automaticky generovaný
- `Nazev` – text max 150 znaků, povinný
- `Reziser` – text max 100 znaků
- `RokVydani` – celé číslo
- `Hodnoceni` – desetinné číslo (3,1) pro hodnocení 0.0–10.0
- `DatumPridani` – datum, výchozí hodnota dnešní datum

```sql
-- B4:
```

### Úloha 5 (3 body)

Vytvořte tabulku `Recenze` s vazbou na tabulku `Filmy`:
- `RecenzeID` – celé číslo, primární klíč, automaticky generovaný
- `FilmID` – cizí klíč odkazující na `Filmy`
- `Autor` – text max 50 znaků, povinný
- `Text` – text max 500 znaků
- `Hvezdicky` – celé číslo (1–5)

```sql
-- B5:
```

### Úloha 6 (3 body)

Vložte do tabulky `Filmy` alespoň 4 filmy (můžete použít skutečné nebo vymyšlené názvy).

```sql
-- B6:
```

### Úloha 7 (2 body)

Vložte do tabulky `Recenze` alespoň 3 recenze k různým filmům.

```sql
-- B7:
```

### Úloha 8 (2 body)

Aktualizujte hodnocení jednoho z filmů na novou hodnotu.

```sql
-- B8:
```

### Úloha 9 (2 body)

Napište dotaz s JOINem, který zobrazí název filmu, autora recenze a počet hvězdiček. Seřaďte podle názvu filmu.

```sql
-- B9:
```

### Úloha 10 (2 body)

Smažte jeden film, který **nemá** žádnou recenzi. (Pokud všechny mají recenzi, nejdříve přidejte film bez recenze.)

```sql
-- B10:
```

---

## Část C: Python (12 bodů)

### Úloha 11 (4 body)

Napište Python skript `den2-test-11.py`, který:
1. Připojí se k databázi
2. Načte všechny filmy z vaší tabulky `studentXX.Filmy`
3. Vypíše je ve formátu: `Název (rok) – hodnocení X.X`
4. Korektně uzavře připojení

```python
# den2-test-11.py
```

### Úloha 12 (4 body)

Napište Python skript `den2-test-12.py`, který:
1. Požádá uživatele o název filmu
2. Pomocí parametrizovaného dotazu vyhledá film podle názvu (použijte LIKE)
3. Pokud nalezne, zobrazí detaily; pokud ne, vypíše „Film nenalezen"
4. Používá parametrizovaný dotaz (ochrana proti SQL injection)

```python
# den2-test-12.py
```

### Úloha 13 (4 body)

Napište Python skript `den2-test-13.py`, který:
1. Požádá uživatele o údaje nového filmu (název, režisér, rok, hodnocení)
2. Vloží film do tabulky `studentXX.Filmy`
3. Po vložení zobrazí potvrzení a vypíše aktuální počet filmů v tabulce
4. Správně ošetřuje chyby (try/except) a uzavírá připojení

```python
# den2-test-13.py
```

---

## Bodování

| Část | Body |
|---|---|
| A: Teorie normalizace | 6 |
| B: SQL – DDL a DML | 18 |
| C: Python | 12 |
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

### SQL řešení (den2-test.sql)

```sql
-- A1: Normalizace je proces rozdělení dat do více tabulek propojených klíči.
--     Důležitost: odstraňuje redundanci, předchází aktualizační, vkládací
--     a mazací anomáliím, zajišťuje konzistenci dat.

-- A2: 1NF - každý sloupec obsahuje atomické hodnoty.
--     Porušení: sloupec "Telefony" obsahující "777111222, 602333444".
--     Řešení: vytvořit samostatnou tabulku Telefony s FK na původní tabulku.

-- A3: 1:N - jeden záznam má N souvisejících (zákazník → objednávky).
--     M:N - mnoho na obou stranách (student ↔ knihy).
--     M:N se řeší vazební tabulkou se dvěma cizími klíči.

-- B4:
CREATE TABLE studentXX.Filmy (
    FilmID INT IDENTITY(1,1) PRIMARY KEY,
    Nazev NVARCHAR(150) NOT NULL,
    Reziser NVARCHAR(100),
    RokVydani INT,
    Hodnoceni DECIMAL(3,1),
    DatumPridani DATE DEFAULT GETDATE()
);

-- B5:
CREATE TABLE studentXX.Recenze (
    RecenzeID INT IDENTITY(1,1) PRIMARY KEY,
    FilmID INT NOT NULL,
    Autor NVARCHAR(50) NOT NULL,
    Text NVARCHAR(500),
    Hvezdicky INT,
    FOREIGN KEY (FilmID) REFERENCES studentXX.Filmy(FilmID)
);

-- B6:
INSERT INTO studentXX.Filmy (Nazev, Reziser, RokVydani, Hodnoceni) VALUES
    ('Pelíšky', 'Jan Hřebejk', 1999, 8.5),
    ('Tmavomodrý svět', 'Jan Svěrák', 2001, 7.8),
    ('Kolja', 'Jan Svěrák', 1996, 8.0),
    ('Samotáři', 'David Ondříček', 2000, 7.5);

-- B7:
INSERT INTO studentXX.Recenze (FilmID, Autor, Text, Hvezdicky) VALUES
    (1, 'Jan', 'Skvělá komedie!', 5),
    (2, 'Eva', 'Velmi dojemný film.', 4),
    (1, 'Petr', 'Klasika české kinematografie.', 5);

-- B8:
UPDATE studentXX.Filmy
SET Hodnoceni = 8.2
WHERE Nazev = 'Samotáři';

-- B9:
SELECT
    f.Nazev AS Film,
    r.Autor,
    r.Hvezdicky
FROM studentXX.Filmy AS f
INNER JOIN studentXX.Recenze AS r ON f.FilmID = r.FilmID
ORDER BY f.Nazev;

-- B10:
-- Kolja nemá recenzi, smažeme ho
DELETE FROM studentXX.Filmy
WHERE Nazev = 'Kolja';

-- Úklid na konci testu (volitelné):
-- DROP TABLE studentXX.Recenze;
-- DROP TABLE studentXX.Filmy;
```

### Python řešení

```python
# den2-test-11.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER, database=DB_NAME,
    user=DB_USER, password=DB_PASSWORD
)
try:
    cursor = connection.cursor()
    cursor.execute("""
        SELECT Nazev, RokVydani, Hodnoceni
        FROM studentXX.Filmy
        ORDER BY Nazev
    """)

    print("=== Seznam filmů ===")
    for row in cursor:
        rok = row[1] if row[1] else "neznámý"
        hodnoceni = f"{row[2]:.1f}" if row[2] else "N/A"
        print(f"  {row[0]} ({rok}) – hodnocení {hodnoceni}")

    cursor.close()
finally:
    connection.close()
```

```python
# den2-test-12.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

nazev = input("Zadejte název filmu: ")

connection = mssqlpython.connect(
    server=DB_SERVER, database=DB_NAME,
    user=DB_USER, password=DB_PASSWORD
)
try:
    cursor = connection.cursor()
    cursor.execute("""
        SELECT Nazev, Reziser, RokVydani, Hodnoceni
        FROM studentXX.Filmy
        WHERE Nazev LIKE ?
    """, (f"%{nazev}%",))

    rows = cursor.fetchall()
    if rows:
        print(f"\nNalezeno {len(rows)} filmů:")
        for row in rows:
            print(f"  {row[0]} | Režisér: {row[1]} | Rok: {row[2]} | Hodnocení: {row[3]}")
    else:
        print("Film nenalezen.")

    cursor.close()
finally:
    connection.close()
```

```python
# den2-test-13.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

nazev = input("Název filmu: ")
reziser = input("Režisér: ")
rok = input("Rok vydání: ")
hodnoceni = input("Hodnocení (0-10): ")

connection = mssqlpython.connect(
    server=DB_SERVER, database=DB_NAME,
    user=DB_USER, password=DB_PASSWORD
)
try:
    cursor = connection.cursor()
    cursor.execute("""
        INSERT INTO studentXX.Filmy (Nazev, Reziser, RokVydani, Hodnoceni)
        VALUES (?, ?, ?, ?)
    """, (nazev, reziser, int(rok), float(hodnoceni)))
    connection.commit()
    print(f"\nFilm '{nazev}' vložen.")

    cursor.execute("SELECT COUNT(*) FROM studentXX.Filmy")
    pocet = cursor.fetchone()[0]
    print(f"Celkem filmů v tabulce: {pocet}")

    cursor.close()
except Exception as e:
    connection.rollback()
    print(f"Chyba: {e}")
finally:
    connection.close()
```

</details>
