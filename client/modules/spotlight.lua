ColorScheme = GlobalState.UIColors
local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "spotlight"

local function OpenMenu(mainMenu)
    lib.registerContext(
        {
            id = menuName,
            menu = mainMenu,
            title = locale("spotlight.menu.title"),
            description = locale("spotlight.menu.description"),
            options = {
                {
                    title = locale("spotlight.menu.add"),
                    description = locale("spotlight.menu.addDescription"),
                    icon = "square-plus",
                    iconAnimation = Config.IconAnimation,
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("spotlight")
                    end
                },
                {
                    title = locale("spotlight.menu.remove"),
                    description = locale("spotlight.menu.removeDescription"),
                    icon = "trash-can",
                    iconColor = ColorScheme.danger,
                    iconAnimation = Config.IconAnimation,
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("spotlight 1")
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
