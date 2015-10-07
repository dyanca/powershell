$myVCenter = Connect-VIServer -Server "GENVCENTER01" -User "secyancadan" -Password "Sep.2013E"
  
foreach ($ESXhost in get-cluster GEN_CLUSTER01 | get-vmhost)

{
	get-virtualswitch -vmhost $ESXhost  -name vSwitch0 | new-virtualportgroup -name VLAN_2655_vCenter -vlanid 2655
}

