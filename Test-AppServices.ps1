# This script creates an Azure WebApp and set it to have Continuous Integration with github
# Inspired from: https://docs.microsoft.com/en-us/azure/app-service/scripts/powershell-deploy-github?toc=%2fpowershell%2fmodule%2ftoc.json

# Replace the following URL with a public GitHub repo URL
$gitrepo="https://github.com/dcaro/app-service-web-dotnet-get-started.git"
$webappname="dcaroweb$(Get-Random -Maximum 100)"
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

# Configure GitHub deployment from your GitHub repo and deploy once.
Set-AzWebAppSourceControl -Name $webappname -ResourceGroupName $myResourceGroup -RepoUrl $gitrepo
Get-AzWebAppSourceControl -Name $webappname -ResourceGroupName $myResourceGroup 

Remove-AzResourceGroup -Name $myResourceGroup