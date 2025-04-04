local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "crafting"

local function OpenMenu(mainMenu)
    lib.registerContext(
        {
            id = menuName,
            menu = mainMenu,
            title = locale("crafting.menu.title"),
            description = locale("crafting.menu.description"),
            options = {
                {
                    title = locale("crafting.menu.add"),
                    description = locale("crafting.menu.addDescription"),
                    icon = "square-plus",
                    iconAnimation = Config.IconAnimation,
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("craft:create")
                    end
                },
                {
                    title = locale("crafting.menu.list"),
                    description = locale("crafting.menu.listDescription"),
                    icon = "list",
                    iconAnimation = Config.IconAnimation,
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("craft:edit")
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
