local hotkey = require('hs.hotkey')
local window = require('hs.window')
local application = require('hs.application')

window.animationDuration = 0

local function withFocusedWindow(fn)
    local win = window.focusedWindow()
    if not win then
        return
    end

    fn(win)
end

local function bindAltKey(key, handler)
    hotkey.bind({ 'alt' }, key, handler)
end

local function copyFrame(frame)
    return { x = frame.x, y = frame.y, w = frame.w, h = frame.h }
end

local previousWindowFrames = {}

local BUILT_IN_SCREEN_NAMES = {
    ['built-in retina display'] = true,
    ['built-in display'] = true,
    ['color lcd'] = true,
}

local function isBuiltInScreen(scr)
    if not scr then
        return false
    end

    local info = scr.getInfo and scr:getInfo()
    if info and info.isBuiltin ~= nil then
        return info.isBuiltin
    end

    local name = scr:name()
    if name then
        local lower = name:lower()
        if BUILT_IN_SCREEN_NAMES[lower] then
            return true
        end
    end

    return false
end

-- Window positioning helpers
bindAltKey('1', function()
    withFocusedWindow(function(win)
        win:moveToUnit({ x = 0, y = 0, w = 0.5, h = 1 })
    end)
end)

bindAltKey('2', function()
    withFocusedWindow(function(win)
        win:moveToUnit({ x = 0.5, y = 0, w = 0.5, h = 1 })
    end)
end)

bindAltKey('3', function()
    withFocusedWindow(function(win)
        local frame = win:frame()
        local screenFrame = win:screen():frame()

        frame.x = screenFrame.x

        win:setFrame(frame)
    end)
end)

bindAltKey('4', function()
    withFocusedWindow(function(win)
        local frame = win:frame()
        local screenFrame = win:screen():frame()

        frame.x = screenFrame.x + screenFrame.w - frame.w

        win:setFrame(frame)
    end)
end)

bindAltKey('5', function()
    withFocusedWindow(function(win)
        win:moveToUnit({ x = 1 / 6, y = 0, w = 2 / 3, h = 1 })
    end)
end)

bindAltKey('6', function()
    withFocusedWindow(function(win)
        win:moveToUnit({ x = 1 / 3, y = 0, w = 1 / 3, h = 1 })
    end)
end)

bindAltKey('/', function()
    withFocusedWindow(function(win)
        win:centerOnScreen()
    end)
end)

bindAltKey('=', function()
    withFocusedWindow(function(win)
        local frame = win:frame()
        local screenFrame = win:screen():frame()

        frame.x = math.max(screenFrame.x, frame.x - 20)
        frame.y = math.max(screenFrame.y, frame.y - 20)
        frame.w = math.min(screenFrame.w, frame.w + 40)
        frame.h = math.min(screenFrame.h, frame.h + 40)

        win:setFrame(frame)
    end)
end)

bindAltKey('-', function()
    withFocusedWindow(function(win)
        local frame = win:frame()
        local screenFrame = win:screen():frame()

        frame.x = math.min(frame.x + 20, screenFrame.x + screenFrame.w - 100)
        frame.y = math.min(frame.y + 20, screenFrame.y + screenFrame.h - 100)
        frame.w = math.max(100, frame.w - 40)
        frame.h = math.max(100, frame.h - 40)

        win:setFrame(frame)
    end)
end)

bindAltKey('f', function()
    withFocusedWindow(function(win)
        win:maximize()
    end)
end)

bindAltKey('tab', function()
    withFocusedWindow(function(win)
        local currentScreen = win:screen()
        local nextScreen = currentScreen and currentScreen:next()

        if not nextScreen or nextScreen == currentScreen then
            return
        end

        local winID = win:id()
        if not winID then
            return
        end

        local movingToBuiltIn = isBuiltInScreen(nextScreen)
        local currentIsBuiltIn = isBuiltInScreen(currentScreen)

        if movingToBuiltIn and not currentIsBuiltIn then
            previousWindowFrames[winID] = copyFrame(win:frame())
        end

        win:moveToScreen(nextScreen, false, false)

        if movingToBuiltIn then
            win:maximize()
        elseif currentIsBuiltIn then
            local previousFrame = previousWindowFrames[winID]
            if previousFrame then
                win:setFrame(previousFrame)
            end
        end
    end)
end)

bindAltKey('.', function()
    withFocusedWindow(function(win)
        win:moveToUnit({ x = 0.1, y = 0.1, w = 0.8, h = 0.8 })
    end)
end)

local appHotkeys = {
    h = 'ChatGPT',
    d = 'Discord',
    m = 'Mail',
    q = 'Messages',
    b = 'Safari',
    p = 'Spotify',
    v = 'Visual Studio Code',
    w = 'WhatsApp',
    t = 'iTerm',
    i = 'Obsidian',
}

-- Bind Option+<key> to launch or focus the corresponding application.
for key, appName in pairs(appHotkeys) do
    hotkey.bind({ 'alt' }, key, function()
        application.launchOrFocus(appName)
    end)
end
