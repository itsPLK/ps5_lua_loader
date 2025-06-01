local config_path = "/data/config.txt"

-- قراءة القيمة الحالية
local file = io.open(config_path, "r")
local current = file and file:read("*l") or "1"
if file then file:close() end

-- تحويل إلى رقم إن أمكن
local choice = tonumber(current) or 1

-- التبديل: إذا 1 → 2، إذا 2 → 1، وإلا 1
local next_choice = (choice == 1) and 2 or 1

-- كتابة الخيار التالي
local file_out = io.open(config_path, "w")
if file_out then
    file_out:write(tostring(next_choice))
    file_out:close()
end

-- عرض وتشغيل حسب القيمة الحالية (التي قرأناها)
if choice == 1 then
    notify("Selected RemoteLuaLoader — Running now")
    dofile("/savedata0/main_remote.lua")
elseif choice == 2 then
    notify("Selected itsPLK — Running now")
    dofile("/savedata0/main_plk.lua")
else
    notify("Invalid option in config.txt")
end