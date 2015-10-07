
#$viservers = "IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","DTNVCENTER101","DTSVCENTER101"
$viservers ="GENVCENTER01"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Jun.2013E"


foreach ($VMHost in Get-VMhost | select Name, ProcessorType) {


               $Report = "" | Get-VMHost | select Name, ProcessorType
               $Report.Name = $VMHost
               $Report.LunID = $VMHost.ProcessorType
               $HBAreport += $Report
               $print = $Report
     
       $print
}


$HBAreport | export-csv "c:\temp\Processor-GEN01-062613.csv" -NoTypeInformation
}