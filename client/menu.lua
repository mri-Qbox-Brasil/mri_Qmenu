local Utils = lib.require('client/utils')
local PlayerMenu = lib.require('client/player')
local AdminMenu = lib.require('client/admin')

local menus = {
    admin = {},
    player = {},
    management = {}
}

local function getItemIndex(menu, title, operation)
    for k, v in pairs(menu) do
        if v.title == title then
            return k
        end
    end
    if operation == "add" then
        return #menu + 1
    end
    return nil
end

function getMenu(menuName)
    return menus[menuName] or nil
end

return {
    addItemToMenu = function(menuName, item)
        local menu = getMenu(menuName)
        if not menu then
            return
        end
        local index = getItemIndex(menu, item.title, "add")
        menu[index] = Utils.createMenuItem(item.title, item.icon, item.iconAnimation, item.description, item.onSelectFunction, item.onSelectArg, item.arrow)
    end,
    removeItemFromMenu = function(menuName, itemName)
        local menu = getMenu(menuName)
        if not menu then
            return
        end
        local index = getMenuIndex(menu, itemName)
        if not index then
            return
        end
        menu[index] = nil
    end,
    openAdminMenu = function()
        AdminMenu.registerMenu(menus['admin'], menus['management'])
        lib.showContext('menu_admin')
    end,
    openPlayerMenu = function()
        PlayerMenu.registerMenu(menus['player'])
        lib.showContext('menu_jogador')
    end
}
