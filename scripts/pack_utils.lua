function checkBothTotals()
    local games = Tracker:FindObjectForCode('victory_games')
    local trophies = Tracker:FindObjectForCode('victory_trophies')
    if games and trophies then
        if not games.Active and not trophies.Active then
            Tracker:AddLayouts("layouts/total/off.json")
        else
            Tracker:AddLayouts("layouts/total/on.json")
        end
    end
end

function games_layout()
    local games = Tracker:FindObjectForCode('victory_games')
    if games then
        checkBothTotals()
        if games.Active then
            Tracker:AddLayouts("layouts/games/on.json")
        else
            Tracker:AddLayouts("layouts/games/off.json")
        end
    end
end

function trophies_layout()
    local trophies = Tracker:FindObjectForCode('victory_trophies')
    if trophies then
        checkBothTotals()
        if trophies.Active then
            Tracker:AddLayouts("layouts/trophies/on.json")
        else
            Tracker:AddLayouts("layouts/trophies/off.json")
        end
    end
end

function minors_layout()
    local minors = Tracker:FindObjectForCode('victory_minors')
    if minors then
        checkBothTotals()
        if minors.Active then
            Tracker:AddLayouts("layouts/minors/on.json")
        else
            Tracker:AddLayouts("layouts/minors/off.json")
        end
    end
end

function majors_layout()
    local majors = Tracker:FindObjectForCode('victory_majors')
    if majors then
        checkBothTotals()
        if majors.Active then
            Tracker:AddLayouts("layouts/majors/on.json")
        else
            Tracker:AddLayouts("layouts/majors/off.json")
        end
    end
end