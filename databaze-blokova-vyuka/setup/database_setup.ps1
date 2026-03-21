<#
.SYNOPSIS
Creates an Azure SQL Server and sample AdventureWorksLT database.

.DESCRIPTION
This script creates the target resource group (if it does not already exist),
provisions an Azure SQL logical server, enables Azure services access through
the firewall rule, and creates the AdventureWorksLT sample database.

.PARAMETER resourceGroup
The name of the Azure resource group.

.PARAMETER location
The Azure region where resources are deployed.

.PARAMETER sqlServerName
The Azure SQL logical server name (must be globally unique).

.PARAMETER sqlAdminUser
The SQL administrator username for the server.

.PARAMETER databaseName
The name of the SQL database to create.

.PARAMETER allowIPRange
IPv4 CIDR range allowed through SQL Server firewall (for example, 10.1.0.0/24).

.EXAMPLE
.\database_setup.ps1 -resourceGroup "RG-Database-Lab" -location "westeurope" -sqlServerName "sql-lab-server-001" -sqlAdminUser "sqladmin" -sqlAdminPassword "P@ssw0rd123!" -databaseName "AdventureWorksLT" -allowIPRange "10.1.0.0/24"
#>

# ================================
# PARAMETERS
# ================================
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$resourceGroup,

    [Parameter(Mandatory = $true)]
    [string]$location,

    [Parameter(Mandatory = $true)]
    [string]$sqlServerName,     # must be globally unique

    [Parameter(Mandatory = $true)]
    [string]$sqlAdminUser,

    [Parameter(Mandatory = $true)]
    [string]$databaseName,

    [Parameter(Mandatory = $true)]
    [string]$allowIPRange
)

function Convert-CidrToIpRange {
    # Converts IPv4 CIDR notation (for example, 10.1.0.0/24)
    # to a start and end IP address range.
    param(
        [Parameter(Mandatory = $true)]
        [string]$Cidr
    )

    # Validate supported IPv4 CIDR format and prefix length (0-32).
    if ($Cidr -notmatch '^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)/(3[0-2]|[12]?\d)$') {
        throw "Invalid allowIPRange format. Use IPv4 CIDR format, for example: 10.1.0.0/24"
    }

    # Split CIDR into IP and prefix length.
    $parts = $Cidr.Split('/')
    $ip = [System.Net.IPAddress]::Parse($parts[0])
    $prefix = [int]$parts[1]

    # Convert IP to UInt32 for bitwise network calculations.
    $ipBytes = $ip.GetAddressBytes()
    [Array]::Reverse($ipBytes)
    $ipInt = [BitConverter]::ToUInt32($ipBytes, 0)

    # Build subnet mask, then compute network and broadcast addresses.
    $maskInt = if ($prefix -eq 0) { 0u } else { ([uint32]::MaxValue -shl (32 - $prefix)) }
    $networkInt = $ipInt -band $maskInt
    $broadcastInt = $networkInt -bor (-bnot $maskInt)

    # Convert network address back to dotted-quad string.
    $startBytes = [BitConverter]::GetBytes($networkInt)
    [Array]::Reverse($startBytes)
    $startIp = ([System.Net.IPAddress]::new($startBytes)).ToString()

    # Convert broadcast address back to dotted-quad string.
    $endBytes = [BitConverter]::GetBytes($broadcastInt)
    [Array]::Reverse($endBytes)
    $endIp = ([System.Net.IPAddress]::new($endBytes)).ToString()

    # Return object compatible with New-AzSqlServerFirewallRule parameters.
    return [PSCustomObject]@{
        StartIpAddress = $startIp
        EndIpAddress = $endIp
    }
}

$allowedRange = Convert-CidrToIpRange -Cidr $allowIPRange

# ================================
# Create resource group
# ================================
New-AzResourceGroup -Name $resourceGroup -Location $location

# ================================
# Prompt user to provide SQL administrator password if not provided as a parameter
# ================================
$sqlAdminPassword = Read-Host -Prompt "Enter SQL administrator password" -AsSecureString



# ================================
# Create SQL Server
# ================================
New-AzSqlServer `
    -ResourceGroupName $resourceGroup `
    -ServerName $sqlServerName `
    -Location $location `
    -SqlAdministratorCredentials (New-Object System.Management.Automation.PSCredential($sqlAdminUser,$sqlAdminPassword))

# ================================
# Allow Azure services access
# ================================
New-AzSqlServerFirewallRule `
    -ResourceGroupName $resourceGroup `
    -ServerName $sqlServerName `
    -FirewallRuleName "AllowAzure" `
    -StartIpAddress $allowedRange.StartIpAddress `
    -EndIpAddress $allowedRange.EndIpAddress

# ================================
# Create AdventureWorksLT database
# ================================
New-AzSqlDatabase `
    -ResourceGroupName $resourceGroup `
    -ServerName $sqlServerName `
    -DatabaseName $databaseName `
    -Edition "Basic" `
    -RequestedServiceObjectiveName "Basic" `
    -SampleName "AdventureWorksLT" `
    -ZoneRedundant $false 

Write-Host "Azure SQL Server and AdventureWorksLT database were created successfully."