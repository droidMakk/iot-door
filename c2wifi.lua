local config = require('config')
local mqtt_hl= require('mqtt_hl')
local wifi_con = {}

function ctowifi()
	wifi.setmode(wifi.STATIONAP)
	wifi.sta.config(config)
	wifi.sta.setip(config)
end

wifi_con.ctowifi=ctowifi

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function()
	print("Connected to "..config.ssid)	
end)

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function()
	print("IP Configured as below")
	print(wifi.sta.getip())
    mqtt_hl.c2broker()
end)

wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function()
	print("Disconnected from "..config.ssid)
    mqtt_hl.closebrkr()
end)

return wifi_con
