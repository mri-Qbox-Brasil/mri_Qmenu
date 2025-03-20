local Menu = lib.require("client/menu")

defaultPlayerMenuKey = "F9"
defaultAdminMenuKey = "F10"

lib.addKeybind(
    {
        name = "player_menu_kbind",
        description = locale("player.keybind.description"),
        defaultKey = defaultPlayerMenuKey,
        onPressed = function()
            Menu.openPlayerMenu()
        end
    }
)

lib.addKeybind(
    {
        name = "admin_menu_kbind",
        description = locale("admin.keybind.description"),
        defaultKey = defaultAdminMenuKey,
        onPressed = function()
            Menu.openAdminMenu()
        end
    }
)
