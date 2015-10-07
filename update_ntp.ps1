
#Updates ntp settings

$vmhosts = Get-VMHost | Sort Name

foreach ($vmhost in $vmhosts){
 $ESXHost = $vmhost.Name
 
Remove-VmHostNtpServer -VMHost $ESXHost -confirm:$false  -NtpServer 155.45.60.12
Remove-VmHostNtpServer -VMHost $ESXHost -confirm:$false  -NtpServer 155.45.60.13 

Add-VmHostNtpServer -VMHost $ESXHost -confirm:$false  -NtpServer 155.45.120.232


Get-VmHostService -VMHost $ESXHost | Where-Object {$_.key -eq “ntpd“} | reStart-VMHostService -confirm:$false








}
