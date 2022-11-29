Config = {}

Config.Locale = 'en'
Config.DrawDistance = 10

Config.Key = 'E'

Config.CreateOffDutyJob = true -- If the offduty Job not exist it copys the onduty job

Config.Marker = {
    type = 21,
    offduty = {r = 200, g = 0 , b = 0, a = 200},
    onduty = {r = 0, g = 200 , b = 0, a = 200},
    height = 0.5,
    width = 0.5,
    bobUpAndDown = false,
    faceCamera = false,
}

Config.Locations = {
    {coords = vector3(-546.64 , -111.91 , 37.86-0.2) , onduty = 'police' , offduty = 'offpolice'},
    {coords = vector3(-1851.5 , -334.8 , 49.45-0.2) , onduty = 'ambulance' , offduty = 'offambulance'},
}