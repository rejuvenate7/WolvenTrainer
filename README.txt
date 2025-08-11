>--- Wolven Trainer ---<
A powerful trainer for The Witcher 3: Wild Hunt

>--- Installation ---<
Install ASI Loader (https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/latest/download/Ultimate-ASI-Loader_x64.zip)
Copy d8input.dll to install directory > bin > x64 and x64_dx12
d8input.dll should be in the same folder as witcher3.exe
Install Wolven Trainer
Extract the contents of .zip file and drag and drop all files into your Witcher 3 install directory. Replace if prompted.
Install Community Patch - Shared Imports (https://www.nexusmods.com/witcher3/mods/2110)

For DX11: 
Navigate to your Witcher 3 install directory > bin > x64
Right click "witcher3.exe" and create shortcut
Right click the new Witcher 3 shortcut and click properties
Under "Target:" add -net -debugscripts to the end of the text
Example:
"C:\Program Files (x86)\GOG Galaxy\Games\The Witcher 3 Wild Hunt GOTY\bin\x64\witcher3.exe" -net -debugscripts
Apply and press OK.
Launch the game with this shortcut from now on.
Optionally, configure launch parameters in Steam/GOG to use -net -debugscripts.

For DX12: 
Same as above except navigate to install directory > bin > x64_dx12

>--- Controls ---<
Wolven Trainer supports both Keyboard & Gamepad, Controls are:
Open Trainer = F4
Move Up = Arrow Key up
Move Down Arrow Key down
Move Back = Backspace
Select = Enter Key
Gamepad Open Key = RB + A

>--- Custom Themes ---<
Custom themes are supported with Wolven Trainer.
To edit a custom theme, navigate to install directory > bin > WolvenTrainer > themes
Banners: Replace any of the .png files with a different .png file of the same name and size. (441 x 118 pixels)
Colors: Edit themes.xml and change the RGB values of custom theme
The font can also be changed, although it is not recommended (navigate to bin > WolvenTrainer > fonts)
Replace the font files with files of the same name.

>--- Profiles ---<
You can load and save menu profiles with Wolven Trainer. 
Loading a profile will override all currently enabled options with your profile's options.
In Wolven Trainer menu, navigate to Settings -> Load / Save

>--- Translations ---<
To create a translation for Wolven Trainer, navigate to install directory > bin > WolvenTrainer > languages
Create a new .xml using the template of example.xml already provided in the folder.
Translations work by replacing the original line with the new line.
Game restart recommended when enabling a new translation.

>--- Terms & Rules ---<
The Software is provided "As Is", without warranty of any kind.
The Software is completely free and it's forbidden to sell or use it in any commercial way.
You are not allowed to redistribute this software without permission.
You are not allowed to modify or reverse code as well as debugging / patching
You take full responsibility for your actions using this product.
Software support may be stopped at any time without any reason.
This terms may be updated at any time without any reason.

>--- Credits ---<
Created by rejuvenate7 (on discord and Nexus Mods)
Rusty Witcher 3 Debugger (https://github.com/SpontanCombust/rusty_witcher_debugger)
Dear ImGui (https://github.com/ocornut/imgui)
pugixml (https://github.com/zeux/pugixml)
SDL3 (https://github.com/libsdl-org/SDL)

>--- Changelog ---<
Initial Release

Version 1.0