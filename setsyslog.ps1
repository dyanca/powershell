
$viservers = "VC-Field.us001.siemens.net"

$errReport =@()

#Connects to each vCenter and collects the information below for a report
foreach ($singleViserver in $viservers){

	Connect-VIServer $singleViserver -user us001\dky001-a -password 'Apr.2011E'

Foreach ($VMHost in Get-VMHost)	{
	Set-VMHostSysLogServer -SysLogServer 'USMLVA0002QSRV.us001.siemens.net:514' -VMHost $VMHost
	}
	
	Disconnect-VIServer -Confirm:$False
}

$errReport | Export-Csv ".\SetSyslogResults.csv" -NoTypeInformation

