# Digitální kompetence 2025/2026 - výukový materiál

Tento dokument slouží jako příprava k maturitním otázkám z digitálních kompetencí. Cílem není naučit se text nazpaměť, ale umět o každém tématu mluvit souvisle přibližně 15 minut: vysvětlit základní pojmy, princip fungování, uvést příklady z praxe, ukázat praktickou dovednost a zmínit rizika nebo limity.

## Jak stavět odpověď na 15 minut

U většiny témat funguje tato jednoduchá struktura:

1. **Krátké uvedení tématu** - co daný pojem znamená a proč je důležitý.
2. **Vysvětlení principu** - jak technologie, proces nebo oblast funguje.
3. **Příklady z praxe** - kde se s tím student setká ve škole, v práci nebo v běžném životě.
4. **Výhody, nevýhody, rizika** - co daná věc přináší a na co si dát pozor.
5. **Praktická ukázka** - příkaz, web, aplikace, diagram, soubor nebo scénář.
6. **Závěrečné shrnutí** - 3 až 5 vět, které jasně odpoví na hlavní otázku.

---

## 1. Síť Internet, TCP/IP, HTTP, DNS a další protokoly, CZ.NIC

### Osnova odpovědi

- Co je internet a proč nejde jen o jednu síť.
- Jakou roli mají IP adresa, TCP/IP, porty a protokoly.
- DNS, DHCP, HTTP/HTTPS, FTP, SMTP, IMAP, POP3.
- Rozdíl mezi IPv4 a IPv6, veřejnou a privátní IP adresou.
- Domény, TLD, doména 2. a 3. řádu, role CZ.NIC.
- Praktická ukázka: IP adresa, MAC adresa, veřejná IP, vlastník IP.

### Výukový text

Internet je celosvětová síť propojených počítačových sítí. Není to jedna centrální služba ani jeden kabel, ale obrovský systém routerů, serverů, klientských zařízení, poskytovatelů připojení a pravidel komunikace. Aby si zařízení rozuměla, používají protokoly. Nejdůležitější sada protokolů se nazývá TCP/IP. IP řeší adresování a směrování dat mezi zařízeními, TCP se stará o spolehlivé doručení dat a jejich správné pořadí.

IP adresa je číselná adresa zařízení v síti. IPv4 adresa má čtyři části oddělené tečkami, každá část může být od 0 do 255. Z uvedených adres není platná `10.129.280.1`, protože číslo `280` je větší než 255. Adresy `192.168.0.2`, `172.16.0.1` a rozsah `10.x.x.x` jsou typicky privátní adresy používané uvnitř domácích nebo firemních sítí. `127.0.0.1` je loopback, tedy adresa vlastního počítače. `195.39.44.178` vypadá jako veřejná IPv4 adresa.

IPv4 adres postupně začalo být málo, proto vzniklo IPv6. IPv6 používá mnohem delší adresy zapisované šestnáctkově, například `2001:db8::1`. Výhodou IPv6 je obrovský adresní prostor, lepší možnosti automatické konfigurace a jednodušší přímé adresování zařízení. V praxi ale stále často existují IPv4 a IPv6 vedle sebe.

DNS je systém, který překládá doménová jména na IP adresy. Člověk si lépe pamatuje `seznam.cz` než konkrétní IP adresu serveru. DHCP je služba, která zařízení v síti automaticky přidělí IP adresu, masku sítě, bránu a DNS servery. Bez DHCP bychom tyto hodnoty často museli nastavovat ručně.

TCP a UDP se liší způsobem přenosu. TCP je spolehlivé: naváže spojení, kontroluje doručení a v případě ztráty data pošle znovu. Používá se například pro web, e-mail nebo přenos souborů. UDP je rychlejší, ale nezaručuje doručení každého paketu. Hodí se pro videohovory, online hry, streamování nebo DNS dotazy, kde je důležitá nízká latence.

HTTP je protokol pro přenos webových stránek. HTTPS je HTTP zabezpečené pomocí TLS, takže komunikace mezi prohlížečem a serverem je šifrovaná a server se prokazuje certifikátem. FTP slouží k přenosu souborů, i když se dnes často nahrazuje bezpečnějšími variantami jako SFTP. SMTP slouží k odesílání e-mailů, IMAP a POP3 ke stahování nebo synchronizaci pošty.

Doména je čitelné jméno internetového zdroje. Top Level Domain je nejvyšší úroveň domény, například `.cz`, `.com`, `.org`. Doména 2. řádu je například `seznam.cz`, doména 3. řádu je například `mail.seznam.cz`. CZ.NIC je správce české národní domény `.cz`, stará se o její provoz, pravidla registrace a stabilitu českého doménového prostoru.

### Praktická část

Na Windows lze zjistit síťové informace příkazem:

```powershell
ipconfig /all
```

Na Linuxu:

```bash
ip addr
```

Veřejnou IP adresu lze zjistit například zadáním „what is my IP“ do vyhledávače nebo přes službu typu `https://ifconfig.me`. Vlastníka veřejné IP lze ověřit přes WHOIS služby. U zkoušení je dobré ukázat rozdíl mezi lokální IP adresou počítače, MAC adresou síťové karty a veřejnou IP adresou, kterou vidí internet.

---

## 2. Práce se soubory a složkami, Windows a Linux, práva, typy souborů

### Osnova odpovědi

- Co je soubor, složka a cesta k souboru.
- Rozdíly mezi Windows a Linuxem.
- Uživatelé, administrátor, root, práva k souborům.
- Textové a binární soubory, přípony a formáty.
- Systémové složky a skryté soubory.
- Regionální nastavení, ISO standardy, CSV a desetinná čárka.

### Výukový text

Soubor je pojmenovaný blok dat uložený v úložišti. Složka, neboli adresář, slouží k organizaci souborů. Cesta určuje, kde se soubor nachází. Windows používá typicky písmena disků a zpětná lomítka, například `C:\Users\Student\Dokumenty`. Linux používá strom začínající kořenovým adresářem `/` a lomítka, například `/home/student/dokumenty`.

Windows je proprietární operační systém vyvíjený Microsoftem. Linux je open source operační systém, přesněji jádro a sada distribucí, které rozvíjí komunita i firmy. Linux bývá case sensitive, takže `soubor.txt` a `Soubor.txt` mohou být dva různé soubory. Windows v běžném nastavení case sensitive není. Linux také výrazně pracuje s modelem práv owner, group, other, tedy vlastník, skupina a ostatní.

Uživatelé a práva jsou důležitá bezpečnostní vrstva. Běžný uživatel by neměl mít právo měnit systémové části systému. Administrátor ve Windows nebo uživatel `root` v Linuxu má vysoká oprávnění a může systém zásadně měnit. To je užitečné při správě, ale nebezpečné při běžné práci, protože chyba nebo malware může způsobit větší škody.

Typ souboru často poznáme podle přípony. `.txt`, `.xml`, `.json` a `.csv` jsou typicky textové soubory, protože jejich obsah lze číst jako text. `.jpg`, `.png`, `.mp4`, `.exe`, `.xls` nebo `.doc` jsou typicky binární soubory, protože obsahují data ve formátu určeném pro konkrétní program. Binární soubor lze otevřít v textovém editoru, ale často uvidíme nesmyslné znaky, protože editor se pokusí interpretovat bajty jako text.

Textový soubor je také uložen binárně, protože počítač ukládá všechno jako bity. Rozdíl je v tom, že textový soubor používá kódování, například UTF-8, které převádí znaky na čísla. Starší známý standard je ASCII, který uměl základní anglické znaky. UTF-8 umí i češtinu a většinu světových jazyků.

Systémové složky obsahují soubory potřebné pro běh operačního systému a aplikací. Ve Windows jde například o `Windows`, `Program Files` nebo `System32`. V Linuxu například `/etc`, `/bin`, `/usr`, `/var` a `/home`. Některé soubory jsou skryté, aby uživatele nerušily nebo aby se omezilo nechtěné poškození konfigurace.

Regionální nastavení ovlivňuje jazyk, formát data, času, měny, oddělovač desetinných míst a oddělovač seznamů. V Česku se často používá desetinná čárka, zatímco v anglosaském prostředí desetinná tečka. To je důležité u CSV souborů. CSV je textový tabulkový formát, kde jsou hodnoty oddělené čárkou nebo středníkem. Pokud je desetinným oddělovačem čárka, používá se v českém prostředí jako oddělovač sloupců často středník.

### Praktická část

Student by měl umět v systému najít regionální nastavení, ukázat přípony souborů a vysvětlit, proč je například `.csv` čitelný v textovém editoru, zatímco `.jpg` ne. Dobrý praktický příklad je otevřít CSV v tabulkovém procesoru i v textovém editoru a porovnat, co je skutečný obsah souboru.

