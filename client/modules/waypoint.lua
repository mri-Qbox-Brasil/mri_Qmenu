local ColorScheme = GlobalState.UIColors
local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "crafting"

local function OpenMenu(mainMenu)
    lib.registerContext(
        {
            id = menuName,
            menu = mainMenu,
            title = locale("waypoint.menu.title"),
            description = locale("waypoint.menu.description"),
            options = {
                {
                    title = locale("waypoint.menu.clear"),
                    description = locale("waypoint.menu.clearDescription"),
                    icon = "trash-can",
                    iconAnimation = Config.IconAnimation,
                    iconColor = ColorScheme.danger,
                    onSelect = function()
                        ExecuteCommand("clearwaypoints")
                    end
                },
                {
                    title = locale("waypoint.menu.settings"),
                    description = locale("waypoint.menu.settingsDescription"),
                    icon = "location-dot",
                    iconAnimation = Config.IconAnimation,
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("waypointsettings")
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
