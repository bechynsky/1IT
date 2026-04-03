# Den 2 – Lekce 8: Python a databáze – zápis dat a praktický projekt (90 min)

## Cíle lekce

- Vytvářet tabulky z Pythonu
- Vkládat, aktualizovat a mazat data z Pythonu
- Používat transakce (commit/rollback)
- Vytvořit jednoduchý projekt: správa kontaktů

---

## 1. Vytvoření tabulky z Pythonu (15 min)

### DDL příkazy z Pythonu

Python dokáže spouštět libovolné SQL příkazy, včetně `CREATE TABLE`:

```python
# 06_vytvoreni_tabulky.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

# Vytvoření tabulky (nahraďte XX vaším číslem)
cursor.execute("""
    IF NOT EXISTS (
        SELECT * FROM sys.tables
        WHERE name = 'Kontakty' AND schema_id = SCHEMA_ID('studentXX')
    )
    CREATE TABLE studentXX.Kontakty (
        KontaktID INT IDENTITY(1,1) PRIMARY KEY,
        Jmeno NVARCHAR(50) NOT NULL,
        Prijmeni NVARCHAR(50) NOT NULL,
        Email NVARCHAR(100),
        Telefon NVARCHAR(20),
        Poznamka NVARCHAR(200),
        DatumVytvoreni DATETIME2 DEFAULT GETDATE()
    )
""")
connection.commit()

print("Tabulka Kontakty vytvořena (nebo již existuje).")

cursor.close()
connection.close()
```

Vysvětlení:
- `IF NOT EXISTS` – kontrola, zda tabulka již existuje, aby se nevyvolala chyba
- `connection.commit()` – potvrdí změny v databázi

---

## 2. Vkládání dat z Pythonu (15 min)

### Vložení jednoho záznamu

```python
# 07_vlozeni_dat.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

# Vložení jednoho kontaktu
cursor.execute("""
    INSERT INTO studentXX.Kontakty (Jmeno, Prijmeni, Email, Telefon, Poznamka)
    VALUES (?, ?, ?, ?, ?)
""", ("Jan", "Novák", "jan@email.cz", "777111222", "Spolužák"))

connection.commit()
print("Kontakt vložen.")

cursor.close()
connection.close()
```

### Vložení více záznamů v cyklu

```python
# 08_vlozeni_vice.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

kontakty = [
    ("Eva", "Malá", "eva@email.cz", "608333444", "Kamarádka"),
    ("Petr", "Černý", "petr@email.cz", "602555666", "Kolega"),
    ("Anna", "Dvořáková", "anna@email.cz", None, "Ze školy"),
    ("Martin", "Svoboda", "martin@email.cz", "721888999", None),
]

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

sql = """
    INSERT INTO studentXX.Kontakty (Jmeno, Prijmeni, Email, Telefon, Poznamka)
    VALUES (?, ?, ?, ?, ?)
"""

vlozeno = 0
for kontakt in kontakty:
    cursor.execute(sql, kontakt)
    vlozeno += 1

connection.commit()
print(f"Vloženo {vlozeno} kontaktů.")

# Ověření
cursor.execute("SELECT COUNT(*) FROM studentXX.Kontakty")
row = cursor.fetchone()
print(f"Celkem kontaktů v tabulce: {row[0]}")

cursor.close()
connection.close()
```

---

## 3. Aktualizace a mazání z Pythonu (10 min)

### UPDATE

```python
# 09_aktualizace.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

# Aktualizace telefonu
novy_telefon = "777999000"
email = "jan@email.cz"

cursor.execute("""
    UPDATE studentXX.Kontakty
    SET Telefon = ?
    WHERE Email = ?
""", (novy_telefon, email))

connection.commit()
print(f"Aktualizován telefon pro {email}: {novy_telefon}")

# Ověření
cursor.execute(
    "SELECT Jmeno, Prijmeni, Telefon FROM studentXX.Kontakty WHERE Email = ?",
    (email,)
)
row = cursor.fetchone()
if row:
    print(f"  {row[0]} {row[1]}: {row[2]}")

cursor.close()
connection.close()
```

