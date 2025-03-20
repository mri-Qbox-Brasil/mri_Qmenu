local Menu = lib.require("client/menu")

local function addManageMenu(item)
    Menu.removeItemFromMenu("management", item.title)
    Menu.addItemToMenu("management", item)
end

local function removeManageMenu(item)
    Menu.removeItemFromMenu("management", item.title)
end

local function addPlayerMenu(item)
    Menu.removeItemFromMenu("player", item.title)
    Menu.addItemToMenu("player", item)
end

local function removePlayerMenu(item)
    Menu.removeItemFromMenu("player", item.title)
end

exports("AddManageMenu", addManageMenu)
exports("RemoveManageMenu", removeManageMenu)
exports("AddPlayerMenu", addPlayerMenu)
exports("RemovePlayerMenu", removePlayerMenu)
exports("AddItemToMenu", Menu.addItemToMenu)
exports("RemoveItemFromMenu", Menu.removeItemFromMenu)
