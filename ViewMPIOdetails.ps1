Connect-VIServer dtnvcenter101  -user "walgreens\secyancadan" -password "Dec.2012E"

foreach ($VMHost in Get-VMhost) {

      foreach ($lun in ($VMHost | Get-SCSIlun -CanonicalName "*naa.60*")){
                                                
            $id = $lun.CanonicalName
                                                                                                                                                
            foreach($ds in (Get-VMHost $VMHost | Get-Datastore | where{$_.Type -eq "vmfs"} | Get-View)){
                   $ds.Info.Vmfs.Extent | %{
                   if($_.DiskName -eq $id){
                
                   $Details = "" | Select Host, Datastore, CanonicalName, PSPPolicy, State
                   $Details.Host = $VMhost
                   $Details.Datastore = $ds.Info.Name
                     $Details.CanonicalName = $lun.CanonicalName
                   $Details.PSPPolicy = $lun.MultipathPolicy
				   $Details.State = $lun.State
                   $Details.PSTypeNames.Clear()
                   $Details
                           }
              }
         }
    }
}
