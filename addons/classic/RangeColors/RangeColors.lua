-- Rewritten from scratch with a little bit of help :) from AnduinLothar's ActionButtonColors

RangeColors = {};

RangeColors.isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE);


RangeColors.DefaultRangeColor = { r = 1.0, g = 0.2, b = 0.2 };
RangeColors.DefaultManaColor = { r = 0.2, g = 0.2, b = 1.0 };
RangeColors.DefaultBothColor = { r = 1.0, g = 1.0, b = 0.2 };

local old_QuestObjectiveItem_AcquireButton;


function RangeColors.ActionButtonOnUpdate(self, elapsed)
	if (not self.rangeTimer) then
		return;
	end
	
	local name = self:GetName();
	
	if (not RangeColors[name]) then
		RangeColors[name] = {};
	end
	
	if (not RangeColors[name].timer) then
		RangeColors[name].timer = -1;
	end

	local rangeTimer = RangeColors[name].timer;
	rangeTimer = rangeTimer - elapsed;

	if ( rangeTimer <= 0 ) then
		local valid = IsActionInRange(self.action);
		local outofrange = (valid ~= nil) and not IsActionInRange(self.action);
		--local hotkey = _G[self:GetName().."HotKey"];
		
		--if (hotkey:GetText() == RANGE_INDICATOR and hotkey:IsShown()) then
		--	hotkey:Hide();
		--end
		
		if (RangeColors[name].outOfRange ~= outofrange) then
			RangeColors[name].outOfRange = outofrange;

			ActionButton_UpdateUsable(self);
		end

		rangeTimer = TOOLTIP_UPDATE_TIME;
	end
	
	RangeColors[name].timer = rangeTimer;
end


function RangeColors.ActionButtonUpdateUsable(self)
	local name = self:GetName();
	local icon = _G[name.."Icon"];
	local normalTexture = _G[name.."NormalTexture"];
	if ( not normalTexture ) then
		return;
	end
	
	if (not RangeColors[name]) then
		return;
	end
	
	local outofrange = RangeColors[name].outOfRange;
	local isUsable, notEnoughMana = IsUsableAction(self.action);
	
	if (RangeColors_SavedVars.Both == "Y" and notEnoughMana and outofrange) then
		local color = RangeColors_SavedVars.BothColor;
		icon:SetVertexColor(color.r, color.g, color.b);
		normalTexture:SetVertexColor(color.r, color.g, color.b);
	elseif (notEnoughMana) then
		local color = RangeColors_SavedVars.ManaColor;
		icon:SetVertexColor(color.r, color.g, color.b);
		normalTexture:SetVertexColor(color.r, color.g, color.b);
	elseif (isUsable and outofrange) then
		local color = RangeColors_SavedVars.RangeColor;
		icon:SetVertexColor(color.r, color.g, color.b);
		normalTexture:SetVertexColor(color.r, color.g, color.b);
	elseif (isUsable) then
		icon:SetVertexColor(1.0, 1.0, 1.0);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	end
end


function RangeColors.WatchFrameItemOnUpdate(self, elapsed)
	if (not self.rangeTimer) then
		return;
	end
	
	if (not RangeColors[self]) then
		RangeColors[self] = {};
	end
	
	if (not RangeColors[self].timer) then
		RangeColors[self].timer = -1;
	end

	local rangeTimer = RangeColors[self].timer;
	rangeTimer = rangeTimer - elapsed;

	if ( rangeTimer <= 0 ) then
		local link, item, charges, showItemWhenComplete = GetQuestLogSpecialItemInfo(self:GetID());
		if ( not charges or charges ~= self.charges ) then
			return;
		end
		local icon = self.icon;
		local normalTexture = self.NormalTexture;
		if ( not normalTexture ) then
			return;
		end
		
		if (not RangeColors[self]) then
			return;
		end
		
		local valid = IsQuestLogSpecialItemInRange(self:GetID());
		
		if ( valid == 0 ) then
			local color = RangeColors_SavedVars.RangeColor;
			icon:SetVertexColor(color.r, color.g, color.b);
			normalTexture:SetVertexColor(color.r, color.g, color.b);
		elseif ( valid == 1 ) then
			icon:SetVertexColor(1.0, 1.0, 1.0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		end

		rangeTimer = TOOLTIP_UPDATE_TIME;
	end
	
	RangeColors[self].timer = rangeTimer;
end


function RangeColors.QuestObjectiveItem_AcquireButton(parent)
	local button = old_QuestObjectiveItem_AcquireButton(parent);
	
	button:HookScript("OnUpdate", RangeColors.WatchFrameItemOnUpdate);
	
	return button;
end


-- Hook for checking button range
hooksecurefunc("ActionButton_OnUpdate", RangeColors.ActionButtonOnUpdate);
--ActionButton_OnUpdate = RangeColors.ActionButtonOnUpdate;

-- Hook for setting button color
hooksecurefunc("ActionButton_UpdateUsable", RangeColors.ActionButtonUpdateUsable);
--ActionButton_UpdateUsable = RangeColors.ActionButtonUpdateUsable;

-- Hook for setting quest watch button range
if (RangeColors.isRetail) then
	-- Capture button creation in order to add handler
	old_QuestObjectiveItem_AcquireButton = QuestObjectiveItem_AcquireButton;
	QuestObjectiveItem_AcquireButton = RangeColors.QuestObjectiveItem_AcquireButton;
	--hooksecurefunc("WatchFrameItem_OnUpdate", RangeColors.WatchFrameItemOnUpdate);
end
