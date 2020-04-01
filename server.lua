RegisterServerEvent('check:corona')
AddEventHandler('check:corona', function()
  local source = source
  local corona = false
  local coronaSymptome = false
  local immuniser = false
  MySQL.Async.fetchAll(
    'SELECT * FROM coronavirus WHERE identifier = @id',
    {
      ['@id'] = getPlayerID(source)
    },
    function (result)
        for _, v in ipairs(result) do
		    -- print(v.havecorona)
		    if v.havecorona == 1 then
			    corona = false
			    coronaSymptome = true
				immuniser = false
			elseif v.havecorona == 2 then
			    corona = false
			    coronaSymptome = false
				immuniser = true
			else
			    corona = true
			    coronaSymptome = false
				immuniser = false
			end
        end
        if coronaSymptome then
            TriggerClientEvent("verif:coronaSymptome", source)
		elseif corona then
		    TriggerClientEvent("verif:corona", source)
		elseif immuniser then
		    TriggerClientEvent("stop:corona", source)
	    end
    end)
end)

RegisterServerEvent('contamine:closestPlayer')
AddEventHandler('contamine:closestPlayer', function(target)
  local source = source
  local corona = false
  local coronaSymptome = false
  local immuniser = false
  local randomSymptome = math.random(0, 1)
    if tonumber(target) ~= 0 then
        MySQL.Async.fetchAll(
        'SELECT * FROM coronavirus WHERE identifier = @id',
        {
          ['@id'] = getPlayerID(target)
        },
        function (result)
            for _, v in ipairs(result) do
		        if v.havecorona == 1 then
		    	    coronaSymptome = true
		    	    corona = false
		    	elseif v.havecorona == 2 then
		    	    coronaSymptome = false
		    	    corona = false
		    		immuniser = true
		    	else
		    	    corona = true
		    	    coronaSymptome = false
		    		immuniser = false
		    	end
            end
            if coronaSymptome then
                TriggerClientEvent("verif:coronaSymptome", target)
		    elseif corona then
		        TriggerClientEvent("verif:corona", target)
		    elseif immuniser then
		        TriggerClientEvent("stop:corona", target)
		    else
		        MySQL.Async.execute('INSERT INTO coronavirus (identifier,havecorona) VALUES (@id,@havecorona)',
		    	{
		    	    ['@id'] = getPlayerID(target),
		    	    ['@havecorona'] = randomSymptome,
		    	})
		    	if randomSymptome == 1 then
		    	    TriggerClientEvent("verif:coronaSymptome", target)
		    	else
		    	    TriggerClientEvent("verif:corona", target)
		    	end
	        end
        end)
	end
end)

RegisterServerEvent('antivirus:corona')
AddEventHandler('antivirus:corona', function(t)
    MySQL.Async.execute("UPDATE `coronavirus` SET havecorona = '2' WHERE `identifier` = @id",{
	['@id'] = getPlayerID(t)
	})
	TriggerClientEvent("es_freeroam:notify", t, "CHAR_CALL911", 1, "Coronavirus", false, "~g~Você não está mais infectado!")
	TriggerClientEvent("stop:corona", t)
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end
