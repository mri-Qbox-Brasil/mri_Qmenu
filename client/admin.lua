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

local function OpenSubMenu(category, menu)
    local options = {}
    for k, v in pairs(menu) do
        if v.category == category.displayName then
            options[#options + 1] = v
        end
    end
    lib.registerContext(
        {
            id = Config.MenuNameConstant .. category.displayName,
            title = category.displayName,
            description = category.description,
            menu = Config.MenuNameConstant .. category.parentMenu,
            options = options
        }
    )
    lib.showContext(Config.MenuNameConstant .. category.displayName)
end

local function loadRuntimeMenuItems(finalMenu, runtimeMenu, categories)
    if (not runtimeMenu == nil) or (#runtimeMenu > 0) then
        for k, v in pairs(runtimeMenu) do
            if v["category"] then
                local found = false
                local category = categories[v.category]
                for k2, v2 in pairs(finalMenu) do
                    if v2.title == category.displayName then
                        v2.options[#v2.options + 1] = v
                        found = true
                        break
                    end
                end
                if not found then
                    finalMenu[#finalMenu + 1] = {
                        title = category.displayName,
                        icon = category.icon,
                        iconAnimation = category.iconAnimation,
                        description = category.description,
                        arrow = true,
                        onSelect = function()
                            OpenSubMenu(category, runtimeMenu)
                        end
                    }
                end
            else
                finalMenu[#finalMenu + 1] = v
            end
        end
    end
    return finalMenu
end

local function registerMenu(menu, categories)
    local options = loadFixedMenuItems()
    options = loadRuntimeMenuItems(options, menu, categories)
    lib.registerContext(
        {
            id = Config.MenuNameConstant .. "admin",
            title = locale("admin.menu.title", Config.ImgUrl),
            description = "Gerenciamento do servidor",
            options = options
        }
    )
end

return {
    registerMenu = function(menu, categories)
        registerMenu(menu, categories)
    end
}
