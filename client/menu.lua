local Utils = lib.require("client/utils")
local PlayerMenu = lib.require("client/player")
local AdminMenu = lib.require("client/admin")

local menus = {}
local categories = {}

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

local function getMenu(menuName)
    return menus[menuName] or {}
end

local function setMenu(menuName, data)
    menus[menuName] = data
end

return {
    addItemToMenu = function(menuName, item, category)
        local menu = getMenu(menuName)
        if not menu then
            print(string.format("Menu "%s" not found", menuName))
            return
        end
        local index = getItemIndex(menu, item.title, "add")
        menu[index] = Utils.createMenuItem(item)
        setMenu(menuName, menu)
    end,
    removeItemFromMenu = function(menuName, itemName)
        local menu = getMenu(menuName)
        if not menu then
            return
        end
        local index = getItemIndex(menu, itemName)
        if not index then
            return
        end
        menu[index] = nil
        setMenu(menuName, menu)
    end,
    addCategory = function(category)
        if (category.displayName == "admin") or (category.displayName == "player") then
            print(
                string.format(
                    "%s: %s",
                    locale("error.admin.menu.reservedWord"),
                    locale("error.admin.menu.reservedWordDescription", category.displayName)
                )
            )
            return
        end
        categories[category.displayName] = {
            displayName = category.displayName,
            description = category.description,
            icon = category.icon,
            iconAnimation = category.iconAnimation,
            parentMenu = category.parentMenu
        }
    end,
    removeCategory = function(name)
        categories[name] = nil
    end,
    openAdminMenu = function()
        if lib.callback.await("mri_Qmenu:server:HasPermission", false) then
            AdminMenu.registerMenu(getMenu("admin"), categories)
            lib.showContext(Config.MenuNameConstant .. "admin")
        else
            lib.notify({
                type = "error",
                title = locale("error.admin.menu.notAllowedTitle"),
                description = locale("error.admin.menu.notAllowedDescription")
            })
        end
    end,
    openPlayerMenu = function()
        PlayerMenu.registerMenu(getMenu("player"))
        lib.showContext(Config.MenuNameConstant .. "player")
    end
}
