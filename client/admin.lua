local Config = lib.require("shared/config")
local Utils = lib.require("client/utils")

local function loadFixedMenuItems()
    local options = {}

    options[#options + 1] =
        Utils.createMenuItem(
        {
            title = locale("admin.menu.admin"),
            icon = "fa-solid fa-user-tie",
            iconAnimation = Config.IconAnimation,
            description = locale("admin.menu.adminDescription"),
            onSelectFunction = ExecuteCommand,
            onSelectArg = "adm"
        }
    )

    if IsPedInAnyVehicle(cache.ped) then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("admin.menu.customs"),
                icon = "palette",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.customsDescription"),
                onSelectFunction = ExecuteCommand,
                onSelecArg = "customs"
            }
        )
    end

    options[#options + 1] =
        Utils.createMenuItem(
        {
            title = locale("admin.menu.clock"),
            icon = "clock",
            iconAnimation = Config.IconAnimation,
            description = locale("admin.menu.clockDescription"),
            onSelectFunction = ExecuteCommand, -- AbrirMenuTime()
            onSelecArg = "clock"
        }
    )

    options[#options + 1] =
        Utils.createMenuItem(
        {
            title = locale("admin.menu.weather"),
            icon = "cloud",
            iconAnimation = Config.IconAnimation,
            description = locale("admin.menu.weatherDescription"),
            onSelectFunction = ExecuteCommand,
            onSelecArg = "weather"
        }
    )

    -- Adicione mais menus fixos aqui :)

    return options
end

local function registerMenu(menu, categories)
    local options = loadFixedMenuItems()
    options = Utils.loadRuntimeMenuItems(options, menu, categories)
    lib.registerContext(
        {
            id = Config.MenuNameConstant .. "admin",
            title = locale("admin.menu.title", Config.ImgUrl),
            description = locale("admin.menu.description"),
            options = options
        }
    )
end

return {
    registerMenu = function(menu, categories)
        registerMenu(menu, categories)
    end
}
