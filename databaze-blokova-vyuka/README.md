# Bloková výuka databáze

Dvoudenní bloková výuka (8 lekcí × 90 minut) zaměřená na úvod do relačních databází pro studenty střední IT školy. Studenti jsou začátečníci v databázích, ale znají Python.

## Přehled lekcí

### Den 1 – SQL a dotazování

| Lekce | Téma | Soubor |
|---|---|---|
| 1 | Úvod do databází – pojmy, připojení k Azure SQL | [den1-lekce01](lekce/den1-lekce01-uvod-do-databazi.md) |
| 2 | První SQL dotazy – SELECT, WHERE, ORDER BY | [den1-lekce02](lekce/den1-lekce02-prvni-sql-dotazy.md) |
| 3 | Agregační funkce – COUNT, SUM, AVG, GROUP BY, HAVING | [den1-lekce03](lekce/den1-lekce03-agregace-a-seskupovani.md) |
| 4 | Vazby mezi tabulkami – INNER JOIN, LEFT JOIN | [den1-lekce04](lekce/den1-lekce04-join-vazby-mezi-tabulkami.md) |
| **Test** | Ověření znalostí z dne 1 | [den1-test](testy/den1-test.md) |

### Den 2 – Návrh, tvorba a Python

| Lekce | Téma | Soubor |
|---|---|---|
| 5 | Normalizace a návrh databáze – 1NF, 2NF, 3NF | [den2-lekce05](lekce/den2-lekce05-normalizace-a-navrh.md) |
| 6 | Vytváření tabulek a DML – CREATE, INSERT, UPDATE, DELETE | [den2-lekce06](lekce/den2-lekce06-vytvareni-tabulek-a-dml.md) |
| 7 | Python a databáze – čtení dat (mssql-python) | [den2-lekce07](lekce/den2-lekce07-python-cteni-dat.md) |
| 8 | Python a databáze – zápis dat, praktický projekt | [den2-lekce08](lekce/den2-lekce08-python-zapis-projekt.md) |
| **Test** | Ověření znalostí z dne 2 | [den2-test](testy/den2-test.md) |

## Technické prostředí

- **Databáze:** Azure SQL Database se vzorovou databází AdventureWorksLT
- **Nástroje:** Visual Studio Code + rozšíření mssql, Python s modulem `mssql-python`
- **Přístup studentů:**
  - Čtení: schéma `SalesLT` (vzorová data)
  - Zápis: vlastní schéma `studentXX` (tvorba tabulek, zápis dat)

## Vytvoření prostředí

Příprava prostředí se skládá ze tří kroků. Všechny potřebné skripty jsou ve složce [`setup/`](setup/).

### Krok 1: Vytvoření Azure SQL Serveru a databáze

Skript [`setup/database_setup.ps1`](setup/database_setup.ps1) vytvoří resource group, Azure SQL logical server s firewall pravidlem a databázi AdventureWorksLT. Vyžaduje nainstalovaný modul `Az` pro PowerShell a přihlášení do Azure (`Connect-AzAccount`).

```powershell
.\setup\database_setup.ps1 `
    -resourceGroup "RG-Database-Lab" `
    -location "westeurope" `
    -sqlServerName "sql-lab-server-001" `
    -sqlAdminUser "sqladmin" `
    -databaseName "AdventureWorksLT" `
    -allowIPRange "10.1.0.0/24"
```

Parametry:

| Parametr | Popis |
|---|---|
| `resourceGroup` | Název Azure resource group |
| `location` | Azure region (např. `westeurope`) |
| `sqlServerName` | Globálně unikátní název SQL serveru |
| `sqlAdminUser` | Uživatelské jméno administrátora |
| `databaseName` | Název databáze |
| `allowIPRange` | Povolený rozsah IP adres ve formátu CIDR (např. IP adresa školní sítě) |

Skript se interaktivně zeptá na heslo administrátora.

### Krok 2: Vytvoření studentských účtů

Po vytvoření databáze spusťte skript [`setup/database_setup.sql`](setup/database_setup.sql) proti vytvořené databázi (např. přes VS Code s rozšířením mssql nebo přes Azure Portal Query Editor). Skript:

1. Vytvoří roli `db_students` s oprávněním `SELECT` na schéma `SalesLT`
2. Pro každého studenta vytvoří contained uživatele s náhodným heslem
3. Každému studentovi vytvoří vlastní schéma (`student01`, `student02`, ...) s oprávněním vytvářet tabulky, pohledy a procedury
4. Na konci vypíše tabulku s přihlašovacími údaji (uživatel + heslo) pro distribuci studentům

Počet studentů a prefix uživatelských jmen lze upravit na začátku skriptu:

```sql
DECLARE @UserCount INT = 10;        -- počet studentů
DECLARE @UserPrefix SYSNAME = N'student';  -- prefix jména (student01, student02, ...)
```

### Krok 3 (volitelné): Vytvoření read-only uživatele

Skript [`setup/add_readonly_user.sql`](setup/add_readonly_user.sql) vytvoří uživatele s oprávněním pouze pro čtení (`db_datareader`). Hodí se například pro demonstrační účet vyučujícího nebo pro sdílený přístup. Před spuštěním upravte uživatelské jméno a heslo ve skriptu.

