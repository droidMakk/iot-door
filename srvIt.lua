local wrfl = require('wrfl')
local srvCona = {}
--Pin to be connected
rpin=7
status="on"
togstart="off"
--Initiating for the switch
gpio.mode(5,gpio.INT)
gpio.mode(6,gpio.OUTPUT)
gpio.write(6,gpio.HIGH)
gpio.mode(rpin,gpio.OUTPUT);

T2mr = tmr.create()
    T2mr:register(2000, tmr.ALARM_SINGLE,function()
         gpio.write(5,gpio.LOW)
    end)
    
    if not T2mr:start() then print("Err_") end
    
    gpio.trig(5,"up",function()
        if togstart=="off" then
            switch_it()
            togstart="on"
        end
    end)

function Initsrv()
    srv=net.createServer(net.TCP)
end

function offsrv()
    srv:close()
end

function listenIn()
    srv:listen(80,function(conn)
      conn:on("receive",function(conn,payload)
        if payload=="fc3a314493fc47f" then --on
              if (onit()) then
                conn:send("On")
                status="on"
              end
        elseif payload=="off" then --a6cce86c323d0ea
              if (offit()) then
                onaftr=tmr.create()
                onaftr:register(5000, tmr.ALARM_SINGLE,function()
                    if onit() then
                        status="on"
--                        conn:send("auto-on")
                    end
                end)
                onaftr:start()
                conn:send("Off")
                status="off"
              end
        elseif payload=="stat" then
            conn:send(status)
        else
            stt=pcall(sjson.decode,payload)
            if stt then
                json =sjson.decode(payload)
                if (json.ip and json.netmask and json.ssid and json.pwd and json.gateway and json.save) then
                    print("IP : ",json.ip)
                    print("NM : ",json.netmask)
                    print("SSID : ",json.ssid)
                    print("Pwd : ",json.pwd)
                    print("GW : ",json.gateway)
                    print("SV  : ",json.save)
                    if wrfl.wrt(json) then 
                        conn:send("written and restarting")
                        restr=tmr.create()
                        restr:register(2000,tmr.ALARM_SINGLE,function() node.restart() end)
                        restr:start()
                    else 
                        conn:send("not written") 
                    end
                else
                    conn:send("met")
                    print("requirement not met")
                end
            else
                conn:send("no json")
            end
        end
      end)
      conn:on("sent",function(conn) print("Sent") end)
    end)
end

srvCona.offsrv = offsrv
srvCona.Initsrv = Initsrv
srvCona.listenIn = listenIn

function onit()
     gpio.write(rpin,gpio.HIGH)
     if (gpio.read(rpin)==1) then
          return true
     end
end

function offit()
     gpio.write(rpin,gpio.LOW)
     if (gpio.read(rpin)==0) then
          return true
     end
end

function switch_it(level,when)
    Ttmr = tmr.create()
    if offit() then
        status="off"
        print(status)
    end
    Ttmr:register(5000, tmr.ALARM_SINGLE,function()
        if onit() then
            status="on"
            togstart="off"
            print(status)
            gpio.write(5,gpio.LOW)
        end
    end)
    if not Ttmr:start() then print("Err") end       
end

return srvCona
