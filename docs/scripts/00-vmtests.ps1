$virtualNetworkCore = Get-AzVirtualNetwork -Name 'CoreServicesVnet'
$virtualNetworkFacturing = Get-AzVirtualNetwork -Name 'ManufacturingVnet'
$virtualNetworkResearch = Get-AzVirtualNetwork -Name 'ResearchVnet'


# Variables for common values
$resourceGroup = "RG-AZ700"
$location = "westus"
$vmName = "TestVM"

# Create user object
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

 # Create an inbound network security group rule for port 3389
 $nsgRuleRDP = New-AzNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleRDP  -Protocol Tcp `
 -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
 -DestinationPortRange 3389 -Access Allow

# Create a network security group
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location `
 -Name NSG-TEST -SecurityRules $nsgRuleRDP



for ($i = 1; $i -le 2; $i++) {
    # Create a public IP address and specify a DNS name
    $pip = New-AzPublicIpAddress -ResourceGroupName $resourceGroup -Location $location `
        -Name "$vmName-$i-pip" -AllocationMethod Dynamic

    # Create a virtual network card and associate with public IP address and NSG
    $nic = New-AzNetworkInterface -Name "$vmName-$i-nic" -ResourceGroupName $resourceGroup -Location $location `
        -SubnetId $virtualNetworkCore.Subnets[2].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

    $vmConfig = New-AzVMConfig -VMName $vmName-$i -VMSize Standard_D2_v3 | `
        Set-AzVMOperatingSystem -Windows -ComputerName $vmName-$i -Credential $cred  | `
        Set-AzVMSourceImage -PublisherName MicrosoftWindowsDesktop -Offer Windows-10 -Sku 21h1-ent -Version latest | `
        Add-AzVMNetworkInterface -Id $nic.Id

    New-AzVm `
        -ResourceGroupName $resourceGroup `
        -Location $location `
        -VM $vmConfig
} 

Write-output "cmdkey /generic:($(Get-AzPublicIpAddress -Name "$vmName-1-pip").IpAddress) /user:"localadmin" /pass:"Swell2016!!!""
Write-output "mstsc /v:$(Get-AzPublicIpAddress -Name "$vmName-1-pip").IpAddress"

Write-output "cmdkey /generic:($(Get-AzPublicIpAddress -Name "$vmName-2-pip").IpAddress) /user:"localadmin" /pass:"Swell2016!!!""
Write-output "mstsc /v:$(Get-AzPublicIpAddress -Name "$vmName-2-pip").IpAddress"
#cmdkey /delete:20.36.195.38