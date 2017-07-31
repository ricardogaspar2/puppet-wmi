# Module wmi
Original project from Puppet Forge:
 - https://forge.puppet.com/souldo/wmi
 - https://github.com/matthewrstone/puppet-wmi

changed by @ricardogaspar2 (Ricardo Gaspar)

## Overview

This module is a defined type to manage WMI objects on Windows.  It has been tested on Windows Server 2012 R2.

## Module Description

This is a fairly simple type to set the values for WMI objects so you don't have to fight Puppet DSL wrapping up PowerShell with all the right syntax.

## Usage

To use the wmi type, you must specify as least the namespace, class, property and value (as shown below). When a value for `wmi_method` is not provided it will change only the property specified. Otherwise, it will use the method provided.
Be aware that you **should always use the class method** whenever it is available. That's the correct usage. Otherwise the property might not be changed properly.


### Using properties
These examples will set the property value directly without calling any method. Because there isn't any available.
```
wmi { 'Change RDS RDP-TCP Environment Setting':
  wmi_namespace => 'root/cimv2/terminalservices',
  wmi_class     => 'Win32_TSEnvironmentSetting',
  wmi_property  => 'InitialProgramPolicy',
  wmi_value     => '2',
}
```

```
wmi { 'Install SSL Certificate for RDP':
    wmi_namespace => 'root/cimv2/terminalservices',
    wmi_class     => 'Win32_TSGeneralSetting',
    wmi_property  => 'SSLCertificateSHA1Hash',
    wmi_value     => '669A9C961733A05F228CD12AA9C6D5DAFE48FA58', 
  }
```

### Using methods
These examples use specified methods.
```
wmi { 'Remote Desktop - Allow Connections' :
  wmi_namespace => 'root/cimv2/terminalservices',
  wmi_class     => 'Win32_TerminalServiceSetting',
  wmi_property  => 'AllowTSConnections',
  wmi_value     => '1',
  wmi_method    => 'SetAllowTSConnections',
}
```

```
wmi { 'Remote Desktop - Set Encription Level':
  wmi_namespace => 'root/cimv2/terminalservices',
  wmi_class     => 'Win32_TSGeneralSetting',
  wmi_property  => 'MinEncryptionLevel'
  wmi_value     => '1',
  wmi_method    => 'SetEncryptionLevel',
}
```

