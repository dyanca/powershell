
#Connects to the ESX server or vCenter you specify
Connect-VIServer clsrv-c02-b08 -User root -Password ""


#Sets every datastore on the host(s) to Round Robin from the NAA ID given
foreach ($ESXhost in get-vmhost)

{
	get-vmhost|get-scsilun | Where-Object {$_.CanonicalName -like "naa.60000970000192*"} | set-scsilun -MultiPathPolicy RoundRobin #for Symmetrix
	get-vmhost|get-scsilun | Where-Object {$_.CanonicalName -like "naa.60060160*"} | set-scsilun -MultiPathPolicy RoundRobin #for CLARiiON
}



#Disconnects from specified ESX server
disconnect-VIServer * -Confirm:$false