---

## 3. API, request, response, HTTP metody a stavové kódy

### Osnova odpovědi

- Co je API a proč ho aplikace používají.
- REST API, endpoint, request, response.
- HTTP metody GET, POST, PUT, PATCH, DELETE.
- Stavové kódy 2xx, 4xx, 5xx.
- Praktické zavolání veřejného API.
- OAuth, rate limiting, verzování API, rozdíl API a scrapingu.

### Výukový text

API znamená Application Programming Interface, tedy rozhraní, přes které spolu komunikují programy. API umožňuje, aby jedna aplikace používala funkce nebo data jiné aplikace bez toho, aby znala její vnitřní kód. Když mobilní aplikace počasí zobrazí teplotu, pravděpodobně se ptá API meteorologické služby. Když e-shop ověřuje platbu, komunikuje s API platební brány.

U webových aplikací se často používá REST API. REST není jeden konkrétní program, ale styl návrhu API, který využívá HTTP protokol a pracuje se zdroji. Endpoint je konkrétní URL adresa, na kterou klient posílá požadavek. Request je požadavek klienta, response je odpověď serveru. Request může obsahovat metodu, URL, hlavičky, parametry a tělo požadavku. Response obsahuje stavový kód, hlavičky a často data, například ve formátu JSON.

HTTP metoda říká, co chceme se zdrojem udělat. `GET` načítá data, `POST` vytváří nový záznam nebo spouští operaci, `PUT` typicky nahrazuje celý záznam, `PATCH` upravuje jen část záznamu a `DELETE` maže. V praxi se například `GET /products` použije pro seznam produktů a `POST /orders` pro vytvoření objednávky.

HTTP stavový kód říká, jak požadavek dopadl. Kód `200 OK` znamená, že požadavek proběhl v pořádku. `201 Created` znamená, že byl vytvořen nový zdroj. `404 Not Found` znamená, že požadovaný zdroj nebyl nalezen. Kódy `4xx` označují chybu na straně klienta, například špatná adresa, chybějící oprávnění nebo špatný vstup. Kódy `5xx` označují chybu na straně serveru.

API se používá v bankovnictví, mapách, dopravě, sociálních sítích, e-shopech, platebních systémech, počasí, generativní AI nebo mobilních aplikacích. Výhodou API je standardizovaná komunikace. Nevýhodou je, že klient závisí na dostupnosti, pravidlech a verzích API poskytovatele.

OAuth je protokol pro bezpečné předávání oprávnění. Díky OAuth může uživatel například povolit aplikaci přístup ke svému účtu Google, aniž by jí prozradil heslo. Rate limiting znamená omezení počtu požadavků za určitý čas, aby se API nepřetížilo nebo nezneužívalo. Verzování API umožňuje měnit API bez okamžitého rozbití starších klientů, například pomocí `/v1/` a `/v2/` v URL.

Scraping znamená automatické čtení dat z webových stránek, které nejsou primárně určené jako API. Oproti API je křehčí, protože změna HTML stránky může scraper rozbít. Scraping může mít také právní a etická omezení.

### Praktická část

V prohlížeči lze otevřít například:

```text
https://open.er-api.com/v6/latest
https://httpbin.org/get
```

Student by měl ukázat, že odpověď je často JSON, najít v ní konkrétní hodnotu a vysvětlit, že prohlížeč poslal GET request a server vrátil response. Pro pokročilejší ukázku lze použít Postman, Swagger UI nebo nástroj `curl`.

---

## 4. AI, strojové učení a generativní AI

### Osnova odpovědi

- Rozdíl mezi běžným programováním a umělou inteligencí.
- Strojové učení, model, trénovací data.
- Generativní AI a její princip.
- Příklady využití v textu, obraze, hudbě, programování.
- Rizika: halucinace, bias, deepfakes, autorská práva, dopad na práci.
- Praktická ukázka promptování.

### Výukový text

Umělá inteligence je oblast informatiky, která se snaží vytvářet systémy schopné vykonávat úlohy, jež obvykle vyžadují lidskou inteligenci. Patří sem rozpoznávání obrazu, porozumění jazyku, plánování, doporučování obsahu nebo generování textu. Rozdíl oproti běžnému programování je v tom, že u klasického programu vývojář přesně popíše pravidla. U strojového učení se systém učí vzory z dat.

Strojové učení funguje tak, že máme trénovací data a algoritmus, který z nich vytvoří model. Model je zjednodušeně matematická reprezentace naučených vztahů. Pokud chceme model naučit rozpoznávat obrázky koček, ukážeme mu mnoho označených obrázků. Model se postupně naučí vlastnosti, které s kočkou souvisí, ale nemusí jim rozumět jako člověk.

Existuje učení s učitelem, kde data obsahují správné odpovědi, například obrázek a štítek „pes“. Učení bez učitele hledá strukturu v datech bez předem daných odpovědí. Posilované učení pracuje s odměnou a trestem, například při učení hry nebo řízení robota.

Generativní AI je AI, která vytváří nový obsah: text, obrázky, hudbu, video, kód nebo kombinace těchto médií. Textové generativní modely, jako chatovací modely, předpovídají pravděpodobná pokračování textu na základě obrovského množství naučených vzorů. Moderní modely často používají architekturu transformer, která umí pracovat s kontextem a vztahy mezi slovy.

AI se používá ve vzdělávání jako tutor, při shrnování textů, v programování jako asistent, v medicíně při podpoře diagnostiky, v byznysu při analýze dat a v umění jako kreativní nástroj. Ve firmách se používají veřejné modely, cloudové modely i vlastní modely běžící nad firemními daty. Důležité je rozlišovat, zda model pracuje s citlivými daty a jak je chrání.

Rizikem generativní AI jsou halucinace, tedy sebevědomě znějící nepravdivé odpovědi. Dalším problémem je bias, kdy model přebírá zkreslení z dat. Deepfakes mohou napodobovat tvář nebo hlas člověka a šířit dezinformace. U autorských práv se řeší, na jakých datech byl model trénován a kdo má práva k vytvořenému obsahu. AI také mění pracovní trh: některé činnosti automatizuje, ale zároveň vytváří nové role a zvyšuje důležitost schopnosti ověřovat informace.

AGI znamená Artificial General Intelligence, tedy obecná umělá inteligence schopná řešit širokou škálu úloh podobně flexibilně jako člověk. Současné systémy jsou silné v konkrétních úlohách, ale AGI v plném smyslu zatím nemáme. Tomáš Mikolov je český vědec známý mimo jiné prací na metodách word2vec, které výrazně ovlivnily zpracování přirozeného jazyka.

### Praktická část

Student může ukázat práci s chatbotem: položit vágní otázku, potom ji zpřesnit, doplnit roli, kontext, požadovaný formát a kritéria kvality. Důležité je vysvětlit, že promptování není magie, ale způsob, jak modelu dodat jasnější zadání.

Příklad dobrého promptu:

```text
Vysvětli studentovi 4. ročníku IT rozdíl mezi HTTP a HTTPS. Použij příklad z e-shopu, zmiň TLS certifikát a zakonči třemi kontrolními otázkami.
```

---

## 5. Zabezpečení aplikací a systémů, TLS, certifikáty, autentizace a autorizace

### Osnova odpovědi

- Co všechno se v IT zabezpečuje.
- Firewall, porty, příchozí a odchozí komunikace.
- TLS, HTTPS, certifikáty a certifikační autority.
- VPN, end-to-end šifrování, asymetrické šifrování.
- Autentizace, autorizace, MFA, přihlášení přes třetí stranu.
- Praktické rozpoznání nezabezpečené stránky.

### Výukový text

Zabezpečení v IT se týká zařízení, sítí, aplikací, dat, uživatelských účtů i procesů ve firmě. Cílem je chránit důvěrnost, integritu a dostupnost. Důvěrnost znamená, že se k datům dostane jen oprávněný člověk. Integrita znamená, že data nejsou nepozorovaně změněna. Dostupnost znamená, že služba funguje, když ji uživatel potřebuje.

Firewall je bezpečnostní prvek, který filtruje síťovou komunikaci podle pravidel. Může běžet na počítači, routeru, serveru, ve firemní síti nebo v cloudu. Pracuje například s IP adresami, porty a protokoly. Port si lze představit jako číslo dveří ke konkrétní službě. Web běžně používá port 80 pro HTTP a 443 pro HTTPS. Firewall může blokovat příchozí i odchozí komunikaci, záleží na pravidlech.

TLS je protokol, který zabezpečuje komunikaci po internetu. Uživatel ho nejčastěji vidí jako HTTPS v prohlížeči. Laikovi se dá TLS vysvětlit tak, že prohlížeč a server se domluví na šifrovaném spojení, aby cizí člověk po cestě nečetl ani neměnil přenášená data. Certifikát potvrzuje identitu serveru a obsahuje veřejný klíč. Certifikační autorita je důvěryhodná organizace, která certifikáty vydává nebo ověřuje.

