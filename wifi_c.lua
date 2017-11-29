local wicon={}
wcfg={}
local srvCon = require('srvIt')

--------------------- Wifi config ---------------------
wcfg.ssid="" --Wifi SSID / Name Goes here
wcfg.pwd="" --Wifi Password goes here

--wcfg.ssid="makk"
--wcfg.pwd="password"

function connectTo()

    wifi.setmode(wifi.STATION)
    wifi.sta.config(wcfg)
    
    --Configure your static ip, netmas/dns and gateway below
    ipcfg = {ip="192.168.4.211",netmask="255.255.255.0",gateway="192.168.4.1"}

    wifi.sta.setip(ipcfg)
    
    wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function()
        print("Connected..")
    end)
    
    wifi.eventmon.register(wifi.eventmon.STA_GOT_IP,function()
         print(wifi.sta.getip())
         srvCon.Initsrv()
         srvCon.listenIn()
    end)
    
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED,function()
         print("Disconnected")
    end)
end

wicon.connectTo=connectTo

return wicon
