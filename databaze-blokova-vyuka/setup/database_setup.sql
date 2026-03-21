-- Settings
-- Number of students to create
DECLARE @UserCount INT = 10;
DECLARE @UserPrefix SYSNAME = N'student';
DECLARE @PwdLength INT = 14;

-- Create role (if it does not exist)
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'db_students' AND type = 'R')
BEGIN
    CREATE ROLE db_students;
END

-- Grant SELECT on SalesLT schema to the role
GRANT SELECT ON SCHEMA::SalesLT TO db_students;

-- Output table (user + password)
IF OBJECT_ID('tempdb..#Created') IS NOT NULL DROP TABLE #Created;
CREATE TABLE #Created (idx INT IDENTITY(1,1), username SYSNAME, password NVARCHAR(128));

-- Loop to create users, schemas, permissions, and role membership
DECLARE @i INT = 1; -- Start from 1 for better readability in usernames (student01, student02, etc.)
DECLARE @sql NVARCHAR(MAX); -- Variable to hold dynamic SQL statements

WHILE @i <= @UserCount
BEGIN
    DECLARE @numStr NVARCHAR(4) = RIGHT('00' + CAST(@i AS VARCHAR(3)), 2); -- Format number with leading zeros (e.g., 01, 02, ..., 10)
    DECLARE @username SYSNAME = @UserPrefix + @numStr; -- Construct username (e.g., student01, student02, etc.)

    -- Generate a simple random password from NEWID
    DECLARE @raw NVARCHAR(64) = REPLACE(NEWID(),'-','');
    DECLARE @randPart NVARCHAR(64) = LEFT(@raw, @PwdLength - 4);
    DECLARE @password NVARCHAR(128) = UPPER(LEFT(@raw,1)) + N'@' + @randPart + RIGHT('0' + CAST((ABS(CHECKSUM(NEWID())) % 99) AS VARCHAR(2)),2);

    -- Check if user already exists to avoid errors
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @username)
    BEGIN
        -- Create contained user with password
        SET @sql = N'CREATE USER ' + QUOTENAME(@username) + N' WITH PASSWORD = ' + QUOTENAME(@password,'''') + N';';
        EXEC sp_executesql @sql;

        -- Create schema owned by the user
        SET @sql = N'CREATE SCHEMA ' + QUOTENAME(@username) + N' AUTHORIZATION ' + QUOTENAME(@username) + N';';
        EXEC sp_executesql @sql;

        -- Grant object creation permissions (CREATE TABLE/VIEW/PROC)
        SET @sql = N'GRANT CREATE TABLE TO ' + QUOTENAME(@username) + N';';
        EXEC sp_executesql @sql;
        SET @sql = N'GRANT CREATE VIEW TO ' + QUOTENAME(@username) + N';';
        EXEC sp_executesql @sql;
        SET @sql = N'GRANT CREATE PROCEDURE TO ' + QUOTENAME(@username) + N';';
        EXEC sp_executesql @sql;

        -- Add user to db_students role
        SET @sql = N'ALTER ROLE db_students ADD MEMBER ' + QUOTENAME(@username) + N';';
        EXEC sp_executesql @sql;

        INSERT INTO #Created (username, password) VALUES (@username, @password);
    END
    ELSE
    BEGIN
        INSERT INTO #Created (username, password) VALUES (@username, N'EXISTS');
    END

    SET @i = @i + 1;
END

-- Output created users and passwords for copy/paste
SELECT idx AS [#], username AS [User], password AS [Password] FROM #Created ORDER BY idx;