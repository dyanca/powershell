$vCenterSRV = "pw1sim-npciv10"
$UserName = "walgreenco.net\secyanca"
$PassWD = "Feb.2015E"

Connect-VIServer -Server $vCenterSRV -User $UserName -Password $PassWD
  
Get-VMHostHBA -Type FibreChannel | Select VMHost,@{N="WWN";E={"{0:X}"-f$_.PortWorldWideName}}

Disconnect-VIServer $vCenterSRV -Confirm:$false
