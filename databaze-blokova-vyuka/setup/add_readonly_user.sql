-- Create a SQL user with a password.
CREATE USER [readonly_user] WITH PASSWORD = 'YourSecurePasswordHere';
GO

-- Assign read-only access by adding the user to db_datareader role.
ALTER ROLE db_datareader ADD MEMBER [readonly_user];
GO