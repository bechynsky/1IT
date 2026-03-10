# Bezpečnost
```mermaid
graph TD
    A[Fyzická bezpečnost] --> B[Identita & přístup]
    B --> C[Perimetr]
    C --> D[Síť]
    D --> E[Výpočetní prostředí]
    E --> F[Aplikace]
    F --> G[Data]   
```

```mermaid
flowchart TD
    A["Fyzická bezpečnost
Základní ochrana hardware a místností: zámky, karty, kamery, ostraha a požární/klimatická ochrana v serverovnách. Bez toho jsou ostatní vrstvy k ničemu, když lze zařízení ukrást nebo zničit."]
    B["Identita & přístup (IAM)
Řeší, kdo jste a co smíte dělat: silná hesla, vícefaktorové ověření (MFA), role a oprávnění (least privilege), SSO/Entra ID. Každý přístup se eviduje a lze ho zrušit."]
    C["Perimetr
Hranice sítě vůči internetu: firewally, IDS/IPS, WAF a ochrana proti DDoS. Dnes se posouvá k principu Zero Trust – nevěř nikomu jen proto, že je „uvnitř“."]
    D["Síť
Bezpečný provoz uvnitř organizace: segmentace a izolace částí sítě, pravidla (ACL/NSG), filtrování a šifrování komunikace (TLS/IPsec), aby se útočník nemohl volně pohybovat."]
    E["Výpočetní prostředí
Ochrana serverů, virtuálek a kontejnerů: pravidelné aktualizace (patching), hardening OS, antivir/EDR a bezpečné šablony nasazení. Cílem je omezit zranitelnosti."]
    F["Aplikace
Bezpečný vývoj a provoz: DevSecOps v CI/CD, testy proti běžným chybám (OWASP Top 10), validace vstupů a ochrana API. Chyby v aplikaci bývají nejčastější cestou dovnitř."]
    G["Data
To nejdůležitější, co chráníme: šifrování při uložení i přenosu, klasifikace citlivosti, DLP (prevence úniku), zálohování a obnova. Přístup k datům má mít jen ten, kdo je skutečně potřebuje."]

    A --> B --> C --> D --> E --> F --> G
```
    
---

## Autentizace a autorizace
Autentikace ověřuje identitu uživatele, zatímco autorizace určuje, k jakým zdrojům nebo akcím má tento uživatel přístup.

---

## Identity provider (IdP)
- Správa uživatelských účtů
- Zabezpečený přístup
- Autentizace uživatelů
- Příklady: Microsoft Entra ID, Google Identity, Okta

---

## Autentizace přes třetí stranu (federace)
- Místo vlastního IdP aplikace využije existujícího poskytovatele identity (např. Entra ID, Google)
- Aplikace neukládá hesla uživatelů, jen důvěřuje ověření od externího IdP
- Výhody: rychlejší nasazení, vyšší bezpečnost a jednodušší správa účtů
- Běžně se používají standardy OAuth 2.0 a OpenID Connect

---

## Hesla
- Hesla nepoužívat, tam kde to jde
- Silná a jedinečná hesla
- Pravidelná změna hesel
- Nesdílení hesel
- Správce hesel pomáhá ukládat silná unikátní hesla

---

## PIN
- PIN je navázaný na zařízení a chráněný lokálně (typicky přes TPM), neposílá se na server jako heslo
- PIN nenahrazuje úplně heslo účtu: heslo je stále potřeba např. při prvním nastavení, obnově účtu nebo přihlášení na novém zařízení
- PIN není přenositelný mezi zařízeními: na každém PC se nastavuje zvlášť
- Když útočník zná PIN, bez fyzického přístupu k danému zařízení ho obvykle nevyužije

---

## Vícefaktorová autentizace (MFA)
- Zvýšení bezpečnosti
- Riziko neoprávněného přístupu
- Biometrické ověření
- Kombinace faktorů: něco znám (heslo), něco mám (telefon/klíč), něco jsem (biometrie)

---

## Biometrické ověření
- Otisky prstů
- Rozpoznávání obličeje
- Vyšší úroveň zabezpečení

---

## Jednorázová hesla (OTP)
- HOTP mění kód podle počtu použití (counter),
- TOTP mění kód podle času (např. každých 30 s).

---

## Hardwarové bezpečnostní klíče (FIDO/FIDO2)
- Fyzický klíč (např. USB/NFC) pro silné přihlášení
- Odolnost proti phishingu
- Privátní klíč neopouští zařízení, server dostává jen veřejný klíč
- Možné použití jako druhý faktor i bezheslové přihlášení (passkeys)
- Praktické je mít i záložní klíč pro případ ztráty

---

# Sítě

## Referenční model ISO/OSI

```mermaid
graph TD
    A[7. Aplikační] --> B[6. Prezentační]
    B --> C[5. Relační]
    C --> D[4. Transportní]
    D --> E[3. Síťová]
    E --> F[2. Spojová]
    F --> G[1. Fyzická]
```

---

## Firewall
- Ochranná zeď
- Kontrola přístupu
- Pravidelné aktualizace
- Filtrace příchozího i odchozího provozu podle pravidel

---

# Hardware a software

## Hardware
- Ochrana fyzických zařízení

## Starý hardware
- Hardware nemusí být schopen „upočítat“ nejnovější šifrovací algoritmy

---

## Operační systémy (OS)
- Pravidelné aktualizace
- Zabezpečení uživatelských účtů
- Nepoužívat nepodporované verze OS (bez bezpečnostních záplat)
    - Problém u domácí elektroniky

---

## Software
- Antivirový software
- Aktualizace softwaru
- Skenování systému

---

# VPN (Virtual Private Network)
- Šifrované spojení
- Bezpečný přenos dat
- Ochrana před odposlechem
- Skrytí IP adresy
- Vzdálený přístup / veřejná Wi‑Fi

---

# Šifry

## Symetrická vs. asymetrická kryptografie vs. hash
- Symetrické šifrování – jeden klíč
- Asymetrické šifrování – veřejný + privátní klíč
- Hashování – jedinečný otisk dat

---

## Veřejný a privátní klíč
- Veřejný klíč – šifrování
- Privátní klíč – dešifrování
- Privátní klíč se používá i pro digitální podpis

---

## Certifikát a certifikační autority
- Certifikát propojuje identitu (např. doménu) s veřejným klíčem
- Obsahuje např. název subjektu, veřejný klíč, dobu platnosti a digitální podpis vydavatele
- CA (certifikační autorita) ověřuje žadatele a certifikát podepisuje
- Prohlížeč ověřuje řetězec důvěry: certifikát serveru → mezilehlá CA → kořenová CA
- Pokud certifikát neplatí (expirace, jiná doména, nedůvěryhodná CA), spojení je označeno jako rizikové

---

## TLS
- Šifrování dat během přenosu
    - Vytváří šifrovaný komunikační kanál mezi klientem a serverem
- Ochrana citlivých informací
- Asymetrická kryptografie se používá při navázání spojení (ověření identity a výměna klíče)
- Symetrická kryptografie se pak používá pro rychlé šifrování samotných dat
- Prevence útoků

### Přehled verzí SSL/TLS (podle roku vydání)
- SSL 2.0 – 1995 (zastaralé, nebezpečné)
- SSL 3.0 – 1996 (zastaralé, nebezpečné)
- TLS 1.0 – 1999 (zastaralé)
- TLS 1.1 – 2006 (zastaralé)
- TLS 1.2 – 2008 (dlouho standard)
- TLS 1.3 – 2018 (aktuálně doporučené)

---

## Self‑signed certifikát a důvěra
- Certifikát podepsaný vlastní autoritou (ne CA), vhodný hlavně pro testování a interní prostředí
- Omezená důvěra
- V prohlížeči často vyvolá bezpečnostní varování

### Vytvoření self‑signed certifikátu

*OpenSSL*

```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
openssl pkcs12 -in cert.pfx -nocerts -out private.key -nodes
openssl x509 -in cert.pem -pubkey -noout > public.key
```
*PowerShell*

```powershell
New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "cert:\CurrentUser\My" -KeyExportPolicy Exportable
Export-PfxCertificate -Cert "cert:\CurrentUser\My\<THUMBPRINT>" -FilePath .\cert.pfx -Password (ConvertTo-SecureString "Heslo123!" -AsPlainText -Force)
```

---

# Hashování

## SHA‑256
- Moderní hashovací funkce
- Zajištění integrity dat
- Ochrana hesel
- Hash je jednosměrný (z hashe nelze jednoduše získat původní data)

---

## HMAC‑SHA256
- Kombinace hashování a klíče
- Ověření integrity
- Autenticita zpráv

---

## Shared Access Signature (SAS)
- Omezený přístup k datům
- Dočasný přístup
- Podpis je typicky vytvořen pomocí HMAC‑SHA256

---

# Monitoring

## Metody monitoringu
- Sledování síťového provozu
- Logování událostí
- Analýza chování uživatelů

## Nástroje pro monitoring
- Správa logů
- Detekce anomálií
- SIEM systémy
- AI/ML pro rychlejší detekci podezřelého chování
