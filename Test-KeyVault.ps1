# This script create a DNS and attaches it to 

# Set Variables
$id=Get-Random -Maximum 100
$myResourceGroup="dcaro$id"
$location="East US"
$keyVaultName="dcarokv$id"

# Create a resource group.
New-AzResourceGroup -Name $myResourceGroup -Location $location
Get-AzResourceGroup -Name $myResourceGroup

$tenantId = (Get-AzContext).Tenant.Id

# Create KeyVault
New-AzKeyVault -Name $keyVaultName -ResourceGroupName $myResourceGroup -Location $location -SkuName "standard" -TenantId $tenantId
Get-AzKeyVault -Name $keyVaultName -ResourceGroupName $myResourceGroup


# Clean up
Remove-AzResourceGroup -Name $myResourceGroup
