-- LAVET I SAMARBEJDE MED MOHR
-- sCallback.lua og cCallback.lua kan bruges som man vil, dog værdsættes en smule credit, men vigtigst af alt, SÅ SKAL MAN IKKE SÆLGE DET
-- Link: https://github.com/OMikkel/omik_callbacks

sCallback = {
    RegisterServerCallback = function(self, name, f)
        self.server[name] = f
    end,
    TriggerClientCallback = function(self, source, name, args, cb)
        TriggerClientEvent("omik-callback:TriggerClientCallback", source, name, args)
        while self.client[name] == nil do
            Wait(1)
        end
        cb(self.client[name])
    end,
    server = {},
    client = {}
}
RegisterServerEvent("omik-callback:TriggerServerCallback")
AddEventHandler("omik-callback:TriggerServerCallback", function(name, args)
    local source = source
    TriggerClientEvent("omik-callback:RecieveServerCallback", source, name, sCallback.server[name](table.unpack(args)))
end)

RegisterServerEvent("omik-callback:RecieveClientCallback")
AddEventHandler("omik-callback:RecieveClientCallback", function(name, data)
    sCallback.client[name] = data
end)
