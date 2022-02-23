local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","fantasy_banking")

fsBank = {}
Tunnel.bindInterface("fantasy_banking",fsBank)
Proxy.addInterface("fantasy_banking",fsBank)
fcBank = Tunnel.getInterface("fantasy_banking","fantasy_banking")

function formatMoney(amount)
	local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function fsBank.getDate()
    local user_id = vRP.getUserId({source})
	local walletMoney = formatMoney(vRP.getMoney({user_id}))
	
    local bankMoney = formatMoney(vRP.getBankMoney({user_id}))
    local player = vRP.getUserSource({user_id})
    local name = GetPlayerName(player)
    if(money == nil) then money = 0 end
    if(bankMoney == nil) then bankMoney = 0 end
    local date = {
      ["user_id"] = user_id,
      ["name"] = player,
      ["walletMoney"] = walletMoney,
      ["bankMoney"] = bankMoney
    }
    return date
end
imprumut = {}
function fsBank.tryDepositCash(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	local name = GetPlayerName(source)
	local muielaastiadeabuzeaza = math.type (tonumber(amount))
	print(muielaastiadeabuzeaza)
	if muielaastiadeabuzeaza == 'integer' then
		if(tonumber(amount))then
			amount = tonumber(amount)
			if amount > 0 and amount < 10000 then
				exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", { ['@user_id'] = user_id}, function(theHours)
					imprumut[user_id] = tonumber(theHours[1].imprumut)
					print(imprumut[user_id])
					if imprumut[user_id] + amount < 10000 then
						vRP.setBankMoney({user_id, bankMoney+amount})
						exports.ghmattimysql:execute("UPDATE vrp_users SET imprumut = imprumut + @bank WHERE id = @user_id", { ['@user_id'] = user_id,['@wallet'] = walletMoney,['@bank'] = amount })
						vRPclient.notify(thePlayer, {"~g~Ai luat ~y~$"..amount.." ~g~imprumut de la banca ai grija ce faci cu ei!!"})
					else
						vRPclient.notify(thePlayer, {"~r~Ai deja un imprumut care depaseste maxima!\n in valoare de imprumut "..imprumut[user_id]})
					end
				end)
			else
				vRPclient.notify(thePlayer, {"~r~Nu ai cum sa iei un imprumut m-ai mare de 10.000 $"})
			end
		else
			vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
		end
	else
		vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
	end
end




function fsBank.checkBalance()
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local bankMoney = vRP.getBankMoney({user_id})
	exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", { ['@user_id'] = user_id}, function(theHours)
		imprumut[user_id] = tonumber(theHours[1].imprumut)
		TriggerClientEvent('currentbalance1', thePlayer, imprumut[user_id])
	end)
end

function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

  function round(n)
	return math.floor(n + 0.5)
  end
RegisterServerEvent('taxabaaaa')
AddEventHandler('taxabaaaa', function()
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	local name = GetPlayerName(source)
	exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", { ['@user_id'] = user_id}, function(theHours)
		imprumut[user_id] = tonumber(theHours[1].imprumut)
		if imprumut[user_id] > 100 then
			catsaia1 = imprumut[user_id] * 0.15999
			catsaia = math.floor(catsaia1 * 1) / 1
			vRP.setBankMoney({user_id, bankMoney-round(catsaia)})
			exports.ghmattimysql:execute("UPDATE vrp_users SET imprumut = imprumut - @bank WHERE id = @user_id", { ['@user_id'] = user_id,['@wallet'] = walletMoney,['@bank'] = catsaia })
			vRPclient.notify(thePlayer, {"~g~"..catsaia.."$ Au fost retrasi din contul tau, m-ai ai de platit inca "..imprumut[user_id].."$ pentru a plati tot!"})
		end
			
	end)
end)
function round(n)
	return math.floor(n + 0.5)
  end
function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end
