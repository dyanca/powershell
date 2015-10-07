# Make sure you connect to your VCs here
#Connect-VIServer IDVCENTER101,GENVCENTER101,PCIVCENTER101,IPTVCENTER102,SENVCENTER02,IPTVCENTER02,SBVCENTER01,SENVCENTER101,REMVCENTER101,epcivcenter01,infvcenter01,SENVCENTER1,idvcenter01,senvcenter01,genvcenter01,IPTVCENTER01,DTNVCENTER101,DTSVCENTER101 -User "walgreens\secyancadan" -Password "Mar.2013E"
Connect-VIServer DTNVCENTER101,DTNSVCENTER01,EPCIVCENTER01,INFVCENTER01,SENVCENTER1,IDVCENTER01,SENVCENTER01,GENVCENTER01,IPTVCENTER01 -User "walgreens\secyancadan" -Password "Mar.2013E"

# Get the license info from each VC in turn 
$vSphereLicInfo = @() 
$ServiceInstance = Get-View ServiceInstance 
Foreach ($LicenseMan in Get-View ($ServiceInstance | Select -First 1).Content.LicenseManager) { 
    Foreach ($License in ($LicenseMan | Select -ExpandProperty Licenses)) { 
        $Details = "" |Select VC, Name, Key, Total, Used, ExpirationDate , Information 
        $Details.VC = ([Uri]$LicenseMan.Client.ServiceUrl).Host 
        $Details.Name= $License.Name 
        $Details.Key= $License.LicenseKey 
        $Details.Total= $License.Total 
        $Details.Used= $License.Used 
        $Details.Information= $License.Labels | Select -expand Value 
        $Details.ExpirationDate = $License.Properties | Where { $_.key -eq "expirationDate" } | Select -ExpandProperty Value 
        $vSphereLicInfo += $Details 
    } 
} 
#$vSphereLicInfo | Format-Table -AutoSize
$vSphereLicInfo | export-csv "c:\temp\LicenseReport-040113.csv" -NoTypeInformation