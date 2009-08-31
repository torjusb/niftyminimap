local f = CreateFrame("Frame", "niftyMinimap", Minimap)

f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")


f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

local string

local function checkCalendarInvites ()
	local pendingInvites = CalendarGetNumPendingInvites()
	
	if pendingInvites > 0 then
		string:SetTextColor(1, .4, 1)
	else
		string:SetTextColor(1, 1, 1)
	end
end

function f:PLAYER_LOGIN ()
	self:UnregisterEvent("PLAYER_LOGIN")
	
	
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
	
    
	local Minimap = _G["Minimap"]	
	Minimap:SetMaskTexture("Interface\\AddOns\\niftyminimap\\mask")
	
	
	local tracker = _G["MiniMapTracking"]
	tracker:ClearAllPoints()
	tracker:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 5, -5)
	
	
	local cluster = _G["MinimapCluster"]
	cluster:ClearAllPoints()
	cluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, -5)
	
	
	local zone = _G["MinimapZoneText"]
	zone:ClearAllPoints()
	zone:SetPoint("BOTtom", Minimap, "BOTTOM", 0, 5)
	zone:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	zone:SetDrawLayer("OVERLAY")
	
	self:EnableMouseWheel(true)
	self:SetScript("OnMouseWheel", function (self, z)
		local level = Minimap:GetZoom()
		if level > 0 and z < 0 then
			Minimap:SetZoom(level -1)
		elseif level < 5 and z > 0 then
			Minimap:SetZoom(level + 1)
		end
	end)
	
	local frames = {
		MinimapZoomIn,
		MinimapZoomOut,
        MinimapToggleButton,
        MinimapBorderTop,
        MiniMapWorldMapButton,
        MinimapBorder,
        MiniMapTrackingButtonBorder,
        MiniMapTrackingBackground,
        MiniMapTrackingButtonShine,
        MiniMapTrackingIconOverlay,
        GameTimeCalendarInvitesTexture,
        GameTimeCalendarInvitesGlow        
    }
    for _, frame in pairs(frames) do frame:Hide() end
end

function f:PLAYER_ENTERING_WORLD ()

	date = _G["GameTimeFrame"]
	date:ClearAllPoints()
	date:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 5)
	date:SetFrameStrata("DIALOG")
	
	date:SetNormalTexture(nil)
	date:SetPushedTexture(nil)
	date:SetHighlightTexture(nil)
	date.flashInvites = false
	
	string = date:GetFontString()
	string:SetFont("Interface\\AddOns\\niftyminimap\\font.ttf", 16, "OUTLINE")
	string:SetShadowOffset(1, -1)

	checkCalendarInvites()	
end

function f:CALENDAR_UPDATE_PENDING_INVITES ()
	checkCalendarInvites()
end