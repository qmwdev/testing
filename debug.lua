ver_type, ver = 'debug', '0.1'



local api = {
    flower_zones = game.Workspace.FlowerZones,
    flower_decos = game.Workspace.FieldDecos,
    collectibles = game.Workspace.Collectibles,


    notify = function(Title, Text, Icon, Duration)
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = Title, -- Required
            Text = Text, -- Required
            Icon = Icon or "rbxassetid://1234567890", -- Optional
            Duration = Duration or 5,
        })
    end




}

local fields = function(variable)
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            local field_name = v.Name
            local field_coords = v.Position
            print(field_name, ':', field_coords)
        end
    end
end

local collect_collectibles = function(variable)
    api.notify('Started','Started')
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            wait(3)
            game.Players.LocalPlayer.Character:MoveTo(v.Position)
        end
    end
    
end

--collect_collectibles(api.collectibles)
--fields(api.flower_zones)



return api
