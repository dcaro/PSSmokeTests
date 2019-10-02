# This script create a VNET with 2 subnets

# Create ResourceGroup
$myResourceGroup="dcaro$(Get-Random -Maximum 100)"
$location="West Europe"
$VNetAddress="10.0.0.0/16"
$Subnet1Name="subnet1"
$Subnet2Name="subnet2"
$SubNet1Address="10.0.1.0/24"
$SubNet2Address="10.0.2.0/24"
$myVirtualNetwork="dcarovnet$(Get-Random -Maximum 100)"

# Create a resource group.
New-AzResourceGroup -Name $myResourceGroup -Location $location
Get-AzResourceGroup -Name $myResourceGroup

# Create VNet
New-AzVirtualNetwork -ResourceGroupName $myResourceGroup -Location $location -Name $myVirtualNetwork -AddressPrefix $VNetAddress
Get-AzVnet -Name $myVirtualNetwork -ResourceGroupName $myResourceGroup

# Create Subnet in VNet
New-AzVnetSubnet -Name $Subnet1Name -ResourceGroupName $myResourceGroup -VnetName $myVirtualNetwork -AddressPrefix $SubNet1Address
New-AzVnetSubnet -Name $Subnet2Name -ResourceGroupName $myResourceGroup -VnetName $myVirtualNetwork -AddressPrefix $SubNet2Address

Get-AzVnetSubnet -Name $Subnet1Name -ResourceGroupName $myResourceGroup -VnetName $myVirtualNetwork
Get-AzVnetSubnet -Name $Subnet2Name -ResourceGroupName $myResourceGroup -VnetName $myVirtualNetwork 

Remove-AzVnet -Name $myVirtualNetwork -ResourceGroupName $myResourceGroup
Remove-AzResourceGroup -Name $myResourceGroup