## Design and implement private IP addressing for VNets
- [X] create a VNet
- [ ] plan and configure subnetting for services, including VNet gateways, private endpoints, 
firewalls, application gateways, and VNet-integrated platform services
- [ ] plan and configure subnet delegation
 
### Criar VNET


***
Save space in your document using buttons or tabs for sub chapters. Add this code at the end of your title:



## Tabs 

```curl
$ curl -O wget http://example.com/pk.zip
```

```wget
$ wget http://example.com/pk.zip
```

## Single block

```
$ ls -lisa
```


```powershell
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
```bash
az group create --name 'RG-AZ700' --location 'EastUS'
az network vnet create --name 'VNET-700' --resource-group 'RG-AZ700' --subnet-name 'SNET-700'
```



### Atualizar VNET





### Remover VNET
```bash
Remove-AzResourceGroup -Name 'RG-AZ700' -Force
```
```bash
az group delete --name 'RG-AZ700' --yes
```
