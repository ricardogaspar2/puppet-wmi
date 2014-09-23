# wmi

## Overview

This module is a defined type to manage WMI objects on Windows.  It has been tested on Windows Server 2012 R2.

## Module Description

This is a fairly simple type to set the values for WMI objects so you don't have to fight Puppet DSL wrapping up PowerShell with all the right syntax.

## Usage

To use the wmi type, you must specify as least the namespace, class, property and value (as shown below).  You can also specify a value for `wmi_method` if it does not follow the default syntax of prefixing the property with `set`.

	wmi { 'Remote Desktop - Network Level Authentication' :
	  wmi_namespace => 'root/cimv2/terminalservices',
	  wmi_class     => 'Win32_TSGeneralSetting',
	  wmi_property  => 'UserAuthenticationRequired',
	  wmi_value     => 1,
	}
  	wmi { 'Remote Desktop - Allow Connections' :
    	  wmi_namespace => 'root/cimv2/terminalservices',
    	  wmi_class     => 'Win32_TerminalServiceSetting',
    	  wmi_property  => 'AllowTSConnections',
    	  wmi_value     => 1
  	}
