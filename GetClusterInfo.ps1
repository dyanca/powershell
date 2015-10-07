$viservers = "EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","PCIVCENTER02","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-npciv10","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10"
#$viservers = "SENVCENTER01","pw1sim-npciv10"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Feb.2015E"

	foreach ($ClusterObject in Get-Cluster) {

       $Report = "" | select vCenter, ClusterName, Hosts, VMs
	   $Report.vCenter = $singleViserver
       $Report.ClusterName = $ClusterObject.Name
       	$HostCount = get-vmhost | Where-Object {$_.Parent -like $ClusterObject.Name}
	   $Report.Hosts = $HostCount.count
	   	$VMCount = Get-Cluster -Name $ClusterObject.Name | get-VM
	   $Report.VMs = $VMCount.count
     	$HBAreport += $Report
      
	}

	Disconnect-VIServer $singleViserver -Confirm:$false
	
}
$HBAreport | export-csv "C:\temp\ClusterInfo-04-20-15.csv" -NoTypeInformation