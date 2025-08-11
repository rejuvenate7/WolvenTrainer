# Wolven Trainer
A powerful trainer for The Witcher 3: Wild Hunt<br>
https://www.nexusmods.com/witcher3/mods/11154<br>

## Installation
Install ASI Loader (https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/latest/download/Ultimate-ASI-Loader_x64.zip)<br>
Copy d8input.dll to install directory > bin > x64 and x64_dx12<br>
d8input.dll should be in the same folder as witcher3.exe<br>
Install Wolven Trainer<br>
Extract the contents of .zip file and drag and drop all files into your Witcher 3 install directory. Replace if prompted.<br>
Install Community Patch - Shared Imports (https://www.nexusmods.com/witcher3/mods/2110)<br>

For DX11: <br>
Navigate to your Witcher 3 install directory > bin > x64<br>
Right click "witcher3.exe" and create shortcut<br>
Right click the new Witcher 3 shortcut and click properties<br>
Under "Target:" add -net -debugscripts to the end of the text<br>
Example:<br>
"C:\Program Files (x86)\GOG Galaxy\Games\The Witcher 3 Wild Hunt GOTY\bin\x64\witcher3.exe" -net -debugscripts<br>
Apply and press OK.<br>
Launch the game with this shortcut from now on.<br>
Optionally, configure launch parameters in Steam/GOG to use -net -debugscripts.<br>

For DX12: <br>
Same as above except navigate to install directory > bin > x64_dx12<br>
Use borderless fullscreen ingame.<br>

## Controls
Wolven Trainer supports both Keyboard & Gamepad, Controls are:<br>
Open Trainer = F4<br>
Move Up = Arrow Key up<br>
Move Down Arrow Key down<br>
Move Back = Backspace<br>
Select = Enter Key<br>
Gamepad Open Key = RB + A<br>

## Custom Themes
Custom themes are supported with Wolven Trainer.<br>
To edit a custom theme, navigate to install directory > bin > WolvenTrainer > themes<br>
Banners: Replace any of the .png files with a different .png file of the same name and size. (441 x 118 pixels)<br>
Colors: Edit themes.xml and change the RGB values of custom theme<br>
The font can also be changed, although it is not recommended (navigate to bin > WolvenTrainer > fonts)<br>
Replace the font files with files of the same name.<br>

## Profiles
You can load and save menu profiles with Wolven Trainer. <br>
Loading a profile will override all currently enabled options with your profile's options.<br>
In Wolven Trainer menu, navigate to Settings -> Load / Save<br>

## Translations
To create a translation for Wolven Trainer, navigate to install directory > bin > WolvenTrainer > languages<br>
Create a new .xml using the template of example.xml already provided in the folder.<br>
Translations work by replacing the original line with the new line.<br>
Game restart recommended when enabling a new translation.<br>

## Terms & Rules
The Software is provided "As Is", without warranty of any kind.<br>
The Software is completely free and it's forbidden to sell or use it in any commercial way.<br>
You are not allowed to redistribute this software without permission.<br>
You are not allowed to modify or reverse code as well as debugging / patching<br>
You take full responsibility for your actions using this product.<br>
Software support may be stopped at any time without any reason.<br>
This terms may be updated at any time without any reason.<br>

## Credits
Created by rejuvenate7 (on discord and Nexus Mods)<br>
Rusty Witcher 3 Debugger (https://github.com/SpontanCombust/rusty_witcher_debugger)<br>
Dear ImGui (https://github.com/ocornut/imgui)<br>
pugixml (https://github.com/zeux/pugixml)<br>
SDL3 (https://github.com/libsdl-org/SDL)<br>

## Changelog
Initial Release<br>

Version 1.0<br>
