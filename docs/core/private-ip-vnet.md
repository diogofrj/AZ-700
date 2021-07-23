# Private IP addressing for VNets

## Design and implement private IP addressing for VNets
- [ ] create a VNet
- [ ] plan and configure subnetting for services, including VNet gateways, private endpoints, 
firewalls, application gateways, and VNet-integrated platform services
- [ ] plan and configure subnet delegation
 
### Criar VNET
:smile:

***
Save space in your document using buttons or tabs for sub chapters. Add this code at the end of your title:


=== "PowerShell"

    ```azurepowershell
    # Crianção de RG
    $rg = @{
        Name = 'RG-AZ700'
        Location = 'EastUS'
    }
    New-AzResourceGroup @rg
    
    # Crianção de vNET
    $vnet = @{
        Name = 'VNET-700'
        ResourceGroupName = $rg
        Location = 'EastUS'
        AddressPrefix = '10.0.0.0/16'    
    }
    $virtualNetwork = New-AzVirtualNetwork @vnet
    
    # Crianção de Subnet
    $subnet = @{
        Name = 'SNET-700'
        VirtualNetwork = $virtualNetwork
        AddressPrefix = '10.0.0.0/24'
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
    
    # Associar subnet a vNet
    $virtualNetwork | Set-AzVirtualNetwork
    ```
=== "Azure CLI"

    ```azurecli
    az group create --name 'RG-AZ700' --location 'EastUS'
    az network vnet create --name 'VNET-700' --resource-group 'RG-AZ700' --subnet-name 'SNET-700'
    ```


### Atualizar VNET


### Remover VNET
=== "Powershell"

    ```azurepowershell
    Remove-AzResourceGroup -Name 'RG-AZ700' -Force
    ```
=== "Azure CLI"

    ```azurecli
    az group delete --name 'RG-AZ700' --yes
    ```
