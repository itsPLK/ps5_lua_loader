
## PS5 Lua Loader

Fork of [remote_lua_loader](https://github.com/shahrilnet/remote_lua_loader)

Automatically loads umtx kernel exploit, elfloader, your elf payloads, and Lua scripts.
Supports PS5 firmwares up to 10.01 (above 7.61 uses [lapse exploit](https://github.com/shahrilnet/remote_lua_loader/blob/main/payloads/lapse.lua), which is currently unstable).

## How to use
* Create a directory named `ps5_lua_loader`.
* Inside this directory, place your .elf/.bin/.lua files, and an `autoload.txt` file.
    * In autoload.txt, list the files you want to load (one per line).
    * Filenames are case-sensitive - make sure the names exactly match your files.
    * You can add lines like `!1000` to make the loader wait 1000ms before sending the next payload.
    * Note: Do not put kernel exploit (e.g. `umtx.lua`) or elfloader in `autoload.txt`, as they are loaded automatically.
* Put the `ps5_lua_loader` directory in one of these locations:
    * In the root of a USB drive
    * In the internal drive at `/data/ps5_lua_loader`
    * In the game’s savedata folder
* Import savedata to your game:  
  Follow the steps in [SETUP.md](SETUP.md) to prepare and import the savedata for your Lua-compatible game.
   

## Game Compatibility

Currently this loader is compatible with the following games:
  
| Game Title                            | TITLE ID    | Notes                                                                           |
|---------------------------------------|-------------|---------------------------------------------------------------------------------|
| Raspberry Cube                        | CUSA16074   |                                                                                 |
| Aibeya                                | CUSA17068   |                                                                                 |
| Hamidashi Creative                    | CUSA27389   |                                                                                 |
| Hamidashi Creative Demo               | CUSA27390   | Requires latest firmware to download from PSN                                   |
| Aikagi Kimi to Issho ni Pack          | CUSA16229   |                                                                                 |
| Aikagi 2                              | CUSA19556   |                                                                                 |
| IxSHE Tell                            | CUSA17112   |                                                                                 |
| IxSHE Tell Demo                       | CUSA17126   | Requires latest firmware to download from PSN                                   |
| Nora Princess and Stray Cat Heart HD  | CUSA13303   |                                                                                 |
| Jinki Resurrection                    | CUSA25179   |                                                                                 |
| Jinki Resurrection Demo               | CUSA25180   | Requires latest firmware to download from PSN                                   |
| Fuyu Kiss                             | CUSA29745   |                                                                                 |
| Fuyu Kiss Demo                        | CUSA29746   | Requires latest firmware to download from PSN                                   |
| Nora Princess and Crying Cat 2        | CUSA13586   |                                                                                 |
| Haruoto Alice Gram Snow Drop          | CUSA14324   |                                                                                 |

## Updating Savedata

If you have the savedata setup and want to update the files, please refer [UPDATE.md](UPDATE.md)


## Credits

* shahrilnet – creator and maintainer of the original [remote_lua_loader](https://github.com/shahrilnet/remote_lua_loader)
* excellent blog [post](https://memorycorruption.net/posts/rce-lua-factorio/) where most of the ideas of lua primitives are taken from 
* flatz - for sharing ideas and lua implementations
* null_ptr - for helping to develop umtx exploit for PS5 & numerous helps with the loader development
* gezine - for sharing the vulnerable games & ideas
* specter & chendo - for webkit implementations referenced a lot
* al-azif - parts and information grabbed from his sdk, aswell as from his ftp server
* horror - for the notification popup and ftp server payloads
* everyone else who shared their knowledge with the community

