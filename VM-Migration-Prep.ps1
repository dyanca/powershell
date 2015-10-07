#test

function getStringFromArray ( $array) {
	$retval = ""
	foreach($obj in $array) {
		if ($retval -eq "")
		{
			$retval = "$obj"
		} else {
			$retval = "$retval|$obj"
		}
	}
	return $retval
}

$viservers = "IPTVCENTER102"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Aug.2014E"

	foreach ($VM in Get-VM) {

       $Report = "" | select Name, PowerState, vCenter, ClusterName, Datastore, Folder, CpuLimit, MemoryLimit, CpuReservation, MemoryReservation,PortGroup,AnnotationNotes
       $Report.Name = $VM.Name
       $Report.PowerState = $VM.PowerState
       $Report.vCenter = $singleViserver
	    $getCluster = get-vm -Name $VM.Name | Get-Cluster | Select Name
	   $Report.ClusterName = $getCluster.Name
	    $GetDatastore = get-vm -Name $VM.Name | Get-Datastore | Select Name
		
		$Report.Datastore = getStringFromArray @($GetDatastore.Name)
	   $Report.Folder = $VM.Folder
	    $GetCpuLimit = Get-VMResourceConfiguration -VM $VM.Name | select CpuLimitMhz
	   $Report.CpuLimit = $GetCpuLimit.CpuLimitMhz
	    $GetMemoryLimit = Get-VMResourceConfiguration -VM $VM.Name | select MemLimitGB
	   $Report.MemoryLimit = $GetMemoryLimit.MemLimitGB
	    $GetCpuReservation = Get-VMResourceConfiguration -VM $VM.Name | select CpuReservationMhz
	   $Report.CpuReservation = $GetCpuReservation.CpuReservationMhz
	   	$GetMemoryReservation = Get-VMResourceConfiguration -VM $VM.Name | select MemReservationGB
	   $Report.MemoryReservation = $GetMemoryReservation.MemReservationGB
	   	$GetPortGroup = get-vm -Name $VM.Name | Get-VirtualPortGroup | Select Name
	   $Report.PortGroup = getStringFromArray @($GetPortGroup.Name)
	   $Report.AnnotationNotes = $VM.Notes
       $HBAreport += $Report
	     	       
	}

	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport | export-csv "C:\temp\VM-Migration-Prep-11-11-14-2.csv" -NoTypeInformation
}
