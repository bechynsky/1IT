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

