#This script exports a list of Distributed Switches, each port group, the port group's VLAN, and the Datacenter they reside in

Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"



#Get-VirtualSwitch -Server $vCenter | Get-VirtualPortGroup | select Datacenter,VirtualSwitch,Name,@{N="VLANId";E={$_.Extensiondata.Config.DefaultPortCOnfig.Vlan.VlanId}} 


#----------- Clear out major variables ------------
$singleViserver = $null
$viservers = $null
$HBAreport = @()
$user = $null
$pass = $null

#----------- Capture arguments given --------------
$user = $args[0]
$pass = $args[1]

#----------- Read in the list of vCenters to query --------
."C:\users\dyancayx\Documents\GitHub\working\vCenterList.ps1"

#----------- Use this option to test against one vCenter -----------
#$viservers ="senvcenter02"

#----------- Begin loop, that for each vCenter in the list it queries all the information and concatenates it to a variable -----------
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user $user -Password $pass


	foreach ($PG in Get-VirtualSwitch -Server $singleViserver | Get-VirtualPortGroup) {
	     

	           $Report = "" | select vCenter,Datacenter,VirtualSwitch,Portgroup,VLANId
               $Report.vCenter = $singleViserver
               $Report.Datacenter = $PG.Datacenter
               $Report.VirtualSwitch = $PG.VirtualSwitch
               $Report.Portgroup = $PG.Name
               $Report.VLANId = $PG.Extensiondata.Config.DefaultPortCOnfig.Vlan.VlanId
	           $HBAreport += $Report
	           $print = $Report
	       
	       $print
	}
    disConnect-VIServer $singleViserver -Confirm:$false

}

#----------- Write total contents of the variable to the comma separated value file -------------
$HBAreport | Export-Csv c:\temp\All-vCenter-networkInfo-080715.csv -NoTypeInformation