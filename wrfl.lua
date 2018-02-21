local wrtfl = {}

function wrt(data)
    if file.open('config.lua','w+') then
        file.writeline("")
        file.writeline("local config={}")
        file.writeline("")
        file.write('config.ssid="')
        file.write(data.ssid)
        file.writeline('"')
        file.write('config.pwd="')
        file.write(data.pwd)
        file.writeline('"')
        file.write('config.save=')
        file.writeline(data.save)
        file.writeline('')
        file.write('config.ip="')
        file.write(data.ip)
        file.writeline('"')
        file.write('config.netmask="')
        file.write(data.netmask)
        file.writeline('"')
        file.write('config.gateway="')
        file.write(data.gateway)
        file.writeline('"')
        file.writeline("")
        file.writeline('return config')
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
