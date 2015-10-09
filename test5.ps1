#$myVCenter = Connect-VIServer -Server "SENVCENTER1" -User "" -Password ""
  
foreach ($ESXhost in get-vmhost)

{
	Get-VirtualSwitch | Get-VirtualPortGroup
}


#disConnect-VIServer SENVCENTER1