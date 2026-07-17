-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/sectionID.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
FIRSTS = { "First Win", "First Clear", "First Completion" }
MAJOR_BOARDS_IDS = { 1, 6, 11, 17, 22, 25, 30, 35, 40, 45, 50, 53, 58, 60, 65, 70, 75, 80, 93 }
MAJOR_CARDS_IDS = { 85, 102, 107, 112, 115, 120, 125, 130, 135, 140, 143 }
MAJOR_SPORTS_IDS = { 146, 155, 159, 172, 181, 186, 191, 196, 201, 206 }
MAJOR_VARIETY_IDS = { 176, 211, 216, 221, 226, 230, 235, 243, 252, 262, 265 }
MINOR_WOODEN_IDS = { 1, 11, 25, 35, 40, 53, 60, 70 }
MINOR_PAPER_IDS = { 6, 17, 22, 30, 50, 58, 65  }
MINOR_JP_IDS = { 45, 75, 80, 85, 93, 140, 143 }
MINOR_NON_JP_IDS = { 102, 107, 112, 115, 120, 125, 130, 135 }
MINOR_SOPHISTICATED_IDS = { 146, 155, 159, 172, 206 }
MINOR_TOY_IDS = { 181, 186, 191, 196, 201 }
MINOR_VARIETY_IDS = { 176, 211, 216, 221, 226, 230, 235 }
MINOR_SINGLE_IDS = { 243, 252, 262, 265 }
COUNTERS = { "completed",  "trophy",
    "major-boards", "major-cards", "major-sports", "major-variety", 
    "minor-wooden", "minor-paper", "minor-jp", "minor-non-jp",
    "minor-sophisticated", "minor-toy", "minor-variety", "minor-single"}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1

    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    local autotrack_beaten = Tracker:FindObjectForCode('autotrack-beaten')
    if autotrack_beaten.Active then
        for _, counter in ipairs(COUNTERS) do
            local obj = Tracker:FindObjectForCode(counter)
            obj.AcquiredCount = 0
        end
    end
    -- slot data
    if slot_data['amazing_cpus'] then
        local obj = Tracker:FindObjectForCode('amazing')
        if obj then
            obj.Active = slot_data['amazing_cpus']
        end
    end

    if slot_data['impossible_cpus'] then
        local obj = Tracker:FindObjectForCode('impossible')
        if obj then
            obj.Active = slot_data['impossible_cpus']
        end
    end
    
    if slot_data['games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('required')
        if obj then
            obj.AcquiredCount = slot_data['games_required_for_victory']
        end
    end
    
    if slot_data['additional_checks'] then
        local obj = Tracker:FindObjectForCode('extras')
        if obj then
            obj.Active = slot_data['additional_checks']
        end
    end
    
    if slot_data['victory_condition'] then
        local obj = Tracker:FindObjectForCode('goal')
        if obj then
            obj.CurrentStage = slot_data['victory_condition']
        end
    end

    if slot_data['board_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('major-boards-req')
        if obj then
            obj.AcquiredCount = slot_data['board_games_required_for_victory']
        end
    end
    if slot_data['card_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('major-cards-req')
        if obj then
            obj.AcquiredCount = slot_data['card_games_required_for_victory']
        end
    end
    if slot_data['sports_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('major-sports-req')
        if obj then
            obj.AcquiredCount = slot_data['sports_games_required_for_victory']
        end
    end
    if slot_data['variety_and_single_player_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('major-variety-req')
        if obj then
            obj.AcquiredCount = slot_data['variety_and_single_player_games_required_for_victory']
        end
    end

    if slot_data['wooden_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-wooden-req')
        if obj then
            obj.AcquiredCount = slot_data['wooden_games_required_for_victory']
        end
    end
    if slot_data['paper_plastic_board_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-paper-req')
        if obj then
            obj.AcquiredCount = slot_data['paper_plastic_board_games_required_for_victory']
        end
    end
    if slot_data['japanese_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-jp-req')
        if obj then
            obj.AcquiredCount = slot_data['japanese_games_required_for_victory']
        end
    end
    if slot_data['non_japanese_card_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-non-jp-req')
        if obj then
            obj.AcquiredCount = slot_data['non_japanese_card_games_required_for_victory']
        end
    end
    if slot_data['sophisticated_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-sophisticated-req')
        if obj then
            obj.AcquiredCount = slot_data['sophisticated_games_required_for_victory']
        end
    end
    if slot_data['toy_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-toy-req')
        if obj then
            obj.AcquiredCount = slot_data['toy_games_required_for_victory']
        end
    end
    if slot_data['variety_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-variety-req')
        if obj then
            obj.AcquiredCount = slot_data['variety_games_required_for_victory']
        end
    end
    if slot_data['single_player_games_required_for_victory'] then
        local obj = Tracker:FindObjectForCode('minor-single-req')
        if obj then
            obj.AcquiredCount = slot_data['single_player_games_required_for_victory']
        end
    end

    -- print(dump_table(slot_data))

    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    -- manually run snes interface functions after onClear in case we are already ingame
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here
    end
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
end

-- called when a location gets cleared
function onLocation(location_id, location_name)
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array or not location_array[1] then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
        return
    end

    for _, location in pairs(location_array) do
        local obj = Tracker:FindObjectForCode(location)
        if obj then
            if location:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        else
            print(string.format("onLocation: could not find object for code %s", location))
        end
    end
end

function incrementByListAndID(code, location_id, id_base, id_cap, list)
    local obj = Tracker:FindObjectForCode(code)
    if obj and location_id >= id_base and location_id <= id_cap then
        print(code .. ": successfully located")
        for _, id in ipairs(list) do
            if location_id == id then
                obj.AcquiredCount = obj.AcquiredCount + 1
                print("incremented")
            end
        end
    end
end

-- called when a locations is scouted
function onScout(location_id, location_name, item_id, item_name, item_player)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name,
            item_player))
    end
    -- not implemented yet :(
end

-- called when a bounce message is received 
function onBounce(json)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onBounce: %s", dump_table(json)))
    end
    -- your code goes here
end

ScriptHost:AddOnLocationSectionChangedHandler("manual", function(section)
    local sectionID = section.FullID
    if sectionID == "Victory/Victory/Click to Complete Goal" and section.AvailableChestCount == 0 then
        local res = Archipelago:StatusUpdate(Archipelago.ClientStatus.GOAL)
        if res then
            print("Sent Victory")
        else
            print("Error sending Victory")
        end
    elseif sectionID == "Release/Release/Click Here To !release Game" and section.AvailableChestCount == 0 then
        for _, apID in pairs(sectionIDToAPID) do
            if apID ~= nil then
                local res = Archipelago:LocationChecks({apID})
                if res then
                    print("Sent " .. tostring(apID) .. " for " .. tostring(sectionID))
                else
                    print("Error sending " .. tostring(apID) .. " for " .. tostring(sectionID))
                end
            else
                print(tostring(sectionID) .. " is not an AP location")
            end
        end
    elseif (section.AvailableChestCount == 0) then
        -- AP location cleared
        local sectionID = section.FullID
        local apID = sectionIDToAPID[sectionID]

        -- for automating counter increases via autotracking
        local auto = Tracker:FindObjectForCode('autotrack-beaten')
        if auto.Active then
            local completed = Tracker:FindObjectForCode('completed')
            if completed and apID <= 268 then
                for _, win in ipairs(FIRSTS) do
                    if sectionID:find(win) then
                        completed.AcquiredCount = completed.AcquiredCount + 1
                    end
                end
            end
            incrementByListAndID('major-boards', apID, 1, 93, MAJOR_BOARDS_IDS)
            incrementByListAndID('major-cards', apID, 85, 143, MAJOR_CARDS_IDS)
            incrementByListAndID('major-sports', apID, 146, 206, MAJOR_SPORTS_IDS)
            incrementByListAndID('major-variety', apID, 176, 265, MAJOR_VARIETY_IDS)

            incrementByListAndID('minor-wooden', apID, 1, 70, MINOR_WOODEN_IDS)
            incrementByListAndID('minor-paper', apID, 6, 65, MINOR_PAPER_IDS)
            incrementByListAndID('minor-jp', apID, 45, 143, MINOR_JP_IDS)
            incrementByListAndID('minor-non-jp', apID, 102, 135, MINOR_NON_JP_IDS)
            incrementByListAndID('minor-sophisticated', apID, 146, 206, MINOR_SOPHISTICATED_IDS)
            incrementByListAndID('minor-toy', apID, 181, 201, MINOR_TOY_IDS)
            incrementByListAndID('minor-variety', apID, 176, 235, MINOR_VARIETY_IDS)
            incrementByListAndID('minor-single', apID, 243, 265, MINOR_SINGLE_IDS)
        end

        if apID ~= nil then
            local res = Archipelago:LocationChecks({apID})
            if res then
                print("Sent " .. tostring(apID) .. " for " .. tostring(sectionID))
            else
                print("Error sending " .. tostring(apID) .. " for " .. tostring(sectionID))
            end
        else
            print(tostring(sectionID) .. " is not an AP location")
        end
    end
end)

-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
-- Archipelago:AddScoutHandler("scout handler", onScout)
-- Archipelago:AddBouncedHandler("bounce handler", onBounce)
