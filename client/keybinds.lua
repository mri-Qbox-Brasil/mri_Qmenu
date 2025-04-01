local Menu = lib.require("client/menu")
local Config = lib.require("shared/config")

defaultPlayerMenuKey = "F9"
defaultAdminMenuKey = "F10"

lib.addKeybind(
    {
        name = "player_menu_kbind",
        description = locale("player.keybind.description"),
        defaultKey = Config.PlayerMenuKeybind or defaultPlayerMenuKey,
        onPressed = function()
            Menu.openPlayerMenu()
        end
    }
)

lib.addKeybind(
    {
        name = "admin_menu_kbind",
        description = locale("admin.keybind.description"),
        defaultKey = Config.AdminMenuKeybind or defaultAdminMenuKey,
        onPressed = function()
            Menu.openAdminMenu()
        end
    }
)
