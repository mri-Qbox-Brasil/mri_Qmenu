lib.addKeybind(
    {
        name = "player_menu_kbind",
        description = "Pressione F9 para abrir o menu do jogador",
        defaultKey = "F9",
        onPressed = function(source)
            exports["mri_Qmenu"]:OpenPlayerMenu(source)
        end
    }
)

lib.addKeybind(
    {
        name = "admin_menu_kbind",
        description = "Pressione F10 para abrir o menu de admin",
        defaultKey = "F10",
        onPressed = function(source)
            exports["mri_Qmenu"]:OpenAdminMenu(source)
        end
    }
)
