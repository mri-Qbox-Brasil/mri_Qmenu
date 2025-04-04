local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "spotlight"

local function OpenMenu(mainMenu)
    lib.registerContext(
        {
            id = menuName,
            menu = mainMenu,
            title = "Gerenciar Spotlights",
            options = {
                {
                    title = "Criar novo spotlight",
                    description = "Crie um spotlight.",
                    icon = "square-plus",
                    iconAnimation = "fade",
                    arrow = true,
                    onSelect = function()
                        ExecuteCommand("spotlight")
                    end
                },
                {
                    title = "Deletar",
                    description = "Delete algum spotlight",
                    icon = "x",
                    iconAnimation = "fade",
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
