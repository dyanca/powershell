$user = $args[0]
$pass = $args[1]

Connect-VIServer pw1sim-npciv10 -user $user -Password $pass 

$temp = Get-VMHostNetworkAdapter -VMHost c32b16.walgreens.com 

$IP = $temp.IP[5]

Write-Host "The IP is $IP"

Disconnect-VIServer * -Confirm:$false