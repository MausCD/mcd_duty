local marker = nil

Citizen.CreateThread(function()
    local sleep = 2500
    while true do Citizen.Wait(sleep) 
        local Job = MCD.GetPlayerData().job.name
        local ped = PlayerPedId()
        local plycoords = GetEntityCoords(ped)
        for i,p in ipairs(Config.Locations) do
            p.draw = nil
            local draw = nil
            if Job == p.onduty then
                draw = 'onduty'
            end
            if Job == p.offduty then
                draw = 'offduty'
            end

            if draw ~= 'not' then
                local dist = #(plycoords - p.coords)
                if dist <= Config.DrawDistance then
                    p.draw = draw
                end
            end
        end       
    end
end)


Citizen.CreateThread(function()
    local sleep = 500
    while true do Citizen.Wait(sleep)
        sleep = 500
        for i,p in ipairs(Config.Locations) do
            if p.draw then
                sleep = MCD.GetMarkerSpeed()
                local color = {}
                if p.draw == 'onduty' then
                    color = Config.Marker.onduty
                else
                    color = Config.Marker.offduty
                end
                MCD.DawMarker(Config.Marker.type , p.coords , Config.Marker.height , Config.Marker.width , color , Config.Marker.bobUpAndDown , Config.Marker.faceCamera)

                if marker == nil or marker == i then
                    local ped = PlayerPedId()
                    local plycoords = GetEntityCoords(ped)
                    local dist = #(plycoords - p.coords)
                    if dist <= Config.Marker.width/2 then
                        marker = i
                    else
                        if marker == i then
                            marker = nil
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local sleep = 500
    while true do Citizen.Wait(sleep)
        sleep = 500
        if marker then
            sleep = MCD.GetHelpTextSpeed()
            if Config.Locations[marker].draw ~= nil then
                MCD.DrawHelpText(_U('helptext_'..Config.Locations[marker].draw) )
            end
        end
    end
end)

Citizen.CreateThread(function()
    local sleep = 500
    while true do Citizen.Wait(sleep)
        sleep = 500
        if marker then
            sleep = MCD.GetControllSpeed()
            if IsControlJustReleased(0, 51) then
                ToggleDuty(marker)
                Citizen.Wait(2500)
            end
        end
    end
end)

function ToggleDuty(markerid)
    local Job = MCD.GetPlayerData().job
    if Config.Locations[markerid].draw == 'offduty' then
        MCD.SetJob(Config.Locations[markerid].onduty , Job.grade ,  GetCurrentResourceName())
        MCD.Notify(_U('notify_onduty') , nil , nil , 'success')
    else
        MCD.SetJob(Config.Locations[markerid].offduty , Job.grade ,  GetCurrentResourceName())
        MCD.Notify(_U('notify_offduty') , nil , nil , 'error')
    end
end