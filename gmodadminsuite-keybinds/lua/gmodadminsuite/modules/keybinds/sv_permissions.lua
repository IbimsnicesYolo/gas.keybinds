
local function OpenPermissions_Init()
	GAS:unhook("OpenPermissions:Ready", "keybinds:OpenPermissions")

	function GAS.keybinds:ReloadPermissions()
		GAS.keybinds.OpenPermissions = OpenPermissions:RegisterAddon("gmodadminsuite_keybinds", {
			Name = "GmodAdminSuite keybinds Restriction",
			Color = Color(216,39,76),
			Icon = "icon16/script_gear.png"
		})

		for cmd, options in pairs(GAS.keybinds.Config.keybinds) do
			GAS.keybinds.OpenPermissions:AddToTree({
				Label = cmd,
				Value = cmd,
				Icon = "icon16/user_comment.png",
				Default = OpenPermissions.CHECKBOX.TICKED
			})
		end
	end

	GAS.keybinds:ReloadPermissions()
end
if (OpenPermissions_Ready == true) then
	OpenPermissions_Init()
else
	GAS:hook("OpenPermissions:Ready", "keybinds:OpenPermissions", OpenPermissions_Init)
end





