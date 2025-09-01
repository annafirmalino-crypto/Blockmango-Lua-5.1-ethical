--[[
next zentex panel & Gui?? 
]]











UIGMControlPanel = require("engine_client.ui.layout.GUIGMControlPanel")

function UIGMControlPanel:show()
if not self.newGUI then
    self.newGUI = GUIManager:createGUIWindow(GUIType.Button, "NewGUIButton")
    self.newGUI:SetWidth({0, 65})
    self.newGUI:SetHeight({0, 65})
    self.newGUI:SetXPosition({0, 680})
    self.newGUI:SetYPosition({0, 0})
    self.newGUI:SetBackgroundColor({0, 0, 0, 0.6})
    self.newGUI:SetNormalImage("set:new_gui_material.json image:chat_send_nor")
    self.newGUI:SetPushedImage("set:new_gui_material.json image:chat_send_nor")
    self.newGUI:SetLevel(100)
    self.newGUI:SetTouchable(true)

    self.edInput = self:getChildWindow("GMControlPanel-Input-Edit", GUIType.Edit)
    self.edInput:AddChildWindow(self.newGUI)

    self.newGUI:registerEvent(GUIEvent.ButtonClick, function()
        self:inputText()
    end)
    
    self.CloseButton = GUIManager:createGUIWindow(GUIType.Button, "CancelButtonInput")
    self.CloseButton:SetWidth({0, 65})
    self.CloseButton:SetHeight({0, 65})
    self.CloseButton:SetXPosition({0, 740})
    self.CloseButton:SetYPosition({0, 0})
    self.CloseButton:SetBackgroundColor({0, 0, 0, 0.6})
    self.CloseButton:SetNormalImage("set:tip_dialog.json image:btn_close")
    self.CloseButton:SetPushedImage("set:tip_dialog.json image:btn_close")
    self.CloseButton:SetLevel(100)
    self.CloseButton:SetTouchable(true)

    self.edInput = self:getChildWindow("GMControlPanel-Input-Edit", GUIType.Edit)
    self.edInput:AddChildWindow(self.CloseButton)

    self.CloseButton:registerEvent(GUIEvent.ButtonClick, function()
        self:closeInput()
    end)    
    
end
Toast("Panel : Open")
self.super.show(self)
UIHelper.showOpenAnim(self)
end 

function showCloseAnim(layout, callback)
    local root = layout.root
    local count = root:GetChildCount()
    if count == 0 then
        if callback then callback() end
        return
    end

    local animationsRemaining = count

    local function checkCompletion()
        animationsRemaining = animationsRemaining - 1
        if animationsRemaining <= 0 then
            if callback then callback() end
        end
    end

    for index = 1, count do
        local content = root:GetChildByIndex(index - 1)
        if content then
            local scale = 1.5  
            content:SetScale(VectorUtil.newVector3(scale, scale, scale))

            layout:addTimer(LuaTimer:scheduleTicker(function()
                scale = scale - 0.3  
                
                if scale <= 0 then
                    scale = 0
                    content:SetScale(VectorUtil.newVector3(scale, scale, scale))
                    checkCompletion()
                else
                    content:SetScale(VectorUtil.newVector3(scale, scale, scale))
                end
            end, 1, 50))
        end
    end
end

function UIGMControlPanel:hide()
    showCloseAnim(self, function()
        self.super.hide(self)
    end)
    Toast("Panel : Closed")
end


local Test
local ToastTimer

function Toast(content,  hideBG)
    if Test == nil then
        Test = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-hshah")
        Test:SetHorizontalAlignment(HorizontalAlignment.Center)
        Test:SetVerticalAlignment(VerticalAlignment.Bottom)
        Test:SetTextHorzAlign(HorizontalAlignment.Center)
        Test:SetTextVertAlign(VerticalAlignment.Center)
        Test:SetHeight({ 0, 45 })
        Test:SetYPosition({ 0, -120 })
        Test:SetBackgroundColor(Color.CYAN) 
        Test:SetLevel(1)
        Test:SetTouchable(false)
        Test:SetBordered(true)
        GUISystem.Instance():GetRootWindow():AddChildWindow(Test)
    end
    Test:SetVisible(true)
    Test:SetText(content)
    
    if hideBG then
        Test:SetBackgroundColor({ 0, 0, 0, 0 })
    else
        Test:SetBackgroundColor(Color.CYAN)
        Test:SetWidth({ 0, Test:GetTextWidth() + 25 })
    end
    LuaTimer:cancel(ToastTimer)
          local scale = 0.5
Test:SetScale(VectorUtil.newVector3(scale, scale, scale))
    
    local timer = LuaTimer:scheduleTicker(function()
        if scale <= 1 then
            scale = scale + 0.1
        else
            scale = scale - 0.025
        end
Test:SetScale(VectorUtil.newVector3(scale, scale, scale))
    end, 1, 10)
    ToastTimer = LuaTimer:schedule(function()
        Test:SetVisible(false)
local scale = 1.5
Test:SetScale(VectorUtil.newVector3(scale, scale, scale))
local timer = LuaTimer:scheduleTicker(function()
        if scale >= 1 then
            scale = scale - 0.3
        end
Test:SetScale(VectorUtil.newVector3(scale, scale, scale))
    end, 1, 10)
    end, 2000)
end

--- ===v( <<< FUNCTION BY ZENTEX  >>>)v===

local loadSpeedValue = 5
local loadingCount = 0

function LoadSpeed(v)
    loadSpeedValue = v or 5
end

