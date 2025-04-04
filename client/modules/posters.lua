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
                title = 'Deletar poster',
                description = 'Deletar um poster.',
                icon = 'trash-can',
                iconAnimation = 'fade',
                arrow = true,
                onSelect = function()
                    local input = lib.inputDialog('Deletar Poster', {
                        { type = 'input', label = 'ID do poster' }
                    })
                    if input then
                        ExecuteCommand('rw_draw++/rem ' .. input[1])
                        lib.notify({
                            title = 'Deletar Poster',
                            description = 'Poster deletado com sucesso.',
                            type = 'success'
                        })
                    end
                end
            },
            {
                title = 'Modo DEV',
                description = 'Habilita o modo DEV para gerenciar os posters.',
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
