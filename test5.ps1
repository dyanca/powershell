#$myVCenter = Connect-VIServer -Server "SENVCENTER1" -User "secyancadan" -Password "Mar.2014E"
  
foreach ($ESXhost in get-vmhost)

{
	Get-VirtualSwitch | Get-VirtualPortGroup
}


#disConnect-VIServer SENVCENTER1