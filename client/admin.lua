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
                onSelectArg = "customs"
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
            onSelectArg = "clock"
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
            onSelectArg = "weather"
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
                onSelectFunction = ExecuteCommand,
                onSelectArg = "objectspawner",
                category = "manage"
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
                onSelectFunction = ExecuteCommand,
                onSelectArg = "elevador",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qdraw") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Outdoors/Posters",
                icon = "panorama",
                iconAnimation = "fade",
                description = "Crie ou gerencie os outdoors ou imagens criados do servidor, você pode adicionar ou remover.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "outdoors",
                category = "manage"
            }
        )
    end

    if (GetResourceState("rhd_garage") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Garagens",
                icon = "warehouse",
                iconAnimation = "fade",
                description = "Crie ou gerencie as garagens criadas do servidor, você pode definir todas as opções in game.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "garagelist",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qcrafting") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Crafting",
                icon = "tools",
                iconAnimation = "fade",
                description = "Crie ou gerencie mesas de fabricação do servidor, você pode usar props para a mesa.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "crafting",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qjobsystem") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Grupos",
                icon = "briefcase",
                iconAnimation = "fade",
                description = "Crie ou gerencie grupos, trabalhos e facções (Jobs e Gangs) in game.",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "groups",
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qspotlights") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = "Spotlight",
                icon = "lightbulb",
                iconAnimation = "fade",
                description = "Crie ou gerencie luzes in game",
                onSelectFunction = ExecuteCommand,
                onSelectArg = "spotlight",
                category = "manage",
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
