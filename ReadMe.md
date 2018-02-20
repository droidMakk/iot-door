Add your Wifi Name and Password in wifi_c.lua file. Marked!

SSID & Password in wifi_c.lua

Configure static ip address, netmask and gateway in wifi_c.lua
file.

Ip : 192.168.4.211
Gateway : 192.168.4.1
Netmask : 255.255.255.0

You can find the specifics marked what to put where.

Once the code is pushed to device restart or reset the device.

It'll start a server to which you can send the following request to
control if any relay connected to a specific port

The request must be in TCP format on top of which HTTP sits.

The following request can be made to control or know the status of
the device

--------------------------
 Request | Action
--------------------------
 "on"    | Switch on
 "off"   | Switch off
 "stat"  | Status (on/off)
--------------------------