### DELETE

```python
# 10_mazani.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

email_smazat = "martin@email.cz"

# Nejdříve zobrazíme, co budeme mazat
cursor.execute(
    "SELECT Jmeno, Prijmeni FROM studentXX.Kontakty WHERE Email = ?",
    (email_smazat,)
)
row = cursor.fetchone()
if row:
    print(f"Mažu kontakt: {row[0]} {row[1]}")

    cursor.execute(
        "DELETE FROM studentXX.Kontakty WHERE Email = ?",
        (email_smazat,)
    )
    connection.commit()
    print("Kontakt smazán.")
else:
    print(f"Kontakt s e-mailem {email_smazat} nenalezen.")

cursor.close()
connection.close()
```

---

## 4. Transakce (10 min)

Transakce zajistí, že se buď provedou **všechny** změny, nebo **žádná**. Důležité pro konzistenci dat.

### Příklad: převod mezi účty

```python
# 11_transakce.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

# Vytvoření testovací tabulky účtů
cursor.execute("""
    IF NOT EXISTS (
        SELECT * FROM sys.tables
        WHERE name = 'Ucty' AND schema_id = SCHEMA_ID('studentXX')
    )
    CREATE TABLE studentXX.Ucty (
        UcetID INT PRIMARY KEY,
        Vlastnik NVARCHAR(50),
        Zustatek DECIMAL(10,2)
    )
""")
connection.commit()

# Naplnění daty
cursor.execute("DELETE FROM studentXX.Ucty")
cursor.execute("""
    INSERT INTO studentXX.Ucty (UcetID, Vlastnik, Zustatek) VALUES
    (1, 'Alice', 10000.00),
    (2, 'Bob', 5000.00)
""")
connection.commit()

# Převod 2000 Kč z Alice na Boba
castka = 2000.00

try:
    # Odečtení z účtu Alice
    cursor.execute(
        "UPDATE studentXX.Ucty SET Zustatek = Zustatek - ? WHERE UcetID = ?",
        (castka, 1)
    )

    # Přičtení na účet Boba
    cursor.execute(
        "UPDATE studentXX.Ucty SET Zustatek = Zustatek + ? WHERE UcetID = ?",
        (castka, 2)
    )

    # Pokud vše proběhlo bez chyby, potvrdíme
    connection.commit()
    print(f"Převod {castka} Kč proběhl úspěšně!")

except Exception as e:
    # Pokud nastala chyba, vrátíme vše zpět
    connection.rollback()
    print(f"Chyba při převodu: {e}")
    print("Vše vráceno do původního stavu.")

# Zobrazení zůstatků
cursor.execute("SELECT Vlastnik, Zustatek FROM studentXX.Ucty ORDER BY UcetID")
for row in cursor:
    print(f"  {row[0]}: {row[1]:.2f} Kč")

cursor.close()
connection.close()
```

Vysvětlení:
- `connection.commit()` – potvrdí všechny změny od posledního commitu
- `connection.rollback()` – zruší všechny změny od posledního commitu
- `try/except` – pokud nastane chyba, transakce se vrátí (`rollback`)

---

## 5. Praktický projekt: Správce kontaktů (30 min)

Vytvořte kompletní aplikaci pro správu kontaktů s textovým menu:

```python
# projekt_kontakty.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

# Nahraďte XX vaším číslem
SCHEMA = "studentXX"


def get_connection():
    """Vytvoří připojení k databázi."""
    return mssqlpython.connect(
        server=DB_SERVER,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )


def vytvor_tabulku():
    """Vytvoří tabulku Kontakty, pokud neexistuje."""
    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"""
            IF NOT EXISTS (
                SELECT * FROM sys.tables
                WHERE name = 'Kontakty' AND schema_id = SCHEMA_ID('{SCHEMA}')
            )
            CREATE TABLE {SCHEMA}.Kontakty (
                KontaktID INT IDENTITY(1,1) PRIMARY KEY,
                Jmeno NVARCHAR(50) NOT NULL,
                Prijmeni NVARCHAR(50) NOT NULL,
                Email NVARCHAR(100),
                Telefon NVARCHAR(20),
                Poznamka NVARCHAR(200),
                DatumVytvoreni DATETIME2 DEFAULT GETDATE()
            )
        """)
        connection.commit()
        cursor.close()
    finally:
        connection.close()


def zobraz_kontakty():
    """Zobrazí seznam všech kontaktů."""
    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"""
            SELECT KontaktID, Jmeno, Prijmeni, Email, Telefon
            FROM {SCHEMA}.Kontakty
            ORDER BY Prijmeni, Jmeno
        """)
        rows = cursor.fetchall()

        if not rows:
            print("\nŽádné kontakty v databázi.")
            return

        print(f"\n{'ID':<5} {'Jméno':<15} {'Příjmení':<15} {'E-mail':<25} {'Telefon':<15}")
        print("-" * 75)
        for row in rows:
            email = row[3] if row[3] else ""
            telefon = row[4] if row[4] else ""
            print(f"{row[0]:<5} {row[1]:<15} {row[2]:<15} {email:<25} {telefon:<15}")

        cursor.close()
    finally:
        connection.close()


def pridej_kontakt():
    """Přidá nový kontakt."""
    print("\n--- Nový kontakt ---")
    jmeno = input("Jméno: ").strip()
    prijmeni = input("Příjmení: ").strip()

    if not jmeno or not prijmeni:
        print("Jméno a příjmení jsou povinné!")
        return

    email = input("E-mail (volitelné): ").strip() or None
    telefon = input("Telefon (volitelné): ").strip() or None
    poznamka = input("Poznámka (volitelné): ").strip() or None

    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"""
            INSERT INTO {SCHEMA}.Kontakty (Jmeno, Prijmeni, Email, Telefon, Poznamka)
            VALUES (?, ?, ?, ?, ?)
        """, (jmeno, prijmeni, email, telefon, poznamka))
        connection.commit()
        print(f"Kontakt {jmeno} {prijmeni} přidán.")
        cursor.close()
    finally:
        connection.close()


def hledej_kontakt():
    """Vyhledá kontakt podle jména nebo příjmení."""
    hledany = input("\nHledaný text (jméno nebo příjmení): ").strip()
    if not hledany:
        return

    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"""
            SELECT KontaktID, Jmeno, Prijmeni, Email, Telefon, Poznamka
            FROM {SCHEMA}.Kontakty
            WHERE Jmeno LIKE ? OR Prijmeni LIKE ?
            ORDER BY Prijmeni, Jmeno
        """, (f"%{hledany}%", f"%{hledany}%"))

        rows = cursor.fetchall()

        if not rows:
            print(f"Žádný kontakt obsahující '{hledany}' nenalezen.")
        else:
            print(f"\nNalezeno {len(rows)} kontaktů:")
            for row in rows:
                poznamka = f" ({row[5]})" if row[5] else ""
                print(f"  [{row[0]}] {row[1]} {row[2]} | {row[3] or '-'} | {row[4] or '-'}{poznamka}")

        cursor.close()
    finally:
        connection.close()


def aktualizuj_kontakt():
    """Aktualizuje existující kontakt."""
    zobraz_kontakty()
    try:
        kontakt_id = int(input("\nZadejte ID kontaktu k aktualizaci: "))
    except ValueError:
        print("Neplatné ID.")
        return

    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"""
            SELECT Jmeno, Prijmeni, Email, Telefon
            FROM {SCHEMA}.Kontakty WHERE KontaktID = ?
        """, (kontakt_id,))

        row = cursor.fetchone()
        if not row:
            print("Kontakt nenalezen.")
            return

        print(f"\nAktuální údaje: {row[0]} {row[1]} | {row[2]} | {row[3]}")
        print("(Stiskněte Enter pro ponechání aktuální hodnoty)")

        email = input(f"Nový e-mail [{row[2]}]: ").strip() or row[2]
        telefon = input(f"Nový telefon [{row[3]}]: ").strip() or row[3]

        cursor.execute(f"""
            UPDATE {SCHEMA}.Kontakty
            SET Email = ?, Telefon = ?
            WHERE KontaktID = ?
        """, (email, telefon, kontakt_id))
        connection.commit()
        print("Kontakt aktualizován.")
        cursor.close()
    finally:
        connection.close()


def smaz_kontakt():
    """Smaže kontakt podle ID."""
    zobraz_kontakty()
    try:
        kontakt_id = int(input("\nZadejte ID kontaktu ke smazání: "))
    except ValueError:
        print("Neplatné ID.")
        return

    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"""
            SELECT Jmeno, Prijmeni FROM {SCHEMA}.Kontakty WHERE KontaktID = ?
        """, (kontakt_id,))

        row = cursor.fetchone()
        if not row:
            print("Kontakt nenalezen.")
            return

        potvrzeni = input(f"Opravdu smazat {row[0]} {row[1]}? (a/n): ").strip().lower()
        if potvrzeni == "a":
            cursor.execute(f"""
                DELETE FROM {SCHEMA}.Kontakty WHERE KontaktID = ?
            """, (kontakt_id,))
            connection.commit()
            print("Kontakt smazán.")
        else:
            print("Mazání zrušeno.")

        cursor.close()
    finally:
        connection.close()


def hlavni_menu():
    """Hlavní smyčka programu."""
    vytvor_tabulku()

    while True:
        print("\n===== SPRÁVCE KONTAKTŮ =====")
        print("1. Zobrazit všechny kontakty")
        print("2. Přidat kontakt")
        print("3. Hledat kontakt")
        print("4. Aktualizovat kontakt")
        print("5. Smazat kontakt")
        print("0. Konec")
        print("============================")

        volba = input("Vaše volba: ").strip()

        if volba == "1":
            zobraz_kontakty()
        elif volba == "2":
            pridej_kontakt()
        elif volba == "3":
            hledej_kontakt()
        elif volba == "4":
            aktualizuj_kontakt()
        elif volba == "5":
            smaz_kontakt()
        elif volba == "0":
            print("Nashledanou!")
            break
        else:
            print("Neplatná volba.")


if __name__ == "__main__":
    hlavni_menu()
```