Asymetrické šifrování používá dvojici klíčů: veřejný a soukromý. Veřejný klíč lze sdílet, soukromý musí zůstat tajný. Co je zašifrováno veřejným klíčem, lze typicky dešifrovat soukromým klíčem. Tento princip se používá při navazování bezpečné komunikace i při digitálních podpisech.

VPN vytváří šifrovaný tunel mezi zařízením a sítí nebo službou. Používá se pro bezpečný přístup do firemní sítě nebo pro ochranu komunikace na nedůvěryhodné Wi-Fi. End-to-end šifrování znamená, že zprávu mohou číst jen koncová zařízení komunikujících uživatelů, ne provozovatel služby po cestě. Typickým příkladem jsou některé komunikační aplikace.

Autentizace odpovídá na otázku „Kdo jsi?“ a ověřuje identitu uživatele, například heslem, čipovou kartou nebo biometrikou. Autorizace odpovídá na otázku „Co smíš dělat?“ a určuje oprávnění. Vícefaktorové ověřování kombinuje více faktorů: něco znám, například heslo; něco mám, například telefon; něco jsem, například otisk prstu. Přihlášení přes třetí stranu znamená, že identitu ověřuje externí poskytovatel, například Google, Microsoft nebo bankovní identita.

### Praktická část

Na nezabezpečené stránce je v adrese `http://` místo `https://`. Prohlížeč často zobrazuje varování. Pokud se přes nezabezpečený formulář posílá heslo nebo osobní údaj, data mohou cestou putovat bez šifrování. Student by měl umět otevřít informace o certifikátu v prohlížeči a vysvětlit, komu byl certifikát vydán, kým byl vydán a do kdy platí.

---

## 6. Databáze, relační model a SQL

### Osnova odpovědi

- Co je databáze a proč nestačí soubory.
- Relační databáze, tabulka, řádek, sloupec.
- Primární a cizí klíč, vztahy 1:1, 1:N, M:N.
- SQL a základní operace.
- Návrh jednoduchého modelu.
- Výhody a nevýhody relačních databází.

### Výukový text

Databáze je organizované úložiště dat, které umožňuje data bezpečně ukládat, vyhledávat, měnit a propojovat. Oproti obyčejným souborům přináší kontrolu přístupu, souběžnou práci více uživatelů, transakce, zálohování a efektivní dotazování. Relační databáze ukládá data do tabulek. Tabulka má sloupce, které určují typ informací, a řádky, které představují konkrétní záznamy.

Důležitým pojmem je primární klíč. Ten jednoznačně identifikuje řádek v tabulce, například `customer_id`. Cizí klíč odkazuje na záznam v jiné tabulce. Když má objednávka sloupec `customer_id`, víme, kterému zákazníkovi patří. Díky tomu nemusíme údaje o zákazníkovi kopírovat do každé objednávky.

Vztah 1:N znamená, že jeden záznam na jedné straně může mít více záznamů na druhé straně. Jeden zákazník může mít více objednávek. Vztah M:N znamená, že více záznamů na jedné straně může souviset s více záznamy na druhé straně. Student může chodit do více kurzů a jeden kurz může mít více studentů. V relační databázi se M:N řeší spojovací tabulkou, například `student_course`.

SQL je jazyk pro práci s relační databází. Pomocí `SELECT` data čteme, pomocí `INSERT` přidáváme, `UPDATE` upravujeme a `DELETE` mažeme. Pomocí `JOIN` propojujeme tabulky. SQL také umožňuje filtrovat, řadit, seskupovat a agregovat data.

Jednoduchý příklad dotazu:

```sql
SELECT customers.name, orders.order_date
FROM customers
JOIN orders ON orders.customer_id = customers.id
WHERE customers.city = 'Praha';
```

Relační databáze mají zákonitosti. Patří mezi ně integrita dat, datové typy, omezení jako `NOT NULL` nebo `UNIQUE`, transakce a často normalizace. Normalizace znamená návrh databáze tak, aby se data zbytečně neduplikovala a aby změna jednoho údaje nevyžadovala opravu na mnoha místech.

Mezi známé relační databáze patří PostgreSQL, MySQL, MariaDB, Microsoft SQL Server, Oracle Database a SQLite. Nevýhodou relačních databází může být složitější návrh schématu, menší flexibilita při často se měnící struktuře dat a náročnější horizontální škálování u velmi velkých distribuovaných systémů.

### Praktická část

Na W3Schools SQL editoru lze ukázat `SELECT`, `WHERE`, `JOIN`, `LIKE`, `INSERT` a vysvětlit, co dotaz vrací. U maturitní odpovědi je dobré nakreslit jednoduchý model: zákazník, objednávka, položka objednávky, produkt.

---

## 7. Datové soubory JSON, XML, CSV, NoSQL databáze a scraping

### Osnova odpovědi

- Struktura CSV, JSON a XML.
- Využití těchto formátů v praxi.
- Relační vs. NoSQL databáze.
- Typy NoSQL databází: dokumentové, klíč-hodnota, sloupcové, grafové, vektorové.
- Výhody a nevýhody NoSQL.
- Scraping dat a jeho limity.

### Výukový text

CSV, JSON a XML jsou běžné formáty pro ukládání nebo výměnu dat. CSV je jednoduchý textový formát pro tabulková data. Jeden řádek odpovídá jednomu záznamu, hodnoty jsou oddělené čárkou nebo středníkem. Hodí se pro exporty z tabulek, účetních systémů nebo jednoduché seznamy. Nevýhodou je slabší popis struktury, problémy s oddělovači, kódováním a uvozovkami.

JSON je textový formát založený na dvojicích klíč-hodnota, objektech a polích. Je velmi oblíbený v API, webových aplikacích a konfiguracích. JSON je čitelný pro člověka a zároveň snadno zpracovatelný programem. Příklad:

```json
{
  "name": "Anna",
  "age": 18,
  "skills": ["SQL", "HTML", "Python"]
}
```

XML je značkovací formát, kde mají data stromovou strukturu a používají otevírací a uzavírací tagy. Je ukecanější než JSON, ale dobře se hodí pro dokumenty, starší integrační systémy, konfigurace a formáty, kde je důležitá přesná struktura. Příklad:

```xml
<student>
  <name>Anna</name>
  <age>18</age>
</student>
```

NoSQL databáze nejsou postavené primárně na tabulkách a SQL dotazech. Neznamená to, že jsou lepší než relační databáze, ale že řeší jiné typy problémů. Dokumentové databáze, například MongoDB, ukládají dokumenty podobné JSONu. Key-value databáze, například Redis, pracují s dvojicí klíč a hodnota. Sloupcové databáze se hodí pro velká analytická data. Grafové databáze se hodí pro vztahy, například sociální sítě nebo doporučovací systémy. Vektorové databáze ukládají vektory a používají se u AI vyhledávání podobnosti.

Výhodou NoSQL bývá flexibilní struktura, snadnější škálování a dobrý výkon pro specifické typy dat. Nevýhodou může být duplicita dat, složitější agregace, slabší transakční vlastnosti u některých systémů a riziko chaotického modelu, pokud není dobře navržen. NoSQL se nehodí automaticky na všechno. Pokud máme silně strukturovaná data, jasné vztahy a požadavek na transakce, relační databáze je často lepší volba.

Scraping dat znamená automatické získávání dat z webových stránek. Používá se například pro monitoring cen, analýzu nabídek nebo sběr veřejných informací. Je potřeba respektovat právo, podmínky služby, ochranu osobních údajů a technická omezení serveru. Pokud web nabízí API, je obvykle vhodnější použít API než scraping.

### Praktická část

Student může otevřít `https://open.er-api.com/v6/latest`, ukázat JSON s kurzovními lístky a vysvětlit objekty a klíče. Převod JSON na XML znamená převést klíče JSONu na XML elementy a zachovat hodnoty. U CSV je dobré vytvořit tabulku v Google Sheets, exportovat ji jako CSV a vysvětlit oddělovač, kódování UTF-8 a problém s desetinnou čárkou.

---

## 8. Cloudové služby, SaaS, PaaS, IaaS, on-premise a virtualizace

### Osnova odpovědi

- Co je cloud a on-premise řešení.
- SaaS, PaaS, IaaS, případně FaaS/serverless.
- Hlavní poskytovatelé cloudových služeb.
- Shared resources, shared responsibility, škálování.
- Virtualizace a kontejnery.
- Private, public a hybrid cloud.

### Výukový text

