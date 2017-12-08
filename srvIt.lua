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
        switch_it()
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
        if payload=="on" then
              if (onit()) then
                conn:send("On")
                status="on"
              end
        end 
        if payload=="off" then
              if (offit()) then
                conn:send("Off")
                status="off"
              end
        end 
        if payload=="stat" then
            conn:send(status)
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
            print(status)
            gpio.write(5,gpio.LOW)
        end
    end)
    if not Ttmr:start() then print("Err") end       
end

return srvCona
