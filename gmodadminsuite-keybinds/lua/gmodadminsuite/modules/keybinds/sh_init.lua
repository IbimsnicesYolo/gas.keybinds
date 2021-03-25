if (SERVER) then
	AddCSLuaFile("gmodadminsuite/modules/keybinds/cl_keybinds.lua")
	AddCSLuaFile("gmodadminsuite/modules/keybinds/sh_keybinds.lua")
end

GAS:hook("gmodadminsuite:LoadModule:keybinds", "LoadModule:keybinds", function()
include("gmodadminsuite/modules/keybinds/cl_keybinds.lua")
include("gmodadminsuite/modules/keybinds/sh_keybinds.lua")
end)
