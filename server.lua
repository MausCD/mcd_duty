Citizen.CreateThread(function()
    Citizen.Wait(10000)
    if Config.CreateOffDutyJob then
        print(MCD.Function.ConvertPrint('[~b~Info~s~] ~g~Checking~s~ for ~r~not existing~s~ Off-Duty Jobs'))
        MySQL.Async.fetchAll('SELECT * FROM jobs ', {}, function(result)
            if #result > 0 then
                for k,v in ipairs(Config.Locations) do
                    v.exist = false
                end
                for i,p in ipairs(result) do
                    for k,v in ipairs(Config.Locations) do
                        if v.offduty == p.name then
                            v.exist = true
                        end
                        if v.onduty == p.name then
                            v.label = p.label
                            v.whitelisted = p.whitelisted
                        end
                    end
                end
            else
                print(MCD.Function.ConvertPrint("[~o~ERROR~s~] ~r~Couldn't Select Jobs From Database"))
            end
        end)
        Citizen.Wait(3000)
        local createt = 0
        for i,p in ipairs(Config.Locations) do
            if not p.exist then
                print(MCD.Function.ConvertPrint('[~b~Info~s~] ~g~Creating~s~ Off-Duty Job for ~p~' .. p.onduty))
                MySQL.Async.insert('INSERT INTO jobs (name , label , whitelisted) VALUES (@name , @label , @whitelisted)', {
                    ['@name'] = p.offduty,
                    ['@label'] = 'Off - ' ..p.label,
                    ['@whitelisted'] = p.whitelisted,
                }, function(result) end)

                Citizen.Wait(1000)

                MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job', {
                    ['@job'] = p.onduty,
                }, function(result)
                    if #result > 0 then
                        for k,v in ipairs(result) do
                            local salary = v.salary - 100
                            if salary < 0 then
                                salary = 0
                            end
                            MySQL.Async.insert('INSERT INTO job_grades (job_name , grade , name , label , salary) VALUES (@job_name , @grade , @name, @label, @salary)', {
                                ['@job_name'] = p.offduty,
                                ['@grade'] = v.grade,
                                ['@name'] = v.name,
                                ['@label'] = v.label,
                                ['@salary'] = salary,
                            }, function(result) end)
                            Citizen.Wait(1000)
                        end
                    else
                        print(MCD.Function.ConvertPrint("[~o~ERROR~s~] ~r~Couldn't Select "..p.onduty.." From Database"))
                    end
                end)
                Citizen.Wait(1000)
                createt = createt + 1
                print(MCD.Function.ConvertPrint('[~b~Info~s~] ~g~Finsihed~s~ Off-Duty Job for ~p~' .. p.onduty))
            end
        end      
        if createt > 0 then
            print(MCD.Function.ConvertPrint('[~b~Info~s~] ~g~Finished ~y~' .. createt .. '~s~ Jobs , ~o~please Restart the Server otherwise the Jobs are not direktly Ingame'))
        else
            print(MCD.Function.ConvertPrint('[~b~Info~s~] ~g~Finished ~y~' .. createt .. '~s~ Jobs'))
        end
    end
end)

MCD.AddUpdateChecker('mcd_duty' , GetCurrentResourceName())