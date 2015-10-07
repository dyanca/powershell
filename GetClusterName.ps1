$myVCenter = Connect-VIServer -Server "vc-ovsdc" -User "" -Password ""

Foreach ($Cluster in Get-Cluster){
	Write-Host $Cluster
	foreach ($ESXhost in get-cluster $Cluster | get-vmhost){
		Write-Host $ESXhost
	}
}