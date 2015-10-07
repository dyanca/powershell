# Set to multiple VC Mode 
if(((Get-PowerCLIConfiguration).DefaultVIServerMode) -ne "Multiple") { 
    Set-PowerCLIConfiguration -DefaultVIServerMode Multiple | Out-Null 
}

# Make sure you connect to your VCs here

Connect-VIServer epcivcenter01,infvcenter01,SENVCENTER1,idvcenter01,genvcenter01,IPTVCENTER01,IPTVCENTER02,senvcenter01,SENVCENTER101,SENVCENTER02  -user "secyancadan" -password "Sep.2013E"

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
$vSphereLicInfo