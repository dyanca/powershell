#test environment build out

#Connection Info
$nUserName = "wag2lab\yancadan"
$nPassword = "Jun.2014"
$nvCenter = "172.31.72.21"

Connect-VIServer $nvCenter -User $nUserName -Password $nPassword


#New Cluster Info
$nNewClusterName = "Virtual ESX Cluster"
$nDatacenterObject = "WAG2 Lab"

#New-Cluster -Location $nDatacenterObject -Name $nNewClusterName -DRSEnabled -DRSMode FullyAutomated -HAEnabled:$true




#build new host VM
$i = 1
$nHostIP = "labc03b10.wag2lab.local"
$nISOPath = "[clariion-ds01] ISO/ESXi 5.5/VMware-VMvisor-Installer-5.5.0.update01-1623387.x86_64.iso"

do {
$nVM = "vESX00"+$i
New-VM -Name $nVM -VMHost $nHostIP -DiskMB 10000 -MemoryMB 8192 -Datastore "clariion-ds02" -GuestId "otherLinux64Guest" -NumCpu 2 -CD:$true

#attach build ISO
Get-VM $nVM | Get-CDDrive | Set-CDDrive -IsoPath $nISOPath -StartConnected $true -Confirm:$false

#Boot VM
Start-VM -VM $nVM

$i++
}
while ($i -le 2)







#disConnect-VIServer $nvCenter -Confirm:$false