
vehicleData = { }

    gridlist = {}
    window = {}
    button = {}
    label = {}


function resizeGUI(gui)
    local sx, sy = guiGetScreenSize()
    guiSetPosition( gui, sx*(3/4), sy*0.35, false)
end
        window[1] = guiCreateWindow(956, 266, 314, 363, "USC ~ Vehicles", false)
        guiWindowSetSizable(window[1], false)
        guiSetVisible(window[1], false)
        resizeGUI(window[1])
        label[1] = guiCreateLabel(6, 21, 298, 20, "Vehicles", false, window[1])
        guiSetFont(label[1], "default-bold-small")
        guiLabelSetColor(label[1], 255, 0, 0)
        guiLabelSetHorizontalAlign(label[1], "center", false)
        guiLabelSetVerticalAlign(label[1], "center")
        gridlist[1] = guiCreateGridList(9, 46, 295, 219, false, window[1])
        guiGridListAddColumn(gridlist[1], "Name", 0.3)
        guiGridListAddColumn(gridlist[1], "Health", 0.2)
        guiGridListAddColumn(gridlist[1], "Locked", 0.2)
        guiGridListAddColumn(gridlist[1], "Location", 0.4)
        button[1] = guiCreateButton(10, 271, 92, 33, "Spawn", false, window[1])
        button[2] = guiCreateButton(112, 271, 92, 33, "Mark", false, window[1])
        button[3] = guiCreateButton(212, 271, 92, 33, "Recover", false, window[1])
        button[4] = guiCreateButton(10, 314, 92, 33, "Sell", false, window[1])
        button[5] = guiCreateButton(112, 314, 92, 33, "Lock", false, window[1])
        button[6] = guiCreateButton(212, 314, 92, 33, "Close", false, window[1])
        
    for i=1, 6 do
        guiSetProperty(button[i], "NormalTextColour", "FFFF0000")
        guiSetFont(button[i], "default-bold-small")
    end
bindKey("F3", "down", 
    function()
        if guiGetVisible(window[1]) and isCursorShowing() then
            guiSetVisible(window[1], false)
            showCursor(false)
        else
            guiSetVisible(window[1], true)
            showCursor(true)
            triggerServerEvent( "refreshGridListInfo", getLocalPlayer() )
        end
    end
)
addEvent("updateVehicleInfo", true)

function refreshGridList()
    triggerServerEvent( "refreshGridListInfo", getLocalPlayer() )
end

function updateGridListData(vehTables)
    guiGridListClear(gridlist[1])
    if ( #vehTables == 0 ) then
        guiGridListSetItemText ( gridlist[1], guiGridListAddRow ( gridlist[1] ), 1, "You have no vehicles.", true, true )
    else
    if vehTables then
        for i, v in ipairs ( vehTables ) do
        local row = guiGridListAddRow(gridlist[1])
        guiGridListSetItemText(gridlist[1],row,1,(getVehicleNameFromModel((v["vehicleid"]))),false,false)
        guiGridListSetItemData ( gridlist[1], row, 1, v["id"] )
        guiGridListSetItemText(gridlist[1],row,2,math.floor(v["health"]/10).." %",false,false)
        if v["locked"] == 1 then locked = "Yes" else locked = "No" end
        guiGridListSetItemText(gridlist[1],row,3,locked,false,false)
        guiGridListSetItemText(gridlist[1],row,4,getZoneName(v["posX"], v["posY"], v["posZ"]),false,false)
        table.insert ( vehicleData, v["id"], v )
        end
    end
end
end
addEventHandler("updateVehicleInfo", root, updateGridListData)



addEventHandler("onClientGUIClick", root,
    function(b, s)
        if b == "left" and s == "up" then
             if source == button[6] then
                guiSetVisible(window[1], false)
                showCursor(false)
                --updateGridListData()
            elseif source == gridlist[1] then
                local row, col = guiGridListGetSelectedItem ( gridlist[1] )
                if ( row ~= -1 ) then
                    local index = (guiGridListGetItemData( gridlist[1], row, 1))
                    iprint(vehicleData[index]["id"])
                    local visible =   tonumber( vehicleData[index]["spawned"] )
                    if ( visible == 1 ) then visible = true else visible = false end
                    if ( visible) then
                        guiSetText (button[1], "Hide" )
                        vehicleData[index]["spawned"] = 1
                    else
                        guiSetText ( button[1], "Spawn" )
                        vehicleData[index]["spawned"] = 0
                    end
                    local lock =   tonumber( vehicleData[index]["locked"] )
                    if ( lock == 1 ) then lock = true else lock = false end
                    if ( lock ) then
                        guiSetText (button[5], "Unlock" )
                        vehicleData[index]["locked"] = 1
                    else
                        guiSetText ( button[5], "Lock" )
                        vehicleData[index]["locked"] = 0
                    end
                end
                --updateGridListData()
            elseif source == button[1] then
                local row, col = guiGridListGetSelectedItem ( gridlist[1] )
                if ( row ~= -1 ) then
                    local index = guiGridListGetItemData ( gridlist[1], row, 1 )
                    
                    local visible = tonumber ( vehicleData[index]["spawned"])

                    if ( visible == 1 ) then visible = true else visible = false end
                    iprint(visible)
                    triggerServerEvent ( "SetVehicleVisible", localPlayer, vehicleData[index]["id"], not visible )
                    refreshGridList()
                end
                --updateGridListData()
            elseif source == button[2] then
                local row, col = guiGridListGetSelectedItem ( gridlist[1] )
                if ( row ~= -1 ) then
                    local index = guiGridListGetItemData ( gridlist[1], row, 1 )
                    triggerServerEvent("onPlayerVehicleMark", localPlayer, vehicleData[index]["id"])
                    refreshGridList()
                end
            elseif source == button[3] then
                local row, col = guiGridListGetSelectedItem ( gridlist[1] )
                if ( row ~= -1 ) then
                    local index = guiGridListGetItemData ( gridlist[1], row, 1 )
                    triggerServerEvent("onPlayerVehicleRecover", localPlayer, vehicleData[index]["id"])
                    refreshGridList()
                end
            elseif source == button[5] then
                local row, col = guiGridListGetSelectedItem ( gridlist[1] )
                if ( row ~= -1 ) then
                    local index = guiGridListGetItemData ( gridlist[1], row, 1 )
                    triggerServerEvent("onPlayerLockVehicle", localPlayer, vehicleData[index]["id"])
                    refreshGridList()
                end

            end
        end
    end
    )

function getSelectedVehicles()
    local selected = guiGridListGetSelectedItems(gridlist[1])
    local rowSelected = {}
    local ids = {}

    for i=1,#selected do
        if not rowSelected[selected[i].row] then
            local id = guiGridListGetItemData(gridlist[1],selected[i].row,1)
            if id  then
                rowSelected[selected[i].row] = true
                table.insert(ids,id)
            end
        end
    end
    if #ids > 0 then
        return ids
    else
        return false
    end
end