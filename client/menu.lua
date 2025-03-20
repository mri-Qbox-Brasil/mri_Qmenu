local ColorScheme = {
    success = "#51CF66",
    info = "#668CFF",
    warning = "#FFD700",
    danger = "#FF6347"
}
GlobalState:set("UIColors", ColorScheme, true)
local imageUrl = "https://cfx-nui-mri_Qbox/web-side/icones/logo24.png"

local PlayerMenu = lib.require('client/player')
local AdminMenu = lib.require('client/admin')

local menus = {
    "admin" = {},
    "player" = {},
    "management" = {}
}

local function getItemIndex(menu, title, operation)
    for k, v in pairs(menu) do
        if v.title == title then
            return k
        end
    end
    if operation = "add" then
        return #menu + 1
    end
    return nil
end

local function createMenuItem(title, icon, iconAnimation, description, onSelectFunction, onSelectArg, arrow)
    return {
        title = title,
        icon = icon,
        iconAnimation = iconAnimation,
        description = description,
        arrow = arrow or false,
        onSelect = function()
            if onSelectArg then
                onSelectFunction(onSelectArg)
            else
                onSelectFunction()
            end
        end
    }
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
        menu[index] = createMenuItem(item.title, item.icon, item.iconAnimation, item.description, item.onSelectFunction, item.onSelectArg, item.arrow)
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
        Admin.registerMenu(menus['admin'], menu['management'])
        lib.showContext('menu_admin')
    end,
    openPlayerMenu = function()
        Player.registerMenu(menus['player'])
        lib.showContext('menu_jogador')
    end
}