Cloud znamená poskytování výpočetních služeb přes internet. Místo toho, aby firma kupovala vlastní servery, síťové prvky a datové centrum, může si pronajmout výkon, úložiště, databáze, aplikace nebo celé platformy. On-premise řešení znamená, že infrastruktura běží ve vlastních prostorách firmy nebo ve firmou řízeném datacentru. Cloud je často on-demand, tedy podle potřeby: službu vytvořím, používám a platím za spotřebu nebo tarif.

SaaS, Software as a Service, je hotová aplikace dostupná přes internet. Uživatel neřeší servery ani aktualizace aplikace. Příkladem je Gmail, Google Workspace, Microsoft 365, Slack nebo Salesforce. PaaS, Platform as a Service, poskytuje platformu pro běh aplikací. Vývojář nahraje aplikaci a cloud řeší infrastrukturu, škálování a běhové prostředí. Příkladem může být Google App Engine, Azure App Service nebo Firebase. IaaS, Infrastructure as a Service, poskytuje virtuální servery, sítě a disky. Uživatel má větší kontrolu, ale také větší odpovědnost. Příkladem jsou virtuální stroje v AWS, Azure nebo Google Cloud.

Serverless nebo FaaS znamená, že vývojář píše funkce, které se spouštějí podle událostí, například HTTP požadavku nebo zprávy ve frontě. Neznamená to, že servery neexistují, ale že je uživatel přímo nespravuje.

Největší poskytovatelé cloudu jsou Amazon Web Services, Microsoft Azure a Google Cloud Platform. Dalšími hráči jsou Oracle Cloud, IBM Cloud nebo Cloudflare. Shared resources znamená, že fyzická infrastruktura je sdílená mezi více zákazníky, ale logicky oddělená. To umožňuje efektivní využití výkonu a nižší náklady. Shared responsibility model říká, že část bezpečnosti řeší cloudový poskytovatel a část zákazník. Poskytovatel chrání datacentra a základní služby, zákazník musí správně nastavit účty, oprávnění, data a konfiguraci.

Scalability znamená schopnost přizpůsobit výkon zátěži. Vertikální škálování znamená přidat silnější server. Horizontální škálování znamená přidat více instancí služby. Cloud usnadňuje automatické škálování, kdy se výkon zvýší při špičce a sníží při menší zátěži.

Virtualizace umožňuje provozovat více virtuálních strojů na jednom fyzickém serveru. Každý virtuální stroj se chová jako samostatný počítač. Kontejnery jsou lehčí způsob balení aplikací a jejich závislostí. Kontejner sdílí jádro hostitelského systému, ale aplikace běží izolovaně. Známým nástrojem je Docker, pro orchestraci kontejnerů se používá Kubernetes.

Public cloud je cloud poskytovaný veřejným poskytovatelem. Private cloud je cloudové prostředí určené pro jednu organizaci. Hybrid cloud kombinuje vlastní infrastrukturu a veřejný cloud. Google Apps Script je blízko PaaS/serverless/nocode-lowcode přístupu: uživatel píše skripty nad službami Googlu a nemusí řešit servery.

### Praktická část

Na Google Workspace lze ukázat SaaS služby: Gmail, Disk, Dokumenty, Tabulky, Meet. U každé služby student vysvětlí, že uživatel řeší práci s aplikací, ale neřeší server, databázi, aktualizace ani fyzické disky.

---

## 9. Vývoj softwarového projektu, fáze, role a DevOps

### Osnova odpovědi

- Fáze softwarového projektu.
- Jak se vybírají technologie.
- Role v IT projektu a jejich odpovědnosti.
- Agilní a neagilní přístup.
- QA, DevOps, monitoring a provoz.
- Rozdíl korporace, malé firmy a startupu.

### Výukový text

Softwarový projekt obvykle začíná nápadem nebo potřebou. Následuje sběr požadavků, analýza, návrh řešení, vývoj, testování, nasazení, provoz a údržba. V praxi se tyto fáze mohou opakovat a překrývat, hlavně v agilním vývoji. Důležité je pochopit, že software nekončí napsáním kódu. Musí fungovat pro uživatele, být bezpečný, udržovatelný a provozovatelný.

Výběr technologií určuje povaha projektu, zkušenosti týmu, rozpočet, bezpečnostní požadavky, integrace s okolními systémy, očekávaná zátěž, dostupnost vývojářů a dlouhodobá údržba. Jinou technologii zvolíme pro rychlý prototyp, jinou pro bankovní systém s vysokými nároky na bezpečnost.

V projektu vystupuje mnoho rolí. Software architect navrhuje celkovou architekturu, rozdělení systému, technologie a důležité technické principy. Backend developer vyvíjí serverovou část aplikace, API, databáze a integrační logiku. Frontend developer řeší uživatelské rozhraní v prohlížeči nebo aplikaci. Project manager plánuje rozpočet, termíny, komunikaci a rizika. Product owner určuje hodnotu produktu, priority a backlog. Scrum master pomáhá týmu používat Scrum a odstraňovat překážky. UX designer zkoumá potřeby uživatelů a navrhuje použitelné rozhraní. QA tester ověřuje kvalitu a hledá chyby.

Manažerské role se více zabývají plánem, prioritami, komunikací a rozpočtem. Technické role řeší návrh, implementaci, testy, infrastrukturu a provoz. Některé role jsou na hraně, například business analyst nebo product owner.

QA znamená Quality Assurance, tedy zajištění kvality. Nejde jen o hledání chyb na konci, ale o celý přístup, který zvyšuje šanci, že produkt splní očekávání. DevOps propojuje vývoj a provoz. Cílem je, aby se aplikace dala spolehlivě nasazovat, sledovat a udržovat. DevOps využívá nástroje jako Git, GitHub/GitLab CI, Jenkins, Docker, Kubernetes, Terraform, Ansible, Prometheus, Grafana, Azure Monitor nebo Application Insights.

V korporaci bývá více procesů, bezpečnostních pravidel, specializovaných rolí a schvalování. Výhodou je stabilita a zdroje, nevýhodou pomalejší rozhodování. V malé firmě nebo startupu jsou role často spojené, komunikace je rychlá, ale lidé musí dělat širší rozsah práce. POC, proof of concept, je krátké ověření, zda je nápad technicky nebo obchodně proveditelný. Například firma si může ověřit, zda dokáže napojit vlastní systém na API banky, než začne celý projekt.

### Praktická část

Student může popsat vývoj jednoduchého e-shopu: požadavky, návrh databáze, vývoj backendu a frontendu, testování objednávky, nasazení na cloud, monitoring chyb a následné opravy.

---

## 10. Testování aplikací, druhy testů, prostředí, QA

### Osnova odpovědi

- Proč se software testuje.
- Manuální a automatické testování.
- Unit, integrační, E2E, performance, penetrační testy.
- UAT, smoke test, regresní test, mockování.
- Happy a unhappy scénář.
- Prostředí: dev, test, staging, production.

### Výukový text

Testování je důležité, protože software má chyby a ty mohou způsobit finanční ztráty, bezpečnostní incidenty nebo špatnou zkušenost uživatele. Testování nezaručí absolutní bezchybnost, ale snižuje riziko. Testuje se v různých fázích projektu: při vývoji, před nasazením, po opravách i při změnách prostředí.

Manuální testování provádí člověk podle scénáře nebo průzkumně. Hodí se pro ověření uživatelského chování, vizuálních detailů a nových funkcí. Automatické testování provádí program, který lze spouštět opakovaně. Hodí se pro regresní testy a rychlou kontrolu, zda změna nerozbila existující funkce.

Unit test ověřuje malou část kódu, například jednu funkci. Integrační test ověřuje spolupráci více částí, například aplikace a databáze. E2E, end-to-end test, ověřuje celý tok z pohledu uživatele. U e-shopu může E2E test znamenat vyhledání produktu, vložení do košíku, vyplnění adresy a dokončení objednávky. Performance test ověřuje výkon, odezvu a chování při zátěži. Penetrační test hledá bezpečnostní zranitelnosti.

UAT, User Acceptance Testing, je akceptační testování uživateli nebo zákazníkem. Ověřuje, zda systém odpovídá obchodním požadavkům. Happy scénář je očekávaný úspěšný průchod, například správné přihlášení platným heslem. Unhappy scénář řeší chyby, například špatné heslo, prázdný formulář, neplatnou kartu nebo výpadek služby.

Smoke test je rychlá kontrola, že základní části aplikace po nasazení vůbec fungují. Regresní test ověřuje, že nová změna nerozbila starou funkcionalitu. Mockování znamená nahrazení skutečné závislosti falešnou verzí, například místo skutečné platební brány použijeme testovací objekt. Díky tomu lze testovat bez reálných plateb.

