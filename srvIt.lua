local srvCon = {}

--Pin to be connected
rpin=6
status="off"

function Initsrv()
    gpio.mode(rpin,gpio.OUTPUT);
    srv=net.createServer(net.TCP)
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

srvCon.Initsrv = Initsrv
srvCon.listenIn = listenIn

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

return srvCon
