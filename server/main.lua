if GetResourceState('qb-core') then
    local QBCore = exports['qb-core']:GetCoreObject()

    function GetPlayer(source)
        local player = QBCore.Functions.GetPlayer(source)
        return {
            source = player.PlayerData.source,
            identifier = player.PlayerData.citizenid
        }
    end
elseif GetResourceState('es_extended') then
    local ESX = exports['es_extended']:getSharedObject()

    function GetPlayer(source)
        local player = ESX.GetPlayerFromId(source)
        return {
            source = player.source,
            identifier = player.identifier
        }
    end
end

lib.callback.register('gksphone-billing:server:GetBillings', function(source)
    local player = GetPlayer(source)
    return MySQL.query.await(
        'SELECT `id`, `description` AS `label`, `price` AS `amount` FROM `billings` WHERE `identifier` = ? AND `status` NOT IN ("canceled", "paid")',
        { player.identifier }
    )
end)

lib.callback.register('gksphone-billing:server:PayBill', function(source, id)
    local player = GetPlayer(source)
    local bill = MySQL.single.await('SELECT `price`, `company`, `biller_id` FROM `billings` WHERE `id` = ?', { id })
    return exports.bcs_companymanager:PayBill(id, bill.price, bill.company, bill.biller_id, player)
end)
