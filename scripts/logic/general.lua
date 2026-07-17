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

function victory()
    local goal = itemStage("goal")
    if (
        (goal == 0 and itemCount("completed") >= itemCount("required"))
        or
        ( goal == 1 and 
            itemCount("major-boards") >= itemCount("major-boards-req") and
            itemCount("major-cards") >= itemCount("major-cards-req") and
            itemCount("major-sports") >= itemCount("major-sports-req") and
            itemCount("major-variety") >= itemCount("major-variety-req")
        )
        or
        ( goal == 2 and
            itemCount("minor-wooden") >= itemCount("minor-wooden-req") and
            itemCount("minor-paper") >= itemCount("minor-paper-req") and
            itemCount("minor-jp") >= itemCount("minor-jp-req") and
            itemCount("minor-non-jp") >= itemCount("minor-non-jp-req") and
            itemCount("minor-sophisticated") >= itemCount("minor-sophisticated-req") and
            itemCount("minor-toy") >= itemCount("minor-toy-req") and
            itemCount("minor-variety") >= itemCount("minor-variety-req") and
            itemCount("minor-singleplayer") >= itemCount("minor-singleplayer-req")
        )
        or (goal == 3 and itemCount("trophy") >= itemCount("required"))
    ) then
        return hasAllCategories()
    else
        return false
    end
end