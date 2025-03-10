What's it do:
Converts all cartridge roms into 7z files and all disc roms into chd files which saves you between 35% and 45% total storage space for your games. Both 7z and CHD formats are playable by the emulators for all suggested systems so you save a ton of space at no cost. It can also extract compressed CHD files in case you want to apply a new patch or have a version of the rom that works on a console. This script can also fix improperly compressed iso files that were turned into chd files using incorrect formatting and will slow down PS2 emulation and probably break PSP emulation of those files. Note that MAME arcade, Neo Geo, and DOSbox games can be compressed to 7z from folders with all necessary game files inside.

Is there anything I shouldn't compress:
Yes. GameCube, Wii, Wii U, and Xbox 360 roms can be compressed via their emulators. And Xbox, PS Vita, PS3, PS4, Switch, and 3DS roms currently can not be played in compressed formats. Also while you can compress PSP roms the developers of that emulator suggest you use CSO compression instead which does not compress the games as much but the emulator plays them fractions of a second faster, the choice is yours though.

Warnings:
You need 7zip installed to your C drive if you want to compress cartridge based roms with this script and chman.exe which is included with every MAME download in the same folder with this script if you wish to compress disc based roms. Anything in the folder with this script when it is ran will be compressed and the original files/folders will be deleted upon successful compression. Also note that PS2 games could have been CUE or ISO roms so if you want to extract PS2 games from CHD to their original format (to patch or play on original hardware) you should check Redump and see if the game is one of the few CD games (Extract to CUE) or DVD (vast majority, extract to ISO).
CD (CUE) - http://redump.org/discs/system/ps2/media/cd
DVD (ISO) - http://redump.org/discs/system/ps2/media/dvd

How does it work:
First it checks for CHD files, if it finds them it asks you what format you would like to extract them to. It also has an option here for fixing ISO files improperly compressed using cd compression format which the vast majority of compression programs/scripts (NamDHC for example) uses.
If no CHD files are found it checks for any disc roms and if they are present it compresses them to the proper chd format (cd for CUE/GDI and dvd for ISO).
If no disc roms are found the script then compresses any files in the folder to 7z format for the remaining roms.
