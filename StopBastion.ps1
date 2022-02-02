$resourcegroupname = "resourcegroup"
$vmname = "VM"
$publicipname = "PublicIP"
$vnetname = "virtualnetwork"

#log in Azure
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

#Stop VM
Write-Output "VM Stop."
Stop-AzVM -ResourceGroupName $resourcegroupname -Name $vmname -Force
Write-Output "VM Stop complete."


#Stop Bastion
Write-Output "Bastion Stop."
$publicip =  Get-AzPublicIpAddress -Name $publicipname -ResourceGroupName $resourcegroupname
$vnet = Get-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroupname
Remove-AzBastion -ResourceGroupName $resourcegroupname -Name "myBastion" -Force
Write-Output "Bastion Stop complete."