$myVCenter = Connect-VIServer -Server "192.168.87.13" -User "home\dan" -Password "Myn3tp@s$"
  
foreach ($ESXhost in get-vmhost)

{
	New-Datastore -VMHost $ESXhost -Name NFS-01 -Nfs -Path /mnt/volumegroup1/datastore01/nfs_datastore1 -NFSHost openfiler.home.local
	New-Datastore -VMHost $ESXhost -Name NFS-02 -Nfs -Path /mnt/volumegroup2/datastore02/nfs_datastore2 -NFSHost openfiler.home.local
}