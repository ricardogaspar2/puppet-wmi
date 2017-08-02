# == Defined Type: wmi
#
# This module is a defined type for manipulating WMI Objects with Puppet.
#
# === Parameters
#
#
# $wmi_namespace - The object's namespace.
# $wmi_class - The class name.
# $wmi_property - The property you wish to manage.
# $wmi_value - The value you wish for the property
# $wmi_method - The method to set the value, defaults to set${wmi_property}.
#
# === Examples
#
# To use the wmi type, you must specify as least the namespace, class, property and value (as shown below). When a value for
# `wmi_method` is not provided it will change only the property specified. Otherwise, it will use the method provided.
# Be aware that you should always use the class method whenever it is available. That's the correct usage. Otherwise the property
# might not be changed properly.
#
#
# This example will set the property value directly without calling any method. Because there isn't any available.
#
# wmi { 'Change RDS RDP-TCP Environment Setting':
#  wmi_namespace => 'root/cimv2/terminalservices',
#  wmi_class     => 'Win32_TSEnvironmentSetting',
#  wmi_property  => 'InitialProgramPolicy',
#  wmi_value     => '2',
#}
#
#
# These examples use specified methods.
#
# wmi { 'Remote Desktop - Allow Connections' :
#  wmi_namespace => 'root/cimv2/terminalservices',
#  wmi_class     => 'Win32_TerminalServiceSetting',
#  wmi_property  => 'AllowTSConnections',
#  wmi_value     => '1',
#  wmi_method    => 'SetAllowTSConnections',
#}
#
# wmi { 'Remote Desktop - Set Encription Level':
#  wmi_namespace => 'root/cimv2/terminalservices',
#  wmi_class     => 'Win32_TSGeneralSetting',
#  wmi_property  => 'MinEncryptionLevel'
#  wmi_value     => '1',
#  wmi_method    => 'SetEncryptionLevel',
#}
#
#}
# === Authors
#
# Matthew Stone <matt@souldo.net>
#
# Changed by Ricardo Gaspar <ricardo.gaspar@cern.ch>
#
# === Copyright
#
# Copyright 2014 Matthew Stone, unless otherwise noted.
#
define wmi ($wmi_namespace, $wmi_property, $wmi_class, $wmi_value, $wmi_method = "") {
  $wmi_array = ["-Namespace ${wmi_namespace}", "-Class ${wmi_class}",]
  $wmi_data = join($wmi_array, ' ')
  $wmi_ps = "Get-WmiObject ${wmi_data}"
  $wmi_chk = "If ((\$wmiobject.${wmi_property}) -like '${wmi_value}')" 

  if $wmi_method != "" {
    $wmi_pscommand = "\$wmiobject=${wmi_ps};\$wmiobject.${wmi_method}('${wmi_value}')"
  } else {
    $wmi_pscommand = "${wmi_ps} | Set-WmiInstance -Arguments @{${wmi_property}='${wmi_value}'}"
  }

  exec { $name:
    command  => "${wmi_pscommand}",
    onlyif   => "\$wmiobject=${wmi_ps};${wmi_chk} {exit 1} else {exit 0}",
    provider => powershell,
  }
}
