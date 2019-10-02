# This script create a VM and attaches it to 

# Create ResourceGroup
$id=Get-Random -Maximum 100
$myResourceGroup="testdcaro$id"
$vmName= "testdcarovm$id"
$location="East US"
$Password = ConvertTo-SecureString "MyComplexP@ssw0rd!" -AsPlainText -Force
$azureUser = "azureuser"

#$cred = Get-Credential -UserName $azureUser -Credential $Password 
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($azureUser, $Password)
new-AzVM -Name $vmName -Credential $cred -ResourceGroupName $myResourceGroup -Location $location

$startDate = Get-Date

while ($vmState -ne "Succeeded" -and $startDate.AddMinutes(2) -gt (Get-Date) ) {
    $vmState = (Get-AzVm -Name $vmName -ResourceGroupName $myResourceGroup).ProvisioningState
    Write-Output "Waiting for VM $vmName to be provisioned, current state $vmState"
    sleep 2
}
sleep 30
Write-Output "Deleting Resource Group"
Remove-AzResourceGroup -Name $myResourceGroup 