Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

$fileName = "C:\temp\AlarrmInfo-09-10-15.csv"
$emailRecipient = "daniel.yanca@walgreens.com"
$emailSender = "daniel.yanca@walgreens.com"
$array = @(Import-CSV "C:\Users\dyancayx\Documents\GitHub\working\vcenters.csv")
$i = 0
$HBAreport = @()
$vcenterCount = $array.count

do {
    Connect-VIServer $array.vcenter[$i] -user "walgreens\secyancad" -password "Jul.2015E"

	foreach ($alarm in Get-AlarmDefinition | Get-AlarmAction -ActionType "SendEmail") {

       $Report = "" | select vCenter,AlarmDefinition,Email
       $Report.vCenter = $array.vcenter[$i]
       $Report.AlarmDefinition = $alarm.AlarmDefinition
       $Report.Email = $alarm.To
       $HBAreport += $Report
	     	       
	}

	Disconnect-VIServer $array.vcenter[$i] -Confirm:$false
	
	$HBAreport | export-csv $fileName -NoTypeInformation
    
    $i++

}
while ($i -lt $vcenterCount)


Send-MailMessage -From $emailSender -To $emailRecipient -Cc 'daniel.yanca@walgreens.com' -Subject 'Alarm Email Report' -Body 'See the attached Alarm Email Report' -SmtpServer corpsmtp.walgreens.com -Attachments $fileName
