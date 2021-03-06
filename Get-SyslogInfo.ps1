function getStringFromArray ( $array) {
	$retval = ""
	foreach($obj in $array) {
		if ($retval -eq "")
		{
			$retval = "$obj"
		} else {
			$retval = "$retval | $obj"
		}
	}
	return $retval
}

$viservers = "PCIVCENTER02","EPCIVCENTER02","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10","pw1sim-npciv10"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "<<>>"

	foreach ($dy in Get-VMHost) {

       $Report = "" | select Name, Syslog, vCenter
       $Report.Name = $dy.Name
	    $GetSyslogInfo = Get-VMHostSysLogServer -VMHost $dy.Name
       $Report.Syslog = getStringFromArray @($GetSyslogInfo.Host)
       $Report.vCenter = $singleViserver
       $HBAreport += $Report
	     	       
	}
	
	Disconnect-VIServer $singleViserver -Confirm:$false

}

	
	$HBAreport | export-csv "C:\temp\Syslog-info-111314.csv" -NoTypeInformation