# SplitByMats
3ds Max script to split selected pbjects or whole scene by materials.<br />
Very useful when preparing the models extracted from various games.<br />
Written and tested on 3ds Max 2024, but should work on all modern versions.<br />

![image](https://github.com/oxmaulmike2581/SplitByMats/assets/28642811/d35a3303-de92-4488-9db8-a6abc16f6c08)


## Includes
* splitByMats.mcr - split all geometry objects in the scene automatically
* splitByMats_selected.mcr - split only selected objects

## Features
* Split each geometry object by its materials
* Adds the name of the material at the end of each splitted object
* Preserve vertex normals when splitting
* Works with embedded Multi-Sub objects
* Convert non-Editable Poly objects to Editable Poly automatically

## Installation
* go to Scripting -> Run Script
* Select "splitByMats.mcr" or "splitByMats_selected.mcr"
* go to Customize -> Customize User Interface
* switch to Toolbars tab
* find "Scripts by Mike" category
* drag the script's name to your toolbar(s)
* repeat for second script if you need to install both of them

### If you don't have a toolbar for scripts...
* go to Customize -> Customize User Interface
* switch to Toolbars tab
* press "New..." button and enter any name you like
* drag a small thing (yes, this is toolbar) at the top, where other icons are placed

## Bugs / Errors
* If you see an error about line 57, it means that you're trying to split an already splitted object

## License
* MIT

