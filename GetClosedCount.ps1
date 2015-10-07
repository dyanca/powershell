$Username = "root"
$esxcli = "C:\Program Files\VMware\VMware vSphere CLI\bin\esxcli.exe"
 
#list of ESX and ESXi host to perform operation against
$vihosts = @(
"uslzuil008vsh.us001.siemens.net",
"uslzuil009vsh.us001.siemens.net",
"uslzuil013vsh.us001.siemens.net",
"uslzuil017vsh.us001.siemens.net",
"uslzuil018vsh.us001.siemens.net"
)
 
#prompt user for password
$passwordInput = Read-Host -AsSecureString:$true "Please enter your common password for hosts"
 
#convert secure password to normal string
$Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($passwordInput)
$Password = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
 
#loop through array of hosts
for($i = 0; $i -le $vihosts.length -1; $i++) {
 write-Host Retrieving closed ports on $vihosts[$i]
 #could not find a way to store the params in a variable you must
 #insert esxcli parameters at the very end of the statement below
 $lines = & $esxcli --server $vihosts[$i] --username $Username --password $Password network connection list
 ($lines | Where {$_ -like "*CLOSED*"}).Count}