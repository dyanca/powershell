Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#----------- Read in the list of vCenters to query --------
."C:\users\dyancayx\Documents\GitHub\working\vCenterList.ps1"

#$viservers = "EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-npciv10","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user secyancad -password "Jul.2015E"
}
	
get-vm | select Name,NumCpu,MemoryGB,@{N="vCenter";E={$_.ExtensionData.CLient.ServiceUrl.Split('/')[2]}},@{N="OS";E={$_.Guest.OSFullName}} | Export-Csv c:\temp\VM-Inventory-060215.csv -NoTypeInformation

Disconnect-VIServer * -Confirm:$false