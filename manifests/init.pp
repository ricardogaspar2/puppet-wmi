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
#  wmi { 'Remote Desktop - Network Level Authentication' :
#    wmi_namespace => 'root/cimv2/terminalservices',
#    wmi_class     => 'Win32_TSGeneralSetting',
#    wmi_property  => 'UserAuthenticationRequired',
#    wmi_value     => 1,
#  }
#  wmi { 'Remote Desktop - Allow Connections' :
#    wmi_namespace => 'root/cimv2/terminalservices',
#    wmi_class     => 'Win32_TerminalServiceSetting',
#    wmi_property  => 'AllowTSConnections',
#    wmi_value     => 1
#  }
#
# === Authors
#
# Matthew Stone <matt@souldo.net>
#
# === Copyright
#
# Copyright 2014 Matthew Stone, unless otherwise noted.
#
define wmi (
  $wmi_namespace,
  $wmi_property,
  $wmi_class,
  $wmi_value,
  $wmi_method = "Set${wmi_property}"
) {

  $wmi_array = ["-Namespace ${wmi_namespace}",
    "-Class ${wmi_class}",]
  $wmi_data  = join($wmi_array,' ')
  $wmi_ps    = "Get-WmiObject ${wmi_data}"
  $wmi_chk   = "If ((\$wmiobject.${wmi_property}) -like '${wmi_value}')"

  exec { $name :
    command  => "\$wmiobject=${wmi_ps};\$wmiobject.${wmi_method}(${wmi_value})",
    onlyif   => "\$wmiobject=${wmi_ps};${wmi_chk} { exit 1 }",
    provider => powershell,
  }
}

