param($sourceVC,$destinationVC)

#Connect to source vCenter and gather Cluster details
	Connect-VIServer $sourceVC -User yancadan -Password "Oct.2014E"

		$SourceClusterInfo = Get-Cluster
		$SourceClusterName = $SourceClusterInfo.Name
		$SourceEVCMode = $SourceClusterInfo.EVCMode
		$SourceDRSMode = $SourceClusterInfo.DrsMode
		$SourceHAstatus = $SourceClusterInfo.HAEnabled

	Disconnect-VIServer $sourceVC -Confirm:$false

#Connect to destination vCenter and create new Cluster
	Connect-VIServer $destinationVC -User yancadan -Password "Oct.2014E"

	$DestinationDCName = Get-Datacenter | Select Name

	If($SourceDRSMode -eq "FullyAutomated")
		{
			$tempVar = "Fully Automated"
		} elseif ($SourceDRSMode -eq "Manual")
		{
			$tempVar = "Manual"
		} elseif ($SourceDRSMode -eq "PartiallyAutomated") 
		{
			$tempVar = "Partially Automated"
		}
		
		$tempVar
#	New-Cluster -Location $DestinationDCName.Name -DrsEnabled:$true -EVCMode 'intel-nehalem' -Name "TestCluster"

Disconnect-VIServer $DestinationVC -Confirm:$false
