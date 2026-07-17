function swapgoal()
    local obj = Tracker:FindObjectForCode('goal')
    if obj then
        if obj.CurrentStage == 3 then
            Tracker:AddLayouts("layouts/trophies/tracker.json")
        elseif obj.CurrentStage == 2 then
            Tracker:AddLayouts("layouts/minors/tracker.json")
        elseif obj.CurrentStage == 1 then
            Tracker:AddLayouts("layouts/majors/tracker.json")
        else
            Tracker:AddLayouts("layouts/tracker.json")
        end
    end
end