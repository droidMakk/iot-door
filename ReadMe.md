# IoT : Door Controller

## Follow below steps to configure nodemcu

* add your **wifi/gateway** configuration in **config.lua** file
* Including your IP configuration
* DNS is default at _255.255.255.0_
* Configure mqtt broker name in **mqtt_hl.lua**

Note That TCP server at 85 is under construction
Server Type| Port
-|-
TCP : Handling|82
<del>TCP Update</del> | <del>85</del>

Send this following JSON payload to TCP Server at **Port 82**

```json
{
  "ssid": "Gateway/Hotspot name",
  "pwd": "Gateway's password",
  "save": "true",
  "ip": "Device's ip address",
  "netmask": "255.255.255.0",
  "gateway": "Gateway's internal ip address"
}
```

The following request can be made to control or know the status of
the device

| Request | Action          |
| ------- | --------------- |
| "off"   | Switch off      |
| "stat"  | Status (on/off) |

Automatically switches on after two seconds
