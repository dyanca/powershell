
  
foreach ($ESXhost in get-vmhost)

{
	Set-vmhostsyslogserver -syslogserver 155.45.145.23 -syslogserverport 514 -VMHost $ESXhost
}