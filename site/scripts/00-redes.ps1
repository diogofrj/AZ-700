# vNet Core Configurations

# Crianção de RG
$rg = @{
    Name = 'RG-AZ700'
    Location = 'EastUS'
}
New-AzResourceGroup @rg
#-------------------------------------------------------
# Crianção de vNET Core
$vnet = @{
    Name = 'VNET-CORE-US'
    ResourceGroupName = $rg
    Location = 'EastUS'
    AddressPrefix = '10.20.0.0/16'    
}
$virtualNetwork = New-AzVirtualNetwork @vnet

 # Crianção das Subnets
    $subnet1 = @{
        Name = 'GatewaySubnet'
        VirtualNetwork = $virtualNetwork
        AddressPrefix = '10.20.0.0/27'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet1
    $subnet2 = @{
        Name = 'SN-SharedServices'
        VirtualNetwork = $virtualNetwork
        AddressPrefix = '10.20.10.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet2
    $subnet3 = @{
        Name = 'SN-Databases'
        VirtualNetwork = $virtualNetwork
        AddressPrefix = '10.20.20.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet3
    $subnet4 = @{
        Name = 'SN-PublicWebService'
        VirtualNetwork = $virtualNetwork
        AddressPrefix = '10.20.30.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet4

# Associar subnet a vNet
$virtualNetwork | Set-AzVirtualNetwork



#-------------------------------------------------------
# Crianção de vNET Fabric
$vnet = @{
    Name = 'VNET-FABRIC-WEST'
    ResourceGroupName = $rg
    Location = 'WestUS'
    AddressPrefix = '10.30.0.0/16'    
}
$virtualNetwork = New-AzVirtualNetwork @vnet

# Crianção das Subnets
$subnet1 = @{
    Name = 'ManufacturingSystemSubnet'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.30.10.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet1
$subnet2 = @{
    Name = 'SensorSubnet1'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.30.20.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet2
$subnet3 = @{
    Name = 'SensorSubnet2'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.30.21.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet3
$subnet4 = @{
    Name = 'SensorSubnet3'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.30.22.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet4

# Associar subnet a vNet
$virtualNetwork | Set-AzVirtualNetwork