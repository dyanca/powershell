
$viservers = "genvcenter01"

$HBAreport = @()
foreach ($singleViserver in $viservers)
{
	Connect-VIServer $singleViserver -user "walgreens\secyancadan" -password "Dec.2012E"


foreach ($VMHost in Get-VMhost) {

			Get-VMHost | %{
		      $esxImpl = $_
		      $_ | Get-ScsiLun | where {$_.LunType -eq "Disk"} | %{
		            $_ | Select @{N="HostName";E={$esxImpl.Name}},
		            @{N="Path";E={$_.CanonicalName}},
		            @{N="Policy";E={$_.MultiPathPolicy}},
		            @{N="Number";E={($_ | Get-ScsiLunPath).Count}}
		      }
			}|Export-Csv "C:\temp\ds.csv" -NoTypeInformation
		}
}