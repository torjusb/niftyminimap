local f = CreateFrame("Frame", "niftyMinimap", Minimap)

f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
f:SetScript("OnEvent", function(self, event)
    local time = GameTimeFrame
    local pendingCalendarInvites = CalendarGetNumPendingInvites();
    if event == "PLAYER_LOGIN" then 
        f:UnregisterEvent("PLAYER_LOGIN")
        
        --Make it squara[] =]
        Minimap:SetMaskTexture("Interface\\AddOns\\rMinimap\\mask")
        
        --Damn tracker, so many frames and textures
        MiniMapTracking:ClearAllPoints()
        MiniMapTracking:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 5, -5)
        MiniMapTrackingButtonBorder:Hide()
        MiniMapTrackingBackground:Hide()
        MiniMapTrackingButtonShine:Hide()
        MiniMapTrackingIconOverlay:Hide()
        
        MinimapCluster:ClearAllPoints()
        MinimapCluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, -5)
        
        --The text
        MinimapZoneText:ClearAllPoints()
        MinimapZoneText:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 5)
        MinimapZoneText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        MinimapZoneText:SetDrawLayer("OVERLAY")
        
        --Making it scroll!
        self:EnableMouseWheel(true)
        self:SetScript("OnMouseWheel", function(self, z)
            local level = Minimap:GetZoom()
            if level > 0 and z < 0 then
                Minimap:SetZoom(level - 1)
            elseif level < 5 and z > 0 then
                Minimap:SetZoom(level + 1)
            end
        end)

        time.string = time:GetFontString()
        time.string:SetFont("Interface\\AddOns\\!LynSettings\\fonts\\font.ttf", 16, "OUTLINE")
        time.string:SetTextColor(1, 1, 1)
        time.string:SetShadowOffset(1, -1)

        time:SetNormalTexture(nil)
        time:SetPushedTexture(nil)
        time:SetHighlightTexture(nil)

        time:ClearAllPoints()
        time:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 5)
        time:SetFrameStrata("DIALOG")
        
        --The black coolish border
        self:ClearAllPoints()
        self:SetPoint("CENTER", Minimap, "CENTER")
        
        self:SetFrameStrata("BACKGROUND")
        self:SetFrameLevel(0)
        
        self:SetWidth(140)
        self:SetHeight(140)
        self:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            insets = { left = -2, top = -2, right = -2, bottom = -2},
        })
        self:SetBackdropColor(0,0,0,.5)
        
        --Hiding the minimap frames
        local frames = {
            MinimapZoomIn,
            MinimapZoomOut,
            MinimapToggleButton,
            MinimapBorderTop,
            MiniMapWorldMapButton,
            MinimapBorder,
        }
        for _, frame in ipairs(frames) do 
            frame:Hide()
        end
    end
     if pendingCalendarInvites > 0 then 
        time.string:SetTextColor(255, 100, 255)
    else 
        time.string:SetTextColor(1, 1, 1)
    end
    GameTimeCalendarInvitesTexture:Hide()
    GameTimeCalendarInvitesGlow:Hide()
    time.flashInvite = false;
    
    if event == "PLAYER_ENTERING_WORLD" then f:UnregisterEvent("PLAYER_ENTERING_WORLD") end
end)
