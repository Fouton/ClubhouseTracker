function hasItem(item)
    return Tracker:ProviderCountForCode(item) > 0
end

function itemStage(item)
    return Tracker:FindObjectForCode(item).CurrentStage
end

function itemCount(item)
    return Tracker:ProviderCountForCode(item)
end

function hasAllCategories()
    if hasItem("major-boards-access") and hasItem("major-cards-access") and
        hasItem("major-sports-access") and hasItem("major-variety-access") and
        hasItem("minor-wooden-access") and hasItem("minor-paper-access") and
        hasItem("minor-jp-access") and hasItem("minor-non-jp-access") and
        hasItem("minor-sophisticated-access") and hasItem("minor-toy-access") and
        hasItem("minor-variety-access") and hasItem("minor-single-access") then
        return true
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function games_goal()
    local count = Tracker:FindObjectForCode("completed").AcquiredCount
    local target = Tracker:FindObjectForCode("games-req").AcquiredCount
    local victory = Tracker:FindObjectForCode("victory_games").Active
    if count >= target and victory then
        return 1
    else
        return 0
    end
end

function majors_goal()
    local boards = Tracker:FindObjectForCode("major-boards").AcquiredCount
    local boards_req = Tracker:FindObjectForCode("major-boards-req").AcquiredCount
    local cards = Tracker:FindObjectForCode("major-cards").AcquiredCount
    local cards_req = Tracker:FindObjectForCode("major-cards-req").AcquiredCount
    local sports = Tracker:FindObjectForCode("major-sports").AcquiredCount
    local sports_req = Tracker:FindObjectForCode("major-sports-req").AcquiredCount
    local variety = Tracker:FindObjectForCode("major-variety").AcquiredCount
    local variety_req = Tracker:FindObjectForCode("major-variety-req").AcquiredCount
    local victory = Tracker:FindObjectForCode("victory_majors").Active
    if boards >= boards_req and cards >= cards_req and sports >= sports_req and variety >= variety_req and victory then
        return 1
    else
        return 0
    end
end

function minors_goal()
    local wooden = Tracker:FindObjectForCode("minor-wooden").AcquiredCount
    local wooden_req = Tracker:FindObjectForCode("minor-wooden-req").AcquiredCount
    local paper = Tracker:FindObjectForCode("minor-paper").AcquiredCount
    local paper_req = Tracker:FindObjectForCode("minor-paper-req").AcquiredCount
    local jp = Tracker:FindObjectForCode("minor-jp").AcquiredCount
    local jp_req = Tracker:FindObjectForCode("minor-jp-req").AcquiredCount
    local nonjp = Tracker:FindObjectForCode("minor-non-jp").AcquiredCount
    local nonjp_req = Tracker:FindObjectForCode("minor-non-jp-req").AcquiredCount
    local sophisticated = Tracker:FindObjectForCode("minor-sophisticated").AcquiredCount
    local sophisticated_req = Tracker:FindObjectForCode("minor-sophisticated-req").AcquiredCount
    local toy = Tracker:FindObjectForCode("minor-toy").AcquiredCount
    local toy_req = Tracker:FindObjectForCode("minor-toy-req").AcquiredCount
    local variety = Tracker:FindObjectForCode("minor-variety").AcquiredCount
    local variety_req = Tracker:FindObjectForCode("minor-variety-req").AcquiredCount
    local single = Tracker:FindObjectForCode("minor-single").AcquiredCount
    local single_req = Tracker:FindObjectForCode("minor-single-req").AcquiredCount
    local victory = Tracker:FindObjectForCode("victory_minors").Active
    if wooden >= wooden_req and paper >= paper_req and 
        jp >= jp_req and nonjp >= nonjp_req and 
        sophisticated >= sophisticated_req and toy >= toy_req and 
        variety >= variety_req and single >= single_req and
        victory then
        return 1
    else
        return 0
    end
end

function trophies_goal()
    local count = Tracker:FindObjectForCode("trophy").AcquiredCount
    local target = Tracker:FindObjectForCode("trophies-req").AcquiredCount
    local victory = Tracker:FindObjectForCode("victory_trophies").Active
    if count >= target and victory then
        return 1
    else
        return 0
    end
end

function victory()
    local victories = games_goal() + majors_goal() + minors_goal() + trophies_goal()
    local needed = Tracker:FindObjectForCode("victories_needed").AcquiredCount
    if victories >= needed then
        return hasAllCategories()
    else
        return false
    end
end