$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101"
#$viservers ="SENVCENTER101","GENVCENTER101"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "secyancadan" -password "Sep.2013E"


	foreach ($VMHost in Get-VMhost | get-view) {

	       
	               $Report = "" | select vCenter, Name, Version, Build, FullName
				   $Report.vCenter = $singleViserver
	               $Report.Name = $VMHost.Name
	               $Report.Version = $VMHost.Config.Product.Version
	               $Report.Build = $VMHost.Config.Product.Build
				   $Report.FullName = $VMHost.Config.Product.FullName
	               $HBAreport += $Report
	               $print = $Report
	   $print
	}
	
	Disconnect-VIServer -Server $singleViserver -Force -Confirm:$false

}
$HBAreport | export-csv "C:\temp\All-101013-hostversions.csv" -NoTypeInformation
