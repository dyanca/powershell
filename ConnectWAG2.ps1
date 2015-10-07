$viservers = "IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER101","IPTVCENTER101","EDTSVCENTER101","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancad" -password "Jul.2015E"
}