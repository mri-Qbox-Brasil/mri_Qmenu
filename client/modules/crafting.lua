local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "crafting"

local function OpenMenu(mainMenu)
    lib.registerContext({
        id = menuName,
        menu = mainMenu,
        title = 'Gerenciar Craftings',
        options = {
            {
                title = 'Criar nova mesa',
                description = 'Crie uma mesa de fabricação nova.',
                icon = 'square-plus',
                iconAnimation = 'fade',
                arrow = true,
                onSelect = function()
                    ExecuteCommand('craft:create')
                end
            },
            {
                title = 'Ver lista',
                description = 'Veja todas as mesas de fabricação criadas.',
                icon = 'list',
                iconAnimation = 'fade',
                arrow = true,
                onSelect = function()
                    ExecuteCommand('craft:edit')
                end
            },
        }
    })
    lib.showContext(menuName)
end

return {
    openMenu = OpenMenu
}
