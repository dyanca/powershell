$myVCenter = Connect-VIServer senvcenter101 -User "walgreens\secyancadan" -Password "W@lgr33ns3"
$HostReport = @()


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer GENVCENTER101 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer PCIVCENTER101 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer IPTVCENTER102 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer SENVCENTER02 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer IPTVCENTER02 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer SBVCENTER01 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer REMVCENTER101 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 
	
$myVCenter = Connect-VIServer epcivcenter01  -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer infvcenter01 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer SENVCENTER1 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer idvcenter01 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer senvcenter01 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$myVCenter = Connect-VIServer genvcenter01 -User "walgreens\secyancadan" -Password "W@lgr33ns3"


Get-VMHost |Get-View |%{     
     $Report = "" | select Hostname,Build
     $Report.Hostname = $_.Name 
     $Report.Build =$_.Config.Product.Build 
     $HostReport += $Report
} 

$HostReport | Export-Csv "c:\temp\HostReport-All.csv" –NoTypeInformation