local wicon={}
local srvCon = require('srvIt')
local wiconf = require('wiconf')

wcfg={}
ipcfg={}


--------------------- Wifi config ---------------------
--wcfg.ssid="Colife4thfloor" --Wifi SSID / Name Goes here
--wcfg.pwd="Colife@247" --Wifi Password goes here

wcfg.ssid=wiconf.ssid
wcfg.pwd=wiconf.pwd
wcfg.save=wiconf.save
--For Colive static .0.122, For Colive5thfloor .1.124

ipcfg.ip=wiconf.ip
ipcfg.netmask=wiconf.netmask
ipcfg.gateway=wiconf.gateway

function connectTo()

    wifi.setmode(wifi.STATIONAP)
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
    end)
    
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED,function()
         print("Disconnected")
    end)
end

wicon.connectTo=connectTo

return wicon
