Connect-VIServer uslzuilw001srv.us001.siemens.net -User "us001\dky001-a" -Password "ILoveAlana!"

$esxName = "uslzuil014v05.us001.siemens.net"

Get-ScsiLun -VmHost (Get-VMHost $esxName) -LunType disk |  Set-ScsiLun -MultipathPolicy "roundrobin"
