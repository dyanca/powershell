Connect-VIServer epcivcenter101 -User secyancadan -Password "Aug.2014E"

$vmhost = $null
$SyslogInfo = $null
$report = $null
$HBAreport = @()

	foreach ($vmhost in (Get-VMHost)) 
		{
			$report = "" | Select Server,ConfiguredScratchLocation,CurrentScratchLocation,Syslog,vpxaHostIP,vpxaHostKey
			$CurrentScratchLocation = Get-AdvancedSetting -Entity (Get-VMHost -Name $vmhost) -Name ScratchConfig.CurrentScratchLocation
			$ConfiguredScratchLocation = Get-AdvancedSetting -Entity (Get-VMHost -Name $vmhost) -Name ScratchConfig.ConfiguredScratchLocation
			$SyslogInfo = Get-AdvancedSetting -Entity (Get-VMHost -Name $vmhost) -Name Syslog.global.logHost
			$VpxaHostIP = Get-AdvancedSetting -Entity (Get-VMHost -Name $vmhost) -Name Vpx.Vpxa.config.vpxa.hostIp
			$VpxaHostKey = Get-AdvancedSetting -Entity (Get-VMHost -Name $vmhost) -Name Vpx.Vpxa.config.vpxa.hostKey
			$report.ConfiguredScratchLocation = $ConfiguredScratchLocation.Value
			$report.CurrentScratchLocation = $CurrentScratchLocation.Value
			$report.Server = $SyslogInfo.Entity
			$report.Syslog = $SyslogInfo.Value
			$report.vpxaHostIP = $VpxaHostIP.Value
			$report.vpxaHostKey = $VpxaHostKey.Value
			$HBAreport += $report
			
		}

$HBAreport | ft
Disconnect-VIServer * -Confirm:$false