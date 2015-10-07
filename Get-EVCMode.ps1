$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101"
#$viservers = "IDVCENTER01","GENVCENTER01","SENVCENTER01"

$results = @()
foreach ($singleViserver in $viservers)
	{
		$connection = Connect-VIServer $singleViserver -User secyancadan -Password "Mar.2014E"
		foreach ($Cluster in Get-Cluster)
			{
				$ClusterName = $Cluster.Name
				$EVCmode = $Cluster.EVCMode
				$CurrentvCenter = $global:DefaultVIServer.Name
				$output = "$CurrentvCenter,$ClusterName,$EVCmode"
				$results += $output
			}
		Disconnect-VIServer $singleViserver -Confirm:$false
		$results #| export-csv "C:\temp\EVC-051614.csv" -NoTypeInformation
	}