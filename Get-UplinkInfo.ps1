#$viservers = "PCIVCENTER02","EPCIVCENTER02","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10","pw1sim-npciv10"
$viservers = "GENVCENTER01"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Aug.2014E"

	foreach ($temp in Get-VDSwitch | get-vdport | Where-Object{ $_.Name -eq "dvUplink1"} | select dvSwitch,Name,ConnectedEntity,ProxyHost) {

       $Report = "" | select dvSwitch, Name, ConnectedEntity, ProxyHost
       $Report.dvSwitch = $temp.Switch
	   $Report.Name = $temp.Name
       $Report.ConnectedEntity = $temp.ConnectedEntity
       $Report.ProxyHost = $temp.ProxyHost
       $HBAreport += $Report
	   $HBAreport	       
	}
	
	Disconnect-VIServer $singleViserver -Confirm:$false

}

	
#	$HBAreport | export-csv "C:\temp\Syslog-info-111314.csv" -NoTypeInformation