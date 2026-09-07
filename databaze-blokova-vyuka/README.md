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

## Audit přihlášení a aktivity studentů

Azure SQL Auditing umožňuje vyučujícímu ověřit, kdy se jednotliví studenti připojili k databázi a jaké typy databázových akcí prováděli. Samotné úspěšné přihlášení potvrzuje pouze navázání spojení. Pro kontrolu práce na úkolu sledujte také sloupec `action_name_s` a navazující události dotazů nebo změn v databázi.

### Zapnutí auditu do Log Analytics

1. V Azure Portal otevřete vytvořený **SQL server** nebo konkrétní **SQL database**.
2. V části **Auditing** zapněte auditování.
3. Jako cíl zvolte **Log Analytics workspace** a vyberte pracovní prostor, do kterého se mají auditní záznamy odesílat.
4. Nastavení uložte a proveďte zkušební přihlášení studentským účtem. První záznamy se mohou objevit s několikaminutovým zpožděním.
5. Otevřete vybraný Log Analytics workspace, přejděte do části **Logs** a spusťte KQL dotaz níže.

Audit nastavujte buď na úrovni serveru, nebo databáze. Současné zapnutí na obou úrovních může vytvářet duplicitní záznamy. Pro čtení logů potřebuje vyučující například roli **Log Analytics Reader** nad daným workspace.

### Přehled posledních auditních událostí

```kql
AzureDiagnostics
| where Category == "SQLSecurityAuditEvents"
| project TimeGenerated,
          server_principal_name_s,
          database_name_s,
          client_ip_s,
          action_name_s 
| order by TimeGenerated desc
```

Význam sloupců:

| Sloupec | Význam |
|---|---|
| `TimeGenerated` | Čas zaznamenání události v UTC |
| `server_principal_name_s` | Přihlášený databázový uživatel, například `student01` |
| `database_name_s` | Databáze, ve které událost vznikla |
| `client_ip_s` | Veřejná IP adresa klienta |
| `action_name_s` | Název provedené nebo auditované akce |

### Studenti přihlášení během poslední hodiny

Následující dotaz vypíše unikátní uživatelské účty, které se během poslední hodiny úspěšně přihlásily k databázi:

```kql
AzureDiagnostics
| where Category == "SQLSecurityAuditEvents"
| where action_name_s == "DATABASE AUTHENTICATION SUCCEEDED"
| where TimeGenerated > ago(1h)
| summarize by server_principal_name_s
| sort by server_principal_name_s
```

Dotaz postupně:

1. Vybere auditní události zabezpečení Azure SQL.
2. Ponechá pouze úspěšná přihlášení k databázi.
3. Omezí výsledky na posledních 60 minut.
4. Pomocí `summarize by` sloučí opakovaná přihlášení stejného účtu do jednoho řádku.
5. Seřadí uživatelská jména abecedně.

Výsledkem je seznam studentů, kteří se v daném období alespoň jednou úspěšně připojili. Dotaz neukazuje počet ani čas jednotlivých přihlášení a sám o sobě nedokládá práci na úkolu. Tu je potřeba ověřit pomocí dalších auditních událostí.

Pro rychlejší kontrolu konkrétní hodiny lze dotaz omezit časem a studentem:

```kql
AzureDiagnostics
| where TimeGenerated > ago(2h)
| where Category == "SQLSecurityAuditEvents"
| where server_principal_name_s == "student01"
| project TimeGenerated,
          server_principal_name_s,
          database_name_s,
          client_ip_s,
          action_name_s
| order by TimeGenerated desc
```

Auditní data obsahují identifikátory uživatelů a IP adresy. Přístup k nim omezte pouze na pověřené osoby, nastavte přiměřenou dobu uchování a používejte je v souladu se školními pravidly a zásadami ochrany osobních údajů.

