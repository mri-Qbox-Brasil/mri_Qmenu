local Menu = lib.require("client/menu")

defaultPlayerMenuKey = "F9"
defaultAdminMenuKey = "F10"

lib.addKeybind(
    {
        name = "player_menu_kbind",
        description = locale("keybind.player.description", defaultPlayerMenuKey),
        defaultKey = defaultPlayerMenuKey,
        onPressed = function()
            Menu.openPlayerMenu()
        end
    }
)

lib.addKeybind(
    {
        name = "admin_menu_kbind",
        description = locale("keybind.admin.description", defaultAdminMenuKey),
        defaultKey = defaultAdminMenuKey,
        onPressed = function()
            Menu.openAdminMenu()
        end
    }
)
