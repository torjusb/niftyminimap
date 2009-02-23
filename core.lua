local f = CreateFrame("Frame", "niftyMinimap", Minimap)
local border = "Interface\\Addons\\niftyMinimap\\border"
local border_color = "1, 1, 1"

f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self) 
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
	
	--The text
	MinimapZoneText:ClearAllPoints()
	MinimapZoneText:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 5)
	MinimapZoneText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	MinimapZoneText:SetDrawLayer("OVERLAY")
	
	--Making it scroll!
	self:EnableMouseWheel(true)
	self:SetScript("OnMouseWheel", function(self, z)
		local level = Minimap:GetZoom()
		print(level, z)
		if level > 0 and z < 0 then
			Minimap:SetZoom(level - 1)
		elseif level < 5 and z > 0 then
			Minimap:SetZoom(level + 1)
		end
	end)
	
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
	
	--Set border texture
	self.text = self:CreateTexture(nil, OVERLAY)
	self.text:SetTexture(border) 
	self.text:SetTexCoord(0, 1/3, 0, 1/3) -- L, R, T, B 
	self.text:SetPoint("TOPLEFT", Minimap, -6, 6) 
	self.text:SetWidth(16)
	self.text:SetHeight(16) 
	self.text:SetVertexColor(1, 1, 1)
	 
	self.text = self:CreateTexture(nil, OVERLAY)
	self.text:SetTexture(border) 
	self.text:SetTexCoord(2/3, 1, 0, 1/3) 
	self.text:SetPoint("TOPRIGHT", Minimap, 6, 6) 
	self.text:SetWidth(16)
	self.text:SetHeight(16) 
	self.text:SetVertexColor(1, 1, 1)
	 
	self.text = self:CreateTexture(nil, OVERLAY)
	self.text:SetTexture(border) 
	self.text:SetTexCoord(0, 1/3, 2/3, 1) 
	self.text:SetPoint("BOTTOMLEFT", Minimap, -6, -6) 
	self.text:SetWidth(16) 
	self.text:SetHeight(16) 
	self.text:SetVertexColor(1, 1, 1)
	 
	self.text = self:CreateTexture(nil, OVERLAY)
	self.text:SetTexture(border) 
	self.text:SetTexCoord(2/3, 1, 2/3, 1) 
	self.text:SetPoint("BOTTOMRIGHT", Minimap, 6, -6) 
	self.text:SetWidth(16) 
	self.text:SetHeight(16) 
	self.text:SetVertexColor(1, 1, 1)
	
	for i = 1, 8 do 
	     self.text = Minimap:CreateTexture(nil, "OVERLAY") -- top edge 
	     self.text:SetTexture(border) 
	     self.text:SetTexCoord(1/3, 2/3, 0, 1/3) 
	     self.text:SetPoint("TOPLEFT", Minimap, 10 + (15 * (i - 1)), 6) 
	     self.text:SetWidth(15) 
		 self.text:SetHeight(16) 
	     self.text:SetVertexColor(1, 1, 1)
	 
	     self.text = Minimap:CreateTexture(nil, "OVERLAY") -- bottom edge 
	     self.text:SetTexture(border) 
	     self.text:SetTexCoord(1/3, 2/3, 2/3, 1) 
	     self.text:SetPoint("BOTTOMLEFT", Minimap, 10 + (15 * (i - 1)), -6) 
	     self.text:SetWidth(15) 
		 self.text:SetHeight(16) 
	     self.text:SetVertexColor(1, 1, 1)
	 
	     self.text = Minimap:CreateTexture(nil, "OVERLAY") -- left edge 
	     self.text:SetTexture(border) 
	     self.text:SetTexCoord(0, 1/3, 1/3, 2/3) 
	     self.text:SetPoint("TOPLEFT", Minimap, -6, -10 - (15 * (i - 1))) 
	     self.text:SetWidth(16)
		 self.text:SetHeight(15) 
	     self.text:SetVertexColor(1, 1, 1)
	 
	     self.text = Minimap:CreateTexture(nil, "OVERLAY") -- right edge 
	     self.text:SetTexture(border) 
	     self.text:SetTexCoord(2/3, 1, 1/3, 2/3) 
	     self.text:SetPoint("TOPRIGHT", Minimap, 6, -10 - (15 * (i - 1))) 
	     self.text:SetWidth(16) 
		 self.text:SetHeight(15) 
	     self.text:SetVertexColor(1, 1, 1)
	end 
	--end of border texture
	
	--Hiding the minimap frames
	local frames = {
		MinimapZoomIn,
		MinimapZoomOut,
		MinimapToggleButton,
		MinimapBorderTop,
		MiniMapWorldMapButton,
		MinimapBorder,
		GameTimeFrame,
	}
	for _, frame in ipairs(frames) do 
		frame:Hide()
	end
end)