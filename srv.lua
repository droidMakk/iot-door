local srv={}
local gpio_h=require('gpio_handle')
local wrfl=require('wrfl') 

tcpsrv=net.createServer(net.TCP)

function listen()
	tcpsrv:listen(82,function(conn)
		conn:on("receive",handlepayload)
	end)
end

function handlepayload(sck,data)
    if data=="off" then --crypto.encrypt("AES-ECB", "Colive@123456", "off")
        if gpio_h.switch_door() then
            sck:send("Offd")
        else
            sck:send("err")
        end
    elseif pcall(sjson.decode,data) then
        json =sjson.decode(data)
        if (json.ip and json.netmask and json.ssid and json.pwd and json.gateway and json.save) then
            print("IP : ",json.ip)
            print("NM : ",json.netmask)
            print("SSID : ",json.ssid)
            print("Pwd : ",json.pwd)
            print("GW : ",json.gateway)
            print("SV  : ",json.save)
            if wrfl.wrt(json) then 
                sck:send("written and restarting")
                restr=tmr.create()
                restr:register(2000,tmr.ALARM_SINGLE,function() node.restart() end)
                restr:start()
            else 
                sck:send("not written") 
            end
        else
            sck:send("Missing something?")
        end
    else 
        sck:send("invalid request")
    end
end


srv.listen=listen

return srv
