$myVCenter = Connect-VIServer senvcenter101 -User "walgreens\secyancadan" -Password "W@lgr33ns3"
$HostReport = @()


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 
$HostReport | Export-Csv "c:\temp\HostReport-SEN101.csv" –NoTypeInformation




  



