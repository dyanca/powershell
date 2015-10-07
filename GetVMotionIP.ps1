Connect-VIServer "infvcenter01" -User "walgreens\secyancadan" -Password "Mar.2013E"
$HostReport = @()
Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname, vmotion_ip
     $Report.Hostname = $_.Name
     $Report.vmotion_ip =$_.Config.Vmotion.IpConfig.IpAddress
     $HostReport += $Report
} 
$HostReport | Export-Csv "c:\temp\infvcenter01-052913.csv" –NoTypeInformation
