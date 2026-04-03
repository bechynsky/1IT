# Den 2 – Lekce 7: Python a databáze – čtení dat (90 min)

## Cíle lekce

- Nainstalovat a nakonfigurovat modul `mssql-python`
- Připojit se k Azure SQL Database z Pythonu
- Načítat data pomocí SQL dotazů
- Zpracovat výsledky v Pythonu (seznamy, cykly, výpis)

---

## 1. Příprava prostředí (15 min)

### Instalace modulu mssql-python

Modul `mssql-python` je oficiální Microsoft driver pro přístup k SQL Serveru z Pythonu.

Otevřete terminál ve VS Code (Ctrl+`) a spusťte:

```bash
pip install mssql-python
```

> Pokud máte nainstalovaný Python pod jiným názvem, použijte `pip3 install mssql-python` nebo `python -m pip install mssql-python`.

### Ověření instalace

```python
import mssqlpython
print("Modul mssql-python je nainstalován!")
```

### Vytvoření konfiguračního souboru

Vytvořte soubor `config.py` s přihlašovacími údaji. Tento soubor budeme importovat v dalších skriptech:

```python
# config.py
# Přihlašovací údaje k Azure SQL Database
# POZOR: Tento soubor nikdy nenahrávejte na GitHub ani nesdílejte!

DB_SERVER = "<název-serveru>.database.windows.net"
DB_NAME = "<název-databáze>"
DB_USER = "studentXX"           # Nahraďte XX vaším číslem
DB_PASSWORD = "vaše-heslo"      # Heslo od vyučujícího
```

> **Bezpečnost:** V profesionální praxi se hesla ukládají do proměnných prostředí nebo do bezpečných úložišť (Azure Key Vault). Pro školní účely použijeme konfigurační soubor, ale nikdy ho nesdílejte.

---

## 2. Připojení k databázi (20 min)

### Základní připojení a jednoduchý dotaz

Vytvořte soubor `01_pripojeni.py`:

```python
# 01_pripojeni.py
import mssqlpython

# Přihlašovací údaje
server = "<název-serveru>.database.windows.net"
database = "<název-databáze>"
user = "studentXX"
password = "vaše-heslo"

# Vytvoření připojení
connection = mssqlpython.connect(
    server=server,
    database=database,
    user=user,
    password=password
)

print("Připojení k databázi bylo úspěšné!")

# Vytvoření kurzoru pro provádění dotazů
cursor = connection.cursor()

# Jednoduchý dotaz
cursor.execute("SELECT TOP 5 FirstName, LastName FROM SalesLT.Customer")

# Načtení všech výsledků
rows = cursor.fetchall()

# Výpis výsledků
for row in rows:
    print(f"Zákazník: {row[0]} {row[1]}")

# Uzavření kurzoru a připojení
cursor.close()
connection.close()

print("Připojení uzavřeno.")
```

### Vysvětlení klíčových kroků

1. `mssqlpython.connect(...)` – vytvoří spojení s databází
2. `connection.cursor()` – vytvoří kurzor (objekt pro provádění dotazů)
3. `cursor.execute(sql)` – provede SQL dotaz
4. `cursor.fetchall()` – načte všechny řádky výsledku jako seznam
5. `cursor.close()` a `connection.close()` – uvolní prostředky

---

## 3. Práce s výsledky dotazů (20 min)

### Různé způsoby čtení výsledků

Vytvořte soubor `02_cteni_dat.py`:

```python
# 02_cteni_dat.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

# --- fetchall() - načte všechny řádky najednou ---
print("=== Všechny červené produkty ===")
cursor.execute("""
    SELECT Name, ListPrice
    FROM SalesLT.Product
    WHERE Color = 'Red'
    ORDER BY ListPrice DESC
""")

products = cursor.fetchall()
print(f"Nalezeno {len(products)} červených produktů\n")

for product in products:
    name = product[0]
    price = product[1]
    print(f"  {name}: {price} Kč")

# --- fetchone() - načte jeden řádek ---
print("\n=== Nejdražší produkt ===")
cursor.execute("""
    SELECT TOP 1 Name, ListPrice
    FROM SalesLT.Product
    ORDER BY ListPrice DESC
""")

row = cursor.fetchone()
if row:
    print(f"  {row[0]}: {row[1]} Kč")

# --- Iterace přímo přes kurzor ---
print("\n=== Kategorie produktů ===")
cursor.execute("SELECT Name FROM SalesLT.ProductCategory ORDER BY Name")

for row in cursor:
    print(f"  - {row[0]}")

cursor.close()
connection.close()
```

### Práce s parametry – ochrana proti SQL injection

**Nikdy** nevkládejte uživatelský vstup přímo do SQL řetězce! Používejte parametrizované dotazy:

```python
# 03_parametry.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

# --- ŠPATNĚ (SQL injection riziko!) ---
# barva = input("Zadejte barvu: ")
# cursor.execute(f"SELECT Name FROM SalesLT.Product WHERE Color = '{barva}'")

# --- SPRÁVNĚ (parametrizovaný dotaz) ---
barva = input("Zadejte barvu produktu (Red/Blue/Black): ")

cursor.execute(
    "SELECT Name, ListPrice FROM SalesLT.Product WHERE Color = ? ORDER BY ListPrice DESC",
    (barva,)
)

rows = cursor.fetchall()
print(f"\nProdukty barvy '{barva}':")
for row in rows:
    print(f"  {row[0]}: {row[1]} Kč")

cursor.close()
connection.close()
```

Vysvětlení:
- `?` je **zástupný symbol** (placeholder) pro parametr
- Parametry se předávají jako tuple: `(barva,)` – čárka za hodnotou je důležitá pro jednoprvkový tuple
- Databázový driver se postará o bezpečné vložení hodnoty

---

## 4. Bezpečné používání with (10 min)

### Context manager pattern

Použití `with` zajistí, že se připojení uzavře i v případě chyby. Vlastní wrapper:

```python
# 04_with_pattern.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

def get_connection():
    """Vytvoří a vrátí připojení k databázi."""
    return mssqlpython.connect(
        server=DB_SERVER,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )

# Bezpečný přístup – try/finally
connection = get_connection()
try:
    cursor = connection.cursor()
    cursor.execute("""
        SELECT
            c.FirstName + ' ' + c.LastName AS Zakaznik,
            COUNT(o.SalesOrderID) AS PocetObjednavek
        FROM SalesLT.Customer AS c
        LEFT JOIN SalesLT.SalesOrderHeader AS o
            ON c.CustomerID = o.CustomerID
        GROUP BY c.FirstName, c.LastName
        HAVING COUNT(o.SalesOrderID) > 0
        ORDER BY PocetObjednavek DESC
    """)

    print("Zákazníci s objednávkami:")
    for row in cursor:
        print(f"  {row[0]}: {row[1]} objednávek")

    cursor.close()
finally:
    connection.close()
    print("\nPřipojení uzavřeno.")
```

---

## 5. Praktický příklad: Reporty z databáze (10 min)

### Report: Produkty podle kategorie

```python
# 05_report_kategorie.py
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER,
    database=DB_NAME,
    user=DB_USER,
    password=DB_PASSWORD
)
cursor = connection.cursor()

