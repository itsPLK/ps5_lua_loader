local config_path = "/av_contents/content_tmp/config.txt"

-- Check if the file exists
local file = io.open(config_path, "r")
if not file then
    -- Generate a random number 1 or 2
    math.randomseed(os.time())
    local initial_value = tostring(math.random(1, 2))

    -- Create file with random value
    local new_file = io.open(config_path, "w")
    if new_file then
        new_file:write(initial_value)
        new_file:close()
        notify("Created config.txt with a random value: " .. initial_value)
    else
        notify("Failed to create config.txt")
        return
    end
else
    file:close()
end

-- Read the present value
file = io.open(config_path, "r")
local current = file and file:read("*l") or "1"
if file then file:close() end

-- Convert value to number
local choice = tonumber(current) or 1

-- Execute file based on value
if choice == 1 then
    notify("▶️ Running RemoteLuaLoader (1)")
    dofile("/savedata0/main_remote.lua")
elseif choice == 2 then
    notify("▶️ Running itsPLK (2)")
    dofile("/savedata0/main_plk.lua")
else
    notify("❌ Invalid config.txt value")
end
