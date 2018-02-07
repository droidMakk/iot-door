local ota_update = {}


function chk_update()
    sk=net.createConnection(net.TCP,0)
    sk:on("connection",function(sck,c)
        sk:send("update-json")
        sk:on("receive",function(sck,data)
            djson=sjson.decode(data)
            if djson.status=="true" then
                print(djson.url)
--              Get number of files in JSON
                if(djson.no_files>0) then
                    for i=1,djson.no_files,1 do
                       atmr=tmr.create()
                       atmr:register(2000,tmr.ALARM_SINGLE,function() 
                            http.get("http://192.168.137.1/file/"..djson.filename[i], nil, function(code, data)
                                if (code < 0) then
                                    print("HTTP request failed")
                                else
                                    print(data)
                                end
                            end)
                       end)
                       atmr:start()
                    end
                end
--              Intend array and get filename
--              Send HTTP Request for each file and get write file         
            else
                print("no update")
            end
        end)
        
    end)
    sk:connect(92,"192.168.137.1")
end


function downfile(filename)    
    http.get("http://192.168.137.1/file/"..filename, nil, function(code, data)
        if (code < 0) then
          print("HTTP request failed")
        else
          print(data)
        end
    end)
end