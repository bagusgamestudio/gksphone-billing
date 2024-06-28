local ESX = nil

Citizen.CreateThread(function()
    pcall(function() ESX = exports["es_extended"]:getSharedObject() end)
end)


RegisterNUICallback('input', function(data, cb)
    exports["gksphone"]:InputChange(data)
    cb('ok')
end)

RegisterNUICallback('getInfo', function(data, cb)  -- Uygulamaya girdiğinde çalışacak olan fonksiyon
    if ESX then
        ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
            exports["gksphone"]:NuiSendMessage({event = 'getBills', bills = bills})
        end)
    end
    cb('ok')
end)

RegisterNUICallback('billing_pay', function(data, cb)
    if ESX then
        ESX.TriggerServerCallback('esx_billing:payBill', function(test)
            Wait(1000)
            ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
                exports["gksphone"]:NuiSendMessage({event = 'getBills', bills = bills})
                cb('ok')
            end)
        end, data.id)
    end
end)