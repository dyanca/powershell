Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"

#----------- Clear out major variables ------------
$singleViserver = $null
$viservers = $null
$HBAreport = @()
$user = $null
$pass = $null

#----------- Capture arguments given --------------
$user = "walgreens\secyancad"
$pass = "Sep.2015E"

#----------- Read in the list of vCenters to query --------
."C:\users\dyancayx\Documents\GitHub\working\vCenterList.ps1"

#----------- Use this option to test against one vCenter -----------
#$viservers ="pw1sim-npciv10"

#----------- Begin loop, that for each vCenter in the list it queries all the information and concatenates it to a variable -----------
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user $user -Password $pass


	foreach ($VMHost in Get-VMhost) {
	     

	           $Report = "" | select Name, vCenter, Cluster, ProcessorType, Manufacturer, Model, Version, Build, NumCpu, MemoryTotalGB, ManagementIP, ManagementSM, GatewayIP, VMotionEnabled, ManagementTrafficEnabled, Mtu, PortGroupName, Mac, vMotionIP, vMotionSM, WWN1, WWN2
               $Report.Name = $VMHost
               $Report.vCenter = $singleViserver
                $ClusterInfo = Get-VMHost -Name $VMHost | Get-Cluster
               $Report.Cluster = $ClusterInfo.Name
	           $Report.ProcessorType = $VMHost.ProcessorType
	           $Report.Manufacturer = $VMHost.Manufacturer
	           $Report.Model = $VMHost.Model
			   $Report.Version = $VMHost.Version
	           $Report.Build = $VMHost.Build
			   $Report.NumCPU = $VMHost.NumCpu
			   $Report.MemoryTotalGB = [decimal]::round($VMHost.MemoryTotalGB)
                $info = Get-VMHostNetworkAdapter -VMHost $VMHost | Where-Object{$_.Name -eq 'vmk0'}
               $Report.ManagementIP = $info.IP
               $Report.ManagementSM = $info.SubnetMask
                $GatewayIP = Get-VMHostNetwork -VMHost $VMHost
               $Report.GatewayIP = $GatewayIP.VMKernelGateway
               $Report.VMotionEnabled = $info.VMotionEnabled
               $Report.ManagementTrafficEnabled = $info.ManagementTrafficEnabled
               $Report.Mtu = $info.Mtu
               $Report.PortGroupName = $info.PortGroupName
               $Report.Mac = $info.Mac
                $vMotionInfo = Get-VMHostNetworkAdapter -VMHost $VMHost | Where-Object{$_.Name -eq 'vmk1'}
               $Report.vMotionIP = $vMotionInfo.IP
               $Report.vMotionSM = $vMotionInfo.SubnetMask
               $wwnInfo = Get-VMHostHBA -VMHost $VMHost -Type FibreChannel | Select VMHost,@{N="WWN";E={"{0:X}"-f$_.PortWorldWideName}}
               $Report.WWN1 = $wwnInfo.wwn[0]
               $Report.WWN2 = $wwnInfo.wwn[1]
	           $HBAreport += $Report
	           $print = $Report
	       
	       $print
	}
    disConnect-VIServer $singleViserver -Confirm:$false

}

#----------- Write total contents of the variable to the comma separated value file -------------
$HBAreport | export-csv "C:\temp\All-HostInfo-092215.csv" -NoTypeInformation