$vCenterName = "pw1sim-npciv10"
$userName = "walgreenco.net\secyanca"
$UserPass = "Apr.2015E"
$VMname = "TestServer1"
$ClusterName = "Sensitive Dev Test Cluster 101"
$Datastore = "Sensitive Dev Test Cluster 101"
$PortGroup = "1206_ESXi_Management"
$Template = "vCAC-W2012R2-STD-Gold"
$CustomSpec = "WIN2012 R2 Build"

#connect to vCenter
Connect-VIServer $vCenterName -User $userName -Password $UserPass

$myTemplate = Get-Template -Name $Template
$mySpecification = Get-OSCustomizationSpec -Name $CustomSpec

New-VM -Name $VMname -ResourcePool $ClusterName -Datastore $Datastore -NetworkName $PortGroup -Template $myTemplate -OSCustomizationSpec $mySpecification

Disconnect-VIServer $vCenterName -Confirm:$false