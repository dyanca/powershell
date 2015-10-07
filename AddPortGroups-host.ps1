Connect-VIServer uslzuil003v01.US001.SIEMENS.NET -Username root -Password "ixse.2010@GL"
  
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 117_SIS -vlanid 117
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 116_SIS -vlanid 116
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 510_SIS -vlanid 510
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 600_SIS -vlanid 600
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 121_SIS -vlanid 121
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 610_SIS -vlanid 610
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2105_CHESS -vlanid 2105
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2112_CHESS -vlanid 2112
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2106_CHESS -vlanid 2106
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2104_CHESS -vlanid 2104
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2101_CHESS -vlanid 2101
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2111_CHESS -vlanid 2111
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2127_CHESS -vlanid 2127
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2103_CHESS -vlanid 2103
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2102_CHESS -vlanid 2102
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2120_CHESS -vlanid 2120
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2119_CHESS -vlanid 2119
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2000_CHESS -vlanid 2000
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 2100_CHESS -vlanid 2100
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 464_SIS -vlanid 464
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 462_SIS -vlanid 462
get-virtualswitch -name vSwitch2| new-virtualportgroup -name 421_SIS -vlanid 421




