Connect-VIServer usmlvpa020vsh.US001.SIEMENS.NET -Username root -Password "ex@MLV.2010"

### Remove port groups ###
get-virtualswitch -name vSwitch0| get-virtualportgroup -name 650_SEI | remove-virtualportgroup -Confirm:$False
get-virtualswitch -name vSwitch0| get-virtualportgroup -name 532_SRM_Isolation | remove-virtualportgroup -Confirm:$False
get-virtualswitch -name vSwitch0| get-virtualportgroup -name 602_SIS | remove-virtualportgroup -Confirm:$False
get-virtualswitch -name vSwitch0| get-virtualportgroup -name 651_SEI | remove-virtualportgroup -Confirm:$False
get-virtualswitch -name vSwitch0| get-virtualportgroup -name 513_SEA | remove-virtualportgroup -Confirm:$False

### Create vSwitch1 ###
New-VirtualSwitch �Name �vSwitch1� -Nic vmnic0

$vh01=get-vmhost usmlvpa020vsh.US001.SIEMENS.NET

$vh01moref=$vh01 |% {get-view $_.Id}
$vh01morefconfig=$vh01moref.configmanager
$vh01netsys=$vh01morefconfig.networksystem
$vh01netsysmoref=get-view $vh01netsys
$vh01vsw0=$vh01netsysmoref.NetworkConfig.Vswitch | where {$_.Name -eq "vSwitch1"}

$swspec= $vh01vsw0.Spec   # here you copy the existing spec object

$swspec.policy.security.allowPromiscuous=$false
$swspec.policy.security.forgedTransmits=$false
$swspec.policy.security.macChanges=$false

$vh01netsysmoref.UpdateVirtualSwitch($vh01vsw0.name,$swspec)

### Create vmkernel port for NFS ###
New-VMHostNetworkAdapter -VirtualSwitch vSwitch1 -PortGroup "NFS"  -IP 172.18.120.217 -SubnetMask 255.255.255.0

### Modify NFS port with VLAN ID ###
$vs = Get-VirtualSwitch -Name vSwitch1
Get-VirtualPortGroup -VirtualSwitch $vs | Set-VirtualPortGroup -VlanId 608 

### Create vSwitch2 ###
New-VirtualSwitch �Name �vSwitch2� -NumPorts 128 -Nic vmnic6,vmnic4,vmnic7


$vh01moref=$vh01 |% {get-view $_.Id}
$vh01morefconfig=$vh01moref.configmanager
$vh01netsys=$vh01morefconfig.networksystem
$vh01netsysmoref=get-view $vh01netsys
$vh01vsw0=$vh01netsysmoref.NetworkConfig.Vswitch | where {$_.Name -eq "vSwitch2"}

$swspec= $vh01vsw0.Spec   # here you copy the existing spec object

$swspec.policy.security.allowPromiscuous=$false
$swspec.policy.security.forgedTransmits=$false
$swspec.policy.security.macChanges=$false

$vh01netsysmoref.UpdateVirtualSwitch($vh01vsw0.name,$swspec)


### Add port groups ###
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 650_SEI -vlanid 650
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 532_SRM_Isolation
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 602_SIS -vlanid 602
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 651_SEI -vlanid 651
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 513_SEA -vlanid 513

disConnect-VIServer usmlvpa020vsh.US001.SIEMENS.NET -Confirm:$False