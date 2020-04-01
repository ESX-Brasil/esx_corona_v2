local patientAtteint = false
local randomSymptome = math.random(30000, 60000)
local coronaSymptome = false
local corona = false

RegisterNetEvent('verif:coronaSymptome')
AddEventHandler('verif:coronaSymptome', function()
    coronaSymptome = true
    corona = false
end)

RegisterNetEvent('verif:corona')
AddEventHandler('verif:corona', function()
    corona = true
    coronaSymptome = false
end)

RegisterNetEvent('stop:corona')
AddEventHandler('stop:corona', function()
    corona = false
    coronaSymptome = false
end)

Citizen.CreateThread(function()
Citizen.Wait(1000)
 TriggerServerEvent('check:corona')
    while true do
	Citizen.Wait(randomSymptome)
	    if coronaSymptome then
		    local hashSkin = GetHashKey("mp_m_freemode_01")
	    	if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
	    	    local playerPed = GetPlayerPed(-1)
	    		if math.random() > 0.5 then
	    		   RequestAnimDict("oddjobs@taxi@tie")
                   while not HasAnimDictLoaded("oddjobs@taxi@tie") do
                   Citizen.Wait(100)
                   end
                   TaskPlayAnim(GetPlayerPed(-1), "oddjobs@taxi@tie", "vomit_outside", 8.0, 8.0, -1, 50, 0, false, false, false)
	    	    else
	    		    RequestAnimDict("timetable@gardener@smoking_joint")
                    while not HasAnimDictLoaded("timetable@gardener@smoking_joint") do
                    Citizen.Wait(100)
                    end
	                
                    TaskPlayAnim(GetPlayerPed(-1), "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
	    		    TriggerEvent('InteractSound_CL:PlayOnOne', 'toux', 1.0)
	    	    end
	    		local closestPlayer = GetClosestPlayer(2)
	    		if closestPlayer ~= nil then
	    		    if GetPlayerServerId(closestPlayer) ~= nil or GetPlayerServerId(closestPlayer) ~= 0 then
	    		        TriggerServerEvent('contamine:closestPlayer', GetPlayerServerId(closestPlayer))
	    		    end
	    		end
                Citizen.Wait(7000)
	            SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) -1)
	    	    ClearPedTasks(GetPlayerPed(-1))
	    		SetPedHeadOverlay(playerPed, 5,	26, (3 / 10) + 0.0)	
                SetPedHeadOverlayColor(playerPed, 5, 2,	0)	
                SetPedHeadOverlay(playerPed, 7,	10,	(10 / 10) + 0.0)
	    	else
	    		if math.random() > 0.5 then
	    		   RequestAnimDict("oddjobs@taxi@tie")
                   while not HasAnimDictLoaded("oddjobs@taxi@tie") do
                   Citizen.Wait(100)
                   end
                   TaskPlayAnim(GetPlayerPed(-1), "oddjobs@taxi@tie", "vomit_outside", 8.0, 8.0, -1, 50, 0, false, false, false)
	    	    else
	    		    TriggerEvent('InteractSound_CL:PlayOnOne', 'touxfemme', 1.0)
	    		    RequestAnimDict("timetable@gardener@smoking_joint")
                    while not HasAnimDictLoaded("timetable@gardener@smoking_joint") do
                    Citizen.Wait(100)
                    end
	                TaskPlayAnim(GetPlayerPed(-1), "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
	    	    end
	    		local closestPlayer = GetClosestPlayer(2)
	    		if closestPlayer ~= nil then
	    		    if GetPlayerServerId(closestPlayer) ~= nil or GetPlayerServerId(closestPlayer) ~= 0 then
	    		        TriggerServerEvent('contamine:closestPlayer', GetPlayerServerId(closestPlayer))
	    		    end
	    		end
                    Citizen.Wait(7000)
	                SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) -1)
	    	        ClearPedTasks(GetPlayerPed(-1))
	    		    SetPedHeadOverlay(playerPed, 5,	26, (3 / 10) + 0.0)	
                    SetPedHeadOverlayColor(playerPed, 5, 2,	0)	
                    SetPedHeadOverlay(playerPed, 7,	10,	(10 / 10) + 0.0)
	    	    end
	    elseif corona then
	        local closestPlayer = GetClosestPlayer(2)
	        if closestPlayer ~= nil then
	            if GetPlayerServerId(closestPlayer) ~= nil or GetPlayerServerId(closestPlayer) ~= 0 then
	                TriggerServerEvent('contamine:closestPlayer', GetPlayerServerId(closestPlayer))
	            end
	        end
	    end
	end
end)

function GetPlayers()
    local players = {}
	for _, player in ipairs(GetActivePlayers()) do
	    table.insert(players, player)
	end
    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end