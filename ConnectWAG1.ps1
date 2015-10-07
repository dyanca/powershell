$viservers = "SENVCENTER02","IPTVCENTER02","SBVCENTER01","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","pw1sim-npciv10","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancad" -password "Jul.2015E"
}