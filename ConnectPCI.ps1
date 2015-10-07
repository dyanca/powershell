Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

$viservers = "EPCIVCENTER101","PCIVCENTER101","epcivcenter01","pw2sim-ipciv20","pw2sim-epciv20","pw1sim-ipciv10","pw1sim-epciv10"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancad" -password "Sep.2015E"
}