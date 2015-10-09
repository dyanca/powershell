Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

$viservers = "IDVCENTER02","EPCIVCENTER101","DTNVCENTER101","DTSVCENTER101","IDVCENTER101","GENVCENTER101","PCIVCENTER101","IPTVCENTER102","SENVCENTER02","IPTVCENTER02","SBVCENTER01","SENVCENTER101","REMVCENTER101","epcivcenter01","infvcenter01","idvcenter01","senvcenter01","genvcenter01","IPTVCENTER01","IPTVCENTER101","EDTSVCENTER101","it-s8sf-vcenter01","pw2sim-npciv20","pw2sim-ipciv20","pw2sim-epciv20","pw2sim-inetv20","pw1sim-npciv10","pw1sim-ipciv10","pw1sim-epciv10","pw1sim-inetv10"


foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancad" -password ""

        Get-AlarmDefinition | Get-AlarmAction -ActionType "SendEmail" | select @{N="vCenter";E={$singleViserver}},AlarmDefinition,@{N="Email";E={$_.To}}

    Disconnect-VIServer $singleViserver -Confirm:$false
}



