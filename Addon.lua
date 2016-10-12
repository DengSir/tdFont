--[[
Addon.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]


do
    NumberFont_GameNormal:SetFont([[Fonts\ARHei.TTF]], 13, 'OUTLINE')

    NumberFont_Outline_Med:SetFont([[Fonts\ARKai_T.TTF]], 13, 'OUTLINE')
    NumberFont_Outline_Large:SetFont([[Fonts\ARKai_T.TTF]], 14, 'OUTLINE')
    NumberFont_OutlineThick_Mono_Small:SetFont([[Fonts\ARKai_T.TTF]], 12, 'OUTLINE')

    SystemFont_Shadow_Med1:SetFont([[Fonts\ARKai_T.TTF]], 15)
    SystemFont_Shadow_Small:SetFont([[Fonts\ARKai_T.TTF]], 13)
    SystemFont_Shadow_Large:SetFont([[Fonts\ARKai_T.TTF]], 17)


    TextStatusBarText:SetFont([[Fonts\ARHei.TTF]], 11, 'OUTLINE')
end

do
    local hfont, hsize = GameTooltipTextLeft1:GetFont()
    -- GameTooltipHeaderText:SetFont(hfont, hsize, 'OUTLINE')

    local function OnTooltipSetItem(self)
        local name = self:GetName()
        _G[name .. 'TextLeft2']:SetFontObject(_G[name .. 'TextLeft1']:GetText() == CURRENTLY_EQUIPPED and 'GameTooltipHeaderText' or 'GameTooltipText')
    end

    local function SetTooltip(tooltip)
        local backdrop = tooltip.BackdropFrame or tooltip
        if backdrop:GetBackdrop() then
            backdrop:SetBackdrop{
                bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
                edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
                tileSize = 16,
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 },
            }
            backdrop:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
        end

        _G[tooltip:GetName()..'TextLeft1']:SetFontObject('GameTooltipHeaderText')
        _G[tooltip:GetName()..'TextRight1']:SetFontObject('GameTooltipHeaderText')

        if tooltip.shoppingTooltips then
            for i, shopping in pairs(tooltip.shoppingTooltips) do
                SetTooltip(shopping)
                shopping:HookScript('OnTooltipSetItem', OnTooltipSetItem)

                _G[shopping:GetName()..'TextLeft2']:SetFontObject('GameTooltipHeaderText')
                _G[shopping:GetName()..'TextRight2']:SetFontObject('GameTooltipHeaderText')

                local i = 3
                while _G[shopping:GetName()..'TextLeft'..i] do
                    _G[shopping:GetName()..'TextLeft'..i]:SetFontObject('GameTooltipText')
                    _G[shopping:GetName()..'TextRight'..i]:SetFontObject('GameTooltipText')
                    i = i + 1
                end
            end
        end
    end

    for _, tooltip in ipairs({GameTooltip, ItemRefTooltip, WorldMapTooltip}) do
        SetTooltip(tooltip)
    end
end
