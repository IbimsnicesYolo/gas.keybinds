if (SERVER) then
	AddCSLuaFile("gmodadminsuite/modules/keybinds/cl_keybinds.lua")
	AddCSLuaFile("gmodadminsuite/modules/keybinds/sh_keybinds.lua")
	util.AddNetworkString("sendingGroups")
	util.AddNetworkString("UpdateSMAccessTable")
end

GAS:hook("gmodadminsuite:LoadModule:keybinds", "LoadModule:keybinds", function()
include("gmodadminsuite/modules/keybinds/cl_keybinds.lua")
include("gmodadminsuite/modules/keybinds/sh_keybinds.lua")
end)


groups = groups or {}

	

local function Loading()
if file.Exists("gmodadminsuite/keybinds/groups.txt", "DATA" ) then
 	if SERVER then
	local f = file.Read("gmodadminsuite/keybinds/groups.txt", "DATA" )
    --print("Read file"..f)
	table.Empty(groups)
	groups = util.JSONToTable(f)
	--print("Printing new groups table "..util.TableToJSON(groups))
	--print("Found file")
	 end
else
	if SERVER then
	file.CreateDir("gmodadminsuite/keybinds/")
	--print("created directory")
	end
end
--print("printing groups")
--print(util.TableToJSON(groups))
--print("printed")
if SERVER then
net.Start("sendingGroups")
net.WriteTable(groups)
net.Broadcast()
end
end
 
hook.Add("InitPostEntity", "loads", Loading)




if SERVER then
timer.Create( "SaveGroups", 120, 0, function()
	local g = util.TableToJSON(groups)
	file.Write("gmodadminsuite/keybinds/groups.txt", g)
	--print("Saving DATA")
	--print(g)
	--print("saved")
	Loading()
end)
end

timer.Create( "CheckforGroups", 60, 0, function()
for k, v in pairs(player.GetAll()) do

	--print(v:Nick())
	local g = v:GetUserGroup()
--	print(g)

    if table.HasValue(groups, g) then
		
	else
		table.insert(groups, g)
	end
   --print("Found")
	--print(util.TableToJSON(groups))

 end
  --print("Checked for groups")
end)

net.Receive("UpdateSMAccessTable", function(len, ply)

local a = net.ReadString()
local b = net.ReadString()
print(a)
print(b)
end)
