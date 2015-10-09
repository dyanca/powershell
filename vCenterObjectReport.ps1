Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#----------- Read in the list of vCenters to query --------
."C:\users\dyancayx\Documents\GitHub\working\vCenterList.ps1"
#$viservers = "SENVCENTER02","SENVCENTER101"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
    $datacenterCount = $null
    $clusterCount = $null
    $vmCount = $null
    $hostCount = $null
    $datastoreCount = $null

	Connect-VIServer $singleViserver -user "" -password ""

       $Report = "" | select vCenter,Datacenters,Clusters,VMs,Hosts,Datastores
       $Report.vCenter = $singleViserver
        $datacenterCount = Get-Datacenter
       $Report.Datacenters = $datacenterCount.count
        $clusterCount = Get-Cluster
       $Report.Clusters = $clusterCount.count
        $vmCount = Get-VM
       $Report.VMs = $vmCount.count
        $hostCount = Get-VMHost
       $Report.Hosts = $hostCount.count
        $datastoreCount = Get-Datastore
       $Report.Datastores = $datastoreCount.count
        
       $HBAreport += $Report
       $print = $Report
	     	       
	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport | export-csv "C:\temp\vCenter-Objects-8-26-15.csv" -NoTypeInformation
}