Prostředí oddělují různé fáze provozu. Development slouží vývojářům. Test nebo QA slouží testerům. Staging nebo preproduction se podobá produkci a slouží k finálnímu ověření. Production je skutečné prostředí pro uživatele. V malé firmě může být prostředí méně, v korporaci bývá proces přísnější.

### Praktická část

Student si vybere internetový e-shop a popíše E2E test: otevření webu, vyhledání produktu, filtrování, detail produktu, košík, doprava, platba, potvrzení objednávky, e-mail. Potom doplní unhappy scénáře: prázdný košík, neplatný e-mail, zamítnutá platba, vyprodaný produkt.

---

## 11. UX a UI, design zaměřený na uživatele a A/B testování

### Osnova odpovědi

- Rozdíl mezi UX a UI.
- Proč se UX řeší a proč za něj klient platí.
- UX ve fázích vývoje.
- Uživatelský výzkum, prototypy, testování.
- Accessibility, sitemap, landing page, call to action.
- A/B testování a trendy.

### Výukový text

UI znamená User Interface, tedy uživatelské rozhraní. Patří sem tlačítka, formuláře, barvy, typografie, ikony, rozložení stránky a vizuální prvky. UX znamená User Experience, tedy celková zkušenost uživatele s produktem. UX řeší, jestli uživatel rozumí, co má dělat, jestli se rychle dostane k cíli a jestli ho aplikace zbytečně nefrustruje.

Rozdíl se dá vysvětlit na e-shopu. UI je vzhled tlačítka „Koupit“. UX je celá cesta od nalezení produktu přes pochopení ceny až po dokončení objednávky. Krásné UI nezaručuje dobré UX. Pokud je web hezký, ale uživatel nenajde košík, UX je špatné.

Klient platí za UX proto, že špatně navržený produkt ztrácí zákazníky, zvyšuje náklady na podporu a může poškodit značku. Dobré UX zvyšuje konverze, snižuje chybovost a zlepšuje spokojenost. UX se má řešit už na začátku projektu při analýze potřeb, ne až po naprogramování. Pozdější opravy jsou dražší.

Design zaměřený na uživatele vychází z poznání cílové skupiny. Používají se rozhovory, dotazníky, persony, zákaznické cesty, wireframy a prototypy. Při UX testování se uživatelům dávají úkoly, například „Najděte formulář pro žádost“ nebo „Objednejte si produkt“. Otázky pro testery mají být konkrétní a nemají navádět. Místo „Líbí se vám toto tlačítko?“ je lepší „Co byste teď udělal/a?“

Accessibility znamená přístupnost. Web nebo aplikace má být použitelná i pro lidi se zrakovým, motorickým nebo jiným omezením. Patří sem kontrast, ovládání klávesnicí, popisky obrázků, čitelné formuláře a srozumitelný obsah. Často se vychází z pravidel WCAG.

Sitemap je mapa webu, která ukazuje strukturu stránek. Call to action je výzva k akci, například „Registrovat“, „Koupit“, „Stáhnout“. Landing page je stránka zaměřená na jeden konkrétní cíl, například přihlášení na kurz nebo stažení e-booku. Používá se hlavně u kampaní, kde nechceme rozptylovat uživatele celým webem.

A/B testování porovnává dvě varianty. Část uživatelů vidí variantu A, část variantu B a měří se, která lépe plní cíl. Trendy v UX zahrnují personalizaci, jednoduché mikrointerakce, dark mode, přístupnost, hlasové ovládání, AI asistenty a důraz na důvěryhodnost.

### Praktická část

Student porovná dva veřejné weby z hlediska navigace, čitelnosti, formulářů, důvěryhodnosti, přístupnosti a jasnosti hlavní akce. Důležité je neříkat jen „líbí/nelíbí“, ale zdůvodnit to dopadem na uživatele.

---

## 12. Fotky, obrázky a videa na web, RGB/CMYK, bitmapa a vektor

### Osnova odpovědi

- Co zohlednit při přípravě grafiky.
- RGB vs. CMYK.
- Bitmapová vs. vektorová grafika.
- Formáty JPG, PNG, GIF, TIFF, AI, SVG a moderní webové formáty.
- Optimalizace pro web.
- Transparentnost, kvalita, rozměry, přístupnost.

### Výukový text

Při přípravě grafiky je potřeba zohlednit účel, médium, cílové zařízení, kvalitu, velikost souboru, autorská práva a přístupnost. Jinak připravíme plakát pro tisk, jinak obrázek na web a jinak ikonu do aplikace.

RGB je barevný model pro obrazovky. Barvy vznikají skládáním červeného, zeleného a modrého světla. Používá se pro monitory, mobily, web a video. CMYK je barevný model pro tisk. Používá azurovou, purpurovou, žlutou a černou barvu. Převod mezi RGB a CMYK může změnit vzhled barev, protože obrazovka a tisk mají jiný rozsah barev. Proto není dobré bez kontroly převádět tam a zpět.

Bitmapová grafika se skládá z pixelů. Fotografie je typický bitmapový obrázek. Když ji výrazně zvětšíme, ztrácí kvalitu a mohou být vidět pixely. Vektorová grafika je popsána matematicky pomocí tvarů, křivek a bodů. Lze ji zvětšovat bez ztráty kvality. Hodí se pro loga, ikony, diagramy a ilustrace.

JPG se hodí pro fotografie, protože dobře komprimuje složité obrazové informace, ale nepodporuje průhlednost a používá ztrátovou kompresi. PNG se hodí pro obrázky s průhledností, screenshoty a grafiku s ostrými hranami. GIF podporuje jednoduché animace, ale má omezenou paletu barev. TIFF se používá v profesionálním tisku a archivaci, protože může uchovávat vysokou kvalitu. AI je pracovní formát Adobe Illustratoru. SVG je vektorový formát vhodný pro webové ikony, loga a jednoduché ilustrace. Moderní formáty jako WebP a AVIF často nabízejí lepší kompresi pro web.

Při přípravě grafiky na web je důležitá velikost souboru, aby se stránka rychle načítala. Obrázek by neměl mít zbytečně obrovské rozměry, pokud se zobrazuje malý. Je vhodné používat kompresi, responzivní obrázky, správný formát a alternativní text pro přístupnost. U videa je důležitý kodek, rozlišení, datový tok, titulky a možnost přehrávání na různých zařízeních.

Transparentní pozadí podporuje například PNG, SVG, GIF a WebP. JPG transparentnost neumí. U zkoušení je dobré uvést konkrétní scénáře: fotka produktu jako JPG/WebP, logo jako SVG, screenshot aplikace jako PNG, tiskový podklad jako TIFF nebo PDF.

### Praktická část

Student může vzít jednu fotografii, porovnat její velikost v JPG a PNG a vysvětlit rozdíl. U loga může ukázat, proč je SVG vhodnější než malý rastrový obrázek.

---

## 13. Role ve firmě, IT role, korporát, malá firma, startup a CV

### Osnova odpovědi

- Význam zkratek CEO, COO, CFO, CTO, HR.
- IT role ve softwarové firmě.
- Korporát vs. malá firma vs. startup.
- Firemní kultura a komunita.
- Hledání práce a příprava CV.
- Jak hodnotit pracovní nabídku.

### Výukový text

CEO je Chief Executive Officer, tedy nejvyšší výkonný ředitel firmy. COO je Chief Operating Officer a řeší provoz firmy. CFO je Chief Financial Officer a odpovídá za finance. CTO je Chief Technology Officer a řeší technologickou strategii. HR znamená Human Resources, tedy oblast lidí, náboru, smluv, rozvoje zaměstnanců a firemní kultury.

Ve softwarové firmě najdeme mnoho IT rolí. Backend developer vyvíjí serverovou logiku, databáze a API. Frontend developer vytváří uživatelské rozhraní. Full-stack developer zvládá část backendu i frontendu. Software architect navrhuje technickou strukturu systému. DevOps engineer řeší automatizaci, infrastrukturu, nasazování a monitoring. QA tester ověřuje kvalitu. UX/UI designer navrhuje použitelné a vizuálně kvalitní rozhraní. Product owner určuje priority produktu. Business analyst sbírá a překládá požadavky mezi byznysem a IT.

Korporát nabízí stabilitu, větší projekty, jasnější procesy a specializované role. Nevýhodou může být pomalejší rozhodování, více schvalování a menší vliv jednotlivce. Malá firma má často rychlejší komunikaci, širší odpovědnost a méně formální prostředí. Nevýhodou může být méně mentorů, méně jasné procesy nebo větší tlak na univerzálnost. Startup je firma hledající rychle škálovatelný obchodní model. Může být dynamický a zajímavý, ale také rizikovější.

