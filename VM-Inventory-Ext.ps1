$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20"#,"pw2sim-epciv20","pw2sim-inetv20"
#$viservers = "SENVCENTER01","IDVCENTER01"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "" -password ""

	foreach ($VM in Get-VM) {

       $Report = "" | select Name, PowerState, vCenter, vHost, CPU, RAM, Disk, vOS
       $Report.Name = $VM.Name
       $Report.PowerState = $VM.PowerState
       $Report.vCenter = $singleViserver
	   $Report.vHost = $VM.VMHost
	   $Report.CPU = $VM.NumCpu
	   $Report.RAM = $VM.MemoryGB
	   $Report.Disk = $VM.ProvisionedSpaceGB
	   $Report.vOS = $VM.Guest
       $HBAreport += $Report
       $print = $Report
	     	       
	}
	$print

	Disconnect-VIServer $singleViserver -Confirm:$false
	
	$HBAreport | export-csv "C:\temp\VM-Inventory-Ext-09-08-14.csv" -NoTypeInformation
}
