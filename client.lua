fcBank = {}
Tunnel.bindInterface("fantasy_banking", fcBank)
Proxy.addInterface("fantasy_banking", fcBank)
fsBank = Tunnel.getInterface("fantasy_banking", "fantasy_banking")
vRP = Proxy.getInterface("vRP")

local banca = false
local showBlips = true
local walletMoney = 0
local bankMoney = 0
local user_id = ""

local fontId

Citizen.CreateThread(
    function()
        RegisterFontFile("newsflash")
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)

            fsBank.getDate(
                {},
                function(date)
                    walletMoney = date["walletMoney"]
                    bankMoney = date["bankMoney"]
                    user_id = date["user_id"]
                end
            )
        end
    end
)
--     -113.43551635742,6470.060546875,31.626710891724
local banks = { 
    {name = "~h~Banca Nationala ~g~", id = 500, x = -113.43551635742, y = 6470.060546875, z = 31.626710891724}
}


Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            local ped = GetPlayerPed(-1)
            local playerPos = GetEntityCoords(ped, true)

            if (Vdist(playerPos.x, playerPos.y, playerPos.z, -113.43551635742,6470.060546875,31.626710891724) < 15.0) then
                if not banca then
                    DrawMarker(
                        29,
                        -113.43551635742,6470.060546875,31.626710891724 - 0.3,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1.0,
                        1.0,
                        1.0,
                        45,
                        207,
                        0,
                        200,
                        false,
                        true,
                        2,
                        true,
                        0,
                        0,
                        0
                    )
                    DrawMarker(
                        29,
                        148.20277404785,-1039.9718017578,29.377742767334 - 0.3,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1.0,
                        1.0,
                        1.0,
                        45,
                        207,
                        0,
                        200,
                        false,
                        true,
                        2,
                        true,
                        0,
                        0,
                        0
                    )
                end
            end

            if nearBank() then
                drawHudText(
                    0.5,
                    0.93,
                    0,
                    0,
                    0.5,
                    "~w~Apasa ~g~[E] ~w~pentru a iti accesa ~r~Imprumutul bancar",
                    255,
                    255,
                    255,
                    230,
                    1,
                    fontId,
                    1
                )

                if IsControlJustPressed(1, 38) then
                    banca = true
                    local ped = GetPlayerPed(-1)
                end
            end
        end
    end
)

local alphaInchide = 180
local retrageAlpha = 180
local retrageC = {128, 128, 128}
local transferC = {128, 128, 128}
local depositC = {128, 128, 128}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if (banca) then
                FreezeEntityPosition(GetPlayerPed(-1), true)
                ShowCursorThisFrame()
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 58, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
                DisableControlAction(0, 143, true)
                DisableControlAction(0, 1, true)
                DisableControlAction(0, 2, true)
                --- BACKGROUND drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)

                DrawRect(0.50, 0.45, 0.3, 0.4, 0, 0, 0, 180)
                --DrawRect(0.50, 0.2, 0.25, 0.10, 0, 0, 0, 180)
                --DrawSprite("banking","banking",0.50,0.2,0.15,0.10,0.0,255,255,255,255)
                DrawRect(0.50,0.3,0.25,0.04,128,128,128,220)
                local id = PlayerId()
                local playerName = GetPlayerName(id)
                drawHudText(0.50,0.33 - 0.015,0.0,0.0,1.33,"Salut ~b~" .. playerName .. "~s~ ce doresti sa faci?",255,255,255,255,1,fontId,1)
                drawHudText(0.50,0.30 - 0.015,0.0,0.0,1.33,"~w~Sold Cont: ~s~" .. bankMoney .. "$",0,255,0,255,1,7,1)
                DrawRect(0.50, 0.50, 0.22, 0.14, depositC[1], depositC[2], depositC[3], 180) -- imprumut BANI

                DrawRect(0.50, 0.70, 0.05, 0.03, 128, 128, 128, alphaInchide)
                drawHudText(0.50, 0.70 - 0.02, 0.0, 0.0, 1.33, "~r~Inchide", 0, 255, 0, 255, 1, fontId, 1)

                drawHudText(0.50, 0.50 - 0.02, 0.0, 0.0, 1.33, "~g~Imprumut bancar", 0, 255, 0, 255, 1, fontId, 1)

                if (banca) then
                    if isCursorInPosition(0.50, 0.70, 0.06, 0.03) then
                        SetCursorSprite(5)
                        alphaInchide = 150
                        if (IsDisabledControlJustPressed(0, 24)) then
                            banca = not banca
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                        end
                    
                    elseif isCursorInPosition(0.5, 0.50, 0.22, 0.14) then
                        SetCursorSprite(5)
                        depositC = {45, 207, 0}
                        showToolTip("~g~Ia un imprumut bancar.")
                        if (IsDisabledControlJustPressed(0, 24)) then
                            banca = false
                            Citizen.CreateThread(
                                function()
                                    while true do
                                        Citizen.Wait(0)
                                        DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP8", "", "", "", "", "", 70)
                                        while UpdateOnscreenKeyboard() == 0 do
                                            DisableAllControlActions(0)
                                            Wait(0)
                                        end
                                        if UpdateOnscreenKeyboard() == 1 then
                                            mesaj = true
                                            local amount = GetOnscreenKeyboardResult()
                                            if (mesaj) then
                                                banca = true
                                                fsBank.tryDepositCash({amount})
                                                while true do
                                                    Citizen.Wait(0)

                                                    if GetOnscreenKeyboardResult() then
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    else
                        alphaInchide = 180
                        retrageC = {128, 128, 128}
                        transferC = {128, 128, 128}
                        depositC = {128, 128, 128}

                        SetCursorSprite(1)
                    end
                end
            end
        end
    end
)

function isCursorInPosition(x, y, width, height)
    local sx, sy = GetActiveScreenResolution()
    local cx, cy = GetNuiCursorPosition()
    local cx, cy = (cx / sx), (cy / sy)

    local width = width / 2
    local height = height / 2

    if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
        return true
    else
        return false
    end
end

function showToolTip(text)
    local sx, sy = GetActiveScreenResolution()
    local cx, cy = GetNuiCursorPosition()
    local cx, cy = (cx / sx) + 0.008, (cy / sy) + 0.027

    SetTextScale(0.28, 0.28)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(0, 0, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    local stringLenght = string.len(text)

    local width = stringLenght * 0.0047
    --DrawRect(cx, cy + 0.015, width, 0.03, 0,0,0,100)
    DrawText(cx, cy + 0.003)
end

function DrawText3D(x, y, z, text, scl, font)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * scl
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function drawHudText(x, y, width, height, scale, text, r, g, b, a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(0.4, 0.4)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    if (outline) then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function nearBank()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)

    for _, search in pairs(banks) do
        local distance =
            GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc["x"], playerloc["y"], playerloc["z"], true)

        if distance <= 1 then
            return true
        end
    end
end
Citizen.CreateThread(function()
	while true do  -- il pun la 10 sec
		Wait(1800000) -- 30 min  timer sa plateasca bani inapoi 0.2 la %
		TriggerServerEvent("taxabaaaa")
	end
end)
 -- credite interfata machiamavlad