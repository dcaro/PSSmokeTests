# This script create a WebAppl and get associated logs

$webappname="dcarowebapp$(Get-Random -Maximum 100)"
$myResourceGroup="dcaro$(Get-Random -Maximum 100)"
$location="East US"

# Create a resource group.
New-AzResourceGroup -Name $myResourceGroup -Location $location
Get-AzResourceGroup -Name $myResourceGroup

# Create an App Service plan in Free tier.
New-AzAppServicePlan -Name $webappname -ResourceGroupName $myResourceGroup -Location $location -SkuName "F1" -SkuSize "F1" -SkuTier "Free"
# New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName myResourceGroup -Tier Free
$AppSvcPlanId=(Get-AzAppServicePlan -Name $webappname -ResourceGroupName $myResourceGroup).Id

# Create a web app.
#New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $myResourceGroup
New-AzWebApp -Name $webappname -ResourceGroupName $myResourceGroup -Location $location -ServerFarmId $AppSvcPlanId

Get-Azlog -ResourceGroupName $myResourceGroup
