local config_path = "/data/config.txt"

-- Read the present value
local file = io.open(config_path, "r")
local current = file and file:read("*l") or "1"
if file then file:close() end

-- Convert to number if possible
local choice = tonumber(current) or 1

-- Switch: if 1 → 2, if 2 → 1, else 1
local next_choice = (choice == 1) and 2 or 1

-- Write the following option
local file_out = io.open(config_path, "w")
if file_out then
    file_out:write(tostring(next_choice))
    file_out:close()
end

-- Display and play by current value (which we read)
if choice == 1 then
    notify("Selected RemoteLuaLoader — Running now")
    dofile("/savedata0/main_remote.lua")
elseif choice == 2 then
    notify("Selected itsPLK — Running now")
    dofile("/savedata0/main_plk.lua")
else
    notify("Invalid option in config.txt")
end