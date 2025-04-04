local Config = lib.require("shared/config")
local Utils = lib.require("client/utils")

local function formatPlayerData(data)
    return locale(
        "player.menu.info",
        data.source,
        data.citizenid,
        Utils.getSpaces(130),
        data.name,
        Utils.getSpaces(130),
        data.money.coin
    )
end

local function loadFixedMenuItems(playerData)
    local orgs = Utils.getPlayerOrgs(playerData)
    local options = {}

    options[#options + 1] =
        Utils.createMenuItem(
        {
            title = locale("player.menu.id"),
            icon = "fas fa-address-card",
            iconAnimation = Config.IconAnimation,
            description = formatPlayerData(playerData),
            onSelectFunction = ExecuteCommand,
            onSelectArg = "id"
        }
    )

    options[#options + 1] =
        Utils.createMenuItem(
        {
            title = locale("player.menu.job"),
            icon = "fas fa-briefcase",
            iconAnimation = Config.IconAnimation,
            description = string.format("%s | %s", orgs.jobData.label, orgs.jobData.grade),
            onSelectFunction = ExecuteCommand,
            onSelectArg = "job"
        }
    )

    if Utils.isBoss(playerData, "job") or Utils.isRecruiter(playerData, "job") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("player.menu.manageJob"),
                icon = "users",
                iconAnimation = Config.IconAnimation,
                description = locale("player.menu.manageJobDescription"),
                onSelectFunction = ExecuteCommand,
                onSelecArg = "+tablet:job"
            }
        )
    end

    options[#options + 1] =
        Utils.createMenuItem(
        {
            title = locale("player.menu.gang"),
            icon = "gun",
            iconAnimation = Config.IconAnimation,
            description = string.format("%s | %s", orgs.gangData.label, orgs.gangData.grade),
            onSelectFunction = ExecuteCommand,
            onSelectArg = "gang"
        }
    )

    if Utils.isBoss(playerData, "gang") or Utils.isRecruiter(playerData, "gang") then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("player.menu.manageGang"),
                icon = "users",
                iconAnimation = Config.IconAnimation,
                description = locale("player.menu.manageGangDescription"),
                onSelectFunction = ExecuteCommand,
                onSelectArg = "+tablet:gang"
            }
        )
    end

    if GetResourceState("cw-rep") == "started" then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("player.menu.rep"),
                icon = "book",
                iconAnimation = Config.IconAnimation,
                description = locale("player.menu.repDescription"),
                onSelectFunction = ExecuteCommand,
                onSelectArg = "rep"
            }
        )
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("player.menu.skill"),
                icon = "fa-solid fa-book-bookmark",
                iconAnimation = Config.IconAnimation,
                description = locale("player.menu.skillDescription"),
                onSelectFunction = ExecuteCommand,
                onSelectArg = "skill"
            }
        )
    end

    if GetResourceState("pickle_waypoints") == "started" then
        options[#options + 1] =
            Utils.createMenuItem(
            {
                title = locale("player.menu.waypoints"),
                icon = "location-dot",
                iconAnimation = Config.IconAnimation,
                description = locale("player.menu.waypointsDescription"),
                onSelectFunction = function()
                    TriggerEvent('pickle_waypoints:client:openWaypointMenu')
                end
            }
        )
    end

    -- Adicione mais menus fixos aqui :)

    return options
end

local function registerMenu(menu, categories)
    local PlayerData = QBX.PlayerData
    local options = loadFixedMenuItems(PlayerData)
    options = Utils.loadRuntimeMenuItems(options, menu, categories)

    lib.registerContext(
        {
            id = Config.MenuNameConstant .. "player",
            title = locale("player.menu.title", Config.ImgUrl, PlayerData.name),
            description = locale("player.menu.description", Config.ServerName or "MRI QBOX"),
            options = options
        }
    )
end

return {
    registerMenu = function(menu, categories)
        registerMenu(menu, categories)
    end
}
