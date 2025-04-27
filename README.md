
## PS5 Lua Autoloader

Fork of [remote_lua_loader](https://github.com/shahrilnet/remote_lua_loader)

Instead of starting remote loader, it automatically loads `umtx.lua` and `payload.elf`

By default, `payload.elf` is the ELF loader.  
You can replace it with any ELF payload of your choice.  
You can also place a `payload.elf` file in the `/data/` directory, which will take priority over the one in the savedata directory.

---

Currently this loader is specific for the following list of games:

1. Raspberry Cube (CUSA16074)
2. Aibeya (CUSA17068)
3. Hamidashi Creative (CUSA27389)
4. Hamidashi Creative Demo (CUSA27390) - Requires latest firmware to download from PSN
5. Aikagi Kimi to Issho ni Pack (CUSA16229)
6. Aikagi 2 (CUSA19556)
7. IxSHE Tell (CUSA17112)
8. Nora Princess and Stray Cat Heart HD (CUSA13303) - Requires manual loading of savegame
   - Rename save9999.dat into nora_01.dat.


For guide on how to setup this loader, please refer [SETUP.md](SETUP.md)


## Credits

* excellent blog [post](https://memorycorruption.net/posts/rce-lua-factorio/) where most of the ideas of lua primitives are taken from 
* flatz - for sharing ideas and lua implementations
* null_ptr - for helping to develop umtx exploit for PS5 & numerous helps with the loader development
* gezine - for sharing the vulnerable games & ideas
* specter & chendo - for webkit implementations which i refer a lot
* al-azif - parts and information grabbed from his sdk, aswell as from his ftp server
* horror - for the notification popup and ftp server payloads
* everyone else who shared their knowledge with the community