cursor.execute("""
    SELECT
        pc.Name AS Kategorie,
        COUNT(p.ProductID) AS PocetProduktu,
        ROUND(AVG(p.ListPrice), 2) AS PrumernaCena,
        MIN(p.ListPrice) AS MinCena,
        MAX(p.ListPrice) AS MaxCena
    FROM SalesLT.Product AS p
    INNER JOIN SalesLT.ProductCategory AS pc
        ON p.ProductCategoryID = pc.ProductCategoryID
    GROUP BY pc.Name
    ORDER BY PocetProduktu DESC
""")

print(f"{'Kategorie':<30} {'Počet':>6} {'Průměr':>10} {'Min':>10} {'Max':>10}")
print("-" * 70)

for row in cursor:
    kategorie, pocet, prumer, min_cena, max_cena = row
    print(f"{kategorie:<30} {pocet:>6} {prumer:>10.2f} {min_cena:>10.2f} {max_cena:>10.2f}")

cursor.close()
connection.close()
```

---

## 6. Procvičování (15 min)

### Úkol 1: Vyhledávač produktů

Napište Python skript, který:
1. Požádá uživatele o zadání hledaného textu
2. Vyhledá produkty, jejichž název obsahuje zadaný text (LIKE)
3. Vypíše název, barvu a cenu nalezených produktů
4. Používá parametrizovaný dotaz

### Úkol 2: Statistika objednávek

Napište skript, který zobrazí:
1. Celkový počet objednávek
2. Celkovou hodnotu všech objednávek
3. Průměrnou hodnotu objednávky
4. Datum nejstarší a nejnovější objednávky

---

### Řešení

<details>
<summary>Klikněte pro zobrazení řešení</summary>

```python
# Úkol 1: Vyhledávač produktů
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

hledany_text = input("Zadejte hledaný text v názvu produktu: ")

connection = mssqlpython.connect(
    server=DB_SERVER, database=DB_NAME,
    user=DB_USER, password=DB_PASSWORD
)
cursor = connection.cursor()

# Přidáme % kolem hledaného textu pro LIKE
cursor.execute(
    """SELECT Name, Color, ListPrice
       FROM SalesLT.Product
       WHERE Name LIKE ?
       ORDER BY ListPrice DESC""",
    (f"%{hledany_text}%",)
)

rows = cursor.fetchall()
print(f"\nNalezeno {len(rows)} produktů obsahujících '{hledany_text}':\n")
for row in rows:
    barva = row[1] if row[1] else "N/A"
    print(f"  {row[0]} | Barva: {barva} | Cena: {row[2]} Kč")

cursor.close()
connection.close()
```

```python
# Úkol 2: Statistika objednávek
from config import DB_SERVER, DB_NAME, DB_USER, DB_PASSWORD
import mssqlpython

connection = mssqlpython.connect(
    server=DB_SERVER, database=DB_NAME,
    user=DB_USER, password=DB_PASSWORD
)
cursor = connection.cursor()

cursor.execute("""
    SELECT
        COUNT(*) AS PocetObjednavek,
        SUM(TotalDue) AS CelkovaHodnota,
        ROUND(AVG(TotalDue), 2) AS PrumernaHodnota,
        MIN(OrderDate) AS NejstarsiObj,
        MAX(OrderDate) AS NejnovejsiObj
    FROM SalesLT.SalesOrderHeader
""")

row = cursor.fetchone()
print("=== Statistika objednávek ===")
print(f"  Počet objednávek:    {row[0]}")
print(f"  Celková hodnota:     {row[1]:.2f} Kč")
print(f"  Průměrná hodnota:    {row[2]:.2f} Kč")
print(f"  Nejstarší objednávka: {row[3]}")
print(f"  Nejnovější objednávka: {row[4]}")

cursor.close()
connection.close()
```

</details>

---

## Shrnutí lekce

- Modul `mssql-python` umožňuje přístup k MS SQL z Pythonu
- Postup: `connect()` → `cursor()` → `execute()` → `fetchall()/fetchone()` → `close()`
- `fetchall()` vrátí všechny řádky, `fetchone()` vrátí jeden řádek
- **Vždy používejte parametrizované dotazy** (`?`) – ochrana proti SQL injection
- Připojení vždy uzavírejte pomocí `close()` nebo vzoru `try/finally`
