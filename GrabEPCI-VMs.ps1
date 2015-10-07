

$myCol = @()

	ForEach ($VMguest in Get-VM)
	    {
			$Server = $VMguest.Name
			$Sockets = $VMguest.NumCpu
	        $GuestOS = (Get-VMGuest -VM $VMguest.name).OSFullName
			$MemoryInstalled = [decimal]::round($VMguest.MemoryGB)
			$ProvDisk = [decimal]::round($VMguest.ProvisionedSpaceGB)
			$Datastore = Get-Datastore | where {$_.Id -eq $VMguest.DatastoreIdList} 
			$PState = $VMguest.PowerState
			$VMSummary = "$Server,$GuestOS,$Sockets,$MemoryInstalled,$ProvDisk,$Datastore,$PState"
	        $myCol += $VMSummary
	        $myCol
	    }
	

$myCol | Out-File c:\temp\VM-EPCI101-All-013114.csv