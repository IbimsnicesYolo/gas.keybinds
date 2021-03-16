if CLIENT then
local function checkbinds()
if file.Exists("gmodadminsuite/keybinds/keybinds.txt", "DATA") then 
	GAS.Keybinds = util.JSONToTable(file.Read("gmodadminsuite/keybinds/keybinds.txt", "DATA"))
else 
	local defaultbinds = {
		[1] = {
			["text"] = "Salutieren", 
			["key"] = KEY_E, 
			["bind"] = "act salute"
			}, 
		
		[2] = {
			["text"] = "German in den Arsch treten", 
			["key"] = KEY_R, 
			["bind"] = "say German_SW ist tollllll"
			}
		}
	file.CreateDir("gmodadminsuite/keybinds")
	file.Write("gmodadminsuite/keybinds/keybinds.txt", util.TableToJSON(defaultbinds))
	
local was = file.Read("gmodadminsuite/keybinds/keybinds.txt", "DATA")
	GAS.Keybinds = util.JSONToTable(was)
end
end
hook.Add("PlayerInitialSpawn", "Keynbindchecker", checkbinds())
hook.Add("PlayerButtonDown", "KeybindChecker", function(ply, btn)
for k, j in pairs(GAS.Keybinds) do
	if btn == j.key then
		ply:ConCommand(j.bind)
	else 
	end
    end
end)
end

GAS:hook("gmodadminsuite:ModuleSize:keybinds", "keybinds:framesize", function()
	return 400, 600
end)

GAS:hook("gmodadminsuite:ModuleFrame:keybinds", "keybinds:menu", function(ModuleFrame)
    local main = vgui.Create("bVGUI.Tabs", ModuleFrame)
	main:Dock(TOP)
	main:SetTall(40)
	local w = main:AddTab("Keybind Manager", bVGUI.COLOR_GMOD_BLUE)

	local tab = vgui.Create("bVGUI.ScrollPanel", w)
	tab:SetSize(400, 600)
	tab.Paint = function()
		--draw.RoundedBox(4, 0, 0, ScrW(), ScrH(), Color(255, 0, 0))
	end
	for k, v in pairs(GAS.Keybinds) do
		local base = vgui.Create("DPanel", tab)
		base:Dock(TOP)
		base:SetSize(100, 100)
		base.Paint = function()
        draw.SimpleText(v.text, "DermaDefault", 40, 10, Color(255, 255, 255))
		draw.SimpleText("Command: "..v.bind, "DermaDefault", 40, 30, Color(255, 255, 255))
		end
		local binder = vgui.Create("YBinder", base)
		binder:SetPos(250, 20)
		binder:SetSize(100, 50)
		binder:SetValue(v.key)
        binder.Paint = function()
			draw.RoundedBox(100,0, 0, 100, 50, Color(0, 255, 0) )
		end
		function binder:OnChange( num )
			table.remove( GAS.Keybinds, k )
			table.insert(GAS.Keybinds, k,{
				["text"] = v.text, 
				["key"] = num, 
				["bind"] = v.bind
				} )
			file.Write("gmodadminsuite/keybinds/keybinds.txt", util.TableToJSON(GAS.Keybinds))
		end
	end
	local button = vgui.Create("bVGUI.Button", tab)
	button:Dock(TOP)
	button:SetSize(400, 100)
	button:SetText("Eigenen Bind erstellen")
	button.Paint = function()

		draw.RoundedBox(4, 0, 0, ScrW(), 100, Color(255, 255, 0, 100))
	end
	
	button.DoClick = function(self)
--		Derma_StringRequest(
--			"Yolos Keybind System", 
--			"Gebe den Konsolen Command des Binds ein",
--			"",
--			function(text) local newbind = text
--			local b = true end,
--			function(text) LocalPlayer():ConCommand("gmodadminsuite") end)
--		Derma_StringRequest(
--	"Yolos Keybind System", 
--	"Gebe den Titel des Keybinds ein",
--	"",
--	function(text) local newtext = text
--	local a = true end,
--	function(text) LocalPlayer():ConCommand("gmodadminsuite") end)
--timer.Simple(5, function()
--if a and b then
--		local newbind = {[1] = {
--			["text"] = newtext, 
--			["key"] = KEY_H, 
--			["bind"] = newbind
--			}
--		}
--		b = nil
--		a = nil
--		table.Add( GAS.Keybinds, newbind )
--		PrintTable(GAS.Keybinds)
--		LocalPlayer():ConCommand("gmodadminsuite")
--		checkbinds()
--	end
--
--end)
end
end)
