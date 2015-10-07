Connect-VIServer genvcenter01  -user "walgreens\secyancadan" -password "Dec.2012E"


	foreach ($esxhost in ($HostsViews | where {$_.Runtime.ConnectionState -match "Connected"})) {
		$esxhost | %{$_.config.storageDevice.multipathInfo.lun} | %{$_.path} | ?{$_.State -eq "Dead"} | %{
			$myObj = "" | Select VMHost, Lunpath, State
			$myObj.VMHost = $esxhost.Name
			$myObj.Lunpath = $_.Name
			$myObj.State = $_.state
			$deadluns += $myObj
			Write-Host $deadluns
			Write-Host "inside 2 loop"
		}
	}