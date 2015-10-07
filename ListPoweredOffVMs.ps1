$FileName = "WAG1-PoweredOffVMs.csv"
$Path = "\\it-s8mp-util1\scripts\" + $FileName

foreach ( $whatever in Get-VIEvent | where { $_.fullFormattedMessage -like "Task: Power off*" })
{
	$xdate = $whatever.createdTime
	$xname = $whatever.userName
	$xmessage = $whatever.fullFormattedMessage
	
	foreach ($VmObjectId in Get-Task | Where { $_.Name -like "PowerOffVM_Task"})
	{
			foreach ($VmId in Get-VM | where { $_.Id -like $VmObjectId.ObjectId})
			{
				$xvmname = $vmId.Name
				$vmhost = $VmId.Host
			}
	}
	$xstring =  "$xdate,$xname,$xmessage,$xvmname,$vmhost"
	Add-Content -Path $Path -Value $xstring
}