function Loading(textAfter)
    loadingCount = loadingCount + 1
    local id = tostring(loadingCount)
    local y_pos = 115
    local centerX = 560
    local progressBarWidth = 400

    local GUI = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-xuy60-" .. id)
    GUI:SetHorizontalAlignment(HorizontalAlignment.Center)
    GUI:SetTextHorzAlign(HorizontalAlignment.Center)
    GUI:SetVisible(false)
    GUI:SetBordered(true)
    GUI:SetText("Finishing Task")
    GUI:SetWidth({ 0, 800 })
    GUI:SetHeight({ 0, 30 })
    GUI:SetYPosition({ 0, y_pos + 50 })
    GUI:SetAlpha(0)
    GUISystem.Instance():GetRootWindow():AddChildWindow(GUI)

    local shadowGUI = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-xuy60-shadow-" .. id)
    shadowGUI:SetHorizontalAlignment(HorizontalAlignment.Center)
    shadowGUI:SetTextHorzAlign(HorizontalAlignment.Center)
    shadowGUI:SetVisible(true)
    shadowGUI:SetText("Finishing Taak")
    shadowGUI:SetWidth({ 0, 800 })
    shadowGUI:SetHeight({ 0, 30 })
    shadowGUI:SetYPosition({ 0, y_pos + 52 })
    shadowGUI:SetAlpha(0.3)
    shadowGUI:SetTextColor({ 0, 0, 0, 0.5 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(shadowGUI)

    local progressBarBack = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-progressBack-" .. id)
    progressBarBack:SetHorizontalAlignment(HorizontalAlignment.Left)
    progressBarBack:SetTextHorzAlign(HorizontalAlignment.Left)
    progressBarBack:SetVisible(true)
    progressBarBack:SetText("")
    progressBarBack:SetWidth({ 0, progressBarWidth })
    progressBarBack:SetHeight({ 0, 20 })
    progressBarBack:SetYPosition({ 0, y_pos + 90 })
    progressBarBack:SetXPosition({ 0, centerX })
    progressBarBack:SetBackgroundColor({ 0.3, 0.3, 0.3, 0.7 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(progressBarBack)

    local progressBarFront = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-progressFront-" .. id)
    progressBarFront:SetHorizontalAlignment(HorizontalAlignment.Left)
    progressBarFront:SetTextHorzAlign(HorizontalAlignment.Left)
    progressBarFront:SetVisible(true)
    progressBarFront:SetText("")
    progressBarFront:SetWidth({ 0, 0 })
    progressBarFront:SetHeight({ 0, 20 })
    progressBarFront:SetYPosition({ 0, y_pos + 90 })
    progressBarFront:SetXPosition({ 0, centerX })
    progressBarFront:SetBackgroundColor({ 1, 0, 0, 0.9 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(progressBarFront)

    local progressPercent = 0
    local rainbowHue = 0
    local alpha = 0
    local pulseTime = 0
    GUI:SetVisible(true)

    LuaTimer:scheduleTimer(function()
        alpha = alpha + 0.05
        if alpha > 1 then alpha = 1 end
        GUI:SetAlpha(alpha)
        shadowGUI:SetAlpha(alpha * 0.3)
        progressBarBack:SetAlpha(alpha)
        progressBarFront:SetAlpha(alpha)
    end, 30, 20)

    LuaTimer:scheduleTicker(function()
        rainbowHue = (rainbowHue + 0.01) % 1.0
        local r = math.sin(rainbowHue * math.pi * 2) * 0.5 + 0.5
        local g = math.sin((rainbowHue + 0.33) * math.pi * 2) * 0.5 + 0.5
        local b = math.sin((rainbowHue + 0.66) * math.pi * 2) * 0.5 + 0.5
        GUI:SetTextColor({ r, g, b, 1.0 })
        shadowGUI:SetTextColor({ 0, 0, 0, 0.5 })
        GUI:SetBorderColor({ r, g, b, 1.0 })
    end, 50, -1)

    LuaTimer:scheduleTicker(function()
        pulseTime = pulseTime + 0.05
        local pulse = 1.0 + 0.05 * math.sin(pulseTime * 3)
        GUI:SetScale(pulse, pulse, 1.0)
        shadowGUI:SetScale(pulse, pulse, 1.0)
    end, 30, -1)

    LuaTimer:scheduleTicker(function()
        if progressPercent < 100 then
            progressPercent = progressPercent + loadSpeedValue
            if progressPercent > 100 then progressPercent = 100 end
            local width = math.floor(progressBarWidth * (progressPercent / 100))
            progressBarFront:SetWidth({ 0, width })
        end
    end, 100, -1)

    LuaTimer:scheduleTimer(function()
        local fadeOutAlpha = 1
        LuaTimer:scheduleTimer(function()
            fadeOutAlpha = fadeOutAlpha - 0.05
            GUI:SetAlpha(fadeOutAlpha)
            shadowGUI:SetAlpha(fadeOutAlpha * 0.3)
            progressBarBack:SetAlpha(fadeOutAlpha)
            progressBarFront:SetAlpha(fadeOutAlpha)
            if fadeOutAlpha <= 0 then
                GUI:SetText(textAfter)
                shadowGUI:SetText(textAfter)
                GUI:SetYPosition({ 0, y_pos + 30 })
                shadowGUI:SetYPosition({ 0, y_pos + 32 })
                GUI:SetAlpha(1)
                shadowGUI:SetAlpha(0.3)
                GUI:SetVisible(true)
                shadowGUI:SetVisible(true)
                progressBarBack:SetVisible(false)
                progressBarFront:SetVisible(false)

                LuaTimer:scheduleTimer(function()
                    local msgAlpha = 1
                    LuaTimer:scheduleTimer(function()
                        msgAlpha = msgAlpha - 0.05
                        GUI:SetAlpha(msgAlpha)
                        shadowGUI:SetAlpha(msgAlpha * 0.3)
                        if msgAlpha <= 0 then
                            GUI:SetVisible(false)
                            shadowGUI:SetVisible(false)
                        end
                    end, 30, 20)
                end, 6000, 1)
            end
        end, 20, 20)
    end, 8000, 1)
end








function Game:init()
    self.CGame = CGame.Instance()
    self.GameType = self.CGame:getGameType()
    self.EnableIndie = self.CGame:isEnableIndie(true)
    self.Blockman = Blockman.Instance()
    self.World = self.Blockman:getWorld()
    self.LowerDevice = self.CGame:isLowerDevice()
    EngineWorld:setWorld(self.World)
    ClientHelper.putBoolPrefs("IsShowItemDurability", true)
    ClientHelper.putBoolPrefs("setSwordBreakBlock", true)
    ClientHelper.putBoolPrefs("IsCreatureBloodBar", true)
    ClientHelper.putBoolPrefs("IsCreatureCollision", false)
    ClientHelper.putIntPrefs("HurtProtectTime", 20)
    ClientHelper.putBoolPrefs("IsShowCrafting", true)
    ClientHelper.putBoolPrefs("BlockCustomMeta", true)
    ClientHelper.putBoolPrefs("IsCanSprint", true)
    GUIManager:getWindowByName("PlayerInfo-Health"):SetVisible(true)
    ClientHelper.putBoolPrefs("DisStepSound", true)
    CGame.Instance():SetMaxFps(math.huge)
    ClientHelper.putIntPrefs("InTheAirCntLimit", math.huge)
    ClientHelper.putIntPrefs("InTheAirTimeLimit", math.huge)
    MsgSender.sendBottomTips("(^_^)")





--- === (ZENTEX, CYBER) ===



--- === ( ANTI--PANEL--MODIFIER ) ===

local ModsList = {
    "GUIRoot-Ping",        
    "CpsCounterCyberPro", 
    "GUIRoot-Pose",        
    "GUIRoot-Fps"           
}

LuaTimer:scheduleTimer(function()
    for _, mod in ipairs(ModsList) do
        local gui = GUIManager:getWindowByName(mod)
        if not gui then
            Toast("Detected : Panel modified!")
            LuaTimer:scheduleTimer(function()
                CGame.Instance():exitGame("normal")
            end, 2000, 1)
            return
        end
    end
    UIHelper.showCenterToast("Game Loaded..")
    UIHelper.showCenterToast("[!] No Changes")
end, 2000, 1)  



--- === ( USED FOR REMOVING BGFX SHIT ) ===

local guiSystem = GUISystem.Instance()
local rootWindow = guiSystem:GetRootWindow()

local namesToDelete = {
    "BGFX-Credits-XXX",
    "BGFX-Ping-XXX"
}

for index = 1, #namesToDelete do
    local win = GUIManager:getWindowByName(namesToDelete[index])
    if win then
        rootWindow:RemoveChildWindow1(win)
    end
end



local hue = 0

local function interpolateColor(hue)
    local r, g, b, a = 0, 0, 0, 0
    if hue < 60 then
        r, g, b, a = 1, hue / 60, 0, 1 - (hue / 60)
    elseif hue < 120 then
        r, g, b, a = (120 - hue) / 60, 1, 0, (hue - 60) / 60
    elseif hue < 180 then
        r, g, b, a = 0, 1, (hue - 120) / 60, 1 - ((hue - 120) / 60)
    elseif hue < 240 then
        r, g, b, a = 0, (240 - hue) / 60, 1, (hue - 180) / 60
    elseif hue < 300 then
        r, g, b, a = (hue - 240) / 60, 0, 1, 1 - ((hue - 240) / 60)
    else
        r, g, b, a = 1, 0, (360 - hue) / 60, (hue - 300) / 60
    end
    return r, g, b, a
end

function Credits()
    local GUI = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Ping")
    GUI:SetVisible(true)

    local function Update()
        local YE = "Divine Prima「private」"

        GUI:SetText(YE)
        GUI:SetTextScale(1.4)
        GUI:SetTextBoader({ r, g, b, 0.6 })
        GUI:SetProperty("Font", "HT14")

        hue = (hue + 0.5) % 360
        local r, g, b, a = interpolateColor(hue)
        GUI:SetTextColor({ r, g, b, 0.6 })
    end

    GUI:SetWidth({ 0, 200 })
    GUI:SetHeight({ 0, 20 })
    GUI:SetXPosition({ 0, 640 })
    GUI:SetBordered(true)
    GUI:SetYPosition({ 0, 105 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(GUI)

    LuaTimer:scheduleTimer(Update, 100, -1)
end
Credits() 
    



local clicks = 0
local cps = 0
local hue = 0

local function interpolateColor(hue)
    local r, g, b, a = 0, 0, 0, 0
    if hue < 60 then
        r, g, b, a = 1, hue / 60, 0, 1 - (hue / 60)
    elseif hue < 120 then
        r, g, b, a = (120 - hue) / 60, 1, 0, (hue - 60) / 60
    elseif hue < 180 then
        r, g, b, a = 0, 1, (hue - 120) / 60, 1 - ((hue - 120) / 60)
    elseif hue < 240 then
        r, g, b, a = 0, (240 - hue) / 60, 1, (hue - 180) / 60
    elseif hue < 300 then
        r, g, b, a = (hue - 240) / 60, 0, 1, 1 - ((hue - 240) / 60)
    else
        r, g, b, a = 1, 0, (360 - hue) / 60, (hue - 300) / 60
    end
    return r, g, b, a
end

local function CPSCounter()
    local CPSDisplay = GUIManager:createGUIWindow(GUIType.StaticText, "CpsCounterCyberPro")
    CPSDisplay:SetVisible(true)

    local function cpser()
        cps = clicks
        clicks = 0
        CPSDisplay:SetText("Cps: " .. cps)
    end

    local function Updates()
        hue = (hue + 0.5) % 360
        local r, g, b, a = interpolateColor(hue)
        CPSDisplay:SetTextColor({ r, g, b, 0.6 })
    end

    CPSDisplay:SetWidth({ 0, 20 })
    CPSDisplay:SetHeight({ 0, 20 })
    CPSDisplay:SetXPosition({ 0, 15 })
    CPSDisplay:SetTextScale(1.1)
    CPSDisplay:SetBordered(true)
    CPSDisplay:SetProperty("Font", "HT14")    
    CPSDisplay:SetYPosition({ 0, 580 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(CPSDisplay)
    LuaTimer:scheduleTimer(Updates, 100, -1)
    LuaTimer:scheduleTimer(cpser, 900, -1)
end
CPSCounter()

CEvents.PlayerClickScreenEvent:registerCallBack(function()
    clicks = clicks + 1
end)

local hue = 0

local function interpolateColor(hue)
    local r, g, b, a = 0, 0, 0, 0
    if hue < 60 then
        r, g, b, a = 1, hue / 60, 0, 1 - (hue / 60)
    elseif hue < 120 then
        r, g, b, a = (120 - hue) / 60, 1, 0, (hue - 60) / 60
    elseif hue < 180 then
        r, g, b, a = 0, 1, (hue - 120) / 60, 1 - ((hue - 120) / 60)
    elseif hue < 240 then
        r, g, b, a = 0, (240 - hue) / 60, 1, (hue - 180) / 60
    elseif hue < 300 then
        r, g, b, a = (hue - 240) / 60, 0, 1, 1 - ((hue - 240) / 60)
    else
        r, g, b, a = 1, 0, (360 - hue) / 60, (hue - 300) / 60
    end
    return r, g, b, a
end

function Pose()
    local POS = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Pose")
    POS:SetVisible(true)

    local function Updaten()
        local me = PlayerManager:getClientPlayer()
        local myPos = me.Player:getPosition()
        local DC = string.format("XYZ:%.2f/%.2f/%.2f", myPos.x, myPos.y, myPos.z)

        POS:SetText(DC)

        hue = (hue + 0.5) % 360
        local r, g, b, a = interpolateColor(hue)
        POS:SetTextColor({r,g,b,0.6})
    end
    
    POS:SetWidth({0,20})
    POS:SetHeight({0,20})
    POS:SetXPosition({0,15})
    POS:SetBordered(true)
    POS:SetTextScale(1.1)
    POS:SetProperty("Font", "HT14")
    POS:SetYPosition({0,620})
    GUISystem.Instance():GetRootWindow():AddChildWindow(POS)

    LuaTimer:scheduleTimer(Updaten, 100, -1)
end
Pose()


local hue = 0

local function interpolateColor(hue)
    local r, g, b, a = 0, 0, 0, 0
    if hue < 60 then
        r, g, b, a = 1, hue / 60, 0, 1 - (hue / 60)
    elseif hue < 120 then
        r, g, b, a = (120 - hue) / 60, 1, 0, (hue - 60) / 60
    elseif hue < 180 then
        r, g, b, a = 0, 1, (hue - 120) / 60, 1 - ((hue - 120) / 60)
    elseif hue < 240 then
        r, g, b, a = 0, (240 - hue) / 60, 1, (hue - 180) / 60
    elseif hue < 300 then
        r, g, b, a = (hue - 240) / 60, 0, 1, 1 - ((hue - 240) / 60)
    else
        r, g, b, a = 1, 0, (360 - hue) / 60, (hue - 300) / 60
    end
    return r, g, b, a
end

function Fps()
    local DATS = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Fps")
    DATS:SetVisible(true)

    local function Updates()
    local fps = Root.Instance():getFPS()
    local ping = ClientNetwork.Instance():getRaknetPing()
        local YUE = "Fps: " .. fps .. "   Ping:ᯤ" .. ping

        DATS:SetText(YUE)

        hue = (hue + 0.5) % 360
        local r, g, b, a = interpolateColor(hue)
        DATS:SetTextColor({ r, g, b, 0.6 })
    end

    DATS:SetWidth({ 0, 20 })
    DATS:SetHeight({ 0, 20 })
    DATS:SetXPosition({ 0, 15 })
    DATS:SetTextScale(1.1)
    DATS:SetBordered(true)
    DATS:SetProperty("Font", "HT14")
    DATS:SetYPosition({ 0, 660 })
    GUISystem.Instance():GetRootWindow():AddChildWindow(DATS)
    LuaTimer:scheduleTimer(Updates, 100, -1)
end
Fps()




function GMHelper:noway()
     MsgSender.sendMsg("------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")       
     MsgSender.sendMsg("&$[ffca00ff-fbd33fff-cad2ceff-23b8feff-677dffff-ac61ffff-fd15ffff]$「 Divine Prima / Prime Galactica 」$&")
     MsgSender.sendMsg("&$[ffca00ff-fbd33fff-cad2ceff-23b8feff-677dffff-ac61ffff-fd15ffff]$    -( CyberBG / NoobGpt )-$&")    
     MsgSender.sendMsg("&$[677dffff-ac61ffff-fd15ffff]$ <( Helper )>$& :&$[23b8feff-677dffff-ac61ffff-fd15ffff]$  KhdBG, Jiangxi, Zentex$&")     
     MsgSender.sendMsg("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")    
end
GMHelper:noway()








local sigmaUp = GUIManager:getWindowByName("Main-Up")
local sigmaDown = GUIManager:getWindowByName("Main-Down")

local timerUp
local timerDown

local function movePlayerUp()
    local pos = PlayerManager:getClientPlayer():getPosition()
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(pos.x, pos.y + 1.4, pos.z))
end

local function movePlayerDown()
    local pos = PlayerManager:getClientPlayer():getPosition()
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(pos.x, pos.y - 1.4, pos.z))
end

sigmaUp:registerEvent(GUIEvent.TouchDown, function()
    if not timerUp then
        timerUp = LuaTimer:scheduleTimer(movePlayerUp, 0.1, -1) 
    end
end)

sigmaUp:registerEvent(GUIEvent.TouchUp, function()
    if timerUp then
        LuaTimer:cancel(timerUp)  
        timerUp = nil
    end
end)

sigmaDown:registerEvent(GUIEvent.TouchDown, function()
    if not timerDown then
        timerDown = LuaTimer:scheduleTimer(movePlayerDown, 0.1, -1)
    end
end)

sigmaDown:registerEvent(GUIEvent.TouchUp, function()
    if timerDown then
        LuaTimer:cancel(timerDown) 
        timerDown = nil
    end
end)


local hue = 0

local function interpolateColor(hue)
    local r, g, b, a = 0, 0, 0, 0
    if hue < 60 then
        r, g, b, a = 1, hue / 60, 0, 1 - (hue / 60)
    elseif hue < 120 then
        r, g, b, a = (120 - hue) / 60, 1, 0, (hue - 60) / 60
    elseif hue < 180 then
        r, g, b, a = 0, 1, (hue - 120) / 60, 1 - ((hue - 120) / 60)
    elseif hue < 240 then
        r, g, b, a = 0, (240 - hue) / 60, 1, (hue - 180) / 60
    elseif hue < 300 then
        r, g, b, a = (hue - 240) / 60, 0, 1, 1 - ((hue - 240) / 60)
    else
        r, g, b, a = 1, 0, (360 - hue) / 60, (hue - 300) / 60
    end
    return r, g, b, a
end

local UIGMTab = require "engine_client.ui.window.GUIGMTab"

local currentSelectedTab = nil

function UIGMTab:onLoad()
    self.tvTab = self:getChildWindowByName("GMButton", GUIType.StaticText)
    self.tvTab:SetBordered(true)
    
    local function xd()
        hue = (hue + 0.5) % 360
        local r, g, b, a = interpolateColor(hue)
        self.tvTab:SetTextColor({r, g, b, 0.6})
    end

    LuaTimer:scheduleTimer(xd, 100, -1)
    
    self.tvTab:SetBackgroundColor({0, 0, 0, 0.6})

    self.tvTab:registerEvent(GUIEvent.Click, function()
        if currentSelectedTab and currentSelectedTab ~= self then
            currentSelectedTab:resetTabColor()
        end

        currentSelectedTab = self

        self.tvTab:SetBackgroundColor({0, 1, 1, 0.6})

        GUIGMControlPanel:selectTab(self.name)
    end)
end

function UIGMTab:resetTabColor()
    self.tvTab:SetBackgroundColor({0, 0, 0, 0.6})
end

function UIGMTab:onTabChange(newTab)
    if newTab ~= self.name then
        self:resetTabColor()
    end
end











flyButtonn = GUIManager:createGUIWindow(GUIType.Button, "GUIRoot-flyButtonn")
flyButtonn:SetHorizontalAlignment(HorizontalAlignment.Center)
flyButtonn:SetVerticalAlignment(VerticalAlignment.Center)
flyButtonn:SetHeight({0, 60})
flyButtonn:SetWidth({0, 60})
flyButtonn:SetLevel(1)
flyButtonn:SetTouchable(true)
GUISystem.Instance():GetRootWindow():AddChildWindow(flyButtonn)

flyButtonn:SetBackgroundColor({0, 0, 0, 0.6})
flyButtonn:SetVisible(false)
flyButtonn:SetXPosition({0.45, 0})
flyButtonn:SetYPosition({0.1, 0})
flyButtonn:SetNormalImage("set:fly_control.json image:luodi")
flyButtonn:SetPushedImage("set:fly_control.json image:luodi")

flyButtonn:registerEvent(GUIEvent.ButtonClick, function()
    local player = PlayerManager:getClientPlayer().Player
    nigas = not nigas
    
    if nigas then
        player:setAllowFlying(true)
        player:setFlying(true)
        player:setSpeedAdditionLevel(10000)
        local moveDir = VectorUtil.newVector3(0.0, 1.35, 0.0)
        player:moveEntity(moveDir)
    else
        player:setFlying(false)
        player:setAllowFlying(false)
        player:setSpeedAdditionLevel(0)
    end
end)





    btnAutoClickg2 = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
    btnAutoClickg2:SetHorizontalAlignment(HorizontalAlignment.Center)
    btnAutoClickg2:SetVerticalAlignment(VerticalAlignment.Bottom)
    btnAutoClickg2:SetHeight({ 0, 60 })
    btnAutoClickg2:SetWidth({ 0, 140 })
    btnAutoClickg2:SetYPosition({ 0, -360 })
    btnAutoClickg2:SetXPosition({ 0, -670 })
    btnAutoClickg2:SetLevel(1)
    btnAutoClickg2:SetTextColor({ 0.6, 0, 0, 1 })
    btnAutoClickg2:registerEvent(GUIEvent.ButtonClick, function()
    btnAutoClickfunction()
    end)
    GUISystem.Instance():GetRootWindow():AddChildWindow(btnAutoClickg2)
    btnAutoClickg2:SetBackgroundColor({ 0, 0, 0, 0.6 })
    btnAutoClickg2:SetVisible(false)
    btnAutoClickg2:SetText("AutoClick")
    
    
    btnFarAimBotg2 = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
    btnFarAimBotg2:SetHorizontalAlignment(HorizontalAlignment.Center)
    btnFarAimBotg2:SetVerticalAlignment(VerticalAlignment.Bottom)
    btnFarAimBotg2:SetHeight({ 0, 60 })
    btnFarAimBotg2:SetWidth({ 0, 145 })
    btnFarAimBotg2:SetYPosition({ 0, -296 })
    btnFarAimBotg2:SetXPosition({ 0, -670 })
    btnFarAimBotg2:SetLevel(1)
    btnFarAimBotg2:SetTextColor({ 0.6, 0, 0, 1 })
    btnFarAimBotg2:registerEvent(GUIEvent.ButtonClick, function()
    btnFarAimBotfunction()
    end)
    GUISystem.Instance():GetRootWindow():AddChildWindow(btnFarAimBotg2)
    btnFarAimBotg2:SetBackgroundColor({ 0, 0, 0, 0.6 })
    btnFarAimBotg2:SetVisible(false)
    btnFarAimBotg2:SetText("FarAimBot")



    btnJetpackg2 = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
    btnJetpackg2:SetHorizontalAlignment(HorizontalAlignment.Center)
    btnJetpackg2:SetVerticalAlignment(VerticalAlignment.Bottom)
    btnJetpackg2:SetHeight({ 0, 60 })
    btnJetpackg2:SetWidth({ 0, 140 })
    btnJetpackg2:SetYPosition({ 0, -560 })
    btnJetpackg2:SetXPosition({ 0, -670 })
    btnJetpackg2:SetLevel(1)
    btnJetpackg2:SetTextColor({ 0.6, 0, 0, 1 })
    btnJetpackg2:registerEvent(GUIEvent.ButtonClick, function()
    btnJetpackfunction()
    end)
    GUISystem.Instance():GetRootWindow():AddChildWindow(btnJetpackg2)
    btnJetpackg2:SetBackgroundColor({ 0, 0, 0, 0.6 })
    btnJetpackg2:SetVisible(false)
    btnJetpackg2:SetText("JetPack")



    btnTPKill = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
    btnTPKill:SetHorizontalAlignment(HorizontalAlignment.Center)
    btnTPKill:SetVerticalAlignment(VerticalAlignment.Bottom)
    btnTPKill:SetHeight({ 0, 60 })
    btnTPKill:SetWidth({ 0, 140 })
    btnTPKill:SetYPosition({ 0, -560 })
    btnTPKill:SetXPosition({ 0, -525 })
    btnTPKill:SetLevel(1)
    btnTPKill:SetTextColor({ 0.6, 0, 0, 1 })
    btnTPKill:registerEvent(GUIEvent.ButtonClick, function()
        btnTPKillFunction()
    end)
    GUISystem.Instance():GetRootWindow():AddChildWindow(btnTPKill)
    btnTPKill:SetBackgroundColor({ 0, 0, 0, 0.6 })
    btnTPKill:SetVisible(false)
    btnTPKill:SetText("TP Kill")



    btnEmote = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
    btnEmote:SetHorizontalAlignment(HorizontalAlignment.Center)
    btnEmote:SetVerticalAlignment(VerticalAlignment.Bottom)
    btnEmote:SetHeight({ 0, 60 })
    btnEmote:SetWidth({ 0, 140 })
    btnEmote:SetYPosition({ 0, -496})
    btnEmote:SetXPosition({ 0, -670 })
    btnEmote:SetLevel(1)
    btnEmote:SetTextColor({ 0.6, 0, 0, 1 })
    btnEmote:registerEvent(GUIEvent.ButtonClick, function()
    btnEmotefunction()
    end)
    GUISystem.Instance():GetRootWindow():AddChildWindow(btnEmote)
    btnEmote:SetBackgroundColor({ 0, 0, 0, 0.6 })
    btnEmote:SetVisible(false)
    btnEmote:SetText("FreezeEmote")



    btnTPKil = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
    btnTPKil:SetHorizontalAlignment(HorizontalAlignment.Center)
    btnTPKil:SetVerticalAlignment(VerticalAlignment.Bottom)
    btnTPKil:SetHeight({ 0, 60 })
    btnTPKil:SetWidth({ 0, 140 })
    btnTPKil:SetYPosition({ 0, -430 })
    btnTPKil:SetXPosition({ 0, -675 })
    btnTPKil:SetLevel(1)
    btnTPKil:SetTextColor({ 0.6, 0, 0, 1 })
    btnTPKil:registerEvent(GUIEvent.ButtonClick, function()
        btnHitFunction()
    end)
    GUISystem.Instance():GetRootWindow():AddChildWindow(btnTPKil)
    btnTPKil:SetBackgroundColor({ 0, 0, 0, 0.6 })
    btnTPKil:SetVisible(false)
    btnTPKil:SetText("Hitbox")





function btnHitFunction()
    Lol = not Lol
    local players = PlayerManager:getPlayers()
    local autoHeight, autoWidth, autoLength

    if Lol then
        autoHeight = 5
        autoWidth = 5
        autoLength = 5
        btnTPKil:SetTextColor({0, 255, 0, 0.6})
    else
        autoHeight = 1
        autoWidth = 1
        autoLength = 1
        btnTPKil:SetTextColor({0.6, 0, 0, 1})
    end

    for _, player in ipairs(players) do
        local entity = player.Player
        if player ~= PlayerManager:getClientPlayer() then
            entity.height = autoHeight
            entity.width = autoWidth
            entity.length = autoLength
        end
    end
end

function btnEmotefunction()
 emote = not emote
     btnEmote:SetTextColor({ 0, 255, 0, 0.6 })
     PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
 if emote then
     PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", false)
     btnEmote:SetTextColor({ 0.6, 0, 0, 1 })
  end
end


function btnJetpackfunction()
BJF = not BJF
if BJF then
btnJetpackg2:SetTextColor({ 0, 255, 0, 0.6 })
local JetPack = true 
BJFS = LuaTimer:scheduleTimer(function()
local yaw=PlayerManager:getClientPlayer().Player:getYaw()
local pitch = PlayerManager:getClientPlayer().Player:getPitch()
local yawRadians = math.rad(yaw)
local pitchRadians = math.rad(pitch)
local speed = 4.6
local x = -speed * math.cos(pitchRadians) * math.sin(yawRadians) 
local y = -speed * math.sin(pitchRadians) 
local z = speed * math.cos(pitchRadians) * math.cos(yawRadians) 
local velocity = VectorUtil.newVector3(x,y,z)
PlayerManager:getClientPlayer().Player:setVelocity(velocity)
end, 15, 200000)
else
btnJetpackg2:SetTextColor({ 0.6, 0, 0, 1 })
LuaTimer:cancel(BJFS)
end
end

function btnTPKillFunction()
    Aim = not Aim
    btnTPKill:SetTextColor({ 0.6, 0, 0, 1 })
    LuaTimer:cancel(TpKillTimer)
    Blockman.Instance().m_gameSettings:setCollimatorMode(false)
    Toast("Auto Killer Tp : Off")
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)

    if Aim then
        Blockman.Instance().m_gameSettings:setCollimatorMode(true)
        local me = PlayerManager:getClientPlayer()
        local moveDir = VectorUtil.newVector3(1.0, 2.0, 1.0)
        local gameType = CGame.Instance():getGameType()
        local GameHasTeams = { "g1008", "g1046", "g1061", "g1062", "g1063", "g1065", "g1072", "g1027", "g1015" }
        
        local isGameHasTeams = false
        for _, hasTeams in pairs(GameHasTeams) do
            if gameType == hasTeams then
                isGameHasTeams = true
                break
            end
        end

        TpKillTimer = LuaTimer:scheduleTimer(function()
            local others = PlayerManager:getPlayers()
            local minDis = math.huge
            local nearestClient
            local teamId = me:getTeamId()

            for _, c_player in pairs(others) do
                if c_player ~= me then
                    local distance = MathUtil:distanceSquare3d(c_player:getPosition(), me:getPosition())
                    if minDis > distance then
                        minDis = distance
                        nearestClient = c_player
                    end
                end
            end

            if nearestClient then
                local nearestTeamId = nearestClient:getTeamId()
                local nearestHealth = nearestClient:getHealth()

                if isGameHasTeams then
                    if nearestTeamId ~= teamId and nearestHealth > 0 then
                        me.Player:setPosition(nearestClient:getPosition())
                        me.Player:moveEntity(moveDir)
                        local camera = SceneManager.Instance():getMainCamera()
                        local pos = camera:getPosition()
                        local dir = VectorUtil.sub3(nearestClient:getPosition(), pos)
                        local yaw = math.atan2(dir.x, dir.z) * -180 / math.pi
                        local calculate = math.sqrt(dir.x * dir.x + dir.z * dir.z)
                        local pitch = -math.atan2(dir.y + 1.5, calculate) * 180 / math.pi
                        
                        me.Player.rotationYaw = yaw
                        me.Player.rotationPitch = pitch
                        CGame.Instance():handleTouchClick(800, 360)
                        Toast("Name: " .. nearestClient:getName() .. " Health: " .. nearestHealth .. "/" .. nearestClient:getMaxHealth())
                    end
                else
                    if nearestHealth > 0 then
                        me.Player:setPosition(nearestClient:getPosition())
                        me.Player:moveEntity(moveDir)
                        local camera = SceneManager.Instance():getMainCamera()
                        local pos = camera:getPosition()
                        local dir = VectorUtil.sub3(nearestClient:getPosition(), pos)
                        local yaw = math.atan2(dir.x, dir.z) * -180 / math.pi
                        local calculate = math.sqrt(dir.x * dir.x + dir.z * dir.z)
                        local pitch = -math.atan2(dir.y + 1.5, calculate) * 180 / math.pi
                        
                        me.Player.rotationYaw = yaw
                        me.Player.rotationPitch = pitch
                        CGame.Instance():handleTouchClick(800, 360)
                        Toast("Name: " .. nearestClient:getName() .. " Health: " .. nearestHealth .. "/" .. nearestClient:getMaxHealth())
                    end
                end
            end
        end, 90, -1)

        Toast("Auto Killer Tp : On")
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
        btnTPKill:SetTextColor({ 0, 255, 0, 0.6 })
    end
end

function btnFarAimBotfunction()
    BFAF = not BFAF
    LuaTimer:cancel(AlwiiProoa)
    btnFarAimBotg2:SetTextColor({0.6, 0, 0, 1})

    if BFAF then
        btnFarAimBotg2:SetTextColor({0, 255, 0, 0.6})

        AlwiiProoa = LuaTimer:scheduleTimer(function()
            local me = PlayerManager:getClientPlayer()
            if me and me.Player then
                local myPos = me.Player:getPosition()
                local players = PlayerManager:getPlayers()
                local myTeamId = me:getTeamId()

                local closestDistance = math.huge
                local closestPlayer = nil

                for _, player in pairs(players) do
                    if player ~= me and player.Player and player.Player:getTeamId() ~= myTeamId then
                        local playerPos = player:getPosition()
                        local distance = MathUtil:distanceSquare2d(playerPos, myPos)

                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end

                if closestPlayer and closestDistance < 10000 then
                    local health = math.min(closestPlayer:getHealth(), 50.0)
                    local locationString = string.format("%s ¦   %.1f^FF0000♥️", closestPlayer.name, health)
                    Toast(locationString)

                    local camera = SceneManager.Instance():getMainCamera()
                    if camera then
                        local pos = camera:getPosition()
                        local dir = VectorUtil.sub3(closestPlayer:getPosition(), pos)

                        local yaw = math.atan2(dir.x, dir.z) / math.pi * -180
                        local calculate = math.sqrt(dir.x * dir.x + dir.z * dir.z)
                        local pitch = -math.atan2(dir.y, calculate) / math.pi * 180

                        me.Player.rotationYaw = yaw or 0
                        me.Player.rotationPitch = pitch or 0
                    end
                end
            end
        end, 15, -1)
    end
end

function btnAutoClickfunction()
        BACF = not BACF
        if BACF then
btnAutoClickg2:SetTextColor({ 0, 255, 0, 0.6 })
            BACFS = LuaTimer:scheduleTimer(function()
                CGame.Instance():handleTouchClick(800, 360)
            end, 15, -1)
        else
btnAutoClickg2:SetTextColor({ 0.6, 0, 0, 1 })
            LuaTimer:cancel(BACFS)
        end
    end






function Hide(w)
    w:SetVisible(false)
end

function Animate(Gui)
    local scale = 0.5
    Gui:SetScale(Vector3(scale, scale, scale))
    LuaTimer:scheduleTicker(function()
        if scale <= 1 then
            scale = scale + 0.1
        else
            scale = scale - 0.025
        end
        Gui:SetScale(Vector3(scale, scale, scale))
    end, 1, 10)
end

updateBg = GUIManager:createGUIWindow(GUIType.Layout, tostring(math.random(1, 999999999)))
updateBg:SetHorizontalAlignment(HorizontalAlignment.Center)
updateBg:SetVerticalAlignment(HorizontalAlignment.Center)
updateBg:SetHeight({0, 500})
updateBg:SetWidth({0, 520})
updateBg:SetBackgroundColor({0.05, 0.05, 0.05, 0.95})
updateBg:SetYPosition({0, 0})
updateBg:SetXPosition({0, 0})
updateBg:SetTouchable(true)
updateBg:SetVisible(true)
updateBg:SetLevel(1)
GUISystem.Instance():GetRootWindow():AddChildWindow(updateBg)

updateScroll = GUIManager:createGUIWindow(GUIType.List, tostring(math.random(1, 999999999)))
updateScroll:SetHorizontalAlignment(HorizontalAlignment.Center)
updateScroll:SetVerticalAlignment(HorizontalAlignment.Center)
updateScroll:SetHeight({0, 400})
updateScroll:SetWidth({0, 480})
updateScroll:SetBackgroundColor({0.08, 0.08, 0.08, 0.9})
updateScroll:SetTouchable(true)
updateScroll:SetLevel(1)
updateScroll:SetMoveAble(true)
updateScroll:SetVisible(true)
updateScroll:SetYPosition({0, 0})
updateScroll:SetXPosition({0, 0})
GUISystem.Instance():GetRootWindow():AddChildWindow(updateScroll)

updateTitle = GUIManager:createGUIWindow(GUIType.StaticText, tostring(math.random(1, 999999999)))
updateTitle:SetHorizontalAlignment(HorizontalAlignment.Center)
updateTitle:SetVerticalAlignment(VerticalAlignment.Center)
updateTitle:SetTextHorzAlign(HorizontalAlignment.Center)
updateTitle:SetTextVertAlign(VerticalAlignment.Center)
updateTitle:SetHeight({0, 55})
updateTitle:SetWidth({0, 520})
updateTitle:SetYPosition({0, -250})
updateTitle:SetTextScale(1.2)
updateTitle:SetLevel(1)
updateTitle:SetBackgroundColor({0.02, 0.1, 0.12, 1}) 
GUISystem.Instance():GetRootWindow():AddChildWindow(updateTitle)

local hue = 0
local function interpolateColor(hue)
    local r, g, b = 0, 0, 0
    if hue < 60 then
        r, g, b = 1, hue / 60, 0
    elseif hue < 120 then
        r, g, b = (120 - hue) / 60, 1, 0
    elseif hue < 180 then
        r, g, b = 0, 1, (hue - 120) / 60
    elseif hue < 240 then
        r, g, b = 0, (240 - hue) / 60, 1
    elseif hue < 300 then
        r, g, b = (hue - 240) / 60, 0, 1
    else
        r, g, b = 1, 0, (360 - hue) / 60
    end
    return r, g, b
end

function Title()
    local function UpdateColor()
        updateTitle:SetText("🚀 What's New in 2.5?")
        hue = (hue + 1) % 360
        local r, g, b = interpolateColor(hue)
        updateTitle:SetTextColor({0, 1, 1, 1}) 
    end
    LuaTimer:scheduleTimer(UpdateColor, 100, -1)
end
Title()

updateClose = GUIManager:createGUIWindow(GUIType.StaticText, tostring(math.random(1, 999999999)))
updateClose:SetHorizontalAlignment(HorizontalAlignment.Center)
updateClose:SetVerticalAlignment(VerticalAlignment.Center)
updateClose:SetTextHorzAlign(HorizontalAlignment.Center)
updateClose:SetTextVertAlign(VerticalAlignment.Center)
updateClose:SetHeight({0, 50})
updateClose:SetWidth({0, 50})
updateClose:SetYPosition({0, -250})
updateClose:SetXPosition({0, 272})
updateClose:SetText("×")
updateClose:SetTextScale(1.6)
updateClose:SetBackgroundColor({0.8, 0, 0.1, 0.9})
updateClose:SetTouchable(true)
updateClose:SetVisible(true)
updateClose:SetLevel(1)
GUISystem.Instance():GetRootWindow():AddChildWindow(updateClose)

updateClose:registerEvent(GUIEvent.Click, function()
    Hide(updateTitle)
    Hide(updateBg)
    Hide(updateScroll)
    updateClose:SetVisible(false)
    Toast("Closed")
end)

local WhatsNew = {
    " ^FFFFFF「Improvements」 :", 
    "  • Improved UI",
    "  • Improved Keyboard",
    " ", 
    " ^FFFFFF「Recoded」 :", 
    "  • Recoded : Teleportation",    
    "  • Recoded : Panel UI interference",
    "  • Recoded : Crash on-load",
    "  • Recoded : Inside-Panel-Credits",
    " ", 
    " ^FFFFFF「Added」 :",     
    "  • Added Primain Tab",
    "  • Added Keystrokes",
    "  • Added Performance Boost", 
    "  • Added ChatBypass",
    " ", 
    " ^FFFFFF「Removed」 :", 
    "  • Removed Ddos", 
    "  • Removed Clothes Tab"
}

local function addUpdItem(Text)
    local StaticText = GUIManager:createGUIWindow(GUIType.StaticText, tostring(math.random(1, 999999999)))
    StaticText:SetHorizontalAlignment(HorizontalAlignment.Center)
    StaticText:SetTextHorzAlign(HorizontalAlignment.Left)
    StaticText:SetTextVertAlign(VerticalAlignment.Center)
    StaticText:SetHeight({0, 45})
    StaticText:SetWidth({0, 480})
    StaticText:SetText(Text)
    StaticText:SetTextColor({0.6, 1, 1, 1})
    StaticText:SetTouchable(true)
    StaticText:SetVisible(true)
    StaticText:SetBackgroundColor({0.12, 0.12, 0.12, 0.85})
    updateScroll:AddItem(StaticText)
end

for _, Text in ipairs(WhatsNew) do
    addUpdItem(Text)
end

    openButton = GUIManager:createGUIWindow(GUIType.Button, "Open-Button")
    openButton:SetHorizontalAlignment(HorizontalAlignment.Center)
    openButton:SetVerticalAlignment(HorizontalAlignment.Top)
    openButton:SetHeight({0, 50})
    openButton:SetWidth({0, 50})
    openButton:SetYPosition({0, 60 })
    openButton:SetXPosition({0, 0})
    openButton:SetTouchable(false) 
    openButton:SetNormalImage("set:gui_inventory_icon.json image:icon_bookrack")
    openButton:SetPushedImage("set:gui_inventory_icon.json image:icon_bookrack")
    openButton:SetVisible(true)
    GUISystem.Instance():GetRootWindow():AddChildWindow(openButton)



GUIGMItem = require("engine_client.ui.window.GUIGMItem")
local pendingCb = nil
local currentLanguage = "English"
local allItems = {}

local TranslationsEnglish = {
    ["Language"]="Language", ["English"]="English", ["Russian"]="Russian", ["Arabic"]="Arabic", ["Chinese"]="Chinese",
    ["Unlimited Jump"]="Unlimited Jump", ["Blink"]="Blink", ["QuickPlaceblock"]="Quick Place Block",
    ["FastBreak"]="Fast Break", ["BowSpeed"]="Bow Speed", ["AttackCD"]="Attack Cooldown",
    ["ArmSpeed"]="Arm Speed", ["Hitbox"]="Hitbox", ["Aimbot"]="Aimbot",
    ["HoldFly"]="Hold Fly", ["Tracer"]="Tracer", ["TeleportClick"]="Teleport Click",
    ["FlyParachute"]="Fly Parachute", ["DevFly"]="Dev Fly", ["Inject Parachute"]="Inject Parachute",
    ["Skate"]="Skate", ["WWE Camera"]="WWE Camera", ["Speed Boost"]="Speed Boost",
    ["AntiVoid"]="Anti-Void", ["FeatherFall"]="Feather Fall", ["AirGlide"]="Air Glide",
    ["Instant-Respawn"]="Instant Respawn", ["AutoKillerTp"]="Auto Killer Tp", ["TeleportHit"]="Teleport Hit",
    ["ShowHpV2"]="Show HP V2", ["NoKnockBack"]="No Knockback", ["AttackReach Bypass"]="Attack Reach Bypass",
    ["Respawn At Death"]="Respawn At Death", ["NoFallDmg"]="No Fall Damage", ["Player Xray"]="Player Xray",
    ["Fast-Reload"]="Fast Reload", ["Fast-Throw"]="Fast Throw", ["AttackBtn"]="Attack Button",
    ["ReachPlayers"]="Reach Players", ["Wall-Hacks"]="Wall Hacks",
    ["NoClip"]="No Clip", ["Set Attack-Reach"]="Set Attack Reach", ["Set Block-Reach"]="Set Block Reach",
    ["WebMode"]="Web Mode", ["runcode V2"]="Run Code V2", ["runCode (Path)"]="Run Code (Path)",
    ["Dpad"]="Dpad", ["Attack Color"]="Attack Color", ["in the air Bypass"]="In the Air Bypass",
    ["Air Bypass V2"]="Air Bypass V2", ["Speed Bypass"]="Speed Bypass", ["Place & Break Block"]="Place & Break Block",
    ["UIFucker"]="UI Breaker", ["Unlimited Gcubes"]="Unlimited Gcubes", ["Chat-Proxy"]="Chat Proxy",
    ["Damage-Indicator"]="Damage Indicator", ["Manages-Signs "]="Manage Signs", ["Hide-Armor"]="Hide Armor",
    ["BtnAutoClicker"]="Button Auto Clicker", ["BtnAimbot"]="Button Aimbot", ["BtnJetpack"]="Button Jetpack",
    ["BtnTeleportKill"]="Button Teleport Kill", ["BtnFreezeEmote"]="Button Freeze Emote", ["BtnHitbox"]="Button Hitbox",
    ["FlyButton"]="Fly Button",
    ["▢FFFF0000Red"]="Red", ["▢FF0000FFBlue"]="Blue", ["▢FFFF00FFPink"]="Pink", ["▢FF00FFFFCyan"]="Cyan",
    ["▢FF00FF00Green"]="Green", ["▢FF9600FFPurple"]="Purple", ["▢FFFFFF00Yellow"]="Yellow",
    ["▢FFFFAF00Orange"]="Orange", ["▢FFFFD700Gold"]="Gold", ["▢FFFFFFFFWhite"]="White",
    ["Vip0"]="VIP 0", ["Vip1"]="VIP 1", ["Vip2"]="VIP 2", ["Vip3"]="VIP 3", ["Vip4"]="VIP 4",
    ["Vip5"]="VIP 5", ["Vip6"]="VIP 6", ["Vip7"]="VIP 7", ["Vip8"]="VIP 8", ["Vip9"]="VIP 9",
    ["Vip10"]="VIP 10", ["Vip10+"]="VIP 10+",
    ["What's New?"]="What's New?", ["TransBackground"]="Transparent Background", ["Hide Panel"]="Hide Panel",
    ["Rejoin"]="Rejoin", ["Exit"]="Exit", ["GetAllGuiName "]="Get All GUI Names", ["Afk"]="AFK",
    ["SetMaxFps"]="Set Max FPS", ["No Particle"]="No Particles", ["FpsBoost"]="FPS Boost", ["Night Vision"]="Night Vision",
    ["ChatSpam"]="Chat Spam", ["Chat Hider"]="Chat Hider", ["ChatBypass"]="Chat Bypass",
    ["Friends"]="Friends", ["Burnth"]="Burnth",
    ["TpMobsToMe"]="Teleport Mobs to Me", ["ItemThief"]="Item Thief", ["Item Locator"]="Item Locator",
    ["Sunset"]="Sunset", ["Stars"]="Stars", ["Sunny"]="Sunny", ["Rain"]="Rain", ["ShootingStar"]="Shooting Star", ["Snow"]="Snow",
    ["^FFFFFF[ Creator ]"]="Creator", ["^FFFFFF[ Assistant ]"]="Assistant", ["^FFFFFF[ Enc & Dec ]"]="Encoder & Decoder",
    ["Add Function"]="Add Function", ["Remove Function"]="Remove Function"
}

TranslationsRussian = {
    ["Unlimited Jump"] = "Бесконечный прыжок",
    ["Blink"] = "Мгновенное перемещение",
    ["QuickPlaceblock"] = "Быстрая установка блока",
    ["FastBreak"] = "Быстрое разрушение",
    ["BowSpeed"] = "Скорость лука",
    ["AttackCD"] = "Задержка атаки",
    ["ArmSpeed"] = "Скорость руки",
    ["Hitbox"] = "Хитбокс",
    ["Aimbot"] = "Аимбот",
    ["HoldFly"] = "Полёт с удержанием",
    ["Tracer"] = "Трассировка",
    ["TeleportClick"] = "Клик-телепорт",
    ["FlyParachute"] = "Парашют-полёт",
    ["DevFly"] = "Разработчикский полёт",
    ["Inject Parachute"] = "Вставить парашют",
    ["Skate"] = "Скейт",
    ["WWE Camera"] = "Камера WWE",
    ["Speed Boost"] = "Ускорение",
    ["AntiVoid"] = "Анти-бездна",
    ["Attack Reach Bypass"] = "Обход дальности атаки",

    ["FeatherFall"] = "Плавное падение",
    ["AirGlide"] = "Парение в воздухе",
    ["Instant-Respawn"] = "Мгновенное возрождение",
    ["AutoKillerTp"] = "Авто убийца (ТП)",
    ["TeleportHit"] = "Атака-телепорт",
    ["ShowHpV2"] = "Показать здоровье",
    ["NoKnockBack"] = "Без отбрасывания",
    ["Respawn At Death"] = "Возрождение при смерти",
    ["NoFallDmg"] = "Без урона от падения",
    ["Player Xray"] = "Просмотр игроков",
    ["Fast-Reload"] = "Быстрая перезарядка",
    ["Fast-Throw"] = "Быстрое бросание",
    ["AttackBtn"] = "Кнопка атаки",
    ["ReachPlayers"] = "Дальность до игроков",
    ["Wall-Hacks"] = "Вх сквозь стены",

    ["NoClip"] = "Проход сквозь стены",
    ["Set Attack-Reach"] = "Настроить дальность атаки",
    ["Set Block-Reach"] = "Настроить дальность блока",
    ["WebMode"] = "Режим паутины",
    ["runcode V2"] = "Запуск кода V2",
    ["runCode (Path)"] = "Запуск кода (путь)",
    ["Dpad"] = "D-Pad",
    ["Attack Color"] = "Цвет атаки",
    ["in the air Bypass"] = "Обход в воздухе",
    ["Speed Bypass"] = "Обход скорости",
    ["Place & Break Block"] = "Ставить и ломать блоки",
    ["UIFucker"] = "Ломатель интерфейса",
    ["Unlimited Gcubes"] = "Бесконечные кубы",
    ["Chat-Proxy"] = "Чат-прокси",
    ["Damage-Indicator"] = "Индикатор урона",
    ["Hide-Armor"] = "Скрыть броню",

    ["BtnAutoClicker"] = "Автокликер",
    ["BtnAimbot"] = "Аимбот",
    ["BtnJetpack"] = "Джетпак",
    ["BtnTeleportKill"] = "ТП убийство",
    ["BtnFreezeEmote"] = "Заморозить эмоцию",
    ["BtnHitbox"] = "Хитбокс",
    ["FlyButton"] = "Кнопка полета",

    ["Vip plate"] = "Вип табличка",
    ["Vip0"] = "Вип 0",
    ["Vip1"] = "Вип 1",
    ["Vip2"] = "Вип 2",
    ["Vip3"] = "Вип 3",
    ["Vip4"] = "Вип 4",
    ["Vip5"] = "Вип 5",
    ["Vip6"] = "Вип 6",
    ["Vip7"] = "Вип 7",
    ["Vip8"] = "Вип 8",
    ["Vip9"] = "Вип 9",
    ["Vip10"] = "Вип 10",
    ["Vip10+"] = "Вип 10+",

    ["What's New?"] = "Что нового?",
    ["TransBackground"] = "Прозрачный фон",
    ["Hide Panel"] = "Скрыть панель",
    ["Rejoin"] = "Перезайти",
    ["Exit"] = "Выйти",
    ["Afk"] = "АФК",

    ["SetMaxFps"] = "Установить FPS",
    ["No Particle"] = "Без частиц",
    ["FpsBoost"] = "Ускорение FPS",
    ["Night Vision"] = "Ночное зрение",

    ["ChatSpam"] = "Спам в чат",
    ["Chat Hider"] = "Скрыть чат",
    ["ChatBypass"] = "Обход чата",

    ["Friends"] = "Друзья",
    ["Burnth"] = "Горение",

    ["TpMobsToMe"] = "ТП мобов ко мне",
    ["ItemThief"] = "Вор предметов",
    ["Item Locator"] = "Локатор предметов",

    ["Sunset"] = "Закат",
    ["Stars"] = "Звезды",
    ["Sunny"] = "Солнечно",
    ["Rain"] = "Дождь",
    ["ShootingStar"] = "Падающая звезда",
    ["Snow"] = "Снег",

    ["Add Function"] = "Добавить функцию",
    ["Remove Function"] = "Удалить функцию"
}


local TranslationsArabic = {
    ["Language"]="اللغة", ["English"]="الإنجليزية", ["Russian"]="الروسية", ["Arabic"]="العربية", ["Chinese"]="الصينية",
    ["Unlimited Jump"]="قفز غير محدود", ["Blink"]="بلينك", ["QuickPlaceblock"]="وضع سريع للبلوك",
    ["FastBreak"]="كسر سريع", ["BowSpeed"]="سرعة القوس", ["AttackCD"]="إعادة هجوم",
    ["ArmSpeed"]="سرعة اليد", ["Hitbox"]="هيت بوكس", ["Aimbot"]="ايم بوت",
    ["HoldFly"]="طيران بالضغط", ["Tracer"]="تراسر", ["TeleportClick"]="تيلبورت بالنقر",
    ["FlyParachute"]="طيران بالمظلة", ["DevFly"]="طيران المطور", ["Inject Parachute"]="حقن مظلة",
    ["Skate"]="تزحلق", ["WWE Camera"]="كاميرا WWE", ["Speed Boost"]="زيادة السرعة",
    ["AntiVoid"]="مضاد السقوط في الفراغ", ["FeatherFall"]="سقوط خفيف", ["AirGlide"]="انزلاق جوي",
    ["Instant-Respawn"]="إعادة ولادة فورية", ["AutoKillerTp"]="قتل تلقائي", ["TeleportHit"]="ضربة بالتيلبورت",
    ["ShowHpV2"]="عرض الصحة V2", ["NoKnockBack"]="بدون ارتداد", ["AttackReach Bypass"]="تجاوز مدى الهجوم",
    ["Respawn At Death"]="إعادة عند الموت", ["NoFallDmg"]="بدون ضرر سقوط", ["Player Xray"]="رؤية اللاعبين",
    ["Fast-Reload"]="إعادة سريعة", ["Fast-Throw"]="رمي سريع", ["AttackBtn"]="زر الهجوم",
    ["ReachPlayers"]="مدى اللاعبين", ["Wall-Hacks"]="اختراق الجدران",
    ["NoClip"]="مرور عبر الجدران", ["Set Attack-Reach"]="تحديد مدى الهجوم", ["Set Block-Reach"]="تحديد مدى البلوك",
    ["WebMode"]="وضع الشبكة", ["runcode V2"]="تشغيل كود V2", ["runCode (Path)"]="تشغيل كود (مسار)",
    ["Dpad"]="Dpad", ["Attack Color"]="لون الهجوم", ["in the air Bypass"]="تجاوز في الهواء",
    ["Air Bypass V2"]="تجاوز في الهواء V2", ["Speed Bypass"]="تجاوز السرعة", ["Place & Break Block"]="وضع وكسر بلوك",
    ["UIFucker"]="كسر الواجهة", ["Unlimited Gcubes"]="جي كيوبز غير محدود", ["Chat-Proxy"]="بروكسي الدردشة",
    ["Damage-Indicator"]="مؤشر الضرر", ["Manages-Signs "]="إدارة اللوحات", ["Hide-Armor"]="إخفاء الدرع",
    ["What's New?"]="ما الجديد؟", ["TransBackground"]="خلفية شفافة", ["Hide Panel"]="إخفاء اللوحة",
    ["Rejoin"]="إعادة الدخول", ["Exit"]="خروج", ["GetAllGuiName "]="أسماء GUI", ["Afk"]="بعيد عن الكيبورد",
    ["SetMaxFps"]="تحديد FPS أقصى", ["No Particle"]="بدون جزيئات", ["FpsBoost"]="زيادة FPS", ["Night Vision"]="رؤية ليلية",
    ["ChatSpam"]="سبام الدردشة", ["Chat Hider"]="إخفاء الدردشة", ["ChatBypass"]="تجاوز فلتر الدردشة"
}

local TranslationsChinese = {
    ["Language"]="语言", ["English"]="英语", ["Russian"]="俄语", ["Arabic"]="阿拉伯语", ["Chinese"]="中文",
    ["Unlimited Jump"]="无限跳跃", ["Blink"]="闪现", ["QuickPlaceblock"]="快速放置方块",
    ["FastBreak"]="快速破坏", ["BowSpeed"]="弓速", ["AttackCD"]="攻击冷却",
    ["ArmSpeed"]="手速", ["Hitbox"]="碰撞箱", ["Aimbot"]="自动瞄准",
    ["HoldFly"]="按住飞行", ["Tracer"]="追踪器", ["TeleportClick"]="点击传送",
    ["FlyParachute"]="降落伞飞行", ["DevFly"]="开发者飞行", ["Inject Parachute"]="注入降落伞",
    ["Skate"]="滑板", ["WWE Camera"]="WWE 相机", ["Speed Boost"]="加速",
    ["AntiVoid"]="防掉虚空", ["FeatherFall"]="羽落", ["AirGlide"]="空中滑行",
    ["Instant-Respawn"]="立即重生", ["AutoKillerTp"]="自动击杀传送", ["TeleportHit"]="传送攻击",
    ["ShowHpV2"]="显示生命值 V2", ["NoKnockBack"]="无击退", ["AttackReach Bypass"]="攻击距离绕过",
    ["Respawn At Death"]="死亡重生", ["NoFallDmg"]="无掉落伤害", ["Player Xray"]="透视玩家",
    ["Fast-Reload"]="快速换弹", ["Fast-Throw"]="快速投掷", ["AttackBtn"]="攻击按钮",
    ["ReachPlayers"]="攻击范围玩家", ["Wall-Hacks"]="透视墙壁",
    ["NoClip"]="穿墙", ["Set Attack-Reach"]="设置攻击距离", ["Set Block-Reach"]="设置方块距离",
    ["WebMode"]="蜘蛛网模式", ["runcode V2"]="运行代码 V2", ["runCode (Path)"]="运行代码 (路径)",
    ["Dpad"]="方向键", ["Attack Color"]="攻击颜色", ["in the air Bypass"]="空中绕过",
    ["Air Bypass V2"]="空中绕过 V2", ["Speed Bypass"]="速度绕过", ["Place & Break Block"]="放置并破坏方块",
    ["UIFucker"]="破坏界面", ["Unlimited Gcubes"]="无限 Gcubes", ["Chat-Proxy"]="聊天代理",
    ["Damage-Indicator"]="伤害指示器", ["Manages-Signs "]="管理牌子", ["Hide-Armor"]="隐藏护甲",
    ["What's New?"]="新内容？", ["TransBackground"]="透明背景", ["Hide Panel"]="隐藏面板",
    ["Rejoin"]="重新加入", ["Exit"]="退出", ["GetAllGuiName "]="获取 GUI 名称", ["Afk"]="挂机",
    ["SetMaxFps"]="设置最大 FPS", ["No Particle"]="无粒子", ["FpsBoost"]="FPS 加速", ["Night Vision"]="夜视",
    ["ChatSpam"]="刷屏", ["Chat Hider"]="隐藏聊天", ["ChatBypass"]="聊天绕过"
}


function GMHelper:cb(callback)
    pendingCb = callback or function() end
    pendingRemove = false
end

function GMHelper:Acb(callback)
    pendingCb = callback or function() end
    pendingRemove = true
end

function GMHelper:HandleCustomizeClick(clickedItem)
    if pendingCb and not pendingRemove then
        local cb = pendingCb
        pendingCb = nil
        local newItemName = clickedItem.data and clickedItem.data.name or "Custom"
        GMSetting:addItem("Customize", newItemName, clickedItem.data.func or "")
        cb(clickedItem)
        GUIGMControlPanel:selectTab("xd", "Customize")
    end
end

function GMHelper:HandleRemoveClick(clickedItem)
    if pendingCb and pendingRemove then
        local cb = pendingCb
        pendingCb = nil
        pendingRemove = false
        local itemName = clickedItem.data and clickedItem.data.name
        if itemName and itemName ~= "Add Function" and itemName ~= "Remove Function" then
            GMSetting:removeItem("Customize", itemName)
            cb(clickedItem)
            GUIGMControlPanel:selectTab("xd", "Customize")
        end
    end
end

function GUIGMItem:onLoad()
    self.tvItem = self:getChildWindowByName("GMButton", GUIType.StaticText)
    table.insert(allItems, self)
    self.tvItem:registerEvent(GUIEvent.Click, function()
        if pendingCb then
            if pendingRemove then
                GMHelper:HandleRemoveClick(self)
            else
                GMHelper:HandleCustomizeClick(self)
            end
            return
        end
        if self.data and self.data.func ~= "" then
            local params = TableUtil.copyTable(self.data.params or {})
            table.insert(params, self.tvItem)
            GMHelper:callCommand(self.data.func, unpack(params))
        end
    end)
end

function GMSetting:removeItem(tabName, itemName)
    if not self.tabs or not self.tabs[tabName] then return end
    local items = self.tabs[tabName].items
    for i, item in ipairs(items) do
        if item.name == itemName then
            table.remove(items, i)
            break
        end
    end
end

 
function GMHelper:setLanguageEnglish()
    currentLanguage = "English"
    for _, item in ipairs(allItems) do
        local name = item.data and item.data.originalName or item.data.name
        if name then
            local display = TranslationsEnglish[name] or name
            item.tvItem:SetText(display)
        end
    end
    Toast("Language set to English")
end

function GMHelper:setLanguageRussian()
    currentLanguage = "Russian"
    for _, item in ipairs(allItems) do
        local name = item.data and item.data.originalName or item.data.name
        if name then
            local display = TranslationsRussian[name] or name
            item.tvItem:SetText(display)
        end
    end
    Toast("Язык установлен на Русский")
end

function GMHelper:setLanguageArabic()
    currentLanguage = "Arabic"
    for _, item in ipairs(allItems) do
        local name = item.data and item.data.originalName or item.data.name
        if name then
            local display = TranslationsArabic[name] or name
            item.tvItem:SetText(display)
        end
    end
    Toast("تم تعيين اللغة إلى العربية")
end

function GMHelper:setLanguageChinese()
    currentLanguage = "Chinese"
    for _, item in ipairs(allItems) do
        local name = item.data and item.data.originalName or item.data.name
        if name then
            local display = TranslationsChinese[name] or name
            item.tvItem:SetText(display)
        end
    end
    Toast("语言已设置为中文")
end




function GUIGMItem:onDataChanged(data)
    self.data = data
    if not data.originalName then
        data.originalName = data.name
    end

    local displayName =
        (currentLanguage == "English" and TranslationsEnglish[data.originalName])
        or (currentLanguage == "Russian" and TranslationsRussian[data.originalName])
        or (currentLanguage == "Chinese" and TranslationsChinese[data.originalName])
        or (currentLanguage == "Arabian" and TranslationsArabian[data.originalName])
        or data.originalName

    self.tvItem:SetText(displayName)
    self.tvItem:SetProperty("Font", "HT14")

    if self.tvItem:GetTextWidth() > self.tvItem:GetPixelSize().x then
        self.tvItem:SetProperty("Font", "HT12")
        if self.tvItem:GetTextWidth() > self.tvItem:GetPixelSize().x then
            self.tvItem:SetProperty("Font", "HT10")
        end
    end

    if data.color then
        self.tvItem:SetBackgroundColor(data.color)
    else
        self.tvItem:SetBackgroundColor(Color.BLACK)
    end
end







end         
         



function Game:isOpenGM()
    isTest = false
    return isClient or TableUtil.include(AdminIds, tostring(Game:getPlatformUserId()))
end

local Settings = {}
GMHelper = {}
GMSetting = {}

local function isGMOpen(userId)
    if isServer then
        return true
    end
    return TableUtil.include(AdminIds, tostring(userId))
end

function GMSetting:addTab(tab_prefix, tab_name)
    if tab_prefix ~= "xd" then
        return
    end 

    local final_tab_name = tab_name 

    for _, setting in pairs(Settings) do
        if setting.name == final_tab_name then
            setting.items = {}
            return
        end
    end

    table.insert(Settings, { name = final_tab_name, items = {} })
end

function GMSetting:addItem(tab_name, prefix_or_item, item_or_func, func_or_nil, ...)
    local prefix, item_name, func_name

    local is_colored_item = type(prefix_or_item) == "string" and prefix_or_item:match("^▢%x%x%x%x%x%x%w+")

    if is_colored_item or func_or_nil == nil then
        prefix = nil
        item_name = prefix_or_item
        func_name = item_or_func
    else
        prefix = prefix_or_item
        item_name = item_or_func
        func_name = func_or_nil
    end

    local settings
    for _, group in pairs(Settings) do
        if group.name == tab_name then
            settings = group
            break
        end
    end

    if not settings then return end

local color_codes = {
    red         = "^FF0000",
    dark_red    = "^8B0000",
    blue        = "^0000FF",
    dark_blue   = "^00008B",
    cyan        = "^00FFFF",
    dark_cyan   = "^008B8B",
    green       = "^00FF00",
    dark_green  = "^006400",
    lime        = "^32CD32",
    yellow      = "^FFFF00",
    gold        = "^FFD700",
    orange      = "^FFA500",
    pink        = "^FFC0CB",
    hot_pink    = "^FF69B4",
    magenta     = "^FF00FF",
    purple      = "^800080",
    violet      = "^EE82EE",
    white       = "^FFFFFF",
    light_gray  = "^D3D3D3",
    gray        = "^808080",
    dark_gray   = "^404040",
    black       = "^000000",
    brown       = "^A52A2A",
    tan         = "^D2B48C"
}
    local display_name = item_name

    if type(prefix) == "string" and prefix ~= "" then
        local color_code = color_codes[string.lower(prefix)]
        if color_code then
            display_name = color_code .. item_name
        else
            display_name = prefix .. " " .. item_name
        end
    end

    table.insert(settings.items, {
        name = display_name,
        func = func_name,
        params = { ... }
    })
end



function GMSetting:getSettings()
    return Settings
end


GMSetting:addTab("xd", "Main")
GMSetting:addItem("Main", "Unlimited Jump", "togfly")
GMSetting:addItem("Main", "Blink", "BlinkOP")
GMSetting:addItem("Main", "QuickPlaceblock", "quickblock")
GMSetting:addItem("Main", "FastBreak", "FustBreakBlockMode")
GMSetting:addItem("Main", "BowSpeed", "BowSpeed")
GMSetting:addItem("Main", "AttackCD", "BanClickCD")
GMSetting:addItem("Main", "ArmSpeed", "ArmSpeed")
GMSetting:addItem("Main", "Hitbox", "krixop")
GMSetting:addItem("Main", "Aimbot", "AimBot")
GMSetting:addItem("Main", "HoldFly", "JetPack")
GMSetting:addItem("Main", "Tracer", "Tracer")
GMSetting:addItem("Main", "TeleportClick", "clickTp")
GMSetting:addItem("Main", "FlyParachute", "FlyParachute")
GMSetting:addItem("Main", "DevFly", "DevFly")
GMSetting:addItem("Main", "Inject Parachute", "startParachute")
GMSetting:addItem("Main", "Skate", "EmoteFreezer")
GMSetting:addItem("Main", "WWE Camera", "WWE_Camera")
GMSetting:addItem("Main", "Speed Boost", "SpeedBoost") 
GMSetting:addItem("Main", "AntiVoid", "AntiVoid")

if gameType == "g1008" then
    GMSetting:addItem("BedWars", "Attack Reach Bypass", "BWInfReach")
end

function GMHelper:BtnBridge()
	if togBuildMain then return end

	local handlerStore = {}
	Events.ShowFrontBlockEvent = IScriptEvent.new()
	local blockSettings = {}

	function GMHelper:initBlockModule()
		local ymlCfg = FileUtil.getGameConfigFromYml("module_block/ModuleBlock", true) or {}
		self.maxPlaceDepth = ymlCfg.placeBlockMaxDepth or 2
		self.maxBuildDistance = 4
		self.roadModeMaxDist = 4

		if isClient then
			ClientHelper.putIntPrefs("RunLimitCheck", ymlCfg.limitBlockCheckRun or 10)
			ClientHelper.putIntPrefs("SprintLimitCheck", ymlCfg.limitBlockCheckSprint or 10)
		end

		local csvCfg = FileUtil.getGameConfigFromCsv("module_block/ModuleBlock.csv", 2, true, true) or {}
		for _, row in pairs(csvCfg) do
			local data = {
				id = tonumber(row.id),
				itemId = tonumber(row.itemId),
				teamId = tonumber(row.teamId) or 0,
				consumeNum = tonumber(row.consumeNum) or 1,
				schematic = row.schematic,
				offsetX = tonumber(row.offsetX) or 0,
				offsetZ = tonumber(row.offsetZ) or 0,
				image = row.image,
				extraParam = tonumber(row.extraParam) or 0,
			}
			blockSettings[data.itemId] = blockSettings[data.itemId] or {}
			table.insert(blockSettings[data.itemId], data)
		end

		for _, setting in pairs(blockSettings) do
			table.sort(setting, function(a,b) return a.id < b.id end)
		end
	end

	function GMHelper:getBlockModule(itemId, moduleId, teamId)
		local modules = blockSettings[itemId]
		if not modules then return nil end
		if moduleId and moduleId ~= 0 then
			for _, m in pairs(modules) do
				if m.id == moduleId then return m end
			end
		end
		for _, m in pairs(modules) do
			if m.teamId == teamId then return m end
		end
		if teamId ~= 0 then
			return self:getBlockModule(itemId, moduleId, 0)
		end
		return nil
	end

	function GMHelper:getBlockModules(itemId)
		return blockSettings[itemId]
	end

	function GMHelper:getDefaultModuleId(itemId)
		local modules = blockSettings[itemId]
		return (modules and #modules > 0) and modules[1].id or 0
	end

	function GMHelper:hasBlockConfig()
		return not TableUtil.isEmpty(blockSettings)
	end

	self:initBlockModule()

	local faceOffsets = {
		North = VectorUtil.newVector3(0,0,-1),
		South = VectorUtil.newVector3(0,0,1),
		West  = VectorUtil.newVector3(-1,0,0),
		East  = VectorUtil.newVector3(1,0,0),
	}

	local diagOffsets = {
		WestNorth = VectorUtil.newVector3(-1,0,-1),
		WestSouth = VectorUtil.newVector3(-1,0,1),
		EastNorth = VectorUtil.newVector3(1,0,-1),
		EastSouth = VectorUtil.newVector3(1,0,1),
	}

	local faceMap = { Upper=0, Under=1, North=3, South=2, West=5, East=4 }

	local currentClickPos

	local function getHitInfo(player, clickPos)
		local cam = SceneManager.Instance():getMainCamera()
		local pos, dir = cam:getPosition(), cam:getDirection()
		local hit, real = HitInfo.new(), nil
		local ray = Ray.new(pos, dir)
		cam:getCameraRay(ray, clickPos)
		local y = player:getPosition().y - 1.6
		local plane = Plane.new(VectorUtil.UNIT_Y, -y)
		ray:hitPlane(plane, real, hit)
		hit.hitPos = VectorUtil.newVector3(hit.hitPos.x, math.floor(hit.hitPos.y), hit.hitPos.z)
		return hit
	end

	local function canPlaceBlock(pos)
		local blockId = EngineWorld:getBlockId(pos)
		local attachList, buildList, canPlace = {}, {}, false
		if blockId ~= BlockID.AIR and blockId ~= BlockID.SNOW then return canPlace, attachList, buildList end
		for name, offset in pairs(faceOffsets) do
			local newPos = VectorUtil.add3(pos, offset)
			local id = EngineWorld:getBlockId(newPos)
			if id ~= BlockID.AIR and id ~= BlockID.SNOW then
				attachList[name] = newPos
				canPlace = true
			else
				table.insert(buildList, newPos)
			end
		end
		for _, offset in pairs(diagOffsets) do
			local newPos = VectorUtil.add3(pos, offset)
			if EngineWorld:getBlockId(newPos) == 0 then table.insert(buildList, newPos) end
		end
		return canPlace, attachList, buildList
	end

	local function findBuildPos(player, startPos, depth)
		depth = depth or 1
		if depth > (self.maxPlaceDepth or 1) then return false, nil, nil end
		local canPlace, attachList, buildList = canPlaceBlock(startPos)
		local playerPos = VectorUtil.toBlockVector3(player:getPosition().x, player:getPosition().y, player:getPosition().z)
		if canPlace then
			local targetPos, targetFace
			local minDist = self.maxBuildDistance
			for name, pos in pairs(attachList) do
				local dist = VectorUtil.distance(pos, playerPos)
				if dist < minDist then
					minDist = dist
					targetPos, targetFace = pos, faceMap[name]
				end
			end
			return true, targetPos, targetFace
		else
			table.sort(buildList, function(a,b) return VectorUtil.distance(a, playerPos) < VectorUtil.distance(b, playerPos) end)
			for _, pos in pairs(buildList) do
				local ok, bp, face = findBuildPos(player, pos, depth + 1)
				if ok then return ok, bp, face end
			end
		end
		return false, nil, nil
	end

	local function findFrontBlock(player, dir)
		local step = math.abs(dir.x) >= math.abs(dir.z) and VectorUtil.newVector3(dir.x>0 and 1 or -1,0,0)
					or VectorUtil.newVector3(0,0,dir.z>0 and 1 or -1)
		local pos = VectorUtil.toBlockVector3(player:getPosition().x, player:getPosition().y, player:getPosition().z)
		local startPos = VectorUtil.toBlockVector3(pos.x, pos.y-2, pos.z)
		local finalPos = startPos
		local canPlace = false
		for _=1,self.roadModeMaxDist do
			local blockID = EngineWorld:getBlockId(finalPos)
			if blockID == BlockID.AIR or blockID == BlockID.SNOW then
				local ok, bp, face = findBuildPos(player, finalPos, 1)
				if ok then return ok, bp, face end
			else
				finalPos = VectorUtil.add3(finalPos, step)
			end
		end
		for _, offset in pairs(faceOffsets) do
			local ok, bp, face = findBuildPos(player, VectorUtil.add3(startPos, offset), 1)
			if ok then return ok, bp, face end
		end
		return canPlace, finalPos, faceMap.North
	end

	function GMHelper:onClickScreen(x,y) currentClickPos = {x=x,y=y} end

	function GMHelper:onClickAirEvent(isClickAir)
		if not isClickAir or not currentClickPos then currentClickPos = nil return true end
		local player = PlayerManager:getClientPlayer()
		if not player then return true end
		local hitInfo = getHitInfo(player, currentClickPos)
		local startPos = VectorUtil.toBlockVector3(hitInfo.hitPos.x, hitInfo.hitPos.y-1, hitInfo.hitPos.z)
		local ok, bp, face = findBuildPos(player, startPos, 1)
		return self:placeBlock(player, bp, face, "screen")
	end

	function GMHelper:onFrontBuildBtn()
		local player = PlayerManager:getClientPlayer()
		if not player then return end
		if not player.Player.onGround then
			local pos = player.Player:getBottomPos()
			local curPos = VectorUtil.newVector3(math.floor(pos.x), math.floor(pos.y), math.floor(pos.z))
			local under1 = VectorUtil.newVector3(curPos.x, curPos.y-1, curPos.z)
			local under2 = VectorUtil.newVector3(curPos.x, curPos.y-2, curPos.z)
			local curB, uB, uB2 = EngineWorld:getBlockId(curPos), EngineWorld:getBlockId(under1), EngineWorld:getBlockId(under2)
			if curB==BlockID.AIR and uB~=BlockID.AIR then self:placeBlock(player, under1, faceMap.Under,"button")
			elseif curB==BlockID.AIR and uB==BlockID.AIR and uB2~=BlockID.AIR then self:placeBlock(player, under2, faceMap.Under,"button") end
			return
		end
		local dir = SceneManager.Instance():getMainCamera():getDirection()
		local ok, bp, face = findFrontBlock(player, dir)
		self:placeBlock(player, bp, face, "button")
	end

	function GMHelper:placeBlock(player, pos, face, src)
		if not pos or not face then return false end
		local inv = player:getInventory()
		if not inv then return end
		local stack = inv:getRealCurrentItem()
		if not stack then return false end
		local item = stack:getItem()
		if not item then return false end
		src = src or "screen"
		local placed = item:onItemUse(stack, Blockman.Instance():getPlayer(), Blockman.Instance():getWorld(), pos, face, pos)
		if placed then
			if stack:getItemStackSize()==0 then inv:decrStackSize(inv:findItemStack(stack),0) end
			player.Player:swingItem()
			player:sendPacket({pid="TryPlaceBlock", position=pos, face=face, source=src})
			return true
		end
		return false
	end

	local eventListener = {}
	function eventListener:init()
		Listener.registerCallBack(CEvents.ClickAirEvent, function(isClickAir) return GMHelper:onClickAirEvent(isClickAir) end)
		Listener.registerCallBack(CEvents.PlayerClickScreenEvent, function(x,y) GMHelper:onClickScreen(x,y) end)
	end
	eventListener:init()

	local buildBtn = GUIManager:createGUIWindow(GUIType.Button, "BuildToggleBtn")
	buildBtn:SetWidth({0,60})
	buildBtn:SetHeight({0,60})
	buildBtn:SetVisible(true)
	buildBtn:SetBackgroundColor({0.8, 0.4, 0, 1})
	buildBtn:SetTouchable(true)
	buildBtn:SetLevel(1)
	GUISystem.Instance():GetRootWindow():AddChildWindow(buildBtn)

	local label = GUIManager:createGUIWindow(GUIType.StaticText, "BuildBtnLabel")
	label:SetText("Build")
	label:SetTextHorzAlign(HorizontalAlignment.Center)
	label:SetTextVertAlign(VerticalAlignment.Center)
	label:SetWidth({0,60})
	label:SetHeight({0,60})
	label:SetVisible(true)
	label:SetTouchable(false)
	buildBtn:AddChildWindow(label)

	local clickHandler = function() GMHelper:onFrontBuildBtn() end
	buildBtn:registerEvent(GUIEvent.ButtonClick, clickHandler)
	buildBtn:registerEvent(GUIEvent.LongTouchStart, clickHandler)
	buildBtn:registerEvent(GUIEvent.TouchDown, clickHandler)
	buildBtn:registerEvent(GUIEvent.TouchUp, clickHandler)
	buildBtn:SetXPosition({0, 1210})
	buildBtn:SetYPosition({0, 355})

	togBuildMain = true
end

--- Cyberian Prime



GMSetting:addTab("xd", "Main")
GMSetting:addItem("Main", "FeatherFall", "ToggleFeatherFall")
GMSetting:addItem("Main", "AirGlide", "AirGlide")
GMSetting:addItem("Main", "Instant-Respawn", "InstantRespawn", "yellow")
GMSetting:addItem("Main", "AutoKillerTp", "AutoKill", "yellow")
GMSetting:addItem("Main", "TeleportHit", "AttackBypass", "yellow")
GMSetting:addItem("Main", "ShowHpV2", "ShowHp", "yellow")
GMSetting:addItem("Main", "NoKnockBack", "NoKnockback", "yellow")
GMSetting:addItem("Main", "AttackReach Bypass", "Atm", "yellow")
GMSetting:addItem("Main", "Respawn At Death", "UnDeath", "yellow")
GMSetting:addItem("Main", "NoFallDmg", "RemoveFallDamage", "yellow")
GMSetting:addItem("Main", "Player Xray", "ESP", "yellow")
GMSetting:addItem("Main", "Fast-Reload", "InstantReload", "yellow") 
GMSetting:addItem("Main", "Fast-Throw", "FastThrow", "yellow")
GMSetting:addItem("Main", "AttackBtn", "AtkBtn", "yellow")
GMSetting:addItem("Main", "BtnBridge", "BtnBridge", "yellow")
GMSetting:addItem("Main", "ReachPlayers", "ReachPlayers", "yellow")
GMSetting:addItem("Main", "Wall-Hacks", "WallHack", "yellow")



GMSetting:addTab("xd", "Movement / Misc")
GMSetting:addItem("Movement / Misc", "NoClip", "Noclip")
GMSetting:addItem("Movement / Misc", "Set Attack-Reach", "attack")
GMSetting:addItem("Movement / Misc", "Set Block-Reach", "block")
GMSetting:addItem("Movement / Misc", "WebMode", "BGWebMode")
GMSetting:addItem("Movement / Misc", "runcode V2", "runlol")
GMSetting:addItem("Movement / Misc", "runCode (Path)", "runCodeop")
GMSetting:addItem("Movement / Misc", "Dpad", "JumpDpad")
GMSetting:addItem("Movement / Misc", "Attack Color", "AtkColor")
GMSetting:addItem("Movement / Misc", "in the air Bypass", "bypassAir")
GMSetting:addItem("Movement / Misc", "Air Bypass V2", "bypassAirs")
GMSetting:addItem("Movement / Misc", "Speed Bypass", "Sync")
GMSetting:addItem("Movement / Misc", "Place & Break Block", "EnableBreakBlocks", "yellow")
GMSetting:addItem("Movement / Misc", "UIFucker", "UIFucker", "yellow")
GMSetting:addItem("Movement / Misc", "Unlimited Gcubes", "Money", "yellow")
GMSetting:addItem("Movement / Misc", "Chat-Proxy", "chatProxy", "yellow")
GMSetting:addItem("Movement / Misc", "Damage-Indicator", "DamageIndicator", "yellow")
GMSetting:addItem("Movement / Misc", "Manages-Signs", "workodd", "yellow")
GMSetting:addItem("Movement / Misc", "Hide-Armor", "HidingArmor", "yellow")



GMSetting:addTab("xd", "Gui / Combat")
GMSetting:addItem("Gui / Combat", "BtnAutoClicker", "ae4")
GMSetting:addItem("Gui / Combat", "BtnAimbot", "ae5")
GMSetting:addItem("Gui / Combat", "BtnJetpack", "ae1")
GMSetting:addItem("Gui / Combat", "BtnTeleportKill", "ae6")
GMSetting:addItem("Gui / Combat", "BtnFreezeEmote", "ae2")
GMSetting:addItem("Gui / Combat", "BtnHitbox", "ae3")
GMSetting:addItem("Gui / Combat", "FlyButton", "FlyButton")



GMSetting:addTab("xd", "Visuals")
GMSetting:addItem("Visuals", "▢FFFF0000Red", "SetNameColor", nil, "Red")
GMSetting:addItem("Visuals", "▢FF0000FFBlue", "SetNameColor", nil, "Blue")
GMSetting:addItem("Visuals", "▢FFFF00FFPink", "SetNameColor", nil, "Pink")
GMSetting:addItem("Visuals", "▢FF00FFFFCyan", "SetNameColor", nil, "Cyan")
GMSetting:addItem("Visuals", "▢FF00FF00Green", "SetNameColor", nil, "Green")
GMSetting:addItem("Visuals", "▢FF9600FFPurple", "SetNameColor", nil, "Purple")
GMSetting:addItem("Visuals", "▢FFFFFF00Yellow", "SetNameColor", nil, "Yellow")
GMSetting:addItem("Visuals", "▢FFFFAF00Orange", "SetNameColor", nil, "Orange")
GMSetting:addItem("Visuals", "▢FFFFD700Gold", "SetNameColor", nil, "Gold")
GMSetting:addItem("Visuals", "▢FFFFFFFFWhite", "SetNameColor", nil, "Light")
GMSetting:addItem("Visuals", "Friends", "FakeFriends")
GMSetting:addItem("Visuals", "Burnth", "Burnth")
GMSetting:addItem("Visuals", "Night Vision", "NightVision2")
GMSetting:addItem("Visuals", "Sunset", "wanxia")
GMSetting:addItem("Visuals", "Stars", "fanxing")
GMSetting:addItem("Visuals", "Sunny", "qing")
GMSetting:addItem("Visuals", "Rain", "yu")
GMSetting:addItem("Visuals", "ShootingStar", "liuxing")
GMSetting:addItem("Visuals", "Snow", "xue")

GMSetting:addTab("xd", "Vip Plates")
for i=0,10 do
  GMSetting:addItem("Vip Plates", "Vip"..i, "Vip"..i)
end
GMSetting:addItem("Vip Plates", "Vip10+", "Vip11")


GMSetting:addTab("xd", "Game & Panel")
GMSetting:addItem("Game & Panel", "What's New?", "shitto") 
GMSetting:addItem("Game & Panel", "TransBackground", "setP")
GMSetting:addItem("Game & Panel", "Hide Panel", "GM")
GMSetting:addItem("Game & Panel", "Rejoin", "RejoinGame")
GMSetting:addItem("Game & Panel", "Exit", "bye")
GMSetting:addItem("Game & Panel", "GetAllGuiName", "GUINAME")
GMSetting:addItem("Game & Panel", "Afk", "Afk") 



GMSetting:addTab("xd", "Performance")
GMSetting:addItem("Performance", "SetMaxFps", "ProSet")
GMSetting:addItem("Performance", "No Particle", "NoParticles2")
GMSetting:addItem("Performance", "FpsBoost", "FpsBoost2")



GMSetting:addTab("xd", "Chat")
GMSetting:addItem("Chat", "▢FFFF0000Red", "applyColorToChat", nil, "Red")
GMSetting:addItem("Chat", "▢FF0000FFBlue", "applyColorToChat", nil, "Blue")
GMSetting:addItem("Chat", "▢FFFF00FFPink", "applyColorToChat", nil, "Pink")
GMSetting:addItem("Chat", "▢FF00FFFFCyan", "applyColorToChat", nil, "Cyan")
GMSetting:addItem("Chat", "▢FF00FF00Green", "applyColorToChat", nil, "Green")
GMSetting:addItem("Chat", "▢FF9600FFPurple", "applyColorToChat", nil, "Purple")
GMSetting:addItem("Chat", "▢FFFFFF00Yellow", "applyColorToChat", nil, "Yellow")
GMSetting:addItem("Chat", "▢FFFFAF00Orange", "applyColorToChat", nil, "Orange")
GMSetting:addItem("Chat", "▢FFFFD700Gold", "applyColorToChat", nil, "Gold")
GMSetting:addItem("Chat", "▢00000000White", "applyColorToChat", nil, "White")
GMSetting:addItem("Chat", "ChatSpam", "SpamChatV3")
GMSetting:addItem("Chat", "Chat Hider", "ChatToggle")
GMSetting:addItem("Chat", "ChatBypass", "WordBypass", "yellow")



GMSetting:addTab("xd", "Entities")
GMSetting:addItem("Entities", "TpMobsToMe", "TpMobs")
GMSetting:addItem("Entities", "ItemThief", "ItemThief")
GMSetting:addItem("Entities", "Item Locator", "ItemLocator")



GMSetting:addTab("xd", "Credits")
GMSetting:addItem("Credits", "^FFFFFF[ Creator ]", "nil")
GMSetting:addItem("Credits", "^FF9900 ^FFFFFFCyberBG14", "nil")
GMSetting:addItem("Credits", "^00CCFF @cubercoderBMGO", "nil")
GMSetting:addItem("Credits", "^FFFFFF[ Assistant ]", "nil")
GMSetting:addItem("Credits", "^FF9900 ^FFFFFFKhd", "nil")
GMSetting:addItem("Credits", "^00CCFF @khd", "nil")
GMSetting:addItem("Credits", "^FFFFFF[ Enc & Dec ]", "nil")
GMSetting:addItem("Credits", "^FF9900 ^FFFFFFZentex", "nil")
GMSetting:addItem("Credits", "^00CCFF @Fang_Zhi_H", "nil")




GMSetting:addTab("xd", "Customize")
GMSetting:addItem("Customize", "Add Function", "cb")
GMSetting:addItem("Customize", "Remove Function", "Acb")



GMSetting:addTab("xd", "Language")
GMSetting:addItem("Language", "English", "setLanguage", "setLanguageEnglish")
GMSetting:addItem("Language", "Russian", "setLanguage", "setLanguageRussian")
GMSetting:addItem("Language", "Arabic", "setLanguage", "setLanguageArabic")
GMSetting:addItem("Language", "Chinese", "setLanguage", "setLanguageChinese")



if CGame.Instance():getGameType() == "g1047" then
    GMSetting:addTab("xd", "Realm City")
    GMSetting:addItem("Realm City", "Race All Player", "RaceAll")
end

if CGame.Instance():getGameType() == "g1015" then
    GMSetting:addTab("xd", "TreasureHunter")
    GMSetting:addItem("TreasureHunter", "Treasure Reset", "MineReset")
    GMSetting:addItem("TreasureHunter", "Treasure NoClip", "NoclipOP")
    GMSetting:addItem("TreasureHunter", "Block Reach", "block")
end

if CGame.Instance():getGameType() == "g1021" then
    GMSetting:addTab("xd", "Rainbow Parkour")
    GMSetting:addItem("Rainbow Parkour", "Map01Ptsdup", "TeleportV1")
    GMSetting:addItem("Rainbow Parkour", "Map02Ptsdup", "TeleportV2")
    GMSetting:addItem("Rainbow Parkour", "Map03Ptsdup", "TeleportV3")
    GMSetting:addItem("Rainbow Parkour", "Map04Ptsdup", "TeleportV4")
    GMSetting:addItem("Rainbow Parkour", "Enter Map01", "SwitchMap", "m1021_1", "g1021")
    GMSetting:addItem("Rainbow Parkour", "Enter Map02", "SwitchMap", "m1021_2", "g1021")
    GMSetting:addItem("Rainbow Parkour", "Enter Map03", "SwitchMap", "m1021_3", "g1021")
    GMSetting:addItem("Rainbow Parkour", "Enter Map04", "SwitchMap", "m1021_4", "g1021")
end

function GMHelper:SwitchMap(mapId, gameId)
    Game:resetGame(gameId, PlayerManager:getClientPlayer().userId, mapId)
end

local posV1 = {
    {x=256.5,y=80,z=-41.5},{x=170.5,y=83,z=-42.5},
    {x=67.5,y=83,z=-41.5},{x=-38.5,y=86,z=-42.5}
}
local indexV1 = 1
function GMHelper:TeleportV1()
    local p = posV1[indexV1]
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(p.x,p.y,p.z))
    PlayerManager:getClientPlayer().Player:moveEntity(VectorUtil.newVector3(0,0,0))
    indexV1 = indexV1 % #posV1 + 1
end

local posV2 = {
    {x=4.5,y=94,z=50.5},{x=4.5,y=28,z=87.5},
    {x=4.5,y=33,z=209.5},{x=3.5,y=33,z=251.5},
    {x=4.5,y=93,z=-6.5}
}
local indexV2 = 1
function GMHelper:TeleportV2()
    local p = posV2[indexV2]
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(p.x,p.y,p.z))
    PlayerManager:getClientPlayer().Player:moveEntity(VectorUtil.newVector3(0,0,0))
    indexV2 = indexV2 % #posV2 + 1
end

local posV3 = {
    {x=1596.5,y=10,z=-617.5},{x=1676.5,y=10,z=-617.5},
    {x=1763.5,y=10,z=-616.5},{x=1866.5,y=10,z=-618.5},
    {x=1527.5,y=10,z=-619.5},{x=1462.5,y=237,z=-617.5},
    {x=1426.5,y=237,z=-617.5},{x=1344.5,y=237,z=-617.5},
    {x=1502.5,y=237,z=-617.5}
}
local indexV3 = 1
function GMHelper:TeleportV3()
    local p = posV3[indexV3]
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(p.x,p.y,p.z))
    PlayerManager:getClientPlayer().Player:moveEntity(VectorUtil.newVector3(0,0,0))
    indexV3 = indexV3 % #posV3 + 1
end

local posV4 = {
    {x=1626.5,y=200,z=-514.5},{x=1701.5,y=11,z=-515.5},
    {x=1805.5,y=10,z=-427.5},{x=1846.5,y=250,z=-505.5},
    {x=1819.5,y=239,z=-552.5}
}
local indexV4 = 1
function GMHelper:TeleportV4()
    local p = posV4[indexV4]
    PlayerManager:getClientPlayer().Player:setPosition(VectorUtil.newVector3(p.x,p.y,p.z))
    PlayerManager:getClientPlayer().Player:moveEntity(VectorUtil.newVector3(0,0,0))
    indexV4 = indexV4 % #posV4 + 1
end

if CGame.Instance():getGameType() == "g1014" then
    GMSetting:addTab("xd", "JailBreak", 8)
    GMSetting:addItem("JailBreak", "Tp to BlackMarket", "BlackMarket")
    GMSetting:addItem("JailBreak", "Tp to Bank 1", "Bank1")
    GMSetting:addItem("JailBreak", "Tp to Bank 2", "Bank2")
    GMSetting:addItem("JailBreak", "Tp to Bank 3", "Bank3")
    GMSetting:addItem("JailBreak", "Tp to Hospital 1", "Hospital1")
    GMSetting:addItem("JailBreak", "Tp to Hospital 2", "Hospital2")
    GMSetting:addItem("JailBreak", "Tp to Mansion 1", "Mansion1")
    GMSetting:addItem("JailBreak", "Tp to Mansion 2", "Mansion2")
    GMSetting:addItem("JailBreak", "Tp to Mansion 3", "Mansion3")
    GMSetting:addItem("JailBreak", "Tp to Mall 1", "Mall1")
    GMSetting:addItem("JailBreak", "Tp to Mall 2", "Mall2")
    GMSetting:addItem("JailBreak", "Tp to Inn 1", "inn1")
    GMSetting:addItem("JailBreak", "Tp to Inn 2", "inn2")
    GMSetting:addItem("JailBreak", "ItemThief", "ItemThief")
end

if CGame.Instance():getGameType() == "g1072" then
    GMSetting:addTab("xd", "ClanWar", 8)
    GMSetting:addItem("ClanWar", "Tp to blue", "blue")
    GMSetting:addItem("ClanWar", "Tp to red", "red")
end

if CGame.Instance():getGameType() == "g1027" then
    GMSetting:addTab("xd", "SkyRoyale", 8)
    GMSetting:addItem("SkyRoyale", "yellow", "KnockBack", "KnockBackPlayer")
    GMSetting:addItem("SkyRoyale", "yellow", "Tp to blue", "blueg")
    GMSetting:addItem("SkyRoyale", "yellow", "Tp to red", "redg")
    GMSetting:addItem("SkyRoyale", "yellow", "Tp to green", "greeng")
    GMSetting:addItem("SkyRoyale", "yellow", "Tp to yellow", "yellowg")
    GMSetting:addItem("SkyRoyale", "yellow", "Skyroyale Point ( Celestial )", "reward")
    GMSetting:addItem("SkyRoyale", "yellow", "Skyroyale Point ( Highest )", "srdup")
    GMSetting:addItem("SkyRoyale", "yellow", "Skyroyale Point ( Lowest )", "lowsrdup")
    GMSetting:addItem("SkyRoyale", "yellow", "Skyroyale Point ( Random )", "srdupp")
end

if CGame.Instance():getGameType() == "g1054" then
    GMSetting:addTab("xd", "JobsTab", "^FFFF00Jobs")
    local jobs = {}
    for i = 1, 16 do
        table.insert(jobs, {text = "^00FF00Job " .. i, key = "selectJob", param = tostring(i)})
    end
    for _, item in ipairs(jobs) do
        GMSetting:addItem("JobsTab", item.text, item.key, item.param)
    end
end

function GMHelper:selectJob(jobId, text)
    local data = DataBuilder.new():addParam("JobId", tonumber(jobId)):getData()
    PacketSender:sendLuaCommonData("SelectJobId", data)
    Toast("Changed Job")
end

if CGame.Instance():getGameType() == "g1055" then
    GMSetting:addTab("xd", "WWE")
    GMSetting:addItem("WWE", "Infinite Shield", "TryAddInfShieldWWESim") 
    GMSetting:addItem("WWE", "Auto-Sell", "AutoSellWWESim") 
    GMSetting:addItem("WWE", "Auto-Heal", "AutoHeal") 
    GMSetting:addItem("WWE", "Auto-Workout", "AutoWorkout") 
    GMSetting:addItem("WWE", "Equip Sun", "EquipSun") 
end

function GMHelper:TryAddInfShieldWWESim()
    local data = DataBuilder.new():fromTable({ Time = 10000000000 }):getData()
    PacketSender:sendLuaCommonData("AddInvincibleState", data)
    Toast("Success")
end

local isAutoSell = false
local autoSellTimer = nil
function GMHelper:AutoSellWWESim()
    isAutoSell = not isAutoSell
    if isAutoSell then
        autoSellTimer = LuaTimer:scheduleTimer(function()
            local data = DataBuilder.new():fromTable({ Area = "SellArea" }):getData()
            PacketSender:sendLuaCommonData("TeleportToArea", data)
        end, 500, -1)
        Toast("Auto-Sell : On")
    else
        if autoSellTimer then
            LuaTimer:cancel(autoSellTimer)
            autoSellTimer = nil
        end
        Toast("Auto-Sell : Off")
    end
end

local isAutoHeal = false
local autoHealTimer = nil
function GMHelper:AutoHeal()
    isAutoHeal = not isAutoHeal
    if isAutoHeal then
        autoHealTimer = LuaTimer:scheduleTimer(function()
            local data1 = DataBuilder.new():addParam("index", Define.SelectSkinType.Free):getData()
            PacketSender:sendLuaCommonData("SelectSkin", data1)
            local data2 = DataBuilder.new():addParam("index", Define.SelectSkinType.Default):getData()
            PacketSender:sendLuaCommonData("SelectSkin", data2)
        end, 100, -1)
        Toast("Auto-Heal : On")
    else
        if autoHealTimer then
            LuaTimer:cancel(autoHealTimer)
            autoHealTimer = nil
        end
        Toast("Auto-Heal : Off")
    end
end

local isAutoWorkout = false
local workoutTimer = nil

function GMHelper:AutoWorkout()
    isAutoWorkout = not isAutoWorkout
    if isAutoWorkout then
        workoutTimer = LuaTimer:scheduleTimer(function()
            PacketSender:sendLuaCommonData("DoWorkout", "")
        end, 10, -1)
        Toast("Auto-WorkOut : On")
    else
        if workoutTimer then
            LuaTimer:cancel(workoutTimer)
            workoutTimer = nil
        end
        Toast("Auto-WorkOut : Off")
    end
end

function GMHelper:EquipSun()
    local data = DataBuilder.new():fromTable({ ItemId = 607, selectMode = Define.SelectMode.Equip }):getData()
    PacketSender:sendLuaCommonData("ChangeHoldItemActor", data)
    Toast("Equipped Sun")
end

--- ( Important XD)  --- 


function GMHelper:enableGM()
    if GUIGMControlPanel then
        return
    end
    GUIGMControlPanel = UIHelper.newEngineGUILayout("GUIGMControlPanel", "GMControlPanel.json")
    GUIGMControlPanel:hide()
    GUIGMMain = UIHelper.newEngineGUILayout("GUIGMMain", "GMMain.json")
    GUIGMMain:show()
    local isOpenEventDialog = ClientHelper.getBoolForKey("g1008_isOpenEventDialog", false)
    GUIGMMain:changeOpenEventDialog(isOpenEventDialog)
    if GMSetting.addItemGMItems then
        GMSetting:addItemGMItems()
        GMSetting.addItemGMItems = nil
    end
end

function GMHelper:openInput(paramTexts, callBack)
    if type(paramTexts) ~= "table" then
        return
    end
    for _, paramText in pairs(paramTexts) do
        if type(paramText) ~= "string" then
            if isClient then
                assert(true, "param need string type")
            end
            return
        end
    end    GUIGMControlPanel:openInput(paramTexts, callBack)
end



function GMHelper:callCommand(name, ...)
    local func = self[name]
    if type(func) == "function" then
        local ok, result = pcall(func, self, ...)
        if not ok then
            print("Error calling command '" .. name .. "': " .. tostring(result))
            return nil
        end
        GMSetting:changeColorByFunction(name, _G["tog" .. name])

        return result
    else
        print("Command '" .. name .. "' not found or is not a function")
        return nil
    end
end

function GMSetting:changeColorByFunction(func_name, toggle)
    for _, group in pairs(Settings) do
        for _, item in pairs(group.items) do
            if item.func == func_name then
                if toggle then
                    item.color = Color.CYAN
                else
                    item.color = Color.BLACK
                end
                if item.tvItem then
                    item.tvItem:SetBackgroundColor(item.color)
                end
                return
            end
        end
    end
end


function GMHelper:BedWars()
    local gameId = CGame.Instance():getGameType()
    
    if gameId == "g1008" then
      local GameType
if Server then
    GameType = Server.Instance():getConfig().gameType
end

if CGame then
    GameType = CGame.Instance():getGameType()
end

local mapPath
if LogicSetting.Instance():getLordPlatform() == 2 then
    mapPath = ScriptSetting.getScriptPath() .. "/map/"
else
    mapPath = Root.Instance():getRootPath() .. "/" .. ScriptSetting.getScriptPath() .. "/map/"
end
HostApi.putStringPrefs("MapRegionPath", mapPath)

IsAIGame = false

    end
end


function GMHelper:Nigus()
    local GameType
if Server then
    GameType = Server.Instance():getConfig().gameType
end

if CGame then
    GameType = CGame.Instance():getGameType()
end

local mapPath
if LogicSetting.Instance():getLordPlatform() == 2 then
    mapPath = ScriptSetting.getScriptPath() .. "/map/"
else
    mapPath = Root.Instance():getRootPath() .. "/" .. ScriptSetting.getScriptPath() .. "/map/"
end
HostApi.putStringPrefs("MapRegionPath", mapPath)

IsAIGame = false
end








--- ( Function Start ) ---

function GMHelper:WallHack(text)
    self._wallhackEnabled = not self._wallhackEnabled
    
    local color = self._wallhackEnabled and Color.CYAN or Color.BLACK
    text:SetBackgroundColor(color)
    
    local players = PlayerManager:getPlayers()
    local clientPlayer = PlayerManager:getClientPlayer()
    local wallhack = self._wallhackEnabled and 10 or 1
    
    for _, player in ipairs(players) do
        local entity = player.Player
        if player ~= clientPlayer then
            entity.height = WallHackSize
            entity.width = WallHackSize
            entity.length = WallHackSize
            entity.wallhackMultiplier = damageMultiplier
            entity.criticalGodChance = self._wallhackEnabled and 1.0 or 0.1
            entity.movementSpeed = self._wallhackEnabled and 0.1 or 1.0
            entity.visibility = self._wallhackEnabled and 2.0 or 1.0
            entity.headshot_modifier = self._wallhackEnabled and 5.0 or 1.0
        else
            entity.height = originalHeight
            entity.width = originalWidth
            entity.length = originalLength
            entity.wallhackMultiplier = 1
            entity.criticalGodChance = 0.1
            entity.movementSpeed = 1.5
            entity.visibility = 0.5
            entity.health_regen = self._wallhackEnabled and 50 or 1
            entity.infinite_ammo = self._wallhackEnabled
            entity.no_recoil = self._wallhackEnabled
        end
    end
    
    if self._wallhackEnabled then
        clientPlayer.Player.god_mode = true
        clientPlayer.Player.wall_hack = true
        clientPlayer.Player.auto_aim = true
        ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
        Toast("WallHack : On") 
        player.doubleJumpCount = math.huge + 0
    else
        clientPlayer.Player.god_mode = false
        clientPlayer.Player.wall_hack = false
        clientPlayer.Player.auto_aim = false
        Toast("WallHack : Off") 
        ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
        player.doubleJumpCount = 1
    end
end

GMHelper.knockBackEnabled = false

function GMHelper:KnockBackPlayer(text)
    GMHelper.knockBackEnabled = not GMHelper.knockBackEnabled
    
    if text and text.SetBackgroundColor then
        if GMHelper.knockBackEnabled then
            text:SetBackgroundColor(Color.CYAN) 
            Toast("Knockback : On") 
        else
            text:SetBackgroundColor(Color.BLACK) 
            Toast("Knockback : Off") 
        end
    end
    
    if GMHelper.knockBackEnabled then
        local player = PlayerManager:getClientPlayer()
        if player and player.Player then
            player.Player.m_knockBackCoefficient = 1000.0
        end
        
        local blockmanPlayer = Blockman.Instance():getPlayer()
        if blockmanPlayer then
            blockmanPlayer.m_knockBackCoefficient = 30.0
        end
    else
        local player = PlayerManager:getClientPlayer()
        if player and player.Player then
            player.Player.m_knockBackCoefficient = 1.0
        end
        
        local blockmanPlayer = Blockman.Instance():getPlayer()
        if blockmanPlayer then
            blockmanPlayer.m_knockBackCoefficient = 1.0
        end
    end
end
local AfkActive = false
local AfkStartPos = nil
local AfkStartTime = nil
local AfkTimer = nil

function AfkPosition()
    local yourself = PlayerManager:getClientPlayer()
    if yourself then
        return yourself:getPosition()
    end
    return nil
end

function GMHelper:Afk(text)
    AfkActive = not AfkActive

    if AfkActive then
        AfkStartPos = AfkPosition()
        AfkStartTime = os.time()
        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 1    
        text:SetBackgroundColor(Color.CYAN)
        Toast("AFK Mode : On")
        
        if AfkTimer then
            AfkTimer:cancel()
            AfkTimer = nil
        end
        AfkTimer = LuaTimer:scheduleTimer(function()
            if AfkActive and AfkStartPos then
                local currentPos = AfkPosition()
                if currentPos and (
                    currentPos.x ~= AfkStartPos.x or
                    currentPos.y ~= AfkStartPos.y or
                    currentPos.z ~= AfkStartPos.z
                ) then
                    local total = os.time() - AfkStartTime
                    local hours = math.floor(total / 3600)
                    local minutes = math.floor((total % 3600) / 60)
                    local seconds = total % 60
                    local formatted = string.format("%02dh %02dm %02ds", hours, minutes, seconds)

                    PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
                    Toast("You moved after " .. formatted .. ", canceling AFK Mode")
                    text:SetBackgroundColor(Color.BLACK)
                    AfkActive = false
                    AfkStartPos = nil
                    AfkStartTime = nil

                    if AfkTimer then
                        AfkTimer:cancel()
                        AfkTimer = nil
                    end
                end
            end
        end, 1000, -1) 
    else
        local total = 0
        if AfkStartTime then
            total = os.time() - AfkStartTime
        end

        local hours = math.floor(total / 3600)
        local minutes = math.floor((total % 3600) / 60)
        local seconds = total % 60
        local formatted = string.format("%02dh %02dm %02ds", hours, minutes, seconds)

        PlayerManager:getClientPlayer().Player.m_rotateSpeed = 0
        text:SetBackgroundColor(Color.BLACK)
        Toast("AFK Mode : Off (" .. formatted .. ")")

        AfkStartPos = nil
        AfkStartTime = nil

        if AfkTimer then
            AfkTimer:cancel()
            AfkTimer = nil
        end
    end
end




function GMHelper:HidingArmor(text)
   A = not A
    LogicSetting.Instance():setHideArmor(true)
    text:SetBackgroundColor(Color.CYAN)
    Toast("Armor-Visibility : On")
  if A then
    LogicSetting.Instance():setHideArmor(false)
    text:SetBackgroundColor(Color.BLACK) 
    Toast("Armor-Visibility : Off")
end
end

function GMHelper:startParachute()
  PlayerManager:getClientPlayer().Player:startParachute()
end

local CONFIG = {
    TP_DELAY = 3,
    ATTACK_DELAY = 5,
    RETURN_DELAY = 8,
    CLOSE_RANGE = 6,
    MAX_RANGE = 15,
    ATTACK_OFFSET = 0.8,
    REACH_DISTANCE = 35,
    ATTACK_TIMES = 999999999,
    DAMAGE_AMOUNT = 0.5,
    SMOOTH_ENABLED = true,
    INTERPOLATION_STEPS = 4,
    STEP_DELAY = 2,
    NO_CLIP_DURATION = 1
}

local isEnabled = true
local activeAttacks = {}

local function safeGetPlayer()
    local wrapper = PlayerManager:getClientPlayer()
    return wrapper and wrapper.Player
end

local function getTargetPlayer(entityId)
    local wrapper = PlayerManager:getPlayerByEntityId(entityId)
    return wrapper and wrapper.Player
end

local function calculateDistance(pos1, pos2)
    if not pos1 or not pos2 then return math.huge end
    local dx, dy, dz = pos2.x - pos1.x, pos2.y - pos1.y, pos2.z - pos1.z
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

local function findOptimalY(x, z, startY)
    local safeY = math.max(startY, 8)
    local maxY = math.min(safeY + 15, 255)
    for y = safeY, maxY do
        local currentBlock = EngineWorld:getBlockId({x = x, y = y, z = z})
        local aboveBlock = EngineWorld:getBlockId({x = x, y = y + 1, z = z})
        local above2Block = EngineWorld:getBlockId({x = x, y = y + 2, z = z})
        if currentBlock ~= BlockID.AIR and 
           aboveBlock == BlockID.AIR and 
           above2Block == BlockID.AIR then
            return y + 1
        end
    end
    return math.max(startY, 10)
end

local function instantTP(player, targetPos, isReturn)
    if not player or not targetPos or targetPos.y < 5 then return false end
    local safeY = findOptimalY(targetPos.x, targetPos.z, targetPos.y)
    local finalPos = VectorUtil.newVector3(targetPos.x, safeY, targetPos.z)
    player.noClip = true
    player:setPosition(finalPos)
    local noClipTime = isReturn and 40 or CONFIG.NO_CLIP_DURATION
    LuaTimer:scheduleTimer(function()
        if player then
            player.noClip = false
        end
    end, noClipTime, 1)
    return true
end

local function smoothTP(player, startPos, endPos, callback)
    if not CONFIG.SMOOTH_ENABLED or not player or not startPos or not endPos then
        local success = instantTP(player, endPos)
        if callback then callback(success) end
        return
    end
    local steps = CONFIG.INTERPOLATION_STEPS
    local currentStep = 0
    player.noClip = true
    local function interpolateStep()
        if currentStep >= steps then
            player:setPosition(VectorUtil.newVector3(endPos.x, endPos.y, endPos.z))
            LuaTimer:scheduleTimer(function()
                if player then player.noClip = false end
            end, CONFIG.NO_CLIP_DURATION, 1)
            if callback then callback(true) end
            return
        end
        local t = currentStep / steps
        local smoothT = t * t * (3 - 2 * t)
        local interpPos = {
            x = startPos.x + (endPos.x - startPos.x) * smoothT,
            y = startPos.y + (endPos.y - startPos.y) * smoothT,
            z = startPos.z + (endPos.z - startPos.z) * smoothT
        }
        player:setPosition(VectorUtil.newVector3(interpPos.x, interpPos.y, interpPos.z))
        currentStep = currentStep + 1
        LuaTimer:scheduleTimer(interpolateStep, CONFIG.STEP_DELAY, 1)
    end
    interpolateStep()
end

local function forceAttack(clientPlayer, targetEntityId)
    ClientHelper.putFloatPrefs("EntityReachDistance", CONFIG.REACH_DISTANCE)
    ClientHelper.putBoolPrefs("EntityReachEnabled", true)
    ClientHelper.putIntPrefs("AttackCheatTimes", CONFIG.ATTACK_TIMES)
    ClientHelper.putBoolPrefs("NoAttackCooldown", true)
    clientPlayer:setIntProperty("AttackCheatTimes", CONFIG.ATTACK_TIMES)
    clientPlayer:setFloatProperty("EntityReachDistance", CONFIG.REACH_DISTANCE)
    clientPlayer:setBoolProperty("NoAttackCooldown", true)
    local targetPlayer = getTargetPlayer(targetEntityId)
    if not targetPlayer then return false end
    local attackSuccess = false
    local attackCount = 0
    for attempt = 1, 3 do
        if clientPlayer.attackEntity then
            clientPlayer:attackEntity(targetPlayer)
            attackSuccess = true
            attackCount = attackCount + 1
        end
        local damageMethods = {
            function() return targetPlayer.hurt and targetPlayer:hurt(CONFIG.DAMAGE_AMOUNT) end,
            function() return targetPlayer.takeDamage and targetPlayer:takeDamage(CONFIG.DAMAGE_AMOUNT) end,
            function()
                if targetPlayer.setHealth then
                    local health = targetPlayer:getHealth() or 100
                    targetPlayer:setHealth(math.max(0, health - CONFIG.DAMAGE_AMOUNT))
                    return true
                end
            end,
            function()
                if targetPlayer.entity and targetPlayer.entity.hurt then
                    targetPlayer.entity:hurt(CONFIG.DAMAGE_AMOUNT)
                    return true
                end
            end
        }
        for _, method in ipairs(damageMethods) do
            if method() then
                attackSuccess = true
                attackCount = attackCount + 1
            end
        end
        if CEvents then
            if CEvents.PlayerAttackEvent then
                CEvents.PlayerAttackEvent:fire(targetEntityId)
                attackSuccess = true
                attackCount = attackCount + 1
            end
            if CEvents.AttackEntityEvent then
                CEvents.AttackEntityEvent:fire(targetEntityId)
                attackSuccess = true
                attackCount = attackCount + 1
            end
        end
        if attempt < 3 then
            LuaTimer:scheduleTimer(function() end, 3, 1)
        end
    end
    return attackSuccess, attackCount
end

local function getAttackPosition(targetPos)
    local offsets = {
        {x = CONFIG.ATTACK_OFFSET, z = 0},
        {x = -CONFIG.ATTACK_OFFSET, z = 0},
        {x = 0, z = CONFIG.ATTACK_OFFSET},
        {x = 0, z = -CONFIG.ATTACK_OFFSET},
        {x = CONFIG.ATTACK_OFFSET * 0.7, z = CONFIG.ATTACK_OFFSET * 0.7},
        {x = -CONFIG.ATTACK_OFFSET * 0.7, z = -CONFIG.ATTACK_OFFSET * 0.7}
    }
    for _, offset in ipairs(offsets) do
        local pos = {
            x = targetPos.x + offset.x,
            y = targetPos.y,
            z = targetPos.z + offset.z
        }
        local blockId = EngineWorld:getBlockId({
            x = math.floor(pos.x),
            y = math.floor(pos.y),
            z = math.floor(pos.z)
        })
        if not blockId or blockId == BlockID.AIR then
            return pos
        end
    end
    return {
        x = targetPos.x,
        y = targetPos.y + 1.5,
        z = targetPos.z
    }
end

local function executeLongRangeAttack(clientPlayer, targetEntityId, originalPos, targetPos)
    local distance = calculateDistance(originalPos, targetPos)
    local attackId = tostring(targetEntityId) .. "_" .. tostring(os.time())
    if activeAttacks[targetEntityId] then
        Toast("Attack in progress...")
        return
    end
    activeAttacks[targetEntityId] = true
    local attackPos = getAttackPosition(targetPos)
    Toast("Fast TP attack: " .. math.floor(distance) .. "m")
    LuaTimer:scheduleTimer(function()
        if not clientPlayer then
            activeAttacks[targetEntityId] = nil
            return
        end
        smoothTP(clientPlayer, originalPos, attackPos, function(tpSuccess)
            if tpSuccess then
                Toast("Teleported! Striking...")
                LuaTimer:scheduleTimer(function()
                    local attackSuccess, attackCount = forceAttack(clientPlayer, targetEntityId)
                    if attackSuccess then
                        Toast("HIT! " .. (attackCount or 0) .. " strikes")
                    else
                        Toast("Attack executed")
                    end
                    LuaTimer:scheduleTimer(function()
                        smoothTP(clientPlayer, attackPos, originalPos, function(returnSuccess)
                            if returnSuccess then
                                Toast("Returned instantly")
                            else
                                Toast("Return completed")
                            end
                            activeAttacks[targetEntityId] = nil
                        end)
                    end, CONFIG.RETURN_DELAY, 1)
                end, CONFIG.ATTACK_DELAY, 1)
            else
                Toast("TP failed - trying direct attack")
                local attackSuccess, attackCount = forceAttack(clientPlayer, targetEntityId)
                if attackSuccess then
                    Toast("Direct reach hit! " .. (attackCount or 0) .. " strikes")
                end
                activeAttacks[targetEntityId] = nil
            end
        end)
    end, CONFIG.TP_DELAY, 1)
end

local function executeCloseRangeAttack(clientPlayer, targetEntityId, distance)
    ClientHelper.putFloatPrefs("EntityReachDistance", CONFIG.REACH_DISTANCE)
    ClientHelper.putIntPrefs("AttackCheatTimes", CONFIG.ATTACK_TIMES)
    ClientHelper.putBoolPrefs("NoAttackCooldown", true)
    clientPlayer:setIntProperty("AttackCheatTimes", CONFIG.ATTACK_TIMES)
    clientPlayer:setBoolProperty("NoAttackCooldown", true)
    local attackSuccess, attackCount = forceAttack(clientPlayer, targetEntityId)
    if attackSuccess then
        Toast("Close hit! " .. (attackCount or 0) .. " strikes (" .. math.floor(distance) .. "m)")
    else
        Toast("Close attack attempted")
    end
end

function GMHelper:ReachPlayers(text)
    isEnabled = not isEnabled
    text:SetBackgroundColor(isEnabled and Color.CYAN or Color.BLACK)
    if not isEnabled then
        activeAttacks = {}
        Toast("Fast TP Reach : Off")
        return
    end
    Toast("Ultra-Fast Smooth TP Attack : On")
    CEvents.AttackEntityEvent:registerCallBack(function(targetEntityId)
        if not isEnabled then return end
        local clientPlayer = safeGetPlayer()
        if not clientPlayer then return end
        local targetPlayer = getTargetPlayer(targetEntityId)
        if not targetPlayer then return end
        local originalPos = clientPlayer:getPosition()
        local targetPos = targetPlayer:getPosition()
        if not originalPos or not targetPos then return end
        local distance = calculateDistance(originalPos, targetPos)
        if distance <= CONFIG.CLOSE_RANGE then
            executeCloseRangeAttack(clientPlayer, targetEntityId, distance)
        elseif distance <= CONFIG.MAX_RANGE then
            executeLongRangeAttack(clientPlayer, targetEntityId, originalPos, targetPos)
        else
            Toast("TOO FAR: " .. math.floor(distance) .. "m (max: " .. CONFIG.MAX_RANGE .. "m)")
        end
    end)
end

function GMHelper:CleanupReachPlayers()
    isEnabled = false
    activeAttacks = {}
    ClientHelper.putFloatPrefs("EntityReachDistance", 4)
    ClientHelper.putBoolPrefs("EntityReachEnabled", false)
    ClientHelper.putIntPrefs("AttackCheatTimes", 1)
    ClientHelper.putBoolPrefs("NoAttackCooldown", false)
    Toast("Fast TP Reach cleaned up")
end


function GMHelper:DamageIndicator(text)
    togDamageIndicator = not togDamageIndicator
    lastInfo = lastInfo or {}

    if togDamageIndicator then
        Di_call = function(entityId)
            local targetPlayer = PlayerManager:getPlayerByEntityId(entityId)
            if not targetPlayer then return end

            local entityPos = targetPlayer:getPosition()
            local myPos = PlayerManager:getClientPlayer():getPosition()
            entityPos.y = entityPos.y + 0.7

            local currentHp = targetPlayer:getHealth()
            if not lastInfo[entityId] then
                lastInfo[entityId] = { hp = currentHp }
                return
            end

            local damageTaken = lastInfo[entityId].hp - currentHp
            lastInfo[entityId].hp = currentHp
            if damageTaken <= 0 then return end

            local formatted = math.floor(damageTaken)
            if VectorUtil.distance(myPos, entityPos) <= 80 then
                local size = formatted > 2 and 2 or 1
                WorldImageRender.Instance():addFloatNumber(formatted, entityPos, 0.7, size)
            end
        end

        CEvents.AttackEntityEvent:registerCallBack(Di_call)
        Toast("Damage indicator: On")
        text:SetBackgroundColor(Color.CYAN)
    else
        if Di_call then
            CEvents.AttackEntityEvent:unregisterCallBack(Di_call)
        end
        Di_call = nil
        Toast("Damage indicator: Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end

local function getHpColorByMissingHp(missingHp)
    if missingHp > 15 then
        return "▢FFFF1F1F"
    elseif missingHp > 5 then
        return "▢FFFFFF00"
    else
        return "▢FF00FF00"
    end
end

function GMHelper:ShowHp(text)
    self.ShowHpEnabled = not self.ShowHpEnabled

    if self.ShowHpEnabled then
        text:SetBackgroundColor(Color.CYAN)
        Toast("ShowHpV2 : On") 

        self.ShowHpTimer = LuaTimer:scheduleTimer(function()
            for _, playerData in ipairs(PlayerManager:getPlayers() or {}) do
                local player = playerData.Player
                if player then
                    local curHp = math.floor(player:getHealth() + 0.5)
                    local maxHp = math.floor(player:getMaxHealth() + 0.5)
                    local missingHp = maxHp - curHp

                    local colorCode = getHpColorByMissingHp(missingHp)
                    local hpLine = colorCode .. tostring(curHp) .. " ♥"

                    local showName = player:getShowName() or ""
                    local nameList = StringUtil.split(showName, "\n") or {}

                    for i = #nameList, 1, -1 do
                        if string.find(nameList[i], "♥") then
                            table.remove(nameList, i)
                        end
                    end

                    table.insert(nameList, hpLine)
                    player:setShowName(table.concat(nameList, "\n"))
                end
            end
        end, 50, -1)

    else
        text:SetBackgroundColor(Color.BLACK)
        Toast("ShowHpV2 : Off") 

        if self.ShowHpTimer then
            LuaTimer:cancel(self.ShowHpTimer)
            self.ShowHpTimer = nil
        end

        for _, playerData in ipairs(PlayerManager:getPlayers() or {}) do
            local player = playerData.Player
            if player then
                local showName = player:getShowName() or ""
                local nameList = StringUtil.split(showName, "\n") or {}

                for i = #nameList, 1, -1 do
                    if string.find(nameList[i], "♥") then
                        table.remove(nameList, i)
                    end
                end

                player:setShowName(table.concat(nameList, "\n"))
            end
        end
    end
end


local playerNameCache = {}
local chatProxyTimer = nil
local chatProxyOn = false
local loginCallback = nil
local logoutCallback = nil

function GMHelper:chatProxy(text)
    chatProxyOn = not chatProxyOn

    if chatProxyOn then
        Toast("Chat-Proxy : On")
        text:SetBackgroundColor(Color.CYAN)

        for _, player in pairs(PlayerManager:getPlayers()) do
            local userId = player.userId
            playerNameCache[userId] = player.name
        end

        loginCallback = CEvents.PlayerLoginEvent:registerCallBack(function(userId)
            if not chatProxyOn then return end
            local player = PlayerManager:getPlayerByUserId(userId)
            if player then
                playerNameCache[userId] = player.name
                local date = os.date("^FFFF00[%Y-%m-%d]")
                MsgSender.sendMsg(date .. "^00FF00 Player Joined : ^FFFF00 Name = ^FFFFFF" .. player.name .. "^FFFF00 UserId = ^FFFFFF" .. userId)
            end
        end)

        logoutCallback = CEvents.PlayerLogoutEvent:registerCallBack(function(userId)
            if not chatProxyOn then return end
            local name = playerNameCache[userId] or ("UserId-" .. userId)
            local date = os.date("^FF0000[%Y-%m-%d]")
            MsgSender.sendMsg(date .. "^FF0000 Player Left : ^FFFF00 Name = ^FFFFFF" .. name .. "^FF0000 UserId = ^FFFFFF" .. userId)
        end)

        chatProxyTimer = LuaTimer:scheduleRepeat(function()
            if not chatProxyOn then return end
            for _, player in pairs(PlayerManager:getPlayers()) do
                local userId = player.userId
                if not playerNameCache[userId] then
                    playerNameCache[userId] = player.name
                end
            end
        end, 5)

    else
        Toast("Chat-Proxy : Off")
        text:SetBackgroundColor(Color.BLACK)

        if chatProxyTimer then
            LuaTimer:cancelTimer(chatProxyTimer)
            chatProxyTimer = nil
        end

        if loginCallback then
            CEvents.PlayerLoginEvent:unregisterCallBack(loginCallback)
            loginCallback = nil
        end

        if logoutCallback then
            CEvents.PlayerLogoutEvent:unregisterCallBack(logoutCallback)
            logoutCallback = nil
        end

        playerNameCache = {}
    end
end








function GMHelper:KillAura(text)
    self.KillAuraEnabled = not self.KillAuraEnabled

    if self.KillAuraEnabled then
        Toast("Kill-Aura : On")
        text:SetBackgroundColor(Color.CYAN)
        self.data.color = Color.CYAN

        self.KillAuraTimer = LuaTimer:scheduleTimer(function()
            local me = PlayerManager:getClientPlayer()
            if not me or not me.Player then return end

            local myPos = me.Player:getPosition()
            local myTeamId = me:getTeamId()
            local players = PlayerManager:getPlayers()

            local closestPlayer, minDist = nil, math.huge

            for _, p in pairs(players) do
                if p ~= me and p.Player and p:getTeamId() ~= myTeamId then
                    local dist = MathUtil:distanceSquare2d(p.Player:getPosition(), myPos)
                    if dist <= 75 and dist < minDist then
                        closestPlayer, minDist = p, dist
                    end
                end
            end

            if closestPlayer and closestPlayer.Player then
                local e = closestPlayer.Player
                e.width, e.length, e.height = 5, 5, 5
                CGame.Instance():handleTouchClick(800, 360)
                Toast("PlayerInfo: " .. (closestPlayer:getName() or "Unknown"))
            end
        end, 100, -1)

    else
        Toast("Kill-Aura : Off")
        text:SetBackgroundColor(Color.BLACK)
        self.data.color = Color.BLACK

        if self.KillAuraTimer then
            LuaTimer:cancel(self.KillAuraTimer)
            self.KillAuraTimer = nil
        end

        for _, p in pairs(PlayerManager:getPlayers()) do
            if p.Player then
                p.Player.width, p.Player.length, p.Player.height = 0.1, 0.1, 0.1
            end
        end
    end
end


function GMHelper:bye()
Toast("See ya later") 
CGame.Instance():exitGame("normal")
end

function GMHelper:EnableBreakBlocks(text)
    local curWorld = EngineWorld:getWorld()
    local playerPeer = PlayerManager:getClientPlayer()
    local innerPlayer = playerPeer.Player
    local pos = playerPeer:getPosition()
    local yaw = playerPeer:getYaw()
    local inv = playerPeer:getInventory()
    local invSize = 64
    local debugCount = 0

    local function breakBlock(rakssid, blockId, vec3)
        curWorld:destroyBlock(vec3, true)
        for i = 0, invSize do
            local curItemId = inv:getItemStackInfo(i).id
            if curItemId == blockId then
                inv:decrStackSize(i, -1)
                return true
            elseif curItemId == nil or curItemId == 0 then
                inv:addItemToInventory(Item.getItemById(blockId), 1)
                return true
            else
                debugCount = debugCount + 1
            end
        end
        curWorld:spawnItemInWorld(blockId, 1, 0, 480, vec3, VectorUtil.ZERO, false, true)
        return true
    end

    local function placeBlock(rakssid, itemId, meta, toPlacePos)
        local vec3 = VectorUtil.newVector3(toPlacePos.x, toPlacePos.y + 1, toPlacePos.z)
        EngineWorld:setBlock(vec3, inv:getItemStackInfo(inv:getCurrentItemIndex()).id)
        inv:decrStackSize(inv:getCurrentItemIndex(), 1)
        return true
    end

    togEnableBreakBlocks = not togEnableBreakBlocks

    if togEnableBreakBlocks then
        CEvents.BlockBreakEvent:registerCallBack(breakBlock)
        CEvents.PlayerPlaceBlockEvent:registerCallBack(placeBlock)
        Toast("Place & Break Block : On")
        text:SetBackgroundColor(Color.CYAN)
    else
        CEvents.BlockBreakEvent:unregisterCallBack(breakBlock)
        CEvents.PlayerPlaceBlockEvent:unregisterCallBack(placeBlock)
        Toast("Place & Break Block : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end

function GMHelper:Noclip(text)
   A = not A
    for blockId = 1, 40000 do
        local block = BlockManager.getBlockById(blockId)
        if block then
			block:setBlockBounds(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        end
		    end
   if A then
	Toast("Noclip : On")
	text:SetBackgroundColor(Color.CYAN)
     return
   end
    for blockId = 1, 40000 do
        local block = BlockManager.getBlockById(blockId)
        if block then
			block:setBlockBounds(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)
        end
		    end
	Toast("Noclip : Off")
	text:SetBackgroundColor(Color.BLACK)
end




function GMHelper:bypassAirs(text)
  local player = PlayerManager:getClientPlayer()
  EnableJump = not EnableJump
  player.Player:setFloatProperty("JumpHeight", 0.42)
  player.doubleJumpCount = 1
  LuaTimer:cancel(packettimer)
  Toast("AirBypass : Off")
  text:SetBackgroundColor(Color.BLACK)

  if EnableJump then
    player.Player:setFloatProperty("JumpHeight", 0.50)
    player.doubleJumpCount = 99999999999999999
    packettimer = LuaTimer:scheduleTimer(function()
      player:sendPacket({
        pid = "usingHollowBlock"
      })
    end, 200, -1)
    Toast("AirBypass : On")
    text:SetBackgroundColor(Color.CYAN)
  end
end

function GMHelper:Sync(text)
    Boredomhitsdiff = not Boredomhitsdiff
    LuaTimer:cancel(JiangXiProNoKap)
    text:SetBackgroundColor(Color.CYAN)

    if Boredomhitsdiff then
        Toast("Speed Bypass : On")
        JiangXiProNoKap = LuaTimer:scheduleTimer(function()
            local JiangXiTheClient = PlayerManager:getClientPlayer()
            if JiangXiTheClient then
                local imboredashell = VectorUtil.newVector3(JiangXiTheClient:getPosition().x, JiangXiTheClient:getPosition().y + 1, JiangXiTheClient:getPosition().z)
                JiangXiTheClient:sendPacket({
                    pid = "BedWarPlayerMotion",
                    motion = imboredashell
                })
            end
        end, 5, -1)
    else
        Toast("Speed Bypass : Off")
    end
end


function GMHelper:BWInfReach()
    ClientHelper.putFloatPrefs("EntityReachDistance", 9999)
    Toast("Reach Player BW")

    CEvents.AttackEntityEvent:registerCallBack(function(entityUser)
        local player = PlayerManager:getClientPlayer()
        if not player then return end

        local mypos = player:getPosition()
        local attacked = PlayerManager:getPlayerByEntityId(entityUser)
        if not attacked then return end

        local yaw = player:getYaw()
        local newPos = attacked:getPosition()
        local param = string.format("%f,%f,%f,%f", newPos.x, newPos.y, newPos.z, yaw)
        player:sendPacket({
            pid = "PlayerTicketTipGo",
            type = 1,
            param = param
        })

        LuaTimer:schedule(function()
            self:TeleportXXD(mypos)
        end, 10)
    end)
end

function GMHelper:TeleportXXD(mypos)
    local player = PlayerManager:getClientPlayer()
    if not player then return end

    local yaw = player:getYaw()
    local param = string.format("%f,%f,%f,%f", mypos.x, mypos.y - 2, mypos.z, yaw)
    player:sendPacket({
        pid = "PlayerTicketTipGo",
        type = 1,
        param = param
    })
end






--- <<< === mayhem parts of the GM-Hider, KYRO-<Creation === >>>




function FadedGm(bruh)
    if bruh then
        bruh:SetVisible(false) 
    end
end

function ShowGm(bruhh)
    if bruhh then
        bruhh:SetVisible(true) 
    end
end

function GMHelper:GM(text)
    A = not A

    local Ping = GUIManager:getWindowByName("GUIRoot-Ping")
    local CPS = GUIManager:getWindowByName("CpsCounterCyberPro")
    local Pose = GUIManager:getWindowByName("GUIRoot-Pose")
    local FPS  = GUIManager:getWindowByName("GUIRoot-Fps")
    local GMA = GUIManager:getWindowByName("Open-Button") 

    if A then
        Toast("Hide Panel: On")
        FadedGm(Ping) 
        FadedGm(CPS) 
        FadedGm(Pose) 
        FadedGm(FPS) 
        FadedGm(GMA) 
        GUIGMMain:setTransparent()
        if text then text:SetBackgroundColor(Color.CYAN) end
    else
        ShowGm(Ping) 
        ShowGm(CPS) 
        ShowGm(Pose) 
        ShowGm(FPS) 
        ShowGm(GMA) 
        Toast("Hide Panel: Off")
        if text then text:SetBackgroundColor(Color.BLACK) end
    end
end







function GMHelper:BWBypass(text)
    local A = not A
    if A then
        ClientHelper.putIntPrefs("ClientHelper.RunLimitCheck", 9999)
        Toast("JailBreak Bypass : On")
        text:SetBackgroundColor(Color.CYAN)
        RootGuiLayout.Instance():showMainControl()
        
        local Timer = LuaTimer:scheduleTimer(function()
            local Client = PlayerManager:getClientPlayer()
            Client:sendPacket({pid = "BedWarPlayerMotion"})
        end, 900, -1)
        
    else
        ClientHelper.putIntPrefs("ClientHelper.RunLimitCheck", 0)
        Toast("JailBreak Bypass : Off")
        text:SetBackgroundColor(Color.BLACK)
        LuaTimer:cancel(Timer)
    end
end





function GMHelper:Roast()
    local ChatService = T(Global, "ChatService")
    AZ = not AZ

    local roasts = {
        "You're like a cloud. When you disappear, it's a beautiful day.",
        "Your secrets are safe with me. I never even listen when you tell me them.",
        "You're proof that even failures can succeed.",
        "You bring everyone so much joy... when you leave the room.",
        "You have something on your chin... no, the third one down.",
        "You're like a software update. Whenever I see you, I think, 'Not now.'",
        "You have something in your teeth... the gap!",
        "Nigga your so ugly that everyone clicked ''Decline''", 
        "Your so black that I cannot see u in the night", 
        "You're the reason shampoo bottles have instructions.",
        "Your so fat that when u jumped The earth splitted", 
        "Your secrets are safe with me. I never remember them anyway.",
        "You have something on your mind. It's called 'nothing.'"
    }

    if AZ then
        lmaoes = LuaTimer:scheduleTimer(function()
            local randomRoast = roasts[math.random(1, #roasts)]
            local data = { content = randomRoast }
            ChatService:sendMsgToSameServer(Define.ChatMsgType.TextMsg, data)
        end, 50, -1)
    else
        if lmaoes then
            LuaTimer:cancel(lmaoes)
            lmaoes = nil
        end
    end
end




function GMHelper:AlphaSpam()
    local ChatService = T(Global, "ChatService")
    AZ = not AZ
    if AZ then
        lmaoes = LuaTimer:scheduleTimer(function()
            local randomText = ""
            for i = 1, math.random(50, 100) do
                randomText = randomText .. string.char(math.random(65, 90)) 
                if math.random(0, 1) == 1 then
                    randomText = randomText .. string.char(math.random(97, 122))
                end
            end
            local data = { content = randomText }
            ChatService:sendMsgToSameServer(Define.ChatMsgType.TextMsg, data)
        end, 50, -1)
    else
        if lmaoes then
            LuaTimer:cancel(lmaoes)
            lmaoes = nil
        end
    end
end

function GMHelper:ChatSpammerOwO()
    local ChatService = T(Global, "ChatService")
    AZ = not AZ
    if AZ then
        GMHelper:openInput({ "" }, function(customText)
            lmaoes = LuaTimer:scheduleTimer(function()
                local data = { content = customText }
                ChatService:sendMsgToSameServer(Define.ChatMsgType.TextMsg, data)
            end, 50, -1)
        end)
    else
        if lmaoes then
            LuaTimer:cancel(lmaoes)
            lmaoes = nil
        end
    end
end

function GMHelper:AutoKill(text)
    O = not O
    if O then
        text:SetBackgroundColor(Color.CYAN)
        Toast("AutoKillerTp: On")
        LuaTimer:cancel(Pro)
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
        Auto = LuaTimer:scheduleTimer(function()
            local player = PlayerManager:getClientPlayer().Player
            local entities = PlayerManager:getPlayers()
            for _, entity in pairs(entities) do
                if entity ~= player then
                    Bozo = LuaTimer:scheduleTimer(function()
                        local position = VectorUtil.newVector3(entity:getPosition().x, entity:getPosition().y + 10, entity:getPosition().z)
                        player:setPosition(position)
                    end, 10, 1000)
                end
            end
        end, 1000, -1)
    else
        text:SetBackgroundColor(Color.BLACK)
        Toast("AutoKillerTp: Off")
        LuaTimer:cancel(Auto)
        LuaTimer:cancel(Bozo)
        Pro = LuaTimer:scheduleTimer(function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        end, 1000, -1)
    end
end



GMHelper.noFallDamageEnabled = false
GMHelper.noFallDamageTimer = nil
GMHelper.fallDamageProtectionTimer = nil
GMHelper.previousY = nil
GMHelper.rangeCheck = 2

function GMHelper:RemoveFallDamage(text)
    self.noFallDamageEnabled = not self.noFallDamageEnabled

    if not self.noFallDamageEnabled then
        if self.noFallDamageTimer then
            LuaTimer:cancel(self.noFallDamageTimer)
            self.noFallDamageTimer = nil
        end

        if self.fallDamageProtectionTimer then
            LuaTimer:cancel(self.fallDamageProtectionTimer)
            self.fallDamageProtectionTimer = nil
        end

        local player = PlayerManager:getClientPlayer().Player
        player.noClip = false
        self.previousY = nil
        text:SetBackgroundColor(Color.BLACK)
        return
    end

    text:SetBackgroundColor(Color.CYAN)

    self.noFallDamageTimer = LuaTimer:scheduleTimer(function()
        local player = PlayerManager:getClientPlayer().Player
        local currentY = player:getPosition().y

        if not self.previousY then
            self.previousY = currentY
        end

        player.noClip = currentY < self.previousY - 1.0
        self.previousY = currentY
    end, 100, -1)

    self.fallDamageProtectionTimer = LuaTimer:scheduleTimer(function()
        local player = PlayerManager:getClientPlayer()
        local fallDistance = player.Player.fallDistance

        if fallDistance > 3 then
            local playerPos = player:getPosition()
            local blockFound = false
            local blockBeneath = nil

            for i = 1, self.rangeCheck do
                local blockBelow = VectorUtil.newVector3(playerPos.x, playerPos.y - i, playerPos.z)
                if EngineWorld:getBlockId(blockBelow) ~= 0 then
                    blockFound = true
                    blockBeneath = blockBelow
                    break
                end
            end

            if blockFound then
                local currentPos = player:getPosition()
                player.Player.noClip = true

                if currentPos.y <= blockBeneath.y + 1.0 then
                    local newY = currentPos.y + 1.3
                    player.Player:setPosition(VectorUtil.newVector3(currentPos.x, newY, currentPos.z))
                    local tempBlockPos = VectorUtil.newVector3(currentPos.x, newY - 0.1, currentPos.z)
                    EngineWorld:setBlock(tempBlockPos, 8)
                    EngineWorld:setBlockToAir(tempBlockPos)
                    player.Player.noClip = false
                end
            end
        end
    end, 0.5, -1)
end


function GMHelper:NoKnockback(text)
    NoKnockbackEnabled = not NoKnockbackEnabled
    if NoKnockbackEnabled then
        text:SetBackgroundColor(Color.CYAN)
        self.data.color = Color.BLUE
        Toast("No Knockback : On")
        lastPosition = nil
        lastHealth = nil

        NoKnockbackTimer = LuaTimer:scheduleTimer(function()
            local player = PlayerManager:getClientPlayer()
            if not player or not player.Player then
                print("Player object not found!")
                return
            end
            local currentHealth = player.Player:getHealth()
            local currentPosition = player.Player:getPosition()
            if lastHealth and currentHealth < lastHealth then
                if lastPosition then
                    player.Player:setPosition(lastPosition)
                end
            end
            lastHealth = currentHealth
            lastPosition = currentPosition
        end, 10, -1)
    else
        text:SetBackgroundColor(Color.BLACK)
        self.data.color = Color.BLACK
        Toast("No Knockback : Off")
        if NoKnockbackTimer then
            LuaTimer:cancel(NoKnockbackTimer)
            NoKnockbackTimer = nil
        end
        lastPosition = nil
        lastHealth = nil
    end
end

function GMHelper:AtkBtn(text)
local AtkBtn = GUIManager:getWindowByName("Main-Gun-Operate-RightShootBtn")
    A = not A

    if A then
        A = true
        local throwpotControls = GUIManager:getWindowByName("Main-throwpot-Controls")
        throwpotControls:SetVisible(true)
        throwpotControls:SetXPosition({0, 0})
        throwpotControls:SetYPosition({0, -170})
        
        if AtkBtn then
            AtkBtn:SetVisible(true)
            AtkBtn:SetAlwaysOnTop(true)
            AtkBtn:SetLevel(1)
            Toast("AtkBtn : On") 
            text:SetBackgroundColor(Color.CYAN)

            local mainLayout = GUIManager:getWindowByName("Main")
            if mainLayout then
                mainLayout:AddChildWindow(AtkBtn)
            end
            
            AtkBtn:SetYPosition({0, 400})
            AtkBtn:SetProperty("NormalImage", "set:main_btn.json image:skill_btn")
            AtkBtn:SetProperty("PushedImage", "set:main_btn.json image:skill_btn")
            AtkBtn:SetXPosition({1, -355})
            AtkBtn:SetHeight({0, 120})
            AtkBtn:SetWidth({0, 120})
            
            AtkBtn:setEnableLongTouch(true)
            AtkBtn:SetProperty("EnableBlockBreaking", "True")

            local function enableCollimatorMode()
                Blockman.Instance().m_gameSettings:setCollimatorMode(true)
                GUIManager:getWindowByName("Main-BedWar-BowShoot-Operate"):SetVisible(true)
                GUIManager:getWindowByName("Main-BedWar-BowShoot-CrossHairs"):SetVisible(true)
                CGame.Instance():handleTouchClick(1, 1)
            end

            local function disableCollimatorMode()
                Blockman.Instance().m_gameSettings:setCollimatorMode(false)
                GUIManager:getWindowByName("Main-BedWar-BowShoot-Operate"):SetVisible(false)
                GUIManager:getWindowByName("Main-BedWar-BowShoot-CrossHairs"):SetVisible(false)
            end

            AtkBtn:registerEvent(GUIEvent.DragStart, enableCollimatorMode)
            AtkBtn:registerEvent(GUIEvent.LongTouchStart, enableCollimatorMode)
            AtkBtn:registerEvent(GUIEvent.LongTouchEnd, enableCollimatorMode)
            AtkBtn:registerEvent(GUIEvent.ButtonClick, enableCollimatorMode)
            AtkBtn:registerEvent(GUIEvent.TouchMove, enableCollimatorMode)
            AtkBtn:registerEvent(GUIEvent.Release, disableCollimatorMode)
            AtkBtn:registerEvent(GUIEvent.TouchUp, disableCollimatorMode)
        else
            print("Shoot button not found!")
        end
    else
        A = false
        if AtkBtn then
            AtkBtn:SetVisible(false)
            Toast("AtkBtn : Off") 
            text:SetBackgroundColor(Color.BLACK)
        else
            print("Shoot button not found!")
        end
    end
end



function GMHelper:bypassAir(text)
local no = 0.0
local calc = VectorUtil.newVector3
local checkRange = 5
Enabled = not Enabled
if FallDisChecker then
    LuaTimer:cancel(FallDisChecker)
end
text:SetBackgroundColor(Color.BLACK)
Toast("AirDetect Bypass: Off")
if Enabled then
    FallDisChecker = LuaTimer:scheduleTimer(function()
        local player = PlayerManager:getClientPlayer()
        if not player then return end
        local fallDis = player.Player.fallDistance
        if fallDis > 5 then
            local playerPos = player:getPosition()
            local blockFound = false
            local blockBeneath = nil
            for i = 1, checkRange do
                local blockBelow = calc(playerPos.x, playerPos.y - i, playerPos.z)
                local blockId = EngineWorld:getBlockId(blockBelow)
                if blockId ~= 0 then
                    blockFound = true
                    blockBeneath = blockBelow
                    break
                end
            end
            if blockFound then
                player.Player.noClip = true
                local currentPos = player:getPosition()
                if currentPos.y <= blockBeneath.y + 2.50 then
                    player.Player:setPosition(calc(currentPos.x, currentPos.y + 0.1, currentPos.z))
                    EngineWorld:setBlock(calc(currentPos.x, currentPos.y - 0.1, currentPos.z), 8)
                    EngineWorld:setBlockToAir(calc(currentPos.x, currentPos.y - 0.1, currentPos.z))
                    player.Player.noClip = false
                     if currentPos.y <= blockBeneath.y + 1 then 
                        player.Player.noClip = false
                    end
                end
            end
        end
    end, 0.5, -1)
    text:SetBackgroundColor(Color.CYAN)
    Toast("AirDetect Bypass: On")
end
end


function GMHelper:AtkColor(text)
  showaeae = not showaeae
    ClientHelper.putBoolPrefs("ShowHurtColor", false)
    Toast("Attack Color : Off")
    text:SetBackgroundColor(Color.BLACK)
  
  if showaeae then
    ClientHelper.putBoolPrefs("ShowHurtColor", true)
    Toast("Attack Color : On")
    text:SetBackgroundColor(Color.CYAN)
  end
end

function GMHelper:JumpDpad(text)
    JumpPad = not JumpPad
        ClientHelper.putBoolPrefs("UseCenterJumpButton", false)
        text:SetBackgroundColor(Color.BLACK)
        Toast("Dpad : Off")
    
    if JumpPad then
        ClientHelper.putBoolPrefs("UseCenterJumpButton", true)
        text:SetBackgroundColor(Color.CYAN)
        Toast("Dpad : On")
    end
end


function GMHelper:AirGlide(text)
    A = not A
    if A then
        Toast("AirSpeed: On")
        text:SetBackgroundColor(Color.CYAN)
        PlayerManager:getClientPlayer().Player:setGlide(false)

        self.jumpCallback = function()
            PlayerManager:getClientPlayer().Player:setGlide(true)
        end

        Listener.registerCallBack(CEvents.PlayerJumpEvent, self.jumpCallback)
    else
        Toast("AirSpeed: Off")
        text:SetBackgroundColor(Color.BLACK)
        PlayerManager:getClientPlayer().Player:setGlide(false)

        if self.jumpCallback then
            CEvents.PlayerJumpEvent:unregisterCallBack(self.jumpCallback)
        end
    end
end

function GMHelper:yu()
HostApi.setSky("yu")
end

function GMHelper:liuxing()
HostApi.setSky("liuxing")
end

function GMHelper:xue()
HostApi.setSky("xue")
end

function GMHelper:fanxing()
HostApi.setSky("fanxing")
end

function GMHelper:qing()
HostApi.setSky("qing")
end

function GMHelper:wanxia()
HostApi.setSky("wanxia")
end



function GMHelper:runlol()
    GMHelper:openInput({ "" }, function(key)
        local content = key
        if content == "" then
            Toast("empty code")
            return
        end

        local func, loadErr = load(content)
        if not func then
            Toast("error: " .. loadErr)
            return
        end

        local status, err = pcall(func)
        if not status then
            Toast("error: " .. err)
            return
        end

        Toast("runned successfully")
    end)
end


--- === ( ZENTEX MLFUNC ) ===
local function setPosTest(targetPos)
    if targetPos.y < 10 then return end

    local clientWrapper = PlayerManager:getClientPlayer()
    if not clientWrapper or not clientWrapper.Player then return end
    local clientPlayer = clientWrapper.Player

    local myPos = clientPlayer:getPosition()
    local yaw = clientPlayer.rotationYaw
    local pitch = clientPlayer.rotationPitch

    local disTp = { x = targetPos.x - myPos.x, z = targetPos.z - myPos.z }
    local totalDistance = math.sqrt(disTp.x * disTp.x + disTp.z * disTp.z)

    if myPos.y < 165 then
        myPos.y = 165
    end

    if math.abs(disTp.x) > 18 then
        myPos.x = myPos.x + (disTp.x > 0 and 18 or -18)
        clientPlayer:setPosition(myPos)

        LuaTimer:scheduleTimer(function()
            setPosTest(targetPos)
        end, 0.015, 1)
        return
    end

    if math.abs(disTp.z) > 18 then
        myPos.z = myPos.z + (disTp.z > 0 and 18 or -18)
        clientPlayer:setPosition(myPos)

        LuaTimer:scheduleTimer(function()
            setPosTest(targetPos)
        end, 0.015, 1)
        return
    end

    local function checkBlock(pos)
        while EngineWorld:getBlockId(pos) ~= BlockID.AIR do
            pos.y = pos.y + 1
            if pos.y > 256 then break end
        end
        return pos
    end

    targetPos = checkBlock(targetPos)
    local abovePos = VectorUtil.newVector3(targetPos.x, targetPos.y + 1.3, targetPos.z)

    clientPlayer.noClip = true
    clientPlayer:setPosition(abovePos)
    clientPlayer.noClip = false
    clientPlayer:setPosition(abovePos)
    clientPlayer.rotationYaw = yaw
    clientPlayer.rotationPitch = pitch
    clientPlayer:setVelocity(VectorUtil.newVector3(0, 0.1, 0))
    clientPlayer:setAllowFlying(false)
    clientPlayer:setFlying(false)

    LuaTimer:scheduleOnce(function()
        clientPlayer:setAllowFlying(false)
        clientPlayer:setFlying(false)
    end, 0.05)
end


function GMHelper:BlackMarket()
local playerPos = VectorUtil.newVector3(386.39, 65.62, 142.142)
    setPosTest(playerPos)
end

function GMHelper:Bank1()
local playerPos = VectorUtil.newVector3(124.54, 78.62, 141.30)
    setPosTest(playerPos)
end

function GMHelper:Bank2()
local playerPos = VectorUtil.newVector3(118.54, 78.50, 146.70)
    setPosTest(playerPos)
end

function GMHelper:Bank2()
local playerPos = VectorUtil.newVector3(118.54, 79.50, 146.70)
    setPosTest(playerPos)
end

function GMHelper:Bank3()
local playerPos = VectorUtil.newVector3(130.58, 79.50, 146.70)
    setPosTest(playerPos)
end

function GMHelper:Hospital1()
local playerPos = VectorUtil.newVector3(65.54, 68.42, 271.51)
    setPosTest(playerPos)
end

function GMHelper:Hospital2()
local playerPos = VectorUtil.newVector3(77.43, 76.42, 253.52)
    setPosTest(playerPos)
end

function GMHelper:Mansion1()
local playerPos = VectorUtil.newVector3(55.44, 71.62, 480.30)
    setPosTest(playerPos)
end

function GMHelper:Mansion2()
local playerPos = VectorUtil.newVector3(55.54, 71.62, 520.70)
    setPosTest(playerPos)
end

function GMHelper:Mansion3()
local playerPos = VectorUtil.newVector3(62.38, 67.50, 500.38)
    setPosTest(playerPos)
end

function GMHelper:Mall1()
local playerPos = VectorUtil.newVector3(347.49, 68.42, 521.54)
    setPosTest(playerPos)
end

function GMHelper:Mall2()
local playerPos = VectorUtil.newVector3(350.48, 68.50, 489.44)
    setPosTest(playerPos)
end

function GMHelper:inn1()
local playerPos = VectorUtil.newVector3(216.62, 68.62, 37.35)
    setPosTest(playerPos)
end

function GMHelper:inn2()
local playerPos = VectorUtil.newVector3(216.50, 68.62, 57.55)
    setPosTest(playerPos)
end

function GMHelper:blue()
local playerPos = VectorUtil.newVector3(61.70, 67.62, -53.00)
    setPosTest(playerPos)
end

function GMHelper:red()
local playerPos = VectorUtil.newVector3(-173.70, 67.62, -23.02)
    setPosTest(playerPos)
end


function GMHelper:blueg()
local playerPos = VectorUtil.newVector3(128.04, 31.12, 373.69)
    setPosTest(playerPos)
end

function GMHelper:redg()
local playerPos = VectorUtil.newVector3(55.91, 31.12, 455.96)
    setPosTest(playerPos)
end

function GMHelper:greeng()
local playerPos = VectorUtil.newVector3(128.07, 31.12, 518.36)
    setPosTest(playerPos)
end

function GMHelper:yellowg()
local playerPos = VectorUtil.newVector3(200.26, 31.12, 446.07)
    setPosTest(playerPos)
end


function GMHelper:BGWebMode(text)
    A = not A
    if A then
        GUIManager:getWindowByName("Main-BedWar-BowShoot-Operate"):SetVisible(false)
        GUIManager:getWindowByName("Main-BedWar-BowShoot-CrossHairs"):SetVisible(false)
        Blockman.Instance().m_gameSettings:setCollimatorMode(false)
        Blockman.Instance():enableBreakCurrentScreenMoveTouch(false)
        Blockman.Instance().m_gameSettings:isMouseMoving(false)
        LuaTimer:cancel(self.timer)
        Toast("Hide Control : Off")
        text:SetBackgroundColor(Color.BLACK)
    else
        Toast("Hide Control : On")
        text:SetBackgroundColor(Color.CYAN)
        ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
        ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)

        local windowsToHide = {
            "Main-Fly",
            "Main-PoleControl-BG",
            "Main-PoleControl-Center",
            "Main-Up",
            "Main-Drop",
            "Main-Down",
            "Main-Break-Block-Progress-Nor",
            "Main-Break-Block-Progress-Pre",
            "Main-Parachute"
        }

        for _, windowName in ipairs(windowsToHide) do
            GUIManager:getWindowByName(windowName):SetProperty("ImageName", "")
        end

        GUIManager:getWindowByName("Main-BedWar-BowShoot-Operate"):SetVisible(true)
        GUIManager:getWindowByName("Main-BedWar-BowShoot-CrossHairs"):SetVisible(true)
        Blockman.Instance().m_gameSettings:setCollimatorMode(true)
        Blockman.Instance():enableBreakCurrentScreenMoveTouch(false)
        Blockman.Instance().m_gameSettings:isMouseMoving(true)
    end
end




function GMHelper:ItemThief(text)
    O = not O
    if O then
        stealTimer = LuaTimer:scheduleTimer(function()
            local clientPlayer = PlayerManager:getClientPlayer()
            local clientPos = clientPlayer.Player:getPosition()
            local items = EntityCache:getAllEntity()
            local closestItem = nil
            local minDistance = math.huge
            for _, entity in pairs(items) do
                if entity.type == EntityType.Item then
                    local itemPos = entity.entity:getPosition()
                    local dx = clientPos.x - itemPos.x
                    local dz = clientPos.z - itemPos.z
                    local distance = math.sqrt(dx * dx + dz * dz)
                    if distance < minDistance then
                        closestItem = entity
                        minDistance = distance
                    end
                end
            end
            if closestItem then
                local itemPos = closestItem.entity:getPosition()
                itemPos.y = itemPos.y + 2
                clientPlayer.Player:setPosition(itemPos)
                Toast("Teleporting to the nearest item..")
            else
                Toast("No items found nearby.")
            end
        end, 1, -1)
        Toast("Steal Item : On")
        text:SetBackgroundColor(Color.CYAN)
    else
        LuaTimer:cancel(stealTimer)
        Toast("Steal Item : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end








function GMHelper:sakho()
    A = not A
    if A then
        GMMain:SetVisible(false)
    else
        GMMain:SetVisible(true)
    end
end




function GMHelper:ESP(text)
    ESPEnabled = not ESPEnabled
    local myclient = PlayerManager:getClientPlayer()
    local hoomans = PlayerManager:getPlayers()

    if ESPEnabled then
        Toast("Player ESP: On")
        text:SetBackgroundColor(Color.CYAN)

        if not ESPTimer then
            ESPTimer = LuaTimer:scheduleTimer(function()
                for _, nubs in pairs(hoomans) do
                    if nubs.userId ~= myclient.userId and nubs.Player then
                        nubs.Player:enableXRay({ 0, 1, 1, 1 })
                    end
                end
            end, 100, -1) 
        end
    else
        Toast("Player ESP: Off")
        text:SetBackgroundColor(Color.BLACK)

        if ESPTimer then
            LuaTimer:cancel(ESPTimer)
            ESPTimer = nil
        end

        for _, nubs in pairs(hoomans) do
            if nubs.userId ~= myclient.userId and nubs.Player then
                nubs.Player:disableXRay()
            end
        end
    end
end



function GMHelper:Atm(text)
    toggleAttackReach = not toggleAttackReach

    if not toggleAttackReach then
        Toast("Inf Reach : Off")
        text:SetBackgroundColor(Color.BLACK)
        ClientHelper.putFloatPrefs("EntityReachDistance", 5)

        if self.attackCallback then
            CEvents.AttackEntityEvent:unregisterCallBack(self.attackCallback)
            self.attackCallback = nil
        end
        return
    end

    Toast("Inf Reach : On")
    text:SetBackgroundColor(Color.CYAN)
    ClientHelper.putFloatPrefs("EntityReachDistance", 9999)

    local savedPos = nil

    self.attackCallback = function(targetEntityId)
        local VIP = PlayerManager:getClientPlayer()
        if not VIP or not VIP.Player then return end

        local targetPlayer = PlayerManager:getPlayerByEntityId(targetEntityId)
        if not targetPlayer or not targetPlayer.Player then return end

        savedPos = VIP.Player:getPosition()

        local targetPos = targetPlayer.Player:getPosition()
        VIP.Player:setPosition(_G["VectorUtil"].newVector3(targetPos.x + 0.4, targetPos.y + 3, targetPos.z + 0.4))
        Toast("Teleported to target player!")

        LuaTimer:schedule(function()
            if savedPos then
                VIP.Player:setPosition(savedPos)
                Toast("Returned to original position")
            end
        end, 0.5)
    end

    CEvents.AttackEntityEvent:registerCallBack(self.attackCallback)
end




function GMHelper:AutoBridge(text)
LuaTimer:cancel(self.tir)
A = not A
    Toast("AutoBridge : Off")
    text:SetBackgroundColor(Color.BLACK)
    if A then
    self.tir = LuaTimer:scheduleTimer(function()
     local Hold = PlayerManager:getClientPlayer().Player:getHeldItemId()
    if Hold >= 2441 and Hold <= 3000 then
    CGame.Instance():handleTouchClick(1258, 430)
    end
 end, 1, 900000000000000000)
 Toast("AutoBridge : On")
 text:SetBackgroundColor(Color.CYAN)
end
end





function GMHelper:JiangXiPro()
    local player = PlayerManager:getClientPlayer()
    local packetCount = 0

    for i = 1, 999999 do
        player:sendPacket({
            pid = "pid"
        })
        packetCount = packetCount + 1
    end

    Toast("Total packets sent: " .. packetCount)
end













function GMHelper:AntiVoid(text)
    antiVoidEnabled = not antiVoidEnabled

    if antiVoidEnabled then
        text:SetBackgroundColor(Color.CYAN)
        Toast("Anti Void: On")

        if not antiVoidTimer then
            void = LuaTimer:scheduleTimer(function()
                local clientPlayer = PlayerManager:getClientPlayer().Player
                local fallDistance = clientPlayer.fallDistance

                if not originalPos or fallDistance == 0 then
                    originalPos = clientPlayer:getPosition()
                elseif fallDistance >= 3 then
                    clientPlayer:setPosition(originalPos)
                end
            end, 100, -1)
        end
    else
        text:SetBackgroundColor(Color.BLACK)
        Toast("Anti Void: Off")

        if void then
            LuaTimer:cancel(void)
            void = nil
        end
        originalPos = nil
    end
end






function GMHelper:BlinkOP(text)
   A = not A
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
   if A then
	Toast("Blink : On")
 text:SetBackgroundColor(Color.CYAN)
     return
   end
    ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
	Toast("Blink : Off")
	text:SetBackgroundColor(Color.BLACK)
end





function GMHelper:SpamChatV3(text)
    local ez = GUIManager:getWindowByName("Chat-BtnSend")
    if ez then
        ez:SetVisible(true)
    end
    

    local colors = {
        0xFF0000, 
        0xFFA500,
        0xFFFF00, 
        0x008000, 
        0x0000FF, 
        0x800080  
    }
    
    GMHelper:openInput({ "" }, function(wiadomosc)
        local colorIndex = 1
        self.timer = LuaTimer:scheduleTimer(function()
            local chatInputBox = GUIManager:getWindowByName("Chat-Input-Box")
            if chatInputBox then
                local color = colors[colorIndex]
                chatInputBox:SetProperty("Text", string.format("^%06X%s", color, wiadomosc))

                colorIndex = (colorIndex % #colors) + 1
            end
        end, 5, 1000000)

        if ez then
            local mainLayout = GUIManager:getWindowByName("Main")
            if mainLayout then
                mainLayout:AddChildWindow(ez)
            end
            ez:SetAlwaysOnTop(true)
            ez:SetYPosition({-0.59, 0})
            ez:SetXPosition({-0.99, 0})
            ez:SetVisible(true)
            ez:SetHeight({0, 140})
            ez:SetWidth({0, 140})
            Toast("ChatSpam : On")
            text:SetBackgroundColor(Color.CYAN)
            
            
            local stopButton = GUIManager:getWindowByName("GUIRoot-stopButton")
if not stopButton then
    stopButton = GUIManager:createGUIWindow(GUIType.Button, "GUIRoot-stopButton")
    stopButton:SetHorizontalAlignment(HorizontalAlignment.Center)
    stopButton:SetVerticalAlignment(VerticalAlignment.Center)
    stopButton:SetHeight({0, 50})
    stopButton:SetWidth({0, 90})
    stopButton:SetLevel(1)
    stopButton:SetTouchable(true)
    stopButton:SetText("stop")
    GUISystem.Instance():GetRootWindow():AddChildWindow(stopButton)
    stopButton:SetBackgroundColor({0, 0, 0, 1})
    stopButton:SetXPosition({0.2, 0})
    stopButton:SetYPosition({0.2, 0})
    stopButton:registerEvent(GUIEvent.ButtonClick, function()  
        LuaTimer:cancel(self.spam)
        LuaTimer:cancel(self.timer)
        stopButton:SetVisible(false)
        text:SetBackgroundColor(Color.BLACK)
    end)
end       
            stopButton:SetVisible(true)
            self.spam = LuaTimer:scheduleTimer(function()
                local x = {0.1, 0}
                local y = {0, 0}
                CGame.Instance():handleTouchClick(x, y)
            end, 1500, 9999999)
        end
    end)
end





function GMHelper:togfly(text)
   A = not A
    ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
    PlayerManager:getClientPlayer().doubleJumpCount = 100000000
   if A then
	Toast("Unlimited Fly : On")
 text:SetBackgroundColor(Color.CYAN)
     return
   end
    ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
    PlayerManager:getClientPlayer().doubleJumpCount = 0
	Toast("Unlimited Fly : Off")
 text:SetBackgroundColor(Color.BLACK)
end






function GMHelper:quickblock()
    GMHelper:openInput({ "" }, function(Op)
        if Op and tonumber(Op) then
            ClientHelper.putIntPrefs("QuicklyBuildBlockNum", tonumber(Op))
            Toast("Successfully Changed!")
        else
            Toast("Invalid Input! Please enter a valid number.")
        end
    end)
end






function GMHelper:FustBreakBlockMode(text)
    fastbreakEnabled = not fastbreakEnabled

    if fastbreakEnabled then
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for blockId = 1, 50000 do
            local block = BlockManager.getBlockById(blockId)
            if block then
                block:setHardness(0)
            end
        end
        Toast("Fastbreak : On")
        text:SetBackgroundColor(Color.CYAN)
    else
        cBlockManager.cGetBlockById(66):setNeedRender(true)
        cBlockManager.cGetBlockById(253):setNeedRender(true)
        for blockId = 1, 40000 do
            local block = BlockManager.getBlockById(blockId)
            if block then
                block:setHardness(1)
            end
        end
        Toast("Fastbreak : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end



function GMHelper:BowSpeed()
    GMHelper:openInput({ "" }, function(Op)
        if Op and tonumber(Op) then
            ClientHelper.putFloatPrefs("BowPullingSpeedMultiplier", tonumber(Op))
            ClientHelper.putFloatPrefs("BowPullingFOVMultiplier", 0)
            Toast("Successfully Changed!")
        else
            Toast("Invalid Input! Please enter a valid number.")
        end
    end)
end



function GMHelper:BanClickCD(text)
   A = not A
    ClientHelper.putBoolPrefs("banClickCD", true)
    ClientHelper.putBoolPrefs("BanEntityHitCD", true)
   if A then
 text:SetBackgroundColor(Color.BLACK)
	Toast("NoDelay : Off")
     return
   end
    ClientHelper.putBoolPrefs("banClickCD", false)
    ClientHelper.putBoolPrefs("BanEntityHitCD", false)
	Toast("NoDelay : On")
	text:SetBackgroundColor(Color.CYAN)
end



function GMHelper:ArmSpeed()
    GMHelper:openInput({ "" }, function(Op)
        if Op and tonumber(Op) then
            ClientHelper.putIntPrefs("ArmSwingAnimationEnd", tonumber(Op))
            Toast("Successfully Changed!" )
        else
            Toast("Invalid Input! Please enter a valid number.")
        end
    end)
end



function GMHelper:krixop()
GMHelper:openInput({ "height", "width", "length" }, function(Num1, Num2, Num3)
        local players = PlayerManager:getPlayers()

        for _, player in ipairs(players) do
            local entity = player.Player

            if player ~= PlayerManager:getClientPlayer() then
                entity.height = Num1
                entity.width = Num2
                entity.length = Num3
            end
        end

        Toast("Successfully Changed!")
    end)
end



function GMHelper:autoHitbox()
    local players = PlayerManager:getPlayers()
    local autoHeight = 4
    local autoWidth = 4
    local autoLength = 4

    for _, player in ipairs(players) do
        local entity = player.Player

        if player ~= PlayerManager:getClientPlayer() then
            entity.height = autoHeight
            entity.width = autoWidth
            entity.length = autoLength
        end
    end

    Toast("Successfully Changed!")
end



function GMHelper:AimBot(text)
    AIM = not AIM
    LuaTimer:cancel(self.ja)
    Toast("AimBot : Off")
    Blockman.Instance().m_gameSettings:setCollimatorMode(false)
    
    if AIM then
        Toast("AimBot : On")
        Blockman.Instance().m_gameSettings:setCollimatorMode(true)
       
        self.ja = LuaTimer:scheduleTimer(function()
            local me = PlayerManager:getClientPlayer()
            
            if me then
                local myPos = me.Player:getPosition()
                local players = PlayerManager:getPlayers()
                local myTeamId = me:getTeamId()

                local closestDistance = math.huge
                local closestPlayer = nil

                for _, player in pairs(players) do
                    if player ~= me and player.Player and player.Player:getTeamId() ~= myTeamId then
                        local playerPos = player:getPosition()
                        local distance = MathUtil:distanceSquare2d(playerPos, myPos)
                        
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end

                if closestPlayer ~= nil and closestDistance < 60 then             
                    local health = math.min(closestPlayer:getHealth(), 50.0)
                    local locationString = string.format("Closest player's health: %.1f", health)

                    Toast(locationString)

                    local camera = SceneManager.Instance():getMainCamera()
                    local pos = camera:getPosition()
                    local dir = VectorUtil.sub3(closestPlayer:getPosition(), pos)

                    local yaw = math.atan2(dir.x, dir.z) / math.pi * -180
                    local calculate = math.sqrt(dir.x * dir.x + dir.z * dir.z)
                    local pitch = -math.atan2(dir.y +1.5, calculate) / math.pi * 180

                    me.Player.rotationYaw = yaw or 0
                    me.Player.rotationPitch = pitch or 0
                    CGame.Instance():handleTouchClick(200,200)
                
                end
            end
        end, 5, 99999)
        Toast("AimBot : On")
        text:SetBackgroundColor(Color.CYAN)
    else
        LuaTimer:cancel(self.timer)
        Toast("AimBot : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end



function GMHelper:JetPack(text)
  A = not A
  PlayerManager:getClientPlayer().Player.m_keepJumping = false
  Toast("Jetpack : On")
  text:SetBackgroundColor(Color.CYAN)
  if A then
  PlayerManager:getClientPlayer().Player.m_keepJumping = true
  Toast("Jetpack : Off")
  text:SetBackgroundColor(Color.BLACK)
end
end



function GMHelper:Tracer(text)
    self.tracerToggle = not self.tracerToggle

    if self.TracerLocal then
        LuaTimer:cancel(self.TracerLocal)
        self.TracerLocal = nil
    end

    local me = PlayerManager:getClientPlayer()
    me.Player:deleteAllGuideArrow()
    Toast("Tracer : Off")
    text:SetBackgroundColor(Color.BLACK)

    if self.tracerToggle then
        self.TracerLocal = LuaTimer:scheduleTimer(function()
            me.Player:deleteAllGuideArrow()
            for _, c_player in pairs(PlayerManager:getPlayers()) do
                if c_player ~= me then
                    me.Player:addGuideArrow(c_player:getPosition())
                end
            end
        end, 0.5, -1)

        Toast("Tracer : On")
        text:SetBackgroundColor(Color.CYAN)
    end
end



function GMHelper:InstantRespawn(text)
    self.autoRespawn = not self.autoRespawn

    if self.ArdenPro then
        LuaTimer:cancel(self.ArdenPro)
        self.ArdenPro = nil
    end

    Toast("Auto Respawn : Off")
    text:SetBackgroundColor(Color.BLACK)

    if self.autoRespawn then
        local me = PlayerManager:getClientPlayer()
        self.ArdenPro = LuaTimer:scheduleTimer(function()
            if me:getHealth() <= 0 then
                PacketSender:getSender():sendRebirth()
            end
        end, 0.15, -1)

        Toast("Auto Respawn : On")
        text:SetBackgroundColor(Color.CYAN)
    end
end



function GMHelper:clickTp()
    local function issue(event)
        if not A or not event then return end

        local VIP = PlayerManager:getClientPlayer()
        if not VIP or not VIP.Player then return end

        local newPos = VectorUtil.newVector3(event.x + 0.4, event.y + 3, event.z + 0.4)
        VIP.Player:setPosition(newPos)
    end

    A = not A
    Listener.registerCallBack(CEvents.ClickToBlockEvent, issue)
Toast("^FF00EEClickTP : On")
end



function GMHelper:FlyParachute()
local moveDir = VectorUtil.newVector3(0.0, 1.35, 0.0)
    local player = PlayerManager:getClientPlayer()
    player.Player:setAllowFlying(true)
    player.Player:setFlying(true)
    player.Player:moveEntity(moveDir)
     PlayerManager:getClientPlayer().Player:startParachute()
end

function GMHelper:DevFly(text)
    local moveDir = VectorUtil.newVector3(0.0, 1.35, 0.0)
    local noob = PlayerManager:getClientPlayer()
    if not noob then return end

    A = not A
    if A then
        flyButtonn:SetVisible(true)
        Toast("Fly Button : On")
        text:SetBackgroundColor(Color.CYAN)
        noob:setAllowFlying(true)
        noob:setFlying(true)
        noob:moveEntity(moveDir)
    else
        flyButtonn:SetVisible(false)
        Toast("Fly Button : Off")
        text:SetBackgroundColor(Color.BLACK)
        noob:setFlying(false)
        noob:setAllowFlying(false)
    end
end


function GMHelper:EmoteFreezer(text)
 emote = not emote
     Toast("Freeze Emote : Off")
     text:SetBackgroundColor(Color.BLACK)
     PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", false)
 if emote then
     PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
     text:SetBackgroundColor(Color.CYAN)
     Toast("Freeze Emote : On")
 end
end



function GMHelper:WWE_Camera(text)
   A = not A
    ClientHelper.putBoolPrefs("IsSeparateCamera", true)
   if A then
	Toast("Free Camera : On")
 text:SetBackgroundColor(Color.CYAN)
     return
   end
    ClientHelper.putBoolPrefs("IsSeparateCamera", false)
	Toast("Free Camera : Off")
 text:SetBackgroundColor(Color.BLACK)
end

function GMHelper:UnDeath(text)
    local state = { lastRespawnTime = 0, active = false, callback = nil }
    local cooldown, stepSize, minHeight, safeHeight, maxHeight = 2000, 18, 10, 165, 256
    local scheduleDelay, respawnDelay, syncDelay, syncRepeat, postRespawnDelay, playerOffset =
        0.015, 400, 1, 1000, 0.05, 1.3

    local function nowMillis() return os.time() * 1000 end

    local function findSafePosition(pos)
        while EngineWorld:getBlockId(pos) ~= BlockID.AIR
        or EngineWorld:getBlockId(VectorUtil.newVector3(pos.x, pos.y + 1, pos.z)) ~= BlockID.AIR do
            pos.y = pos.y + 1
            if pos.y > maxHeight then break end
        end
        return pos
    end

    local function stepTowards(current, target, step)
        if math.abs(target - current) <= step then return target end
        return current + (target > current and step or -step)
    end

    local function moveToTarget(targetPos)
        local wrapper = PlayerManager:getClientPlayer()
        if not wrapper or not wrapper.Player then return end
        local player = wrapper.Player
        local currentPos = player:getPosition()
        if currentPos.y < safeHeight then currentPos.y = safeHeight end

        currentPos.x = stepTowards(currentPos.x, targetPos.x, stepSize)
        currentPos.z = stepTowards(currentPos.z, targetPos.z, stepSize)

        player:setPosition(currentPos)
        if currentPos.x ~= targetPos.x or currentPos.z ~= targetPos.z then
            LuaTimer:scheduleTimer(function() moveToTarget(targetPos) end, scheduleDelay, 1)
        else
            targetPos = findSafePosition(targetPos)
            local finalPos = VectorUtil.newVector3(targetPos.x, targetPos.y + playerOffset, targetPos.z)
            player.noClip = true
            player:setPosition(finalPos)
            player.noClip = false
            LuaTimer:scheduleOnce(function() ClientHelper.putBoolPrefs("SyncClientPositionToServer", true) end, postRespawnDelay)
        end
    end

    state.active = not state.active
    if not state.active then
        if state.callback then CEvents.LuaPlayerDeathEvent:unregisterCallBack(state.callback) end
        text:SetBackgroundColor(Color.BLACK)
        Toast("UnDeath : Off") 
        return
    end

    state.callback = function(deadPlayer)
        local currentTime = nowMillis()
        if deadPlayer ~= CGame.Instance():getPlatformUserId() then return end
        if currentTime - state.lastRespawnTime < cooldown then return end
        state.lastRespawnTime = currentTime

        LuaTimer:scheduleTimer(function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        end, syncDelay, syncRepeat)

        local player = PlayerManager:getClientPlayer().Player
        local savedPos = player:getPosition()
        _G["PacketSender"]:getSender():sendRebirth()
        player:setAllowFlying(true)
        player:setFlying(true)

        LuaTimer:schedule(function()
            moveToTarget(VectorUtil.newVector3(savedPos.x, savedPos.y, savedPos.z))
        end, respawnDelay)
    end

    CEvents.LuaPlayerDeathEvent:registerCallBack(state.callback)
    text:SetBackgroundColor(Color.CYAN) 
    Toast("UnDeath : On") 
end




   
function GMHelper:attack()
    GMHelper:openInput({ "" }, function(Op)
        if Op and tonumber(Op) then
            ClientHelper.putFloatPrefs("EntityReachDistance", tonumber(Op))
            Toast("Successfully Changed!!")
        else
            Toast("Invalid Input! Please enter a valid number.")
        end
    end)
end



function GMHelper:block()
    GMHelper:openInput({ "" }, function(Op)
        if Op and tonumber(Op) then
            ClientHelper.putFloatPrefs("BlockReachDistance", tonumber(Op))
            Toast("Successfully Changed!")
        else
            Toast("Invalid Input! Please enter a valid number.")
        end
    end)
end



function GMHelper:MineReset()
local playerPos = VectorUtil.newVector3(536, 2.78, -136)
local moveDir = VectorUtil.newVector3(0.0, 0.0, 0.0)
PlayerManager:getClientPlayer().Player:setPosition(playerPos)
PlayerManager:getClientPlayer().Player:moveEntity(moveDir)
end
   
  
 
function GMHelper:NoclipOP(text)
   A = not A
    for blockId = 3, 133 do
        local block = BlockManager.getBlockById(blockId)
        if block then
			block:setBlockBounds(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        end
		    end
   if A then
	Toast("Noclip : On")
 text:SetBackgroundColor(Color.CYAN)
     return
   end
    for blockId = 3, 133 do
        local block = BlockManager.getBlockById(blockId)
        if block then
			block:setBlockBounds(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)
        end
		    end
	Toast("Noclip : Off")
 text:SetBackgroundColor(Color.BLACK)
end




function GMHelper:lag()
    LuaTimer:scheduleTimer(function()
        for i = 1, 99999999 do
            PlayerManager:getClientPlayer():sendPacket({pid = "onClickVipRespawn"})
        end
    end, 0.1, 999999)
end   
  


function GMHelper:GetAll()
  local players = PlayerManager:getPlayers()
  for _, player in ipairs(players) do
    MsgSender.sendMsg("^FF0000 Info :" .. string.format("^00FF00UserName: %s {} ID: %s {} Gender: %s", player:getName(), player:getUserId(), player:getSex()))
  end
end



function GMHelper:Money()
local me = _G["PlayerManager"]:getClientPlayer()
  local wallet = Game:getPlayer():getWallet()

  wallet.m_diamondBlues = 999999999
  wallet.m_Currency = 999999999
  wallet.m_diamondGolds = 999999999
  wallet:setGolds(99999999)
  PlayerWallet:setMoneyCount(CurrencyId.Currency, 999999999)

  local MyName = "\083\104\141\144\151\145"
  Game:setRegionId(MyName)
  Game:setGameId(MyName)
end






function GMHelper:AttackBypass(text)
    toggleAttackReach = not toggleAttackReach

    if toggleAttackReach then
        Toast("Teleport Hit: On")
        text:SetBackgroundColor(Color.CYAN)
        ClientHelper.putFloatPrefs("EntityReachDistance", 9999)

        self.attackCallback = function(targetEntityId)
            local VIP = PlayerManager:getClientPlayer()
            if not VIP or not VIP.Player then return end

            local targetPlayer = PlayerManager:getPlayerByEntityId(targetEntityId)
            if not targetPlayer or not targetPlayer.Player then return end

            local targetPos = targetPlayer.Player:getPosition()
            if targetPos then
                VIP.Player:setPosition(_G["VectorUtil"].newVector3(targetPos.x + 0.4, targetPos.y + 3, targetPos.z + 0.4))
                Toast("Teleported to target player!")
            else
                Toast("Target position not found!")
            end
        end

        CEvents.AttackEntityEvent:registerCallBack(self.attackCallback)
    else
        Toast("Teleport Hit: Off")
        text:SetBackgroundColor(Color.BLACK)
        ClientHelper.putFloatPrefs("EntityReachDistance", 5)

        if self.attackCallback then
            CEvents.AttackEntityEvent:unregisterCallBack(self.attackCallback)
            self.attackCallback = nil
        end
    end
end


function GMHelper:fish()
GUIManager:getWindowByName("Main-Fishing"):SetVisible(true)
end





function GMHelper:SpeedBoost(text)
    local player = PlayerManager:getClientPlayer().Player
    SpeedActive = not SpeedActive
    text:SetBackgroundColor(Color.BLACK)
    player:setSpeedAdditionLevel(0)
    if SpeedActive then
        Toast("Speed Boost For 1 Minute")
        player:setSpeedAdditionLevel(10000)
        text:SetBackgroundColor(Color.CYAN)
    end
end









function GMHelper:ToggleESP()
    self.btnHitbox = not self.btnHitbox

    local players = PlayerManager:getPlayers()
    if type(players) ~= "table" then return end

    for _, player in ipairs(players) do
        if player and player.Player then
            local entity = player.Player
            if self.btnHitbox then
                entity:setShowName("╔═══╗\n║     ║\n║     ║\n║     ║\n╚═══╝", 0, entity.height / -2, 0)
            else
                entity:setShowName("", 0, 0, 0)
            end
        end
    end
end

function GMHelper:MovingControls()
    A = not A
    LuaTimer:cancel(CyberPro)
    Toast("Move Control : Off")

    if A then
        CyberPro = LuaTimer:scheduleTimer(function()
            local mainJump = GUIManager:getWindowByName("Main-Jump")
            if mainJump and not Blockman.Instance().m_gameSettings:isMouseMoving() then
                local mousePos = Blockman.Instance().m_gameSettings:getMousePos()
                
                mainJump:SetXPosition({0, mousePos.x / 1.5 - 740})
                mainJump:SetYPosition({0, mousePos.y / 1.5 - 305})
            end
        end, 0.05, -1)  
        Toast("Move Control : On")
    end
end






 
   
    
     



    
    
    
    
   
function GMHelper:setP(isOpen)
    SpamR = not SpamR
    GUIGMControlPanel:setBackgroundColor(Color.TRANS)
    if SpamR then
    GUIGMControlPanel:setBackgroundColor({ 0, 0, 0, 0.784314 })
    end
end






function GMHelper:RejoinGame(mapId, gameId)
    local currentGameId = CGame.Instance():getGameType()
    if currentGameId then
        Game:resetGame(gameId or currentGameId, PlayerManager:getClientPlayer().userId, mapId)
    end
end




function GMHelper:runCodeop()
    local file_path = "/storage/emulated/0/BGFX/Scripts/Prima/Runcode.lua"
    local file, fileErr = io.open(file_path, "r")
    if not file then
        Toast("Failed to open file: " .. (fileErr or "unknown"))
        return
    end

    local content = file:read("*a")
    file:close()

    local func, loadErr = load(content)
    if not func then
        Toast("Error loading code: " .. (loadErr or "unknown"))
        return
    end

    local success, runErr = pcall(func)
    if not success then
        Toast("Error running code: " .. (runErr or "unknown"))
        return
    end

    Toast("Code ran successfully")
end



function GMHelper:ProSet()
    GMHelper:openInput({""}, function(FPS)
 Toast("Maximum Fps : Changed")
        CGame.Instance():SetMaxFps(FPS)
    end)
end


function GMHelper:NoParticles2(text)
NP = not NP
if NP then
ClientHelper.putIntPrefs("BlockDestroyEffectSize", 0)
Toast("NoParticles : On")
text:SetBackgroundColor(Color.CYAN)
else
ClientHelper.putIntPrefs("BlockDestroyEffectSize", 3)
Toast("NoParticles : Off")
text:SetBackgroundColor(Color.BLACK)
end
end

function GMHelper:FpsBoost2(text)
    A = not A
    if A then
        ClientHelper.putIntPrefs("BlockDestroyEffectSize", nil)
        ClientHelper.putIntPrefs("BlockRenderDistance", 150)
        ClientHelper.putFloatPrefs("PlayerBobbingScale", nil)
        ClientHelper.putBoolPrefs("DisableRenderClouds", true)
        CGame.Instance():SetMaxFps(1000000000000)
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for blockId = 1, 40000 do
            local block = BlockManager.getBlockById(blockId)
            if block then
                block:setLightValue(150, 150, 150)
            end
        end
        Toast("FpsBoost : On")
        text:SetBackgroundColor(Color.CYAN)
    else
        ClientHelper.putIntPrefs("BlockDestroyEffectSize", 1)
        ClientHelper.putIntPrefs("BlockRenderDistance", 300)
        ClientHelper.putFloatPrefs("PlayerBobbingScale", 1)
        ClientHelper.putBoolPrefs("DisableRenderClouds", false)
        cBlockManager.cGetBlockById(66):setNeedRender(true)
        cBlockManager.cGetBlockById(253):setNeedRender(true)
        for blockId = 1, 40000 do
            local block = BlockManager.getBlockById(blockId)
            if block then
                block:setLightValue(250, 250, 250)
            end
        end
        Toast("FpsBoost : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end

function GMHelper:NightVision2(text)
NV = not NF
if NV then
        cBlockManager.cGetBlockById(66):setNeedRender(false)
        cBlockManager.cGetBlockById(253):setNeedRender(false)
        for blockId = 1, 40000 do
            local block = BlockManager.getBlockById(blockId)
            if block then
                block:setLightValue(150, 150, 150)
            end
        end
        Toast("NightVision : On")
        text:SetBackgroundColor(Color.CYAN)
        else
        cBlockManager.cGetBlockById(66):setNeedRender(true)
        cBlockManager.cGetBlockById(253):setNeedRender(true)
        for blockId = 1, 40000 do
            local block = BlockManager.getBlockById(blockId)
            if block then
                block:setLightValue(250, 250, 250)
            end
        end
        Toast("NightVision : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end  





   
function GMHelper:srdupp()
    LuaTimer:scheduleTimer(function()
        local players = PlayerManager:getPlayers()
        local validPlayers = {}

        local clientPlayer = PlayerManager:getClientPlayer()

        for _, player in ipairs(players) do
            if player ~= clientPlayer then
                table.insert(validPlayers, player)
            end
        end

        if #validPlayers > 0 then
            for i = 1, 30 do
                local randomIndex = math.random(1, #validPlayers)
                local randomPlayer = validPlayers[randomIndex]
                
                randomPlayer:sendPacket({pid = "onClickVipRespawn"})
            end
        end
    end, 0.1, 999999)
end



function GMHelper:lowsrdup()
    LuaTimer:scheduleTimer(function()
        for i = 1, 50 do
            PlayerManager:getClientPlayer():sendPacket({pid = "onClickVipRespawn"})
        end
    end, 0.1, 99)
end 



function GMHelper:srdup()
    LuaTimer:scheduleTimer(function()
        for i = 1, 50 do
            PlayerManager:getClientPlayer():sendPacket({pid = "onClickVipRespawn"})
        end
    end, 0.1, 999999)
end   



function GMHelper:reward()
    local player = PlayerManager:getClientPlayer()
    local packetCount = 0

    for i = 1, 1500000 do
        player:sendPacket({
            pid = "onClickVipRespawn"
        })
        packetCount = packetCount + 1
    end

    Toast("Total packets sent: " .. packetCount)
end






function GMHelper:TpMobs(text)
    A = not A
    LuaTimer:cancel(teleportTimer)
    Toast("TpMobs : Off")
    
    if A then
        teleportTimer = LuaTimer:scheduleTimer(function()
            local clientPos = PlayerManager:getClientPlayer().Player:getPosition()
            clientPos.y = clientPos.y + 2
            local entities = EntityCache:getAllEntity()
            for _, entity in pairs(entities) do
                if entity ~= PlayerManager:getClientPlayer() then
                    entity.entity:setPosition(clientPos)
                end
            end
            Toast("TpMobs : On")
            text:SetBackgroundColor(Color.CYAN)
        end, 1, -1)
    else
        Toast("TpMobs : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end








--( Gui:










function GMHelper:createFakeKeystroke()
    local buttons = {}
    local lastPos = {x = 0, z = 0}

    local function createKeystrokeButton(name, x, y, width, height)
        local button = GUIManager:createGUIWindow(GUIType.Button, tostring(math.random(1, 999e9)))
        button:SetHorizontalAlignment(HorizontalAlignment.Left)
        button:SetVerticalAlignment(VerticalAlignment.Top)
        button:SetHeight({0, height})
        button:SetWidth({0, width})
        button:SetYPosition({0, y})
        button:SetXPosition({0, x})
        button:SetLevel(7)
        button:SetTouchable(true)
        button:SetText(name)
        button:SetBackgroundColor({0.1, 0.1, 0.1, 1})
        button:SetTextColor({1, 0, 0, 1})
        return button
    end

    local function updateButtonColor(name, active)
        if buttons[name] then
            local color = active and {0, 1, 0, 1} or {1, 0, 0, 1}
            buttons[name]:SetTextColor(color)
            if active then
                LuaTimer:scheduleTimer(function()
                    buttons[name]:SetTextColor({1, 0, 0, 1})
                end, 500, 1)
            end
        end
    end

    local function setupButtons()
        local rootWindow = GUISystem.Instance():GetRootWindow()
        if rootWindow then
            buttons["W"] = createKeystrokeButton("W", 170, 110, 70, 70)
            buttons["A"] = createKeystrokeButton("A", 100, 180, 70, 70)
            buttons["S"] = createKeystrokeButton("S", 170, 180, 70, 70)
            buttons["D"] = createKeystrokeButton("D", 240, 180, 70, 70)

            rootWindow:AddChildWindow(buttons["W"])
            rootWindow:AddChildWindow(buttons["A"])
            rootWindow:AddChildWindow(buttons["S"])
            rootWindow:AddChildWindow(buttons["D"])
        end
    end

    local function updateMovement()
        local me = PlayerManager:getClientPlayer()
        LuaTimer:scheduleTimer(function()
            local myPos = me.Player:getPosition()
            local threshold = 0.05

            local movedForward = myPos.z < lastPos.z - threshold
            local movedBackward = myPos.z > lastPos.z + threshold
            local movedLeft = myPos.x < lastPos.x - threshold
            local movedRight = myPos.x > lastPos.x + threshold

            updateButtonColor("W", movedForward)
            updateButtonColor("S", movedBackward)
            updateButtonColor("A", movedLeft)
            updateButtonColor("D", movedRight)

            lastPos = {x = myPos.x, z = myPos.z}
        end, 100, -1)
    end

    setupButtons()
    updateMovement()
end







function GMHelper:fish()
GUIManager:getWindowByName("Main-Fishing"):SetVisible(true)
end



function GMHelper:FlyButton(text)
   A = not A
   if A then
      flyButtonn:SetVisible(true)
      Toast("Fly Button : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      flyButtonn:SetVisible(false)
      Toast("Fly Button : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end





function GMHelper:SetNameColor(color)
    local pickColor = {
        Red = "FF0000",
        Blue = "0000FF",
        Pink = "FF00FF",
        Cyan = "00FFFF",
        Green = "00FF00",
        Purple = "9600FF",
        Yellow = "FFFF00",
        Orange = "FFAF00",
        Gold = "FFD700",
        Black = "000000",
        Light = "FFFFFF"
    }

    if pickColor[color] then
        local playerName = PlayerManager:getClientPlayer().Player:getEntityName()
        PlayerManager:getClientPlayer().Player:setShowName("▢FF"..pickColor[color]..playerName)
    end
end


function GMHelper:Vip0()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_0.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip1()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_1.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip2()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_2.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip3()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_3.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip4()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_4.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip5()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_5.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip6()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_6.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip7()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_7.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip8()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_8.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip9()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_9.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip10()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_10.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end

function GMHelper:Vip11()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer then
        local playerEntity = clientPlayer.Player
        if playerEntity then
            local fixedNickname = playerEntity:getEntityName()
            local formattedNickname = string.format("[S=vip_nameplate_10_plus.json] %s", playerEntity:getEntityName())
            playerEntity:setShowName(formattedNickname)
        end
    end
end



function GMHelper:ae1(text)
   A = not A
   if A then
      btnJetpackg2:SetVisible(true)
      Toast("JetPack Btn : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      btnJetpackg2:SetVisible(false)
      Toast("JetPack Btn : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end

function GMHelper:ae2(text)
   A = not A
   if A then
      btnEmote:SetVisible(true)
      Toast("FreezeEmote Btn : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      btnEmote:SetVisible(false)
      Toast("FreezeEmote Btn : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end

function GMHelper:ae3(text)
   A = not A
   if A then
      btnTPKil:SetVisible(true)
      Toast("Hitbox Btn : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      btnTPKil:SetVisible(false)
      Toast("Hitbox Btn : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end

function GMHelper:ae4(text)
   A = not A
   if A then
      btnAutoClickg2:SetVisible(true)
      Toast("AutoClick Btn : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      btnAutoClickg2:SetVisible(false)
      Toast("AutoClick Btn : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end

function GMHelper:ae5(text)
   A = not A
   if A then
      btnFarAimBotg2:SetVisible(true)
      Toast("Aimbot Btn : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      btnFarAimBotg2:SetVisible(false)
      Toast("Aimbot Btn : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end

function GMHelper:ae6(text)
   A = not A
   if A then
      btnTPKill:SetVisible(true)
      Toast("TpKill Btn : On") 
      text:SetBackgroundColor(Color.CYAN)
   else
      btnTPKill:SetVisible(false)
      Toast("TpKill Btn : Off") 
      text:SetBackgroundColor(Color.BLACK)
   end
end







function GMHelper:shitto() 
    Show(updateTitle)
    Show(updateBg)
    Show(updateScroll)
    Show(updateClose) 
end 

function Show(w)
    w:SetVisible(true)
end



function GMHelper:getNearestPlayerId()
    local me = PlayerManager:getClientPlayer()
    local myPos = me.Player:getPosition()
    local players = PlayerManager:getPlayers()
    local myTeamId = me:getTeamId()

    local closestDistance = math.huge
    local closestPlayer = nil

    for _, player in pairs(players) do
        if player ~= me and player.Player and player.Player:getTeamId() ~= myTeamId then
            local playerPos = player:getPosition()
            local distance = MathUtil:distanceSquare2d(playerPos, myPos)
            
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    if closestPlayer ~= nil and closestDistance < 60 then             
        local playerId = closestPlayer.userId
        Toast("Nearest player ID: " .. playerId)
        ClientHelper.onSetClipboard(playerId)
        return playerId
    else
        Toast("No nearby player found.")
    end

    return nil 
end

function GMHelper:ko()
    GMHelper:openInput({ "Player Id" }, function(inputValue)
        local player = PlayerManager:getPlayerByUserId(inputValue)
        if not player then
            Toast("Player not found:", inputValue)
        else
            HostApi.sendGameover(inputValue, IMessages:msgGameOver(), GameOverCode.GameOver)
        end
    end)
end

function GMHelper:UIFucker()
    local root = GUISystem.Instance():GetRootWindow()
    local count = root:GetChildCount()
    local guiWindows = {}

    for i = 0, count - 1 do
        local child = root:GetChildByIndex(i)
        if child then
            guiWindows[#guiWindows + 1] = {
                win = child,
                width = {child:GetWidth()[1]},
                height = {child:GetHeight()[1]},
                x = {child:GetXPosition()[1]},
                y = {child:GetYPosition()[1]}
            }
        end
    end

    UIFUCK = LuaTimer:scheduleTimer(function()
        for i = 1, #guiWindows do
            local w = guiWindows[i].win
            if w then
                if math.random(0,1) == 1 then
                    w:SetWidth({math.random(30, 100)})
                    w:SetHeight({math.random(20, 100)})
                    w:SetXPosition({math.random(0, 100)})
                    w:SetYPosition({math.random(0, 100)})
                else
                    w:SetWidth(guiWindows[i].width)
                    w:SetHeight(guiWindows[i].height)
                    w:SetXPosition(guiWindows[i].x)
                    w:SetYPosition(guiWindows[i].y)
                end
            end
        end
    end, 80, -1)
end


function GMHelper:cyan()
    local names = { "Main-PoleControl-Move", "Main-PoleControl", "Main-FlyingControls", "Main-Fly" }

    ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
    ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)

    local elements = {
        "Main-Fly",
        "Main-PoleControl-BG",
        "Main-PoleControl-Center",
        "Main-Up",
        "Main-Drop",
        "Main-Down",
        "Main-Break-Block-Progress-Nor",
        "Main-Break-Block-Progress-Pre"
    }

    for _, element in ipairs(elements) do
        local guiElement = GUIManager:getWindowByName(element)
        if guiElement then
            guiElement:SetBackgroundColor(Color.CYAN)
        end
    end
end




function GMHelper:ToggleFeatherFall(text)
    self.featherFallEnabled = not self.featherFallEnabled

    if not self.featherFallEnabled then
        if self.featherFallTimer then
            LuaTimer:cancel(self.featherFallTimer)
            self.featherFallTimer = nil
        end
        text:SetBackgroundColor(Color.BLACK)
        Toast("Feather Fall : Off") 
        return
    end

    text:SetBackgroundColor(Color.CYAN)
    Toast("Feather Fall : On")

    self.featherFallTimer = LuaTimer:scheduleTimer(function()
        local player = PlayerManager:getClientPlayer().Player
        local pos = player:getPosition()

        if player.fallDistance > 0.8 then
            player:setPosition(VectorUtil.newVector3(pos.x, pos.y + 0.09, pos.z))
        end
    end, 55, -1)
end



function GMHelper:WordBypass()
    Toast("Attempting to Inject Chat Bypass")

    local settingPath = Root.Instance():getRootPath() .. "/Media/Setting/"
    lfs.mkdir(settingPath)

    local wordsTxtFile = io.open(settingPath .. "words.txt", "w")
    if wordsTxtFile then
        wordsTxtFile:write("")
        wordsTxtFile:close()
        Toast("Successfully Injected Chat Bypass")
    else
        Toast("Failed to Inject Chat Bypass")
    end
end



function GMHelper:ItemLocator(text)
    O = not O
    if O then
        locateTimer = LuaTimer:scheduleTimer(function()
            local clientPlayer = PlayerManager:getClientPlayer()
            local clientPos = clientPlayer.Player:getPosition()
            local items = EntityCache:getAllEntity()
            local closestItem = nil
            local minDistance = math.huge
            for _, entity in pairs(items) do
                if entity.type == EntityType.Item then
                    local itemPos = entity.entity:getPosition()
                    local dx = clientPos.x - itemPos.x
                    local dz = clientPos.z - itemPos.z
                    local distance = math.sqrt(dx * dx + dz * dz)
                    if distance < minDistance then
                        closestItem = entity
                        minDistance = distance
                    end
                end
            end
            if closestItem then
                Toast("Item Block distance: " .. math.floor(minDistance))
            end
        end, 1, -1)

        noItemTimer = LuaTimer:scheduleTimer(function()
            Toast("No items found nearby.")
        end, 1000, -1)

        Toast("Item Locator: On")
        text:SetBackgroundColor(Color.CYAN)
    else
        LuaTimer:cancel(locateTimer)
        LuaTimer:cancel(noItemTimer)
        Toast("Item Locator: Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end



function GMHelper:ChatToggle(text)
    A = not A
    if A then
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(false)
        Toast("Chat Hider : On")
        text:SetBackgroundColor(Color.CYAN)
    else
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
        GUIManager:getWindowByName("Main-Chat-Message"):SetVisible(true)
        Toast("Chat Hider : Off")
        text:SetBackgroundColor(Color.BLACK)
    end
end



GMSetting:addTab("xd", "Prima") 
GMSetting:addItem("Prima", "Grant", "getcode")

function GMHelper:GUINAME()
    local root = GUISystem.Instance():GetRootWindow()
    local count = root:GetChildCount()
    local path = "/storage/emulated/0/BGFX/Scripts/Prima/GuiNames.lua"
    local file = io.open(path, "w")
    Loading("Successfully Writted at :", path()) 
    LoadSpeed(9) 
    local seenNames = {}

    if file then
        file:write(' __________________\n')
        file:write('/      PRIMA      \\n')
        file:write('\\__________________/\n')
        file:write('All Gui = {\n')

        for i = 0, count - 1 do
            local child = root:GetChildByIndex(i)
            local name = child:GetName()
            if not seenNames[name] then
                seenNames[name] = true
                file:write(string.format('    "%s",\n', name))
            end
        end

        file:write("}\n")
        file:close()
    end
end

function GMHelper:RTXJIANG()
    local bm = Blockman.Instance()
    bm:setBloomEnable(true)
    bm:enableFullscreenBloom(true)
    bm:setBloomThreshold(0.75)
    bm:setBloomSaturation(2.552)
    bm:setBloomIntensity(5.098)
    bm:setBloomBlurDeviation(2.587)
    bm:setBloomBlurMultiplier(1.399)
    bm:setBlockBloomOption(3, 2.6, 1.0)
    Toast("Success")
end


local isUsed = false

function GMHelper:getcode(Test)
    if isUsed then
        Toast("Try again later..")
        return
    end

    isUsed = true

    GMHelper:openInput({ "Enter Passcode" }, function(input)
        if input == "kyro" then
            Toast("Injected Primal Tab")
            Test:SetText("Injected")
            LuaTimer:schedule(function()
                Toast("Opening Primal Tab.. ")
                Loading("Adding Primain Tabs") 
                LoadSpeed(2)
                LuaTimer:schedule(function()
                    GMSetting:addItem("Prima", "GetGameId", "GameID")
                    GMSetting:addItem("Prima", "Shader/Rtx", "RTXJIANG")
                    GMSetting:addItem("Prima", "ChangeColor", "cyan")
                    GMSetting:addItem("Prima", "KeyStroke V3", "Nil")
                      GMSetting:addItem("Prima", "CarSpeed", "aza")
                    GMSetting:addItem("Prima", "NearestPlayerId", "getNearestPlayerId")
                end, 1000)
            end, 3000)
        elseif input == "PrimaDev" then
            Toast("Good guess, But no")
            Test:SetText("Incorrect")
            for i = 1, 16 do
                MsgSender.sendBottomTips("Incorrect Passcode!")
            end
        elseif input == "Hello" then
            Toast("Hi")
            Test:SetText("Hi")
            MsgSender.sendBottomTips("Hello")
        else
            Test:SetText("Incorrect")
            Toast("Incorrect")
            MsgSender.sendBottomTips("Incorrect Primal Key!")
        end
    end)

    Test:SetBackgroundColor(Color.CYAN)
end





function GMHelper:GameID()
    Toast("GameID=" .. CGame.Instance():getGameType())
end



function GMHelper:GiveDiamond()
    LuaTimer:scheduleTimer(function()
        local playerPos = VectorUtil.newVector3(536, 267, -136)
        local moveDir = VectorUtil.newVector3(0.0, 0.0, 0.0)
        
        local clientPlayer = PlayerManager:getClientPlayer()
        if clientPlayer then
            clientPlayer.Player:setPosition(playerPos)
            clientPlayer.Player:moveEntity(moveDir)
        end
        
        Toast("Success, diamond gotten. Note: it can be used only once; you can't get more than one diamond.")
        EngineWorld:setBlock(VectorUtil.newVector3(536, 267, -136), 57)
    end, 1000)
end



function GMHelper:SwitchMap(mapId, gameId)
    Game:resetGame(gameId, PlayerManager:getClientPlayer().userId, mapId)
end

local positions = {
    {x = 256.5, y = 80, z = -41.5},
    {x = 170.5, y = 83, z = -42.5},
    {x = 67.5, y = 83, z = -41.5},
    {x = -38.5, y = 86, z = -42.5}
}
local currentPositionIndex = 1

function GMHelper:TeleportV1()
    local pos = positions[currentPositionIndex]
    local playerPos = VectorUtil.newVector3(pos.x, pos.y, pos.z)
    local moveDir = VectorUtil.newVector3(0.0, 0.0, 0.0)
    
    PlayerManager:getClientPlayer().Player:setPosition(playerPos)
    PlayerManager:getClientPlayer().Player:moveEntity(moveDir)
    
    currentPositionIndex = currentPositionIndex % #positions + 1
end

local positions = {
    {x = 4.5, y = 94, z = 50.5},
    {x = 4.5, y = 28, z = 87.5},
    {x = 4.5, y = 33, z = 209.5},
    {x = 3.5, y = 33, z = 251.5},
    {x = 4.5, y = 93, z = -6.5}
}
local currentPositionIndex = 1

function GMHelper:TeleportV2()
    local pos = positions[currentPositionIndex]
    local playerPos = VectorUtil.newVector3(pos.x, pos.y, pos.z)
    local moveDir = VectorUtil.newVector3(0.0, 0.0, 0.0)
    
    PlayerManager:getClientPlayer().Player:setPosition(playerPos)
    PlayerManager:getClientPlayer().Player:moveEntity(moveDir)
    
    currentPositionIndex = currentPositionIndex % #positions + 1
end 

local positions = {
    {x = 1596.5, y = 10, z = -617.5},
    {x = 1676.5, y = 10, z = -617.5},
    {x = 1763.5, y = 10, z = -616.5},
    {x = 1866.5, y = 10, z = -618.5},
    {x = 1527.5, y = 10, z = -619.5},
    {x = 1462.5, y = 237, z = -617.5},
    {x = 1426.5, y = 237, z = -617.5},
    {x = 1344.5, y = 237, z = -617.5},
    {x = 1502.5, y = 237, z = -617.5}
}
local currentPositionIndex = 1

function GMHelper:TeleportV3()
    local pos = positions[currentPositionIndex]
    local playerPos = VectorUtil.newVector3(pos.x, pos.y, pos.z)
    local moveDir = VectorUtil.newVector3(0.0, 0.0, 0.0)
    
    PlayerManager:getClientPlayer().Player:setPosition(playerPos)
    PlayerManager:getClientPlayer().Player:moveEntity(moveDir)
    
    currentPositionIndex = currentPositionIndex % #positions + 1
end

local positions = {
    {x = 1626.5, y = 200, z = -514.5},
    {x = 1701.5, y = 11, z = -515.5},
    {x = 1805.5, y = 10, z = -427.5},
    {x = 1846.5, y = 250, z = -505.5},
    {x = 1819.5, y = 239, z = -552.5}
}
local currentPositionIndex = 1

function GMHelper:TeleportV4()
    local pos = positions[currentPositionIndex]
    local playerPos = VectorUtil.newVector3(pos.x, pos.y, pos.z)
    local moveDir = VectorUtil.newVector3(0.0, 0.0, 0.0)
    
    PlayerManager:getClientPlayer().Player:setPosition(playerPos)
    PlayerManager:getClientPlayer().Player:moveEntity(moveDir)
    
    currentPositionIndex = currentPositionIndex % #positions + 1
end



function GMHelper:changeLuaHotUpdate(update)
    startLuaHotUpdate()
    HU.CanUpdate = update
end



local function buildTeamUserInfo()
    local cache = UserInfoCache:GetCache(Game:getPlatformUserId())

    return json.encode({
        userId = Game:getPlatformUserId(),
        name = "",
        colorfulNickName = "Rishu23",
        picUrl = CGame.Instance():getPicUrl(),
        country = "CN",
        language = "en",
        sex = 1,
        curHeadFrame = 0,
        curHeadImage = 0,
        qualifyingData = cache and cache.qualifyingData or nil,
        playerLevel = 30,
        status = 10,
        packageName = "com.sandboxol.blockymods",
        appVersion = "1.102.3",
        platform = "",
        regionId = Game:getRegionId(),
        region = Game:getUserRegion(), 
        singleMatch = true,
        gameCount = 197268,
        failedCount = 0
    })
end

function GMHelper:PlayAgainNN()
    local ConnectorCenter = T(Global, "ConnectorCenter")

    ConnectorCenter:sendMsg(120001, {
        ownerId = Game:getPlatformUserId(),
        info = buildTeamUserInfo(),
        gameType = "g1008",
        engineVersion = 10108,
        gameMode = "",
        regionId = Game:getRegionId()
    })
end



function GMHelper:BedDestroyer(text)
    local Active = not Active

    if Active then
        Toast("BedDestroyer : On")
        text:SetBackgroundColor(Color.CYAN)

        Destroyer = LuaTimer:scheduleTimer(function()
            local clientPlayer = PlayerManager:getClientPlayer()
            if not clientPlayer then return end

            local player = clientPlayer.Player
            if not player then return end

            local playerPos = player:getPosition()
            local beds = {}

            local bedIDs = {
                BlockID.BED,
                BlockID.BED_RED,
                BlockID.BED_BLUE,
                BlockID.BED_GREEN,
                BlockID.BED_YELLOW,
                BlockID.BED_WHITE,
                BlockID.BED_BLACK,
                BlockID.BED_PURPLE,
                BlockID.BED_CYAN,
                BlockID.BED_PINK,
                BlockID.BED_GRAY,
                BlockID.BED_LIME,
                BlockID.BED_LIGHT_BLUE
            }

            local teams = TeamConfig:getTeams()
            for _, team in pairs(teams) do
                for _, bedPos in pairs(team.bedPos) do
                    local blockId = EngineWorld:getBlockId(bedPos)
                    if table.contains(bedIDs, blockId) then
                        table.insert(beds, bedPos)
                    end
                end
            end

            local function bindEntity(pos)
                local yaw = clientPlayer:getYaw()
                local param = string.format("%f,%f,%f,%f", pos.x, pos.y - 2, pos.z, yaw)

                clientPlayer:sendPacket({
                    pid = "PlayerTicketTipGo",
                    type = 1,
                    param = param
                })
            end

            if #beds > 0 then
                Toast("Found " .. #beds .. " beds nearby!")
                for _, bedPos in ipairs(beds) do
                    bindEntity(bedPos)
                end
            else
                Toast("No beds detected..")
                for _, team in pairs(teams) do
                    local targetPos = VectorUtil.newVector3(team.bedPos[1].x, team.bedPos[1].y + 3, team.bedPos[1].z)
                    bindEntity(targetPos)
                    Toast(team.name .. " Team location reached!")
                    break
                end
            end
        end, 10000, -1)
    else
        Toast("BedDestroyer : Off")
        text:SetBackgroundColor(Color.BLACK)
        if Destroyer then
            LuaTimer:cancel(Destroyer)
            Destroyer = nil
        end
    end
end



function GMHelper:selectJob(jobId, text)
    local data = DataBuilder.new():addParam("JobId", tonumber(jobId)):getData()
    PacketSender:sendLuaCommonData("SelectJobId", data)
   Toast("Changed Job") 
end



local currentChatColor = "^FFFFFF"

function GMHelper:applyColorToChat(color)

    if color == "Red" then
        currentChatColor = "^FF0000"
    elseif color == "Green" then
        currentChatColor = "^00FF00"
    elseif color == "Blue" then
        currentChatColor = "^0000FF"
    elseif color == "Yellow" then
        currentChatColor = "^FFFF00"
    elseif color == "Cyan" then
        currentChatColor = "^00FFFF"
    elseif color == "Magenta" then
        currentChatColor = "^FF00FF"
    elseif color == "Black" then
        currentChatColor = "^000000"
    elseif color == "White" then
        currentChatColor = "^FFFFFF"
    elseif color == "Orange" then
        currentChatColor = "^FFA500"
    elseif color == "Purple" then
        currentChatColor = "^800080"
    elseif color == "Pink" then
        currentChatColor = "^FFC0CB"
    elseif color == "Brown" then
        currentChatColor = "^A52A2A"
    elseif color == "Gray" then
        currentChatColor = "^808080"
    elseif color == "LightBlue" then
        currentChatColor = "^ADD8E6"
    elseif color == "Indigo" then
        currentChatColor = "^4B0082"
    elseif color == "Violet" then
        currentChatColor = "^8A2BE2"
    elseif color == "Gold" then
        currentChatColor = "^FFD700"
    elseif color == "Silver" then
        currentChatColor = "^C0C0C0"
    elseif color == "Teal" then
        currentChatColor = "^008080"
    elseif color == "Lime" then
        currentChatColor = "^00FF00"
    elseif color == "Turquoise" then
        currentChatColor = "^40E0D0"
    elseif color == "Salmon" then
        currentChatColor = "^FA8072"
    elseif color == "Crimson" then
        currentChatColor = "^DC143C"
    elseif color == "Olive" then
        currentChatColor = "^808000"
    elseif color == "Navy" then
        currentChatColor = "^000080"
    elseif color == "Maroon" then
        currentChatColor = "^800000"
    elseif color == "Teal" then
        currentChatColor = "^008080"
    elseif color == "Lavender" then
        currentChatColor = "^E6E6FA"
    elseif color == "Coral" then
        currentChatColor = "^FF7F50"
    else
        currentChatColor = ""
    end

    local ChatInputBox = GUIManager:getWindowByName("Chat-Input-Box")
    local originalMessage = ChatInputBox:GetText()

    originalMessage = originalMessage:sub(8)

    local coloredMessage = currentChatColor .. originalMessage
    ChatInputBox:SetText(coloredMessage)
end


      ---( GMControl )---

function UIGMControlPanel:onLoad()
    self.root:SetLevel(1)
    self:getChildWindow("GMControlPanel-Close-Text"):SetText("×")

    local llTabs = self:getChildWindow("GMControlPanel-Tabs")
    self.llInput = self:getChildWindow("GMControlPanel-Input-Layout", GUIType.Layout)
    self.llInput:SetVisible(false)

    self.edInput = self:getChildWindow("GMControlPanel-Input-Edit", GUIType.Edit)
    self.lvTabs = IGUIListView.new("GMControlPanel-Tabs-List", llTabs)
    self.lvTabs:setItemSpace(4)

    local llContent = self:getChildWindow("GMControlPanel-Content")
    self.gvItems = IGUIGridView.new("GMControlPanel-Items-List", llContent)
    self.gvItems:setConfig(8, 8, 5)

    local itemW = (self.gvItems:getWidth() - 65) / 5
    self.adapter = UIHelper.newEngineAdapter("GMItemAdapter")
    self.adapter:setItemSize(itemW, 48)
    self.gvItems:setAdapter(self.adapter)

    local btnClose = self:getChildWindow("GMControlPanel-Close", GUIType.Button)
    btnClose:registerEvent(GUIEvent.ButtonClick, function()
        self:hide()
    end)

    local stFilterText = self:getChildWindow("GMControlPanel-FilterText", GUIType.StaticText)
    stFilterText:SetBordered(true)

    local fullText = "「 Prima Panel 」 ¦  'version' : 2.7 "
    local currentIndex = 0
    local typingState = "typing" 
    local delayCounter = 0
    local hue = 0

    local function interpolateColor(h)
        local r, g, b = 0, 0, 0
        if h < 60 then
            r, g, b = 1, h / 60, 0
        elseif h < 120 then
            r, g, b = (120 - h) / 60, 1, 0
        elseif h < 180 then
            r, g, b = 0, 1, (h - 120) / 60
        elseif h < 240 then
            r, g, b = 0, (240 - h) / 60, 1
        elseif h < 300 then
            r, g, b = (h - 240) / 60, 0, 1
        else
            r, g, b = 1, 0, (360 - h) / 60
        end
        return r, g, b, 0.8
    end

    local function animateText()
        hue = (hue + 1.5) % 360
        local r, g, b, a = interpolateColor(hue)
        stFilterText:SetTextColor({ r, g, b, a })

        if typingState == "typing" then
            if currentIndex < #fullText then
                currentIndex = currentIndex + 1
                stFilterText:SetText(string.sub(fullText, 1, currentIndex))
            else
                typingState = "waiting"
                delayCounter = 0
            end
        elseif typingState == "waiting" then
            delayCounter = delayCounter + 1
            if delayCounter >= 100 then 
                typingState = "deleting"
            end
        elseif typingState == "deleting" then
            if currentIndex > 0 then
                currentIndex = currentIndex - 1
                stFilterText:SetText(string.sub(fullText, 1, currentIndex))
            else
                typingState = "typing"
            end
        end
    end

    LuaTimer:scheduleTimer(animateText, 50, -1)

    self.etFilterValue = self:getChildWindow("GMControlPanel-FilterValue", GUIType.Edit)
    self.etFilterValue:SetMaxLength(500)
    self.etFilterValue:SetBackgroundColor({ 0, 0, 0, 0 })
    self.etFilterValue:registerEvent(GUIEvent.EditTextInput, function(args)
        if args.trigger == 0 then
            self:selectTab(self.tab)
        end
    end)

    self.edInput:SetMaxLength(1200)
    self.edInput:SetVisible(true)
    self.edInput:registerEvent(GUIEvent.EditTextInput, function(args)
        if args.trigger == 0 then
            self:inputText()
        end
    end)

    self.llInput:registerEvent(GUIEvent.Click, function()
        self:closeInput()
    end)

    self.gvItems.root:registerEvent(GUIEvent.ScrollMoveChange, function(args)
        if self.settings then
            self.settings.offset = args.offset
        end
    end)
end







