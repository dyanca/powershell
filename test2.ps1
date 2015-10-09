$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101"

$myCol = @()
foreach ($singleViserver in $viservers) {
	Connect-VIServer $singleViserver -User  -Password ""
	ForEach ($VMguest in Get-VM)
	    {
			$Server = $VMguest.Name
			$Sockets = $VMguest.ExtensionData.Config.hardware.numCPU/$VMguest.ExtensionData.Config.hardware.numCoresPerSocket
			$Cores = $VMguest.ExtensionData.Config.hardware.numCoresPerSocket
	        $GuestOS = (Get-VMGuest -VM $VMguest.name).OSFullName
			$VMSummary = "$singleViserver,$Server,$Sockets,$Cores,$GuestOS"
	        $myCol += $VMSummary
	        
	    }
	
	Disconnect-VIServer $singleViserver -Confirm:$false
}
$myCol | Out-File c:\temp\test2.csv