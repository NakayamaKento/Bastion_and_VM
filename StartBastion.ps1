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

#Start VM
Write-Output "VM Start."
Start-AzVM -ResourceGroupName $resourcegroupname -Name $vmname
Write-Output "VM Start complete."


#Start Bastion
Write-Output "Bastion Start."
$publicip =  Get-AzPublicIpAddress -Name $publicipname -ResourceGroupName $resourcegroupname
$vnet = Get-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroupname
New-AzBastion -ResourceGroupName $resourcegroupname -Name "myBastion" -PublicIpAddress $publicip -VirtualNetwork $vnet
Write-Output "Bastion Start complete."