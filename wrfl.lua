local wrtfl = {}

function wrt(data)
    if file.open('wiconf.lua','w+') then
        file.writeline("")
        file.writeline("local wiconf={}")
        file.write('wiconf.ssid="')
        file.write(data.ssid)
        file.writeline('"')
        file.write('wiconf.pwd="')
        file.write(data.pwd)
        file.writeline('"')
        file.write('wiconf.save=')
        file.writeline(data.save)
        file.writeline('')
        file.write('wiconf.ip="')
        file.write(data.ip)
        file.writeline('"')
        file.write('wiconf.netmask="')
        file.write(data.netmask)
        file.writeline('"')
        file.write('wiconf.gateway="')
        file.write(data.gateway)
        file.writeline('"')
        file.writeline('return wiconf')
        file.close()
        print("File written")
        return true
    else
        print("Not found")
        return false
    end
end

wrtfl.wrt = wrt

return  wrtfl