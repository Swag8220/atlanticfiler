ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

TriggerEvent('esx_phone:registerNumber', 'realestateagent', _U('client'), false, false)
TriggerEvent('esx_society:registerSociety', 'realestateagent', 'Agent immobilier', 'society_realestateagent', 'society_realestateagent', 'society_realestateagent', {type = 'private'})


