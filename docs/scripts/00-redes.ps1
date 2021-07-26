# vNet Core Configurations
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"

# Crianção de RG
Write-Host -ForegroundColor Green "Criando RG"
$rg = @{
    Name     = 'RG-AZ700'
    Location = 'EastUS'
}
New-AzResourceGroup @rg -Force
#-------------------------------------------------------
# Crianção de vNET Core
$virtualNetworkCore = Get-AzVirtualNetwork -Name 'CoreServicesVnet'
if ($null -eq $virtualNetworkCore) {
    Write-Host -ForegroundColor Green "Criando vnet core"
    $vnetcore = @{
        Name              = 'CoreServicesVnet'
        ResourceGroupName = $rg.Name
        Location          = 'West US'
        AddressPrefix     = '10.20.0.0/16'    
    }
    $virtualNetworkCore = New-AzVirtualNetwork @vnetcore -Force
    # Crianção das Subnets
    $subnet1 = @{
        Name           = 'GatewaySubnet'
        VirtualNetwork = $virtualNetworkCore
        AddressPrefix  = '10.20.0.0/27'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet1
    $subnet2 = @{
        Name           = 'SharedServicesSubnet'
        VirtualNetwork = $virtualNetworkCore
        AddressPrefix  = '10.20.10.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet2
    $subnet3 = @{
        Name           = 'DatabaseSubnet'
        VirtualNetwork = $virtualNetworkCore
        AddressPrefix  = '10.20.20.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet3
    $subnet4 = @{
        Name           = 'PublicWebServiceSubnet'
        VirtualNetwork = $virtualNetworkCore
        AddressPrefix  = '10.20.30.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet4
    # Associar subnet a vNet
    $virtualNetworkCore | Set-AzVirtualNetwork 
}
#-------------------------------------------------------
# Crianção de vNET Manufacturing
$virtualNetworkFacturing = Get-AzVirtualNetwork -Name 'ManufacturingVnet'
if ($null -eq $virtualNetworkFacturing) {
    Write-Host -ForegroundColor Green "Criando Manufacturing"
    $vnetfacturing = @{
        Name              = 'ManufacturingVnet'
        ResourceGroupName = $rg.Name
        Location          = 'North Europe'
        AddressPrefix     = '10.30.0.0/16'    
    }
    $virtualNetworkFacturing = New-AzVirtualNetwork @vnetfacturing -Force
    # Crianção das Subnets
    $subnet1 = @{
        Name           = 'ManufacturingSystemSubnet'
        VirtualNetwork = $virtualNetworkFacturing
        AddressPrefix  = '10.30.10.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet1
    $subnet2 = @{
        Name           = 'SensorSubnet1'
        VirtualNetwork = $virtualNetworkFacturing
        AddressPrefix  = '10.30.20.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet2
    $subnet3 = @{
        Name           = 'SensorSubnet2'
        VirtualNetwork = $virtualNetworkFacturing
        AddressPrefix  = '10.30.21.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet3
    $subnet4 = @{
        Name           = 'SensorSubnet3'
        VirtualNetwork = $virtualNetworkFacturing
        AddressPrefix  = '10.30.22.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet4
    # Associar subnet a vNet
    $virtualNetworkFacturing | Set-AzVirtualNetwork
}
    # Crianção da vNet Research
$virtualNetworkResearch = Get-AzVirtualNetwork -Name 'ResearchVnet'
if ($null -eq $virtualNetworkResearch) {
    Write-Host -ForegroundColor Green "Criando Research"
    $vnetresearch = @{
        Name              = 'ResearchVnet'
        ResourceGroupName = $rg.Name
        Location          = 'West India'
        AddressPrefix     = '10.40.0.0/16'    
    }
    $virtualNetworkResearch = New-AzVirtualNetwork @vnetresearch -Force
    # Crianção das Subnets
    $subnet1 = @{
        Name           = 'ResearchSystemSubnet'
        VirtualNetwork = $virtualNetworkResearch
        AddressPrefix  = '10.40.0.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet1
    # Associar subnet a vNet
    $virtualNetworkResearch | Set-AzVirtualNetwork 
}
#-------------------------
# Peerings
# Peer CoreServicesVnet to ManufacturingVnet.
Write-Host -ForegroundColor Green "peer-CoreServicesVnet-to-ManufacturingVnet"
Add-AzVirtualNetworkPeering -Name 'peer-CoreServicesVnet-to-ManufacturingVnet' `
    -VirtualNetwork $virtualNetworkCore `
    -RemoteVirtualNetworkId $virtualNetworkFacturing.Id `
    -AllowForwardedTraffic 
# Peer ManufacturingVnet to CoreServicesVnet.
Write-Host -ForegroundColor Green "peer-ManufacturingVnet-to-CoreServicesVnet"
Add-AzVirtualNetworkPeering -Name 'peer-ManufacturingVnet-to-CoreServicesVnet' `
    -VirtualNetwork $virtualNetworkFacturing `
    -RemoteVirtualNetworkId $virtualNetworkCore.Id `
    -AllowForwardedTraffic 
# Peer CoreServicesVnet to Research.
Write-Host -ForegroundColor Green "peer-CoreServicesVnet-to-Research"
Add-AzVirtualNetworkPeering -Name 'peer-CoreServicesVnet-to-Research' `
    -VirtualNetwork $virtualNetworkCore `
    -RemoteVirtualNetworkId $virtualNetworkResearch.Id `
    -AllowForwardedTraffic 
# Peer Research to CoreServicesVnet.
Write-Host -ForegroundColor Green "peer-Research-to-CoreServicesVnet"
Add-AzVirtualNetworkPeering -Name 'peer-Research-to-CoreServicesVnet' `
    -VirtualNetwork $virtualNetworkResearch `
    -RemoteVirtualNetworkId $virtualNetworkCore.Id `
    -AllowForwardedTraffic         
# ---------------------------------
# Private DNS Zones
#Install-Module -Name Az.PrivateDns -force

$privzone = Get-AzPrivateDnsZone -Name 'diogofernandes.net' -ResourceGroupName 'RG-AZ700' -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($null -eq $privzone) {
    Write-Host -ForegroundColor Green "Criando Private DNS Zone" 
    $privzone = New-AzPrivateDnsZone -Name 'diogofernandes.net' -ResourceGroupName 'RG-AZ700' 
}
Write-Host -ForegroundColor Green "Linking Private DNS Zone to" $virtualNetworkCore.Name
New-AzPrivateDnsVirtualNetworkLink -ZoneName 'diogofernandes.net' `
    -ResourceGroupName 'RG-AZ700' -Name "CoreServicesVnetLink" `
    -VirtualNetworkId $virtualNetworkCore.id -EnableRegistration
Write-Host -ForegroundColor Green "Linking Private DNS Zone to" $virtualNetworkFacturing.Name
New-AzPrivateDnsVirtualNetworkLink -ZoneName 'diogofernandes.net' `
    -ResourceGroupName 'RG-AZ700' -Name "ManufacturingVnetLink" `
    -VirtualNetworkId $virtualNetworkFacturing.Id -EnableRegistration
Write-Host -ForegroundColor Green "Linking Private DNS Zone to" $virtualNetworkResearch.Name
New-AzPrivateDnsVirtualNetworkLink -ZoneName 'diogofernandes.net' `
    -ResourceGroupName 'RG-AZ700' -Name "ResearchVnetLink" `
    -VirtualNetworkId $virtualNetworkResearch.Id -EnableRegistration    

Write-Host -ForegroundColor Blue "FIM"