$viservers = "EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","PCIVCENTER02","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-npciv10","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10"
#$viservers = "SENVCENTER01","IDVCENTER01","GENVCENTER01"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "secyancadan" -password ""

	foreach ($VMHost in Get-VMhost) {

	       foreach ($lun in ($VMHost.ExtensionData.config.storageDevice.multipathInfo.lun)){

	               $Report = "" | select Name, LunID, satpPolicy, pspPolicy, Paths
	               $Report.Name = $VMHost
	               $Report.LunID = $lun.Id
	               $Report.satpPolicy = $lun.storageArrayTypePolicy.Policy
	               $Report.pspPolicy = $lun.Policy.Policy
	               $Report.Paths = $lun.Path.Count
	               $HBAreport += $Report
	               $print = $Report
	       }
	       $print
	}


$HBAreport | export-csv "C:\temp\Paths-02-16-15.csv" -NoTypeInformation
}