local gpio_h = {}

tpin=2
rpin=7
inTpin=5
pulsePin=6
lPin=4
on=0
off=1
tmr_stat="offd"

gpio.mode(inTpin,gpio.INT)
gpio.mode(pulsePin,gpio.OUTPUT)
gpio.write(pulsePin,gpio.HIGH)
gpio.mode(rpin,gpio.OUTPUT)
gpio.mode(lPin,gpio.OUTPUT)
gpio.mode(tpin,gpio.INPUT)
gpio.write(tpin,gpio.LOW)

function switch_door()
	if tmr_stat=="offd" then
		switch_tmr = tmr.create()
		-- Switch on after two seconds
		switch_tmr:register(2000,tmr.ALARM_SINGLE,function()
			gpio.write(rpin,off)
			if gpio.read(rpin) == off then
                tmr_stat="offd"
				gpio.write(lPin,off)
			end
		end)

		gpio.write(rpin,0)
		if gpio.read(rpin) == on then
			gpio.write(lPin,on)
			switch_tmr:start()
            tmr_stat="ond"
			return true
		end
	end
end
gpio_h.switch_door=switch_door



function get_temp()
	tmp_stat={}
	tmp_stat.status, tmp_stat.temp, tmp_stat.hum, tmp_stat.tempd, tmp_stat.humd = dht.read11(2)
	return tmp_stat
end
gpio_h.get_temp=get_temp


return gpio_h
