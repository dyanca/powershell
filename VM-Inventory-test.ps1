#$viservers = "PCIVCENTER02","EPCIVCENTER02","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10","pw1sim-npciv10"
$viservers = "SENVCENTER01","DTNVCENTER101"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "" -password ""

	foreach ($VM in Get-VM) {

       $Report = "" | select Name, PowerState, vCenter, VMStatus, HostName,ProvisionedSpace, UsedSpace, HostCPUmhz, GuestOS, ToolsVersion, MemorySize, CPUcount, NICcount, VMuptime
       $Report.Name = $VM.Name
       $Report.PowerState = $VM.PowerState
       $Report.vCenter = $singleViserver
	   $Report.VMStatus = $null
	   $report.HostName = $VM.VMHost
	   $Report.ProvisionedSpace = $VM.ProvisionedSpaceGB
	   $Report.UsedSpace = $VM.UsedSpaceGB
	   $Report.HostCPUmhz = $null
	   	$GuestOSinfo = Get-VMGuest -VM $VM.Name
	   $Report.GuestOS = $GuestOSinfo.OSFullName
	    $ToolsVersion = Get-VMGuest -VM $VM.Name
	   $Report.ToolsVersion = $ToolsVersion.ToolsVersion
	   $Report.MemorySize = $VM.MemoryGB
	   $Report.CPUcount = $VM.NumCpu
	    $VMnicCount = Get-VM -Name $VM.Name
	   $Report.NICcount = $VMnicCount.NetworkAdapters.count
	   $Report.VMuptime = $null
       $HBAreport += $Report
	   $HBAreport
	}

	Disconnect-VIServer $singleViserver -Confirm:$false
	

}

	$HBAreport  | export-csv "C:\temp\VM-Inventory-Test-11-24-14.csv" -NoTypeInformation
