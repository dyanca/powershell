
$viservers = "DTNVCENTER101","DTSVCENTER101","IDVCENTER101"
$user = "walgreens\secyancadan"
$pass = "Dec.2012E"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Write-Host "first loop"
	Connect-VIServer $singleViserver -user $user -password $pass

	foreach ($VMHost in Get-VMhost) {
		Write-Host "Second loop"
       $Report = "" | select vCenter, Name, Build
       $Report.vCenter = $singleViserver
	   $Report.Name = $VMHost
       $Report.Build = $VMHost.Build
       $HBAreport += $Report
       $print = $Report
	       
	      
	}
Write-Host "Print variable hit"
$print

}
$HBAreport | export-csv "c:\temp\InventoryTest-121312-3.csv" -NoTypeInformation