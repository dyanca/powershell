#$viservers = "GENVCENTER02","PCIVCENTER02","EPCIVCENTER02","DTNVCENTER01","DTSVCENTER01","IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101"

$myCol = @()

	ForEach ($VMguest in Get-VM)
	    {
			$Server = $VMguest.Name
			$Sockets = $VMguest.NumCpu
			$Cores = $VMguest.ExtensionData.Config.hardware.numCoresPerSocket
	        $GuestOS = (Get-VMGuest -VM $VMguest.name).OSFullName
			$HWversion = $VMguest.Version
			$VMSummary = "$Server,$Sockets,$Cores,$GuestOS,$HWversion"
	        $myCol += $VMSummary
	        
	    }
	

$myCol #| Out-File c:\temp\VM-CPU-All-120913.csv