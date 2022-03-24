-- LAVET I SAMARBEJDE MED MOHR
-- sCallback.lua og cCallback.lua kan bruges som man vil, dog værdsættes en smule credit, men vigtigst af alt, SÅ SKAL MAN IKKE SÆLGE DET
-- Link: https://github.com/OMikkel/omik_callbacks

cCallback = {
    TriggerServerCallback = function(self, name, args, cb)
        TriggerServerEvent("omik-callback:TriggerServerCallback", name, args)
        while self.server[name] == nil do
            Wait(1)
        end
        cb(self.server[name])
    end,
    RegisterClientCallback = function(self, name, f)
        self.client[name] = f
    end,
    server = {},
    client = {}
}
RegisterNetEvent("omik-callback:RecieveServerCallback")
AddEventHandler("omik-callback:RecieveServerCallback", function(name, data)
    cCallback.server[name] = data
end)

RegisterNetEvent("omik-callback:TriggerClientCallback")
AddEventHandler("omik-callback:TriggerClientCallback", function(name, args)
    TriggerServerEvent("omik-callback:RecieveClientCallback", name, cCallback.client[name](table.unpack(args)))
end)
