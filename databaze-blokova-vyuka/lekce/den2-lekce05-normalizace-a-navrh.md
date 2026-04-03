# Den 2 – Lekce 5: Normalizace a návrh databáze (90 min)

## Cíle lekce

- Pochopit, co je normalizace a proč je důležitá
- Rozpoznat problémy nenormalizované databáze
- Znát první tři normální formy (1NF, 2NF, 3NF)
- Umět navrhnout jednoduchou strukturu tabulek

---

## 1. Proč normalizovat (15 min)

### Špatný příklad: vše v jedné tabulce

Představte si e-shop, kde máme vše v jedné tabulce:

| ObjednavkaID | Zakaznik | Email | Produkt | Cena | Pocet | DatumObj |
|---|---|---|---|---|---|---|
| 1 | Jan Novák | jan@email.cz | Klávesnice | 500 | 1 | 2025-01-15 |
| 1 | Jan Novák | jan@email.cz | Myš | 300 | 2 | 2025-01-15 |
| 2 | Eva Malá | eva@email.cz | Monitor | 5000 | 1 | 2025-01-16 |
| 3 | Jan Novák | jan@email.cz | Klávesnice | 500 | 1 | 2025-01-20 |

### Problémy (anomálie)

1. **Redundance dat** – jméno „Jan Novák" a jeho e-mail se opakují. Pokud Jan změní e-mail, musíme ho aktualizovat na více místech.

2. **Aktualizační anomálie** – změníme e-mail Jana Nováka u objednávky 1, ale zapomeneme u objednávky 3. Data jsou nekonzistentní.

3. **Vkládací anomálie** – nemůžeme přidat nového zákazníka, dokud si něco neobjedná (nemáme kam uložit jen zákazníka).

4. **Mazací anomálie** – pokud smažeme objednávku 2, ztratíme veškeré informace o zákazníkovi Eva Malá.

### Řešení: normalizace

Normalizace je proces rozdělení jedné velké tabulky do více menších tabulek, které jsou propojeny pomocí klíčů. Cílem je odstranit redundanci a anomálie.

---

## 2. První normální forma – 1NF (15 min)

### Pravidlo

Tabulka je v 1NF, pokud:
- Každý sloupec obsahuje **atomické** (nedělitelné) hodnoty
- Žádný sloupec neobsahuje **seznam** nebo **opakující se skupiny**

### Špatně (porušení 1NF)

| StudentID | Jmeno | Telefony |
|---|---|---|
| 1 | Jan Novák | 777111222, 602333444 |
| 2 | Eva Malá | 608555666 |

Sloupec `Telefony` obsahuje více hodnot – to porušuje 1NF.

### Správně (1NF)

**Tabulka Studenti:**

| StudentID | Jmeno |
|---|---|
| 1 | Jan Novák |
| 2 | Eva Malá |

**Tabulka Telefony:**

| TelefonID | StudentID | Telefon |
|---|---|---|
| 1 | 1 | 777111222 |
| 2 | 1 | 602333444 |
| 3 | 2 | 608555666 |

Každý sloupec nyní obsahuje jedinou hodnotu.

---

## 3. Druhá normální forma – 2NF (15 min)

### Pravidlo

Tabulka je v 2NF, pokud:
- Je v 1NF
- Každý neklíčový sloupec závisí na **celém** primárním klíči (ne jen na jeho části)

Toto pravidlo se uplatňuje u tabulek se **složeným primárním klíčem** (PK ze dvou a více sloupců).

### Špatně (porušení 2NF)

Tabulka s položkami objednávek (PK = `ObjednavkaID` + `ProduktID`):

| ObjednavkaID | ProduktID | NazevProduktu | CenaProduktu | Pocet |
|---|---|---|---|---|
| 1 | 101 | Klávesnice | 500 | 1 |
| 1 | 102 | Myš | 300 | 2 |
| 2 | 101 | Klávesnice | 500 | 1 |

Problém: `NazevProduktu` a `CenaProduktu` závisí jen na `ProduktID`, ne na celém klíči (`ObjednavkaID` + `ProduktID`). Název produktu „Klávesnice" se opakuje.

### Správně (2NF)

**Tabulka Produkty:**

| ProduktID | NazevProduktu | CenaProduktu |
|---|---|---|
| 101 | Klávesnice | 500 |
| 102 | Myš | 300 |

**Tabulka PolozkyObjednavek:**

| ObjednavkaID | ProduktID | Pocet |
|---|---|---|
| 1 | 101 | 1 |
| 1 | 102 | 2 |
| 2 | 101 | 1 |

Informace o produktu je uložena jen jednou. Vazba je přes `ProduktID`.

---

## 4. Třetí normální forma – 3NF (15 min)

### Pravidlo

Tabulka je v 3NF, pokud:
- Je v 2NF
- Žádný neklíčový sloupec nezávisí na jiném neklíčovém sloupci (žádná **tranzitivní závislost**)

### Špatně (porušení 3NF)

| ZamestnanecID | Jmeno | OddeleniID | NazevOddeleni |
|---|---|---|---|
| 1 | Jan Novák | 10 | IT |
| 2 | Eva Malá | 20 | Marketing |
| 3 | Petr Černý | 10 | IT |

Problém: `NazevOddeleni` závisí na `OddeleniID`, ne přímo na `ZamestnanecID`. Název „IT" se opakuje.

### Správně (3NF)

**Tabulka Zamestnanci:**

| ZamestnanecID | Jmeno | OddeleniID |
|---|---|---|
| 1 | Jan Novák | 10 |
| 2 | Eva Malá | 20 |
| 3 | Petr Černý | 10 |

**Tabulka Oddeleni:**

| OddeleniID | NazevOddeleni |
|---|---|
| 10 | IT |
| 20 | Marketing |

---

## 5. Normalizace na příkladu AdventureWorksLT (10 min)

Podívejme se, jak je AdventureWorksLT správně normalizovaná:

### Oddělení zákazníků od objednávek (2NF/3NF)

```
SalesLT.Customer (CustomerID, FirstName, LastName, EmailAddress, ...)
    ↓ 1:N
SalesLT.SalesOrderHeader (SalesOrderID, CustomerID, OrderDate, TotalDue, ...)
    ↓ 1:N
SalesLT.SalesOrderDetail (SalesOrderID, SalesOrderDetailID, ProductID, OrderQty, ...)
```

- Zákazník je uložen jednou v `Customer`
- Objednávka odkazuje na zákazníka přes `CustomerID`
- Položky objednávky odkazují na objednávku přes `SalesOrderID` a na produkt přes `ProductID`

### Hierarchie kategorií (3NF)

```
SalesLT.ProductCategory (ProductCategoryID, ParentProductCategoryID, Name)
    ↓ 1:N
SalesLT.Product (ProductID, ProductCategoryID, Name, ListPrice, ...)
```

- Kategorie jsou v samostatné tabulce
- Produkt odkazuje na kategorii přes `ProductCategoryID`
- Název kategorie se neopakuje u každého produktu

### Vazba M:N přes vazební tabulku

Vztah zákazník–adresa je M:N (zákazník může mít více adres, adresa může patřit více zákazníkům):

```
SalesLT.Customer ←→ SalesLT.CustomerAddress ←→ SalesLT.Address
```

Vazební tabulka `CustomerAddress` má složený PK (`CustomerID` + `AddressID`) a navíc sloupec `AddressType` (fakturační/dodací).

---

## 6. Typy vazeb – shrnutí (5 min)

| Vazba | Popis | Příklad v AdventureWorksLT |
|---|---|---|
| **1:1** | Jeden záznam odpovídá jednomu | (méně časté) |
| **1:N** | Jeden záznam na straně 1 má N záznamů na straně N | Customer → SalesOrderHeader |
| **M:N** | Mnoho záznamů na obou stranách, řeší se vazební tabulkou | Customer ↔ CustomerAddress ↔ Address |

---

## 7. Praktické cvičení: Návrh databáze (15 min)

### Zadání

Navrhněte strukturu tabulek pro jednoduchou **školní knihovnu**:
- Evidence knih (název, autor, rok vydání, ISBN)
- Evidence studentů (jméno, třída)
- Evidence výpůjček (kdo si co půjčil, kdy, kdy vrátil)
- Jeden student si může půjčit více knih, jednu knihu si může postupně půjčit více studentů

Přemýšlejte:
1. Jaké tabulky potřebujete?
2. Jaké sloupce budou mít?
3. Jaké budou primární a cizí klíče?
4. Jaká je vazba mezi studenty a knihami?

### Vzorové řešení

<details>
<summary>Klikněte pro zobrazení řešení</summary>

```
Tabulka: Knihy
- KnihaID (PK, INT)
- Nazev (NVARCHAR(200))
- Autor (NVARCHAR(100))
- RokVydani (INT)
- ISBN (NVARCHAR(20))

Tabulka: Studenti
- StudentID (PK, INT)
- Jmeno (NVARCHAR(100))
- Trida (NVARCHAR(10))

Tabulka: Vypujcky (vazební tabulka - řeší M:N)
- VypujckaID (PK, INT)
- StudentID (FK → Studenti.StudentID)
- KnihaID (FK → Knihy.KnihaID)
- DatumVypujcky (DATE)
- DatumVraceni (DATE, NULL = ještě nevráceno)
```

Vazba Student–Kniha je M:N, řešená přes vazební tabulku `Vypujcky`.

</details>

---

## Shrnutí lekce

- **Normalizace** odstraňuje redundanci dat a předchází anomáliím (aktualizační, vkládací, mazací)
- **1NF**: každý sloupec obsahuje jedinou atomickou hodnotu
- **2NF**: neklíčové sloupce závisí na celém primárním klíči
- **3NF**: žádné tranzitivní závislosti mezi neklíčovými sloupci
- Vazby **1:N** se řeší cizím klíčem, vazby **M:N** se řeší vazební tabulkou
- AdventureWorksLT je příkladem správně normalizované databáze
