# This script create a DNS and attaches it to 

# Set Variables
$id=Get-Random -Maximum 100
$myResourceGroup="dcaro$id"
$location="East US"
$keyVaultName="dcarokv$id"
$secretValue = "MySecretValue"
$objectId = (Get-AzADUser -Mail "$((Get-AzContext).Account.Id)").ObjectId
$tenantId = (Get-AzContext).Tenant.Id

# Create a resource group.
New-AzResourceGroup -Name $myResourceGroup -Location $location
Get-AzResourceGroup -Name $myResourceGroup

# Create KeyVault
New-AzKeyVault -Name $keyVaultName -ResourceGroupName $myResourceGroup -Location $location -SkuName "standard" -TenantId $tenantId
Get-AzKeyVault -Name $keyVaultName -ResourceGroupName $myResourceGroup


$params= @{ 
    AccessPolicy = 
        @{
            objectId = "$objectId";
            tenantId = "$tenantId";
            PermissionSecret = "set"
        }
    }

Set-AzKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $myResourceGroup -OperationKind replace -Parameter $params

Set-AzKeyVaultSecret -Name $keyVaultName -VaultName $keyVaultName -SecretValue $secretValue

# Clean up
Remove-AzResourceGroup -Name $myResourceGroup