---

## 6. Rozšíření projektu – samostatná práce (10 min)

Pokud máte hotovo, zkuste projekt rozšířit o:

1. **Export do CSV** – přidejte funkci, která uloží kontakty do souboru CSV
2. **Import z CSV** – přidejte funkci pro načtení kontaktů ze souboru
3. **Statistika** – zobrazení celkového počtu kontaktů, počtu kontaktů s e-mailem/telefonem

### Nápověda pro export do CSV

```python
import csv

def export_csv():
    """Exportuje kontakty do CSV souboru."""
    connection = get_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(f"SELECT Jmeno, Prijmeni, Email, Telefon FROM {SCHEMA}.Kontakty")
        rows = cursor.fetchall()

        with open("kontakty.csv", "w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            writer.writerow(["Jmeno", "Prijmeni", "Email", "Telefon"])
            writer.writerows(rows)

        print(f"Exportováno {len(rows)} kontaktů do kontakty.csv")
        cursor.close()
    finally:
        connection.close()
```

---

## Shrnutí lekce

- Z Pythonu lze spouštět libovolné SQL příkazy: `CREATE TABLE`, `INSERT`, `UPDATE`, `DELETE`
- `connection.commit()` potvrdí změny, `connection.rollback()` je zruší
- Transakce zajistí konzistenci dat – buď se provedou všechny změny, nebo žádná
- Vzor `try/finally` zajistí uzavření připojení i při chybě
- Praktický projekt kombinuje všechny naučené dovednosti: SQL dotazy, DML příkazy a Python logiku
