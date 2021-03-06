Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

$fileName = "C:\temp\VM-Inventory-Full-08-28-15.csv"
$emailRecipient = ""
$emailSender = ""
$array = @(Import-CSV "C:\Users\dyancayx\Documents\GitHub\working\vcenters.csv")
$i = 0
$HBAreport = @()
$vcenterCount = $array.count

do {
    Connect-VIServer $array.vcenter[$i] -user "" -password ""

	foreach ($VM in Get-VM) {

       $Report = "" | select Name, PowerState, vCenter,Location,NumCpu,MemoryGB,ProvisionedSpaceGB,UsedSpaceGB,GuestId, OSFullName, IPAddress
       $Report.Name = $VM.Name
       $Report.PowerState = $VM.PowerState
       $Report.vCenter = $array.vcenter[$i]
       $Report.Location = $array.location[$i]
        $GuestDetails = Get-VMGuest -VM $VM
       $Report.GuestId = $GuestDetails.GuestId
       $Report.OSFullName = $GuestDetails.OSFullName
       $Report.IPAddress = $GuestDetails.IPAddress[0]
       $Report.NumCpu = $VM.NumCpu
       $Report.MemoryGB = $VM.MemoryGB
       $Report.ProvisionedSpaceGB = [decimal]::round($VM.ProvisionedSpaceGB)
       $Report.UsedSpaceGB = [decimal]::round($VM.UsedSpaceGB)
       $HBAreport += $Report
	     	       
	}

	Disconnect-VIServer $array.vcenter[$i] -Confirm:$false
	
	$HBAreport | export-csv $fileName -NoTypeInformation
    
    $i++

}
while ($i -lt $vcenterCount)


Send-MailMessage -From $emailSender -To $emailRecipient -Cc '' -Subject 'VM Inventory Results' -Body 'See the attached VM inventory' -SmtpServer corpsmtp.walgreens.com -Attachments $fileName
