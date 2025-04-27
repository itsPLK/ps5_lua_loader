
options = {
    enable_signal_handler = true,
}

WRITABLE_PATH = "/av_contents/content_tmp/"
LOG_FILE = WRITABLE_PATH .. "loader_log.txt"
log_fd = io.open(LOG_FILE, "w")

game_name = nil
eboot_base = nil
libc_base = nil
libkernel_base = nil

gadgets = nil
eboot_addrofs = nil
libc_addrofs = nil

native_cmd_handler = nil
native_invoke = nil

kernel_offset = nil

old_print = print
function print(...)

    local out = prepare_arguments(...) .. "\n"

    old_print(out) -- print to stdout

    if client_fd and native_invoke then
        syscall.write(client_fd, out, #out) -- print to socket
    end

    log_fd:write(out) -- print to file
    log_fd:flush()
end

package.path = package.path .. ";/savedata0/?.lua"

require "globals"
require "offsets"
require "misc"
require "bit32"
require "uint64"
require "struct"
require "lua"
require "memory"
require "ropchain"
require "syscall"
require "signal"
require "native"
require "thread"
require "kernel_offset"
require "kernel"
require "gpu"

function run_lua_code(lua_code, is_local)
    if not is_local then
        assert(client_fd)
    end

    local script, err = loadstring(lua_code)
    if err then
        local err_msg = "error loading script: " .. err
        if client_fd then
            syscall.write(client_fd, err_msg, #err_msg)
        else
            print(err_msg)
        end
        return
    end

    local env = {
        print = function(...)
            local out = prepare_arguments(...) .. "\n"
            if client_fd then
                syscall.write(client_fd, out, #out)
            else
                print(out)
            end
        end,
        printf = function(fmt, ...)
            local out = string.format(fmt, ...) .. "\n"
            if client_fd then
                syscall.write(client_fd, out, #out)
            else
                print(out)
            end
        end
    }

    setmetatable(env, { __index = _G })
    setfenv(script, env)

    err = run_with_coroutine(script)

    if err then
        if client_fd then
            syscall.write(client_fd, err, #err)
        else
            print("Error: " .. err)
        end
    end
end


function load_file(file_path)
    local file = io.open(file_path, "r")
    if not file then
        error("Error opening file: " .. filepath)
    end
    local lua_code = ""
    for line in file:lines() do
        lua_code = lua_code .. line .. "\n"
    end
    file:close()
    return lua_code
end


function main()

    -- setup limited read & write primitives
    lua.setup_primitives()
    print("[+] lua r/w primitives achieved")

    syscall.init()
    print("[+] syscall initialized")

    native.register()
    print("[+] native handler registered")

    print("[+] arbitrary r/w primitives achieved")

    -- resolve required syscalls for remote lua loader
    syscall.resolve({
        read = 0x3,
        write = 0x4,
        open = 0x5,
        close = 0x6,
        getuid = 0x18,
        accept = 0x1e,
        pipe = 0x2a,
        mprotect = 0x4a,
        socket = 0x61,
        connect = 0x62,
        bind = 0x68,
        setsockopt = 0x69,
        listen = 0x6a,
        getsockopt = 0x76,
        sysctl = 0xca,
        nanosleep = 0xf0,
        sigaction = 0x1a0,
        thr_self = 0x1b0,
        dlsym = 0x24f,
        dynlib_load_prx = 0x252,
        dynlib_unload_prx = 0x253,
        is_in_sandbox = 0x249,
    })

    -- setup signal handler
    if options.enable_signal_handler then
        signal.register()
        print("[+] signal handler registered")
    end

    FW_VERSION = get_version()

    thread.init()

    local lua_umtx = load_file("/savedata0/umtx.lua")
    local lua_elf_loader = load_file("/savedata0/elf_loader.lua")

    run_lua_code(lua_umtx, true)
    run_lua_code(lua_elf_loader, true)

    notify("PS5 Lua Autoloader v0.1")

    sleep(10000000)
end

function entry()
    local err = run_with_coroutine(main)
    if err then
        notify(err)
        print(err)
    end
end

entry()
