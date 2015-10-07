$myVCenter = Connect-VIServer -Server "vc-glsdc" -User "" -Password ""
  
foreach ($ESXhost in get-cluster Standard_SIS_007 | get-vmhost)

{
	get-virtualswitch -vmhost $ESXhost -name vSwitch2| get-virtualportgroup -name 810_ATOS | remove-virtualportgroup -Confirm:$False
}