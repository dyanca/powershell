#this doesn't work

$vmhost = "c46b01.walgreens.com"

add-vmhost $vmhost -location (get-datacenter -name ‘Sensitive Dev Test’ | get-cluster -name "Sensitive Dev Test Cluster 101") -user root -password "VMG!P3pp3r" -force:$true

$targethostMoRef = (get-VMHost $vmhost  | get-view).MoRef
$si = Get-View ServiceInstance
$LicManRef=$si.Content.LicenseManager
$LicManView=Get-View $LicManRef
$licassman = Get-View $LicManView.LicenseAssignmentManager
$licassman.UpdateAssignedLicense($targethostMoRef.value,”G0282-091E1-L8950-0E00K-CEX6N”,”Key only for vRealize Automation hosts”)