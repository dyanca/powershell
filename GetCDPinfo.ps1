
# Set the VI Server and Filename before running
$ESX1 = "clsrv-c13-b11"
Connect-VIServer $ESX1 -User root -Password ""
$filename = "c:\temp\clsrv-c13-b11-CDPoutput.csv"
 

Write "Gathering VMHost objects"
$vmhosts = Get-VMHost | Sort Name | Where-Object {$_.State -eq "Connected"} | Get-View
$MyCol = @()
foreach ($vmhost in $vmhosts){
 $ESXHost = $vmhost.Name
 
 Write "Collating information for $ESXHost"
 
 
 $networkSystem = Get-view $vmhost.ConfigManager.NetworkSystem
 foreach($pnic in $networkSystem.NetworkConfig.Pnic){
     $pnicInfo = $networkSystem.QueryNetworkHint($pnic.Device)
     foreach($Hint in $pnicInfo){
         $NetworkInfo = "" | select-Object Host, Cluster, vSwitch, PNic, Speed, MAC, DeviceID, PortID, VLAN, Observed
         $NetworkInfo.Host = $vmhost.Name
         $NetworkInfo.vSwitch = Get-Virtualswitch -VMHost (Get-VMHost ($vmhost.Name)) | where {$_.Nic -eq ($Hint.Device)}
         $NetworkInfo.PNic = $Hint.Device
         $NetworkInfo.DeviceID = $Hint.connectedSwitchPort.DevId
         $NetworkInfo.PortID = $Hint.connectedSwitchPort.PortId
         $NetworkInfo.Cluster = get-cluster -VMhost $vmhost.Name | ? {$_.name}
		 $NetworkInfo.ip_address = $_.NetworkInfo.VirtualNic[0].IP
         $record = 0
         
         Do{
             If ($Hint.Device -eq $vmhost.Config.Network.Pnic[$record].Device){
                 $NetworkInfo.Speed = $vmhost.Config.Network.Pnic[$record].LinkSpeed.SpeedMb
                 $NetworkInfo.MAC = $vmhost.Config.Network.Pnic[$record].Mac
             }
             $record ++
         }
         
         Until ($record -eq ($vmhost.Config.Network.Pnic.Length))
         foreach ($obs in $Hint.Subnet){
            	 $NetworkInfo.Observed += $obs.IpSubnet + " "
             Foreach ($VLAN in $obs.VlanId){
                 If ($VLAN -eq $null){
                 }
                 Else{
                     $strVLAN = $VLAN.ToString()
                     $NetworkInfo.VLAN += $strVLAN + " "
                 }
             }
         }
                  
         $MyCol += $NetworkInfo
     }
 }
}
$Mycol | Sort Host, PNic | Export-Csv $filename -NoTypeInformation

disConnect-VIServer $ESX1 -Confirm
