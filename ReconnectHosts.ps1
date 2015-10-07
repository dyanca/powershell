# Reconnect all hosts in VirtualCenter. Connect first using Get-VIServer.
# If you need a password, set it here.
$password = "ixse.2010@GL"
get-vmhost | where { $_.State -eq "Disconnected" -or $_.State -eq "notResponding" } |
  % {
    $view = get-view $_.ID
    $arg = new-object VMware.Vim.HostConnectSpec
    $arg.userName = "root"
    $arg.password = $password
    $arg.force = $true
    if ($_.State -eq "notResponding") {
        $return = $view.DisconnectHost_Task()
        wait-task $return
    }
    $view.ReconnectHost_Task($arg)
}