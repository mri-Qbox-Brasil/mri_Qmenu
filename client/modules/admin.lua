local Config = lib.require("shared/config")
local Utils = lib.require("client/utils")
local Time = lib.require("client/modules/time")
local Spotlight = lib.require("client/modules/spotlight")
local Crafting = lib.require("client/modules/crafting")
local Jobs = lib.require("client/modules/jobs")
local Posters = lib.require("client/modules/posters")

local function loadFixedMenuItems(mainMenu)
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
            onSelectFunction = function()
                Time.openMenu(mainMenu)
            end
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
        name = "manage",
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
                title = locale("admin.menu.doors"),
                icon = "door-closed",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.doorsDescription"),
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
                title = locale("admin.menu.blips"),
                icon = "location-dot",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.blipsDescription"),
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
                title = locale("admin.menu.stashes"),
                icon = "box",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.stashesDescription"),
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
                title = locale("admin.menu.npc"),
                icon = "users-gear",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.npcDescription"),
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
                title = locale("admin.menu.props"),
                icon = "tree",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.propsDescription"),
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
                title = locale("admin.menu.elevators"),
                icon = "elevator",
                iconAnimation = Config.IconAnimation,
                description = locale("admin.menu.elevatorsDescription"),
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
                title = locale("admin.menu.posters"),
                icon = "panorama",
                iconAnimation = "fade",
                description = locale("admin.menu.postersDescription"),
                onSelectFunction = function()
                    Posters.openMenu(Config.MenuNameConstant .. "manage")
                end,
                category = "manage"
            }
        )
    end

    if (GetResourceState("rhd_garage") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("admin.menu.garages"),
                icon = "warehouse",
                iconAnimation = "fade",
                description = locale("admin.menu.garagesDescription"),
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
                title = locale("admin.menu.crafting"),
                icon = "tools",
                iconAnimation = "fade",
                description = locale("admin.menu.craftingDescription"),
                onSelectFunction = function()
                    Crafting.openMenu(Config.MenuNameConstant .. "manage")
                end,
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qjobsystem") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("admin.menu.jobs"),
                icon = "briefcase",
                iconAnimation = "fade",
                description = locale("admin.menu.jobsDescription"),
                onSelectFunction = function()
                    Jobs.openMenu(Config.MenuNameConstant .. "manage")
                end,
                category = "manage"
            }
        )
    end

    if (GetResourceState("mri_Qspotlights") == "started") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("admin.menu.spotlights"),
                icon = "lightbulb",
                iconAnimation = "fade",
                description = locale("admin.menu.spotlightsDescription"),
                onSelectFunction = function()
                    Spotlight.openMenu(Config.MenuNameConstant .. "manage")
                end,
                category = "manage"
            }
        )
    end

    -- Adicione mais menus fixos aqui :)

    return categories, options
end

local function registerMenu(menu, categories)
    local menuName = Config.MenuNameConstant .. "admin"
    local options = loadFixedMenuItems(menuName)
    local cats, finalMenu = loadManageMenuFixedItems(menu, categories)
    options = Utils.loadRuntimeMenuItems(options, finalMenu, cats)
    lib.registerContext(
        {
            id = menuName,
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
