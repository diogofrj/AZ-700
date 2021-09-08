# Housekeeping tasks for each VM
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
New-NetFirewallRule -DisplayName 'Allow ICMPv4-In' -Protocol 'ICMPv4'
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value * -Force

# Set variables
$rgName = ''
$zoneName = ''
$vnet1Name = ''
$host1Name = ''
$host1IP = ''
$vnet2Name = ''
$host2Name = ''
$host2IP = ''

$vnet1 = Get-AzVirtualNetwork -Name $vnet1Name -ResourceGroupName $rgName

$vnet2 = Get-AzVirtualNetwork -Name $vnet2Name -ResourceGroupName $rgName

New-AzDnsZone -Name $zoneName -ResourceGroupName $rgName -ZoneType Private -ResolutionVirtualNetworkId @($vnet1.Id) # or registration?

New-AzDnsRecordSet -Name $host1Name -RecordType A -ZoneName $zoneName -ResourceGroupName $rgName -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -IPv4Address $host1IP)

New-AzDnsRecordSet -Name $host2Name -RecordType A -ZoneName $zoneName -ResourceGroupName $rgName -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -IPv4Address $host2IP)

Get-AzDnsRecordSet -ZoneName $zoneName -ResourceGroupName $rgName

Set-AzDnsZone -Name $zoneName -ResourceGroupName $rgName -RegistrationVirtualNetworkId @($vnet1.Id)

Set-AzDnsZone -Name $zoneName -ResourceGroupName $rgName -ResolutionVirtualNetworkId @($vnet2.Id)
