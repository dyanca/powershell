Connect-VIServer vc-glsdc -User locadm1 -Password Welcome1
$HostReport = @()
Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname, vmotion_ip
     $Report.Hostname = $_.Name
     $Report.vmotion_ip =$_.Config.Vmotion.IpConfig.IpAddress
     $HostReport += $Report
} 
$HostReport | Export-Csv "C:\temp\HostReport.csv" –NoTypeInformation
