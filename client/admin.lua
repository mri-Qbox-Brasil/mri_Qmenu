local Config = lib.require('shared/config')
local Utils = lib.require('client/utils')

local function loadFixedMenuItems()
    local options = {}

    options[#options + 1] = Utils.createMenuItem(
        locale("admin.menu.admin"),
        "fa-solid fa-user-tie",
        Config.IconAnimation,
        locale("admin.menu.adminDescription"),
        ExecuteCommand,
        "adm"
    )

    if IsPedInAnyVehicle(cache.ped) then
        options[#options + 1] = Utils.createMenuItem(
            locale("admin.menu.customs"),
            "palette",
            Config.IconAnimation,
            locale("admin.menu.customsDescription"),
            ExecuteCommand,
            "customs"
        )
    end

    options[#options + 1] = Utils.createMenuItem(
        locale("admin.menu.clock"),
        "clock",
        Config.IconAnimation,
        locale("admin.menu.clockDescription"),
        ExecuteCommand, -- AbrirMenuTime()
        "clock"
    )

    options[#options + 1] = Utils.createMenuItem(
        locale("admin.menu.weather"),
        "cloud",
        Config.IconAnimation,
        locale("admin.menu.weatherDescription"),
        ExecuteCommand,
        "weather"
    )
    
    options[#options + 1] = Utils.createMenuItem(
        locale("admin.menu.manage"),
        "a-solid fa-cogs",
        Config.IconAnimation,
        locale("admin.menu.manageDescription"),
        ExecuteCommand, -- AbrirManageMenu
        "manage"
    )

    return options
end

local function loadRuntimeMenuItems(finalMenu, adminMenu, managementMenu)
    return finalMenu
end

local function registerMenu(adminMenu, managementMenu)
    local options = loadFixedMenuItems()
    options = loadRuntimeMenuItems(options, adminMenu, managementMenu)
    lib.registerContext({
        id = 'menu_admin',
        title = locale("admin.menu.title", Config.ImgUrl),
        description = 'Gerenciamento do servidor',
        options = options
    })
end

return {
    registerMenu = function(adminMenu, managementMenu)
        registerMenu(adminMenu, managementMenu)
    end
}
