local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "jobs"

local function OpenMenu(mainMenu)
    lib.registerContext({
        id = menuName,
        menu = mainMenu,
        title = 'Gerenciar Grupos',
        options = {
            {
                title = 'Criar novo grupo',
                description = 'Crie um job ou gang',
                icon = 'square-plus',
                iconAnimation = 'fade',
                arrow = true,
                onSelect = function()
                    ExecuteCommand('createjob')
                end
            },
            {
                title = 'Ver lista',
                description = 'Veja todos grupos criados.',
                icon = 'list',
                iconAnimation = 'fade',
                arrow = true,
                onSelect = function()
                    ExecuteCommand('open_jobs')
                end
            },
        }
    })
    lib.showContext(menuName)
end

return {
    openMenu = OpenMenu
}
