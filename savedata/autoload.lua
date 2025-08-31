
-- autoload.lua
-- This script loads and runs Lua scripts or ELF files from a specified directory on the PS5.
-- Lua scripts are executed directly, while ELF files are sent to a local server running on port 9021.

autoload = {}
autoload.options = {
    autoload_dirname = "ps5_lua_loader", -- directory where the elfs, lua scripts and autoload.txt are located
    autoload_config = "autoload.txt",
}


elf_sender = {}
elf_sender.__index = elf_sender


syscall.resolve(
    {
        sendto = 133
    }
)

function elf_sender:load_from_file(filepath)
    if not elf_loader_active then
        start_elf_loader()
    end

    if file_exists(filepath) then
        print("Loading elf from:", filepath)
        if SHOW_DEBUG_NOTIFICATIONS then
            send_ps_notification("Loading elf from: \n" .. filepath)
        end
    else
        print("[-] File not found:", filepath)
        send_ps_notification("[-] File not found: \n" .. filepath)
    end

    local self = setmetatable({}, elf_sender)
    self.filepath = filepath
    self.elf_data = file_read(filepath)
    self.elf_size = #self.elf_data

    print("elf size:", self.elf_size)
    return self
end

function elf_sender:sceNetSend(sockfd, buf, len, flags, addr, addrlen)
    return syscall.sendto(sockfd, buf, len, flags, addr, addrlen):tonumber()
end
function elf_sender:sceNetSocket(domain, type, protocol)
    return syscall.socket(domain, type, protocol):tonumber()
end
function elf_sender:sceNetSocketClose(sockfd)
    return syscall.close(sockfd):tonumber()
end
function elf_sender:htons(port)
    return bit32.bor(bit32.lshift(port, 8), bit32.rshift(port, 8)) % 0x10000
end

function elf_sender:send_to_localhost(port)

    local sockfd = elf_sender:sceNetSocket(2, 1, 0) -- AF_INET=2, SOCK_STREAM=1
    print("Socket fd:", sockfd)
    assert(sockfd >= 0, "socket creation failed")
    local enable = memory.alloc(4)
    memory.write_dword(enable, 1)
    syscall.setsockopt(sockfd, 1, 2, enable, 4) -- SOL_SOCKET=1, SO_REUSEADDR=2

    local sockaddr = memory.alloc(16)

    memory.write_byte(sockaddr + 0, 16)
    memory.write_byte(sockaddr + 1, 2) -- AF_INET
    memory.write_word(sockaddr + 2, elf_sender:htons(port))

    memory.write_byte(sockaddr + 4, 0x7F) -- 127
    memory.write_byte(sockaddr + 5, 0x00) -- 0
    memory.write_byte(sockaddr + 6, 0x00) -- 0
    memory.write_byte(sockaddr + 7, 0x01) -- 1

    local buf = memory.alloc(#self.elf_data)
    memory.write_buffer(buf, self.elf_data)

    local total_sent = elf_sender:sceNetSend(sockfd, buf, #self.elf_data, 0, sockaddr, 16)
    elf_sender:sceNetSocketClose(sockfd)
    if total_sent < 0 then
        print("[-] error sending elf data to localhost")
        send_ps_notification("error sending elf data to localhost")
        return
    end
    print(string.format("Successfully sent %d bytes to loader", total_sent))
end


function main()
    -- Build possible paths, prioritizing USBs first, then /data, then savedata
    local possible_paths = {}
    for usb = 0, 7 do
        table.insert(possible_paths, string.format("/mnt/usb%d/%s/", usb, autoload.options.autoload_dirname))
    end
    table.insert(possible_paths, string.format("/data/%s/", autoload.options.autoload_dirname))
    table.insert(possible_paths, get_savedata_path() .. autoload.options.autoload_dirname .. "/")

    local existing_path = nil
    for _, path in ipairs(possible_paths) do
        if file_exists(path .. autoload.options.autoload_config) then
            existing_path = path
            break
        end
    end

    if not existing_path then
        send_ps_notification("autoload config not found")
        print("[-] autoload config not found")
        return
    end

    print("Loading autoload config from:", existing_path .. autoload.options.autoload_config)
    if SHOW_DEBUG_NOTIFICATIONS then
        send_ps_notification("Loading autoload config from: \n" .. existing_path .. autoload.options.autoload_config)
    end
    local config = io.open(existing_path .. autoload.options.autoload_config, "r")

    for config_line in config:lines() do

        if config_line == "" or config_line:sub(1, 1) == "#" then
            -- skip empty lines and comments
        elseif config_line:sub(1, 1) == "!" then
            -- sleep line
            -- usage: !1000 to sleep for 1000ms
            local sleep_time = tonumber(config_line:sub(2))
            if type(sleep_time) ~= "number" then
                print("[ERROR] Invalid sleep time:", config_line:sub(2))
                send_ps_notification("[ERROR] Invalid sleep time: \n" .. config_line:sub(2))
                return
            end
            print(string.format("Sleeping for: %s ms", sleep_time))
            sleep(sleep_time, "ms")

        elseif config_line:sub(-4) == ".elf" or config_line:sub(-4) == ".bin" then
            -- error if elfldr is in autoload.txt
            if config_line == "elfldr.elf" or config_line == "elfldr.bin" then
                print("[ERROR] Remove elfldr from autoload.txt")
                send_ps_notification("[ERROR] Remove elfldr from autoload.txt")
                return
            end
            local full_path = existing_path .. config_line
            if file_exists(full_path) then
                -- Load the ELF file and send it to localhost on port 9021
                elf_sender:load_from_file(full_path):send_to_localhost(9021)
            else
                print("[ERROR] File not found:", full_path)
                send_ps_notification("[ERROR] File not found: \n" .. full_path)
            end

        elseif config_line:sub(-4) == ".lua" then
            -- error if umtx.lua is in autoload.txt
            if config_line == "umtx.lua" then
                print("[ERROR] Remove umtx.lua from autoload.txt")
                send_ps_notification("[ERROR] Remove umtx.lua from autoload.txt")
                return
            end
            local full_path = existing_path .. config_line
            if file_exists(full_path) then
                -- Load the Lua script and run it
                print("Loading Lua script from:", full_path)
                if SHOW_DEBUG_NOTIFICATIONS then
                    send_ps_notification("Loading lua from: \n" .. full_path)
                end
                load_and_run_lua(full_path)
            else
                print("[ERROR] File not found:", full_path)
                send_ps_notification("[ERROR] File not found: \n" .. full_path)
            end

        else
            print("[ERROR] Unsupported file type:", config_line)
            send_ps_notification("[ERROR] Unsupported file type: \n" .. config_line)
        end

    end
    config:close()
end


main()
