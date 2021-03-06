#$viservers = "PCIVCENTER02","EPCIVCENTER02","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10","pw1sim-npciv10"
$viservers = "SENVCENTER01","IDVCENTER01"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Nov.2014E"

	foreach ($DS in Get-Datastore) {

       $Report = "" | select vCenter, Name, Capacity, FreeSpace, ProvisionedSpace, PercentageFree, FileSystemVersion
       $Report.vCenter = $singleViserver
	   $Report.Name = $DS.Name
       $Report.Capacity = "{0:N0}" -f $DS.CapacityGB
	   $Report.FreeSpace = "{0:N0}" -f $DS.FreeSpaceGB
	   	$datastores = get-datastore | where-object {$_.name -match $DS.Name} | get-view
		 $datastores | select -expandproperty summary | select $_.Uncommitted
	   $Report.ProvisionedSpace = $datastores
	    $Perc = $DS.FreeSpaceGB / $DS.CapacityGB
	   $Report.PercentageFree = "{0:P0}" -f $Perc
       $Report.FileSystemVersion = $DS.FileSystemVersion
       $HBAreport += $Report
       $print = $Report
	     	       
	}
	$print

	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport #| export-csv "C:\temp\DatastoreReport-01-06-15.csv" -NoTypeInformation
}
