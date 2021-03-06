#####  This script is to UNmask paths per host, **for 5.x only!** #####

#Static variables
$esxcli = Get-EsxCli
$stringPlugin = "MASK_PATH"
$stringType = "location"
$longChannel = "0" #Runtime "C" #

#Modify these variables for every path to mask
$stringAdapterOne = "vmhba0"
$stringAdapterTwo = "vmhba1"
$longRule = 102 #next available rule #
$longLun = 0 #Runtime "L" or LUN ID #
$LastLunNumber = 14 #The highest LUN number presented to the host

Do {

	#First task is to run the add rules for both hba's
	$i = 0
	Do {
		Write-Host "remove rule $longRule..."
		$esxcli.storage.core.claimrule.remove($null,$null,$longRule)
		$longRule++
		Write-Host "remove rule $longRule..."
		$esxcli.storage.core.claimrule.remove($null,$null,$longRule)
		$longRule++
		$i++
	   }
	while($i -lt 4)

	#second task is to load the rules
	Write-Host "loading claim rules..."
	$esxcli.storage.core.claimrule.load()

	#third task is to unclaim the rules
	
	Write-Host "unclaiming paths..."
	$i = 0
	Do {
		$esxcli.storage.core.claiming.unclaim("$stringAdapterOne",$longChannel,$null,$null,$null,$longLun,$null,$null,$null,$i,"$stringType",$null)
		$esxcli.storage.core.claiming.unclaim("$stringAdapterTwo",$longChannel,$null,$null,$null,$longLun,$null,$null,$null,$i,"$stringType",$null)
		$i++
	   }
	while($i -lt 4)
	
	$longLun++
   }
while ($longLun -le $LastLunNumber) 

#fourth task is to run the rule
$esxcli.storage.core.claimrule.run()