Při hledání práce je dobré si ujasnit, co chci: technologie, typ práce, velikost firmy, možnost učení, plat, flexibilitu, firemní kulturu, stabilitu a smysl produktu. Student po střední škole může ukázat školní projekty, GitHub, praxi, brigády, soutěže, kurzy, maturitní práci nebo vlastní aplikace. Důležitější než dokonalý seznam technologií je schopnost vysvětlit, co člověk opravdu dělal.

CV má být přehledné, pravdivé a konkrétní. Mělo by obsahovat kontakt, vzdělání, zkušenosti, projekty, technologie, jazykové znalosti a odkazy na portfolio. U projektů je dobré napsat nejen název, ale i roli a výsledek: „Vytvořil jsem jednoduchou webovou aplikaci pro evidenci knih v Pythonu a SQLite.“ Nevhodné je přehánět znalosti, psát dlouhé odstavce bez struktury nebo uvádět irelevantní informace.

Firemní kultura se pozná podle komunikace, rozhodování, vztahu k chybám, podpory učení, práce přesčas, transparentnosti a způsobu vedení lidí. Komunita v IT je důležitá pro učení, networking a sdílení zkušeností. Patří sem meetupy, open source, Discord/Slack komunity, odborné konference nebo školní projekty.

### Praktická část

Student vezme ukázkové CV a hodnotí, zda je přehledné, konkrétní, přizpůsobené pozici a pravdivé. Měl by navrhnout, co by zkrátil, co doplnil a jak lépe popsat projekty.

---

## 14. Agilní metody, waterfall, Scrum, Kanban, UML a diagramy

### Osnova odpovědi

- Waterfall vs. Agile.
- Výhody, nevýhody a vhodnost obou přístupů.
- Scrum: role, sprint, backlog, ceremonie.
- Kanban a práce s tokem úkolů.
- UML, use case diagram a vývojový diagram.
- Praktické vysvětlení diagramu.

### Výukový text

Waterfall, neboli vodopád, je přístup, kde fáze projektu následují postupně: analýza, návrh, implementace, testování, nasazení. Hodí se tam, kde jsou požadavky stabilní, prostředí regulované a změny drahé. Výhodou je jasný plán a dokumentace. Nevýhodou je horší reakce na změny a riziko, že uživatel uvidí výsledek pozdě.

Agile je přístup, který počítá se změnou a dodává software po menších částech. Tým pravidelně získává zpětnou vazbu a upravuje priority. Výhodou je flexibilita, rychlejší dodávka hodnoty a větší zapojení zákazníka. Nevýhodou může být chaos, pokud tým nemá disciplínu, jasné cíle a kvalitní komunikaci.

Scrum je agilní rámec. Product owner odpovídá za hodnotu produktu a priority v backlogu. Scrum master pomáhá týmu dodržovat Scrum a odstraňuje překážky. Developers jsou lidé, kteří produkt tvoří. Sprint je krátké časové období, často dva týdny, během kterého tým dokončí vybranou část práce. Backlog je seřazený seznam požadavků, úkolů a nápadů.

Scrum používá události jako sprint planning, daily scrum, sprint review a retrospective. Na plánování se vybírá práce do sprintu. Daily je krátká pravidelná synchronizace. Review ukazuje hotový výsledek stakeholderům. Retrospektiva řeší, jak tým zlepší spolupráci.

Kanban se soustředí na vizualizaci práce a plynulý tok úkolů. Typická tabule má sloupce jako To Do, In Progress, Review, Done. Důležitý je WIP limit, tedy omezení rozpracované práce. Kanban se hodí pro průběžnou podporu, údržbu nebo týmy, kde práce přichází nepravidelně.

UML je sada diagramů pro popis softwarových systémů. Use case diagram ukazuje aktéry a případy užití, tedy co uživatelé se systémem dělají. Vývojový diagram ukazuje postup kroků, rozhodování a větvení. Hodí se pro vysvětlení algoritmu nebo procesu, například přihlášení uživatele.

### Praktická část

Student může popsat use case diagram e-shopu: aktér zákazník, use case vyhledat produkt, vložit do košíku, objednat, zaplatit. Vývojový diagram může popsat přihlášení: zadání e-mailu a hesla, kontrola údajů, úspěch nebo chyba.

---

## 15. Open source, distribuované verzování, Git a GitHub/GitLab

### Osnova odpovědi

- Co je open source a proprietární software.
- Výhody a nevýhody open source.
- Licence a komunita.
- Proč je důležité verzování.
- Git: repozitář, commit, branch, merge, conflict.
- Praktické příkazy: clone, fetch, pull, add, commit, push.

### Výukový text

Open source software je software, jehož zdrojový kód je veřejně dostupný a licence umožňuje jeho používání, studium, úpravu a často i další šíření. Proprietární software má zdrojový kód uzavřený a uživatel má práva daná licencí výrobce. Open source neznamená automaticky zdarma bez pravidel. I open source má licence, například MIT, Apache, GPL nebo BSD, a každá stanovuje jiné podmínky.

Výhodou open source pro vývojáře je možnost učit se z reálného kódu, opravovat chyby a přispívat do komunity. Pro firmy je výhodou nižší závislost na jednom dodavateli, transparentnost a rychlý vývoj. Pro uživatele může být výhodou cena a důvěra v kontrolovatelný kód. Nevýhodou může být nejasná odpovědnost, různá kvalita dokumentace, nutnost hlídat licence a bezpečnostní aktualizace.

Příklady open source projektů jsou Linux, Python, PostgreSQL, Firefox, Kubernetes, Git, React nebo LibreOffice. Komunita je důležitá, protože přináší opravy, dokumentaci, návody, testování a nové nápady. Přispívat lze kódem, dokumentací, překladem, hlášením chyb, testováním nebo odpovídáním v diskusích.

Verzování je důležité, protože umožňuje sledovat historii změn, vrátit se ke starší verzi, pracovat v týmu a spojovat změny více lidí. Distribuované verzování znamená, že každý vývojář má vlastní kopii historie repozitáře, nejen pracovní soubory. Git je nejznámější distribuovaný verzovací systém. GitHub a GitLab jsou platformy nad Gitem, které přidávají webové rozhraní, pull/merge requesty, issue tracking a CI/CD.

Repozitář je úložiště projektu včetně historie. Commit je uložená změna s popisem. Branch je větev vývoje, kde lze pracovat na funkci odděleně od hlavní větve. Merge spojuje větve. Konflikt vznikne, když Git nedokáže automaticky rozhodnout, která změna má platit, například když dva lidé upraví stejný řádek. Vývojář musí konflikt ručně vyřešit.

Fetch stáhne informace ze vzdáleného repozitáře, ale nesloučí je do aktuální větve. Pull typicky udělá fetch a následně merge nebo rebase. Rebase přepíše základ větve tak, jako by změny vznikly nad novější verzí. Reset umí vracet větev nebo pracovní stav ke konkrétnímu commitu, ale musí se používat opatrně, hlavně u sdílené historie.

Před Gitem se používaly například CVS, Subversion nebo Mercurial. Subversion je centralizovaný systém, kde je hlavní historie na serveru. Git se prosadil díky rychlosti, práci offline a snadné práci s větvemi.

### Praktická část

Základní posloupnost:

```bash
git clone <url>
git status
git add .
git commit -m "Popis změny"
git push
```

Student by měl umět vysvětlit, co každý příkaz dělá, a ukázat, že commit není totéž co push. Commit ukládá změnu lokálně, push ji odesílá na vzdálený server.

---

## 16. Sociální sítě, sběr dat, personalizace, AI a dopady na společnost

### Osnova odpovědi

- Proč sociální sítě vznikly a jak se změnily.
- Obchodní model a pozornost uživatele.
- Sběr dat a personalizovaný obsah.
- Dopady na duševní zdraví.
- Porovnání TikTok, Instagram, Facebook, X, LinkedIn.
- AI v algoritmech a odpovědnost provozovatelů.

### Výukový text

Sociální sítě vznikly jako nástroje pro propojení lidí, sdílení informací, kontakt s přáteli a vytváření komunit. Postupně se změnily v rozsáhlé mediální platformy, kde se mísí osobní komunikace, zábava, reklama, politika, zpravodajství a obchod. Uživatel už není jen čtenář, ale zároveň tvůrce obsahu a zdroj dat.

Podstatou fungování sociálních sítí je síťový efekt: čím více lidí platformu používá, tím je pro ostatní hodnotnější. Mnoho platforem profituje z reklamy. Čím déle uživatel zůstane, tím více reklam lze zobrazit a tím více dat lze využít pro cílení. Proto algoritmy optimalizují obsah tak, aby udržel pozornost.

Sítě sbírají data přímo i nepřímo. Přímá data jsou profil, příspěvky, fotky, přátelé, lajky a komentáře. Nepřímá data jsou čas strávený u příspěvku, poloha, zařízení, kliknutí, vyhledávání nebo typ obsahu, který uživatel přeskočí. Personalizovaný obsah znamená, že každý uživatel vidí jiný výběr příspěvků podle odhadu, co ho zaujme.

