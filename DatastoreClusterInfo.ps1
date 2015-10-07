#!!!! this isn't ready yet.  couldn't figure out how to count vmdk's yet

#$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10","pw1sim-npciv10"
$viservers = "SENVCENTER01","EPCIVCENTER101"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Aug.2014E"

	foreach ($DSCluster in Get-DatastoreCluster) {

       $Report = "" | select vCenter,Name,VMs,VMDKs,Datastores
       $Report.vCenter = $singleViserver
	   		$DSName = Get-DatastoreCluster | select Name
       $Report.Name = $DSCluster.Name
	   		$vmCount = Get-DatastoreCluster | Get-VM
       $Report.VMs = $vmCount.count
       $HBAreport += $Report
       $print = $Report
	     	       
	}
	$print

	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport #| export-csv "C:\temp\VM-Inventory-10-06-14.csv" -NoTypeInformation
}
