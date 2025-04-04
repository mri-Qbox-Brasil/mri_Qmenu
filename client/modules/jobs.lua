local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "jobs"

local function OpenMenu(mainMenu)
    lib.registerContext(
        {
            id = menuName,
            menu = mainMenu,
            title = locale("jobs.menu.title"),
            description = locale("jobs.menu.description"),
            options = {
                {
                    title = locale("jobs.menu.add"),
                    description = locale("jobs.menu.addDescription"),
                    icon = "square-plus",
                    iconAnimation = "fade",
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("createjob")
                    end
                },
                {
                    title = locale("jobs.menu.list"),
                    description = locale("jobs.menu.listDescription"),
                    icon = "list",
                    iconAnimation = "fade",
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("open_jobs")
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
