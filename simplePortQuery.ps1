$ports =443,902,903
$computer = "senvcenter02"
$results =foreach ($port in $ports)
{
    $tcpClient = New-Object –TypeName System.Net.Sockets.TcpClient
    $tcpClient.Connect($computer,$port)
    $obj = [pscustomobject]@{Computername = $computer
                             Port = "$port"
                             Open = $false
                            }
    if ($tcpClient.Connected)
    {
        $obj.open = $true
    }
    $tcpClient.Close()
    $obj
}