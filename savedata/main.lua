local config_path = "/av_contents/content_tmp/config.txt"

local function notify(msg)
    print(msg)  -- Use print temporarily to monitor execution
end

notify("main.lua...")

local file = io.open(config_path, "r")
if not file then
    notify("config.txt not found, will be generated with random value...")

    math.randomseed(os.time() + os.clock() * 1000000)
    local initial_value = tostring(math.random(1, 2))

    local new_file = io.open(config_path, "w")
    if new_file then
        new_file:write(initial_value)
        new_file:close()
        notify("config.txt created with value: " .. initial_value)
    else
        notify("Failed to create config.txt. Check path permissions.")
        return
    end
else
    file:close()
    notify("config.txt already exists.")
end

file = io.open(config_path, "r")
local current = file and file:read("*l") or "0"
if file then file:close() end
notify("Current value in config.txt: " .. tostring(current))

local choice = tonumber(current) or 0

if choice == 1 then
    notify("RemoteLuaLoader")
    local ok, err = pcall(dofile, "/savedata0/main_remote/main_remote.lua")
    if not ok then
        notify("main_remote.lua: " .. tostring(err))
    end
elseif choice == 2 then
    notify("itsPLK")
    local ok, err = pcall(dofile, "/savedata0/main_plk/main_plk.lua")
    if not ok then
        notify("main_plk.lua: " .. tostring(err))
    end
else
    notify("config.txt: " .. tostring(current))
end

notify("main.lua")
