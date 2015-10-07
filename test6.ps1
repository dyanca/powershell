#$viservers = "GENVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20"
$viservers = "SENVCENTER101"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Aug.2014E"
		foreach ($datastore in Get-Datastore) {

	       $Report = "" | select Name,vCenter,TotalSpaceGB,UsedSpaceGB,ProvisionedSpaceGB,NumVM,PercentUsed,PercentOverProv
		   $Report.Name = $datastore.Name
	       $Report.vCenter = $singleViserver
	       $Report.TotalSpaceGB = [Math]::Round(($datastore.ExtensionData.Summary.Capacity)/1GB,0)
		   $Report.UsedSpaceGB = [Math]::Round(($datastore.ExtensionData.Summary.Capacity - $datastore.ExtensionData.Summary.FreeSpace)/1GB,0)
		   $Report.ProvisionedSpaceGB = [Math]::Round(($_.ExtensionData.Summary.Capacity - $datastore.ExtensionData.Summary.FreeSpace + $datastore.ExtensionData.Summary.Uncommitted)/1GB,0)
		   	$vmCount = Get-Datastore -Name $datastore | Get-VM
		   $Report.NumVM = $vmCount.count
		   	$UsedPerc = $Report.UsedSpaceGB / $Report.TotalSpaceGB
		   $Report.PercentUsed = "{0:P0}" -f $UsedPerc
		   	$OverPerc = $Report.ProvisionedSpaceGB / $Report.TotalSpaceGB
			if ($OverPerc -lt 100) {$OverPerc = 0}
		   $Report.PercentOverProv = "{0:P0}" -f $OverPerc
		   $HBAreport += $Report
	       $print = $Report
		     	       
		}
	#$print

	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport | ft #| export-csv "C:\temp\DatastoreInfo-10-13-14.csv" -NoTypeInformation
	
	
	
}






