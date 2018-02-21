local mqtt_hl={}
local gpio_h=require('gpio_handle')

m=mqtt.Client("iot-door-colive",1800)

brkr="iot.eclipse.org"
tmptmr=tmr.create()
pubontmr=tmr.create()

m:on("connect",function(client) 
	print("Connected to "..brkr)
end)

m:on("offline",function(client) 
	print("Disconnected from "..brkr)
    tmptmr:unregister()
end)

m:on("message",function(client,topic,data) 
 	 if topic=="/opendoor-10101100-colive" and data=="off" then  --crypto.encrypt("AES-ECB", "Colive@123456", "off")
 	 	if gpio_h.switch_door() then
 	 		client:publish("/statdoor-10101100-colive","OFF",2,0,function()
 	 			pubontmr:register(2000, tmr.ALARM_SINGLE,function()
 	 				client:publish("/statdoor-10101100-colive","ON",2,0,function() end)
 				end)
 				pubontmr:start()
 			end)
 	 	end	 	
	 end 
end)

m:lwt("/lwt","This was my last will...")

function c2broker()
	m:connect(brkr,1883,0,function(client)
		client:subscribe("/opendoor-10101100-colive", 2, function(cl)
			print("subscribed to /opendoor-10101100-colive")
		end)
		tmptmr:register(3000, tmr.ALARM_AUTO, function()
			tmp_stat=gpio_h.get_temp()
			client:publish("/temp-10101100-colive",tmp_stat.temp, 2, 0, function(cl) end)
            client:publish("/hum-10101100-colive",tmp_stat.hum, 2, 0, function(cl) end)
		end)
        tmptmr:start()
	end)
end


function closebrkr()
    m:close()
end

mqtt_hl.c2broker=c2broker
mqtt_hl.closebrkr=closebrkr

return mqtt_hl
