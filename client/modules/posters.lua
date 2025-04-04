local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "posters"

local function OpenMenu(mainMenu)
    lib.registerContext({
        id = menuName,
        menu = mainMenu,
        title = 'Gerenciar Posters',
        options = {
            {
                title = 'Criar poster',
                description = 'Criar um novo Poster.',
                icon = 'square-plus',
                iconAnimation = 'fade',
                arrow = false,
                onSelect = function()
                    ExecuteCommand('rw_draw++/draw')
                end
            },
            {
                title = 'Modo DEV',
                description = 'para deletar use o comando rw_draw++/rem id_do_poster',
                icon = 'list-check',
                iconAnimation = 'fade',
                arrow = true,
                onSelect = function()
                    ExecuteCommand('rw_draw++/dev')
                end
            },
        }
    })
    lib.showContext(menuName)
end

return {
    openMenu = OpenMenu
}
