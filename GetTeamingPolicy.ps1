#$viservers = "EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","PCIVCENTER02","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-npciv10","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10"
$viservers = "SENVCENTER01"

$HBAreport = @()
foreach ($singleViserver in $viservers) #for every vCenter listed
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Feb.2015E"
    $Report = "" | select vCenter, vSwitch, Policy
    

	foreach ($NetworkSwitch in Get-VDSwitch) #for every VDS in vCenter
    {    
            

        $Report.vCenter = $singleViserver
        $Report.vSwitch = $NetworkSwitch.Name
        $Policy = Get-VDSwitch $NetworkSwitch | Get-VDUplinkTeamingPolicy
        $Report.Policy = $Policy.LoadBalancingPolicy
        $HBAreport += $Report

	}

	Disconnect-VIServer $singleViserver -Confirm:$false
	
}
$HBAreport | export-csv "C:\temp\GetTeamingPolicy-03-03-15.csv" -NoTypeInformation