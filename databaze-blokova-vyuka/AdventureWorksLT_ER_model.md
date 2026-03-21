# Zjednodušený ER model vzorové databáze AdventureWorksLT

## 1. Customer oblast

### 1.1 `SalesLT.Customer`

- **Primární klíč:**
  - `CustomerID`
- **Atributy (výběr):**
  - `FirstName`
  - `LastName`
  - `EmailAddress`
  - `Phone`
  - `CompanyName`
- **Vazby:**
  - 1:N na `SalesLT.SalesOrderHeader` (`CustomerID`)
  - 1:N na `SalesLT.CustomerAddress` (`CustomerID`)

---

### 1.2 `SalesLT.CustomerAddress`

- **Primární klíč:**
  - `CustomerID`
  - `AddressID`
- **Cizí klíče:**
  - `CustomerID` → `SalesLT.Customer.CustomerID`
  - `AddressID` → `SalesLT.Address.AddressID`
- **Atributy:**
  - `AddressType` (např. Billing, Shipping)

---

### 1.3 `SalesLT.Address`

- **Primární klíč:**
  - `AddressID`
- **Atributy (výběr):**
  - `AddressLine1`
  - `City`
  - `StateProvince`
  - `CountryRegion`
  - `PostalCode`
- **Vazby:**
  - 1:N na `SalesLT.CustomerAddress` (`AddressID`)
  - 1:N na `SalesLT.SalesOrderHeader` (`ShipToAddressID`, `BillToAddressID`)

---

## 2. Sales oblast (objednávky)

### 2.1 `SalesLT.SalesOrderHeader`

- **Primární klíč:**
  - `SalesOrderID`
- **Cizí klíče:**
  - `CustomerID` → `SalesLT.Customer.CustomerID`
  - `ShipToAddressID` → `SalesLT.Address.AddressID`
  - `BillToAddressID` → `SalesLT.Address.AddressID`
- **Atributy (výběr):**
  - `OrderDate`
  - `DueDate`
  - `ShipDate`
  - `SubTotal`
  - `TaxAmt`
  - `Freight`
  - `TotalDue`
- **Vazby:**
  - 1:N na `SalesLT.SalesOrderDetail` (`SalesOrderID`)

---

### 2.2 `SalesLT.SalesOrderDetail`

- **Primární klíč:**
  - `SalesOrderID`
  - `SalesOrderDetailID`
- **Cizí klíče:**
  - `SalesOrderID` → `SalesLT.SalesOrderHeader.SalesOrderID`
  - `ProductID` → `SalesLT.Product.ProductID`
- **Atributy (výběr):**
  - `OrderQty`
  - `UnitPrice`
  - `UnitPriceDiscount`
  - (často používaný výpočet: `OrderQty * UnitPrice`)

---

## 3. Product oblast

### 3.1 `SalesLT.Product`

- **Primární klíč:**
  - `ProductID`
- **Cizí klíče:**
  - `ProductCategoryID` → `SalesLT.ProductCategory.ProductCategoryID`
  - `ProductModelID` → `SalesLT.ProductModel.ProductModelID`
- **Atributy (výběr):**
  - `Name`
  - `ProductNumber`
  - `Color`
  - `StandardCost`
  - `ListPrice`
  - `Size`
  - `Weight`
- **Vazby:**
  - 1:N na `SalesLT.SalesOrderDetail` (`ProductID`)

---

### 3.2 `SalesLT.ProductCategory`

- **Primární klíč:**
  - `ProductCategoryID`
- **Cizí klíče:**
  - `ParentProductCategoryID` → `SalesLT.ProductCategory.ProductCategoryID` (hierarchie kategorií)
- **Atributy:**
  - `Name`
- **Vazby:**
  - 1:N na `SalesLT.Product` (`ProductCategoryID`)

---

### 3.3 `SalesLT.ProductModel`

- **Primární klíč:**
  - `ProductModelID`
- **Atributy:**
  - `Name`
- **Vazby:**
  - 1:N na `SalesLT.Product` (`ProductModelID`)