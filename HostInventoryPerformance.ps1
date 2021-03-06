$viservers = "PCIVCENTER02","EPCIVCENTER02","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20"
#$viservers = "SENVCENTER01","IDVCENTER01"

$HBAreport = @()
$VCount = $null
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Nov.2014E"

	foreach ($VMhost in Get-VMHost) {
       
       $Report = "" | select Name, vCenter, Cluster, MemPercentUsage, CpuUsage, VMcount
       $Report.Name = $VMHost.Name
	   $Report.vCenter = $singleViserver
	   $Report.Cluster = $VMhost.Parent
	   $Report.MemPercentUsage = $VMhost.MemoryUsageGB / $VMHost.MemoryTotalGB
	   $Report.CpuUsage = $VMhost.CpuUsageMhz / $VMhost.CpuTotalMhz
	   		$VCount = Get-VMHost -Name $VMhost | Get-VM | measure
	   $Report.VMcount = $VCount.Count
       $HBAreport += $Report
       $print = $Report
	     	       
	}
	#$print

	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport | export-csv "C:\temp\HostInvPerf-11-18-14.csv" -NoTypeInformation
}
