$myVCenter = Connect-VIServer -Server "sbvcenter01" -User "walgreens\secyancadan" -Password "Dec.2012E"
$CurrentAlarm = "Host Baseboard Management Controller status"


Get-AlarmDefinition $CurrentAlarm | %{

   $_ | Set-AlarmDefinition -ActionRepeatMinutes (60 * 24);

   $_ | New-AlarmAction -Email -To "EIS-vSphere-Alerts@walgreens.com" | %{

      $_ | New-AlarmActionTrigger -StartStatus "Green" -EndStatus "Yellow" -Repeat

      $_ | Get-AlarmActionTrigger | ?{$_.repeat -eq $false} | Remove-AlarmActionTrigger -Confirm:$false

      $_ | New-AlarmActionTrigger -StartStatus "Yellow" -EndStatus "Red" -Repeat

   }

}