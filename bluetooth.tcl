#!/usr/bin/env tclsh
puts "How to connect a device with bluetoothctl"

# steps
[bluetooth]# power on
[bluetooth]# agent on
[bluetooth]# default-agent
[bluetooth]# scan on
#after a while you can stop the scanning
[bluetooth]# scan off

# pair with your device
[bluetooth]# scan pair <MAC address>
# somethimes it is not needed to connect it too, but if it is not connected jet
[bluetooth]# scan connect <MAC address>

# if this does not work try to trust the device and retry
[bluetooth]# scan trust <MAC address>

# to unpair a device
[bluetooth]# remove <MAC address>

