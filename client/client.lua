RegisterNUICallback('input', function(data, cb)
    exports["gksphone"]:InputChange(data)
    cb('ok')
end)

RegisterNUICallback('getInfo', function(data, cb)
    local bills = lib.callback.await('gksphone-billing:server:GetBillings')
    exports["gksphone"]:NuiSendMessage({ event = 'getBills', bills = bills })
    cb('ok')
end)

RegisterNUICallback('billing_pay', function(data, cb)
    local success = lib.callback.await('gksphone-billing:server:PayBill', data.id)
    if success then
        Wait(1000)
        local bills = lib.callback.await('gksphone-billing:server:GetBillings')
        exports["gksphone"]:NuiSendMessage({ event = 'getBills', bills = bills })
    end
    cb('ok')
end)
