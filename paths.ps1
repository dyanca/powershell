#$viservers = "IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","DTNVCENTER101","DTSVCENTER101"
#$viservers = "SENVCENTER02","IPTVCENTER02","SBVCENTER01","epcivcenter01","infvcenter01","SENVCENTER1","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01"

Connect-VIServer "SENVCENTER02" -User "walgreens\secyancadan" -Password "Mar.2013E"

Get-VMHost | % {
     $server = $_
      ($_ | Get-View).config.storagedevice.multipathinfo.Lun | %{$_.Path} | `
      select Name, PathState | `
      Add-Member -pass NoteProperty Server $Server.Name | `
      Select Server, Name, PathState
} | Export-Csv -Path C:\temp\SENVCENTER02-031713-paths.csv -NoTypeInformation