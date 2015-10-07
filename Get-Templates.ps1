#$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101"
$viservers ="GENVCENTER02"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "secyancadan" -password "Nov.2013E"


	foreach ($VMinstance in Get-Template) {
	     
				"$($VMinstance.Name),$($singleViserver)" >> "C:\temp\All-Templates-120313.csv"
				
	           #$Report = "" | select Name, vCenter
	           #$Report.Name = $VMinstance.Name
	           #$Report.vCenter = $singleViserver
	           #$HBAreport += $Report
	}
	disConnect-VIServer $singleViserver -Force -Confirm:$false
}
#$HBAreport | export-csv "C:\temp\All-Templates-120313.csv" -NoTypeInformation