local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "posters"

local function OpenMenu(mainMenu)
    lib.registerContext(
        {
            id = menuName,
            menu = mainMenu,
            title = locale("posters.menu.title"),
            description = locale("posters.menu.description"),
            options = {
                {
                    title = locale("posters.menu.add"),
                    description = locale("posters.menu.addDescription"),
                    icon = "square-plus",
                    iconAnimation = "fade",
                    arrow = false,
                    onSelect = function()
                        ExecuteCommand("rw_draw++/draw")
                    end
                },
                {
                    title = locale("posters.menu.remove"),
                    description = locale("posters.menu.removeDescription"),
                    icon = "trash-can",
                    iconAnimation = "fade",
                    arrow = true,
                    onSelect = function()
                        local input =
                            lib.inputDialog(
                            locale("posters.dialog.title"),
                            {
                                {type = "input", label = locale("posters.dialog.label")}
                            }
                        )
                        if input then
                            ExecuteCommand("rw_draw++/rem " .. input[1])
                            lib.notify(
                                {
                                    title = locale("posters.menu.remove"),
                                    description = locale("posters.notification.message"),
                                    type = "success"
                                }
                            )
                        end
                    end
                },
                {
                    title = locale("posters.menu.devMode"),
                    description = locale("posters.menu.devModeDescription"),
                    icon = "list-check",
                    iconAnimation = "fade",
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("rw_draw++/dev")
                    end
                }
            }
        }
    )
    lib.showContext(menuName)
end

return {
    openMenu = OpenMenu
}
