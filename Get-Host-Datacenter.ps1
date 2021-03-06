#$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","it-s8sf-vcenter01"
$viservers = "REMVCENTER101"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "secyancadan" -password "Aug.2014E"

	foreach ($VMHost in Get-VMhost) {
		$vDatacenter = Get-Datacenter -VMHost $VMHost.Name | Select Name

	               $Report = "" | select Name, vDatacenter
	               $Report.Name = $VMHost.Name
	               $Report.vDatacenter = $vDatacenter
	               $HBAreport += $Report
	               $print = $Report
	    }

	Disconnect-VIServer $singleViserver -Confirm:$false
$HBAreport | export-csv "C:\temp\Datacenters-09-04-14.csv" -NoTypeInformation
}