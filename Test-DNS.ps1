# This script create a DNS and attaches it to 

# Set Variables
$id=Get-Random -Maximum 100
$myResourceGroup="dcaro$id"
$location="East US"
$dnsZoneName="testdcaro$id.com"
$dnsRecordSetName= "testRecordSet"
$IPAddress1 = @{ ipv4Address = ( "10.10.10.10" ) }
$IPAddress2 = @{ ipv4Address = ( "11.11.11.11" ) }


# Create a resource group.
New-AzResourceGroup -Name $myResourceGroup -Location $location
Get-AzResourceGroup -Name $myResourceGroup

# Create DNS 
New-AzDnsZone -Name $dnsZoneName -Location global -ResourceGroupName $myResourceGroup
New-AzDnsRecordSet -Name $dnsRecordSetName -ZoneName $dnsZoneName -ResourceGroupName $myResourceGroup -ARecord $IPAddress1, $IPAddress2  -TimeToLive 3600

Get-AzDnsRecordSet -Name $dnsRecordSetName -ResourceGroupName $myResourceGroup -ZoneName $dnsZoneName -RecordType A 

# Clean up
Remove-AzResourceGroup -Name $myResourceGroup
