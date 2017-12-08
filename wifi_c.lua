local wicon={}
wcfg={}
local srvCon = require('srvIt')

--------------------- Wifi config ---------------------
--wcfg.ssid="COLIVE STATIC IP" --Wifi SSID / Name Goes here
--wcfg.pwd="static@123" --Wifi Password goes here

wcfg.ssid="makk"
wcfg.pwd="password"

ipcfg = {ip="192.168.137.122",netmask="255.255.255.0",gateway="192.168.137.1"}

function connectTo()

    wifi.setmode(wifi.STATION)
    wifi.sta.config(wcfg)
    srvCon.Initsrv()
    srvCon.listenIn()
    --Configure your static ip, netmas/dns and gateway below
    wifi.sta.setip(ipcfg)
    
    wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function()
        print("Connected..")
    end)
    
    wifi.eventmon.register(wifi.eventmon.STA_GOT_IP,function() 
        print(wifi.sta.getip())
--        srvCon.Initsrv()
--        srvCon.listenIn()
--        onthesrv = tmr.create()
--        onthesrv:register(4000,tmr.ALARM_SINGLE,function()    
--            
--         end)
--         onthesrv:start()
    end)
    
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED,function()
         print("Disconnected")
    end)
end

wicon.connectTo=connectTo

return wicon
