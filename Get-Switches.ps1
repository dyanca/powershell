#++++++++++++++++ The purpose of this script is to export dvSwitch, port group, security info +++++++++++

$print = @()
$SwitchReport = @()
	
$myVCenter = Connect-VIServer -Server genvcenter01 -User "secyancadan" -Password "Mar.2014E"
 
foreach ($portGroup in Get-VDPortgroup)
	{
		$Report = "" | select vCenter, VDSwitch, portGP, VlanID, AllowProm, MacChanges, ForgedTrans
		$Report.vCenter = $global:DefaultVIServer.Name
		$Report.VDSwitch = $portGroup.VDSwitch
		if ($Report.VDSwitch -eq "")
			{
				$Report.VDSwitch = $portGroup.Name
			}
		$Report.portGP = $portGroup.Name
		$Report.VlanID = $portGroup.VlanConfiguration
		$SecurityAll = Get-VDSecurityPolicy -VDPortGroup $portGroup.Name
			$Report.AllowProm = $SecurityAll.AllowPromiscuous
			$Report.MacChanges = $SecurityAll.MacChanges
			$Report.ForgedTrans = $SecurityAll.ForgedTransmits
		$SwitchReport += $Report
		$print = $Report
	}

disConnect-VIServer genvcenter01 -Confirm:$false

$SwitchReport # | export-csv "c:\temp\SwitchInfo.csv" -Delimiter ";" -NoTypeInformation

