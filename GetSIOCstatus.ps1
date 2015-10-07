#$viservers = "IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","DTNVCENTER101","DTSVCENTER101"
$viservers ="INFVCENTER01","GENVCENTER101"


foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "secyancadan" -password "Jun.2013E"
	Get-Datastore | select Name,StorageIOControlEnabled
	disConnect-VIServer $singleViserver -Confirm

}

