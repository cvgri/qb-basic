local http = require("socket.http")
local ltn12 = require("ltn12")

local girilenKod = "1234567890123456"
local url = "https://avencreative.com/verify.txt"

local responseBody = {}
local _, statusCode = http.request{
    url = url,
    sink = ltn12.sink.table(responseBody)
}

if statusCode == 200 then
    local dosyaIcerik = table.concat(responseBody)
    if dosyaIcerik then
        for kod in dosyaIcerik:gmatch("%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d") do
            if kod == girilenKod then
                print("Lisans doğrulandı. İşlemleri yapabilirsiniz.")
            else
                print("Lisans geçersiz.")
            end
        end
    else
        print("Dosya içeriği alınamadı.")
    end
else
    print("HTTP isteği başarısız. Durum kodu:", statusCode)
end
