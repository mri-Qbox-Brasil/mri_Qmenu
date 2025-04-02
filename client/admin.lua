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

local function loadManageMenuFixedItems(options, categories)
    categories["manage"] = {
        displayName = locale("admin.menu.manageCategory"),
        description = locale("admin.menu.manageCategoryDescription"),
        icon = "fa-solid fa-cogs",
        iconAnimation = Config.IconAnimation,
        parentMenu = "admin"
    }

    if (GetResourceState("ox_doorlock") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Portas",
                icon = "door-closed",
                iconAnimation = Config.IconAnimation,
                description = "Crie ou gerencie as trancas de portas e portões do servidor.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "doorlock",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qblips") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Blips",
                icon = "location-dot",
                iconAnimation = Config.IconAnimation,
                description = "Crie ou gerencie todos os blips, você pode copiar as configurações de um já criado.  ",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "blip",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qstashes") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Baús",
                icon = "box",
                iconAnimation = Config.IconAnimation,
                description = "Crie ou gerencie os baús do servidor, você pode restringir por permissões ou senha.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "bau",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qnpc") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "NPC",
                icon = "users-gear",
                iconAnimation = Config.IconAnimation,
                description = "Crie ou gerencie os NPCs do servidor, você pode colocar animações nos NPCs.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "npc",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qobjects") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Props",
                icon = "tree",
                iconAnimation = Config.IconAnimation,
                description = "Crie ou gerencie os props criados do servidor, você pode editar e criar cenários.",
                category = "manage",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "objectspawner"
            }
        )
    end

    if (GetResourceState("mri_Qelevators") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Elevador",
                icon = "elevator",
                iconAnimation = Config.IconAnimation,
                description = "Crie ou gerencie os elevadores criados, você pode criar quantos andares forem necessários.",
                category = "manage",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "elevador"
            }
        )
    end

    -- Adicione mais menus fixos aqui :)

    return categories, options
end

local function registerMenu(menu, categories)
    local options = loadFixedMenuItems()
    local cats, finalMenu = loadManageMenuFixedItems(menu, categories)
    options = Utils.loadRuntimeMenuItems(options, finalMenu, cats)
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
