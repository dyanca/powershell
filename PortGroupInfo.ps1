$myVCenter = Connect-VIServer -Server "uslzuilw001srv.us001.siemens.net" -User "us001\dky001-a" -Password "ILoveAlana!"
Write-Host "------------------------------------------"
Foreach ($Cluster in Get-Cluster){
Write-Host "*** " $Cluster " ***"

	Foreach ($VMHost in ($Cluster | Get-VMHost)){
		Write-Host "*** " $VMHost " ***"
		Foreach ($vSwitch in ($VMHost | Get-VirtualSwitch )){
			Foreach ($PortGroup in ($vswitch | Get-VirtualPortGroup)){
				$NicTeaming = Get-NicTeamingPolicy -VirtualPortGroup $PortGroup
				$obj = new-object psobject
				$obj | Add-Member -membertype NoteProperty -Name Host -value $VMHost
				$obj | Add-Member -membertype NoteProperty -Name vSwitch -value $vSwitch
				$obj | Add-Member -membertype NoteProperty -Name PortGroup -value $PortGroup
				$obj | Add-Member -membertype NoteProperty -Name VLAN -value $PortGroup.VLanId
				Write-Host "esxcfg-vswitch -A" $PortGroup $vSwitch
				Write-Host "esxcfg-vswitch -v" $PortGroup.VLanId $vSwitch
				Write-Host
			}
		}
	}

}