Dopad na duševní zdraví souvisí se srovnáváním, tlakem na vzhled, závislostním chováním, strachem z promeškání, kyberšikanou a zahlcením informacemi. Krátká videa a nekonečný feed využívají princip rychlé odměny. Uživatel má pocit, že ještě jedno video nic neznamená, ale ve výsledku stráví na síti dlouhou dobu.

TikTok je zaměřený na krátká videa a silný doporučovací algoritmus. Instagram je vizuální síť zaměřená na fotky, reels, influencery a značky. Facebook je širší sociální síť s komunitami, událostmi a starší uživatelskou základnou. X je síť pro krátké veřejné příspěvky, politiku, média a rychlé komentáře. LinkedIn je profesní síť pro kariéru, pracovní nabídky, networking a odborný obsah.

AI se používá k doporučování obsahu, detekci závadného obsahu, cílení reklamy, automatickým překladům, rozpoznávání obrazu a generování nebo úpravě obsahu. Provozovatelé sociálních sítí mají odpovědnost za ochranu dat, transparentnost reklam, boj s nelegálním obsahem, ochranu nezletilých a moderaci. Zároveň je složité najít rovnováhu mezi svobodou projevu, bezpečností a obchodními zájmy.

### Praktická část

Student může porovnat pět platforem podle cílové skupiny, typu obsahu, způsobu monetizace a rizik. Dobrý závěr je, že sociální sítě nejsou jen technologie, ale ekonomické a společenské prostředí ovlivňující chování lidí.

---

## 17. Digitální stopa, OSINT, social engineering, kyberútoky a dezinformace

### Osnova odpovědi

- Co je digitální stopa a kdo ji zanechává.
- Aktivní a pasivní digitální stopa.
- OSINT a jeho legální využití.
- Social engineering a běžné kyberútoky.
- Dezinformace, psychologie a cílové skupiny.
- Role AI ve fake news a obraně proti nim.

### Výukový text

Digitální stopa je soubor informací, které po sobě člověk nebo organizace zanechává v digitálním prostředí. Aktivní stopa vzniká vědomě, například příspěvky na sociálních sítích, komentáře, fotky, životopis nebo vlastní web. Pasivní stopa vzniká méně viditelně: logy serverů, cookies, poloha, metadata fotek, historie vyhledávání nebo informace o zařízení.

Digitální stopu nelze úplně smazat, ale lze ji kontrolovat. Pomáhá silné nastavení soukromí, opatrné sdílení, mazání nepotřebných účtů, kontrola oprávnění aplikací, oddělení pracovních a osobních profilů a pravidelné vyhledání vlastního jména na internetu. Důležité je přemýšlet, zda by zveřejněná informace nemohla být zneužita.

OSINT znamená Open Source Intelligence, tedy získávání informací z veřejně dostupných zdrojů. Používá se v bezpečnosti, investigativní žurnalistice, náboru, analýze firem nebo ověřování informací. Legální OSINT neznamená hackování. Pracuje s tím, co je veřejně dostupné, například weby, registry, sociální sítě, mapy, metadata, tiskové zprávy nebo veřejné databáze.

Social engineering je manipulace člověka za účelem získání informací, přístupu nebo peněz. Útočník často využívá strach, spěch, autoritu, zvědavost, důvěru nebo chamtivost. Příkladem je phishingový e-mail, falešný telefonát z banky, podvodná SMS o balíku nebo vydávání se za kolegu.

Mezi běžné kyberútoky patří phishing, malware, ransomware, DDoS, credential stuffing, zneužití slabých hesel, podvodné odkazy, útoky na webové aplikace a krádež identity. Phishing se snaží vylákat přihlašovací údaje. Ransomware zašifruje data a požaduje výkupné. DDoS zahlcuje službu provozem. Credential stuffing zkouší uniklé kombinace e-mailů a hesel na dalších službách. APT znamená Advanced Persistent Threat, tedy dlouhodobý cílený útok často spojený s dobře vybavenou skupinou.

Dezinformace cílí na emoce, hlavně strach, hněv, pocit ohrožení a potvrzení vlastního názoru. Více jim mohou podléhat lidé s nízkou mediální gramotností, lidé v informačních bublinách nebo lidé pod stresem. Témata často souvisí s válkou, zdravím, migrací, ekonomikou, volbami a nedůvěrou v instituce.

AI může fake news zrychlit a zlevnit. Umí generovat texty, obrázky, falešné profily, deepfake videa nebo hlasové nahrávky. Na druhou stranu se AI používá i k detekci manipulací, moderaci obsahu a analýze šíření dezinformací. Obrana spočívá v ověřování zdrojů, hledání původní informace, kontrole data, porovnání více zdrojů, mediální gramotnosti a opatrnosti vůči silně emotivnímu obsahu.

### Praktická část

Student může vybrat aktuální dezinformační téma a bezpečně analyzovat, proč se šíří: kdo z něj profituje, jaké emoce vyvolává, jaké zdroje ho podporují a jak lze informaci ověřit. U OSINT ukázky je důležité pracovat jen s veřejnými informacemi a nezasahovat do soukromí konkrétních osob.

---

## 18. DeFi, blockchain a kryptoměny

### Osnova odpovědi

- Co je blockchain a distribuovaná účetní kniha.
- Blok, transakce, hash, řetězení bloků.
- Konsenzus: Proof of Work a Proof of Stake.
- Kryptoměny, Bitcoin, peněženky a privátní klíče.
- DeFi, smart contracts, DEX, stablecoiny, staking.
- Výhody, rizika a využití mimo finance.

### Výukový text

Blockchain je databázová technologie, která ukládá záznamy do bloků propojených kryptograficky. Říká se mu distribuovaná účetní kniha, protože kopii záznamů drží mnoho účastníků sítě a není nutné mít jednu centrální autoritu. Každý blok obsahuje transakce, časové informace a hash předchozího bloku. Hash je krátký otisk dat. Pokud by někdo změnil starý blok, změnil by se jeho hash a narušilo by se navázání dalších bloků.

Konsenzus je mechanismus, kterým se síť shodne, jaký stav je platný. Proof of Work používá výpočetní práci, například u Bitcoinu. Těžaři soutěží v řešení náročné úlohy a za nalezení bloku dostávají odměnu. Nevýhodou je vysoká energetická náročnost. Proof of Stake vybírá validátory podle množství uzamčené kryptoměny a dalších pravidel. Je energeticky úspornější, ale má jiné otázky kolem centralizace a správy.

Kryptoměna je digitální aktivum používající kryptografii a obvykle blockchain. Bitcoin vznikl jako decentralizovaná digitální měna bez centrální banky. Byl vytvořen po finanční krizi jako alternativa k tradičnímu finančnímu systému. Nové bitcoiny vznikají těžbou a jejich celkový počet je omezený. Uživatel kryptoměny používá peněženku a privátní klíč. Kdo ztratí privátní klíč, může přijít o přístup k prostředkům.

DeFi znamená Decentralized Finance, tedy decentralizované finanční služby. Cílem je poskytovat služby jako směna, půjčky, úročení nebo obchodování bez klasické banky či burzy. Klíčovou roli hrají smart contracts, což jsou programy běžící na blockchainu. Pokud jsou splněny podmínky, kontrakt provede akci automaticky.

Decentralizované burzy, DEX, umožňují směnu tokenů přímo přes smart contracty. Stablecoiny jsou kryptoměny navázané na hodnotu jiné měny, například amerického dolaru. Staking znamená uzamčení kryptoměny pro podporu sítě a získání odměny. Yield farming je hledání výnosu napříč DeFi protokoly, často s vyšším rizikem.

Výhodou blockchainu je transparentnost, odolnost proti jednostranné změně dat a možnost fungovat bez centrální autority. Rizika zahrnují volatilitu, podvody, chyby ve smart contractech, ztrátu klíčů, hacky, regulatorní nejistotu a složitost pro běžného uživatele. Mimo finance lze blockchain použít pro dodavatelské řetězce, ověřování dokumentů, digitální identitu nebo sledování původu zboží, ale vždy je nutné ptát se, zda blockchain opravdu přináší výhodu oproti běžné databázi.

### Praktická část

Student může nakreslit řetězec bloků: blok 1, blok 2, blok 3, každý má hash předchozího bloku. Potom vysvětlí, proč změna staré transakce rozbije návaznost. U DeFi je dobré zdůraznit, že „decentralizované“ neznamená automaticky bezpečné.

---

## 19. IoT, internet věcí, využití, rizika a technologie

### Osnova odpovědi

- Co je Internet of Things.
- Rozdíl mezi klasickým internetem a internetem věcí.
- Senzory, aktuátory, IoT zařízení.
- Komunikační technologie a cloud.
- Využití v domácnosti, průmyslu, dopravě, zdravotnictví, zemědělství.
- Bezpečnost, soukromí, AI a big data.

### Výukový text

IoT, Internet of Things, znamená propojení fyzických zařízení s internetem. Nejde jen o počítače a mobily, ale o senzory, kamery, hodinky, domácí spotřebiče, auta, průmyslové stroje, měřiče energií nebo dopravní systémy. Klasický internet propojuje hlavně lidi a počítače. Internet věcí propojuje objekty, které samy sbírají data, komunikují a někdy i automaticky reagují.

Senzor měří vlastnost okolí, například teplotu, vlhkost, polohu, pohyb, tlak, světlo nebo kvalitu vzduchu. Aktuátor naopak něco vykonává, například sepne topení, otevře ventil, rozsvítí světlo nebo zastaví stroj. IoT zařízení často obsahuje senzor, malý procesor, komunikační modul a napájení.

Pro komunikaci se používá Wi-Fi, Bluetooth, Zigbee, Z-Wave, LoRaWAN, NB-IoT, mobilní sítě, Ethernet nebo specializované průmyslové protokoly. Na aplikační úrovni se často používá MQTT, HTTP nebo AMQP. MQTT je lehký protokol vhodný pro zasílání zpráv mezi zařízeními a serverem.

Cloud computing se v IoT používá pro ukládání dat, analýzu, vizualizaci a vzdálené řízení zařízení. Někdy se používá edge computing, kdy se část zpracování provádí přímo u zařízení nebo v blízkosti zdroje dat. To snižuje latenci a množství dat posílaných do cloudu.

V domácnosti IoT zahrnuje chytré žárovky, termostaty, zásuvky, kamery, zámky nebo hlasové asistenty. V průmyslu se používá pro prediktivní údržbu, sledování výroby a optimalizaci spotřeby. V dopravě sleduje polohu vozidel, obsazenost, zpoždění nebo provoz. Ve zdravotnictví pomáhá s monitoringem pacientů a nositelnými zařízeními. V zemědělství měří vlhkost půdy, počasí nebo stav plodin. Smart cities využívají IoT pro dopravu, parkování, osvětlení, odpad nebo kvalitu ovzduší.

Bezpečnost IoT je velké téma. Mnoho zařízení má slabá hesla, dlouho nedostává aktualizace nebo sbírá citlivá data. Útočník může zneužít kameru, chytrý zámek nebo zařízení zapojit do botnetu. Soukromí ohrožuje hlavně nepřehledný sběr dat o pohybu, chování a domácnosti uživatele.

IoT souvisí s AI a big data, protože generuje obrovské množství dat. AI může z dat hledat vzory, předpovídat poruchy, optimalizovat dopravu nebo detekovat anomálie. Hodnota IoT není jen v zařízení, ale hlavně v datech a rozhodnutích, která z nich vzniknou.

### Praktická část

Student může popsat data z dopravního systému, například aktuální polohu vozidel PID. Vysvětlí, jak zařízení nebo systém sbírá polohu, odešle ji přes síť, uloží na serveru a zobrazí uživateli v mapě. Dobrý příklad záznamu dat obsahuje čas, identifikátor vozidla, GPS souřadnice, linku a směr.

---

## 20. IT a právo, odpovědnost, licence, ISO, GDPR, NIS2, DORA a AI Act

### Osnova odpovědi

- Právní odpovědnost ve firmách v souvislosti s IT.
- Licence, správa softwaru, knihovny a open source.
- Směrnice, normy, ISO a webové standardy.
- GDPR a práva občanů.
- NIS2, DORA a rozdíl mezi nimi.
- AI Act a rizikové kategorie AI.

### Výukový text

IT ve firmě není jen technická otázka, ale také právní a organizační odpovědnost. Firma musí chránit data, dodržovat licence, řídit přístupy, spravovat bezpečnost, plnit smlouvy a respektovat regulace. Odpovědnost může nést vedení firmy, IT oddělení, bezpečnostní manažer, právní oddělení, pověřenec pro ochranu osobních údajů nebo konkrétní dodavatel podle smlouvy. V praxi je důležité mít jasné role, interní směrnice a evidenci rozhodnutí.

Správa softwarových licencí znamená vědět, jaký software firma používá, kolik licencí má, kdo je používá a za jakých podmínek. Nelegální software může vést k pokutám, bezpečnostním rizikům a reputační škodě. Rizikové nejsou jen velké programy, ale také knihovny v aplikacích. I open source knihovna má licenci a firma musí vědět, zda ji smí použít v komerčním produktu, zda musí zveřejnit zdrojový kód nebo uvést autora.

U knihoven je důležitá také bezpečnost a údržba verzí. Zastaralá knihovna může obsahovat známou zranitelnost. Firmy proto používají nástroje pro Software Composition Analysis, dependency scanning a evidenci SBOM, tedy Software Bill of Materials. SBOM je seznam komponent, ze kterých se software skládá.

Směrnice jsou interní pravidla firmy, například pravidla pro hesla, zálohování, přístup k datům nebo práci z domova. Normy ISO jsou mezinárodní standardy. V IT je známá ISO/IEC 27001 pro systém řízení bezpečnosti informací. Certifikace ISO může firmě pomoci prokázat zákazníkům a partnerům, že má řízené procesy. Webové standardy spravuje mimo jiné W3C. Díky standardům mohou weby fungovat napříč prohlížeči a zařízeními. ASCII je historický standard pro kódování základních znaků; dnes se často používá UTF-8.

GDPR je obecné nařízení EU o ochraně osobních údajů. Osobní údaj je informace, podle které lze přímo nebo nepřímo identifikovat člověka. Občan má právo na informace, přístup k údajům, opravu, výmaz, omezení zpracování, přenositelnost a námitku. Firma musí mít právní důvod zpracování, chránit data, zpracovávat jen potřebné údaje, informovat subjekty údajů a řešit incidenty. Za závažné porušení GDPR mohou hrozit vysoké pokuty, často se uvádí až 20 milionů eur nebo 4 % celosvětového ročního obratu podle typu porušení.

NIS2 je evropská směrnice zaměřená na kybernetickou bezpečnost důležitých a vybraných organizací. Týká se například energetiky, dopravy, zdravotnictví, digitální infrastruktury, veřejné správy a dalších sektorů. Požaduje řízení rizik, bezpečnostní opatření, hlášení incidentů, odpovědnost vedení a práci s dodavatelským řetězcem. Přesné povinnosti a sankce závisí na národní implementaci, proto je vhodné ověřit aktuální českou právní úpravu.

DORA je evropské nařízení pro digitální provozní odolnost finančního sektoru. Zaměřuje se na banky, pojišťovny, investiční společnosti a také významné ICT dodavatele pro finanční sektor. Řeší řízení ICT rizik, testování odolnosti, hlášení incidentů, řízení dodavatelů a kontinuitu provozu. Rozdíl mezi NIS2 a DORA je v zaměření: NIS2 je širší kyberbezpečnostní rámec pro mnoho sektorů, DORA je specifická pro finanční sektor a jeho digitální odolnost.

AI Act je evropské nařízení regulující umělou inteligenci podle rizikovosti. Cílem je chránit bezpečnost, základní práva a důvěru v AI. Některé praktiky jsou zakázané, například určité formy manipulace nebo nepřípustného sociálního hodnocení. Vysokorizikové AI systémy mají přísné povinnosti kolem dat, dokumentace, řízení rizik, transparentnosti a lidského dohledu. Systémy s omezeným rizikem musí být transparentní, například uživatel má vědět, že komunikuje s chatbotem nebo že obsah může být generovaný AI. Pro běžné uživatele AI Act znamená více informací, ochrany a odpovědnosti poskytovatelů.

### Praktická část

Student může popsat fiktivní firmu, která vyvíjí webovou aplikaci. Musí evidovat licence použitých knihoven, chránit osobní údaje uživatelů, mít pravidla pro přístupy, aktualizovat závislosti, zálohovat data a řešit incidenty. U AI služby musí navíc vědět, jaká data posílá do modelu, zda uživatele informuje o AI a zda systém nespadá do vyšší rizikové kategorie.

---

## Krátké závěrečné rady pro studenta

- U každé otázky začni definicí a jednoduchým příkladem.
- Nevyjmenovávej jen pojmy, vždy vysvětli vztah mezi nimi.
- Praktickou část popisuj nahlas krok za krokem, jako bys učil někoho mladšího.
- Když nevíš detail, přiznej hranici znalosti a vrať se k principu.
- Dobrá odpověď má jasnou strukturu: co to je, jak to funguje, kde se to používá, jaká jsou rizika, jak bych to ukázal prakticky.
