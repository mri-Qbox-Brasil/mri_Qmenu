local Config = lib.require('shared/config')
local Utils = lib.require('client/utils')

local function formatPlayerData(data)
    return locale("player.menu.info",
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

    options[#options + 1] = Utils.createMenuItem(
        locale("player.menu.id"),
        "fas fa-address-card",
        Config.IconAnimation,
        formatPlayerData(playerData),
        ExecuteCommand,
        "id"
    )

    options[#options + 1] = Utils.createMenuItem(
        locale("player.menu.job"),
        "fas fa-briefcase",
        Config.IconAnimation,
        string.format("%s | %s", orgs.jobData.label, orgs.jobData.grade),
        ExecuteCommand,
        "job"
    )

    if Utils.isBoss(playerData, "job") or Utils.isRecruiter(playerData, "job") then
        options[#options + 1] = Utils.createMenuItem(
            locale("player.menu.manageJob"),
            "users",
            Config.IconAnimation,
            locale("player.menu.manageJobDescription"),
            ExecuteCommand,
            "+tablet:job"
        )
    end

    options[#options + 1] = Utils.createMenuItem(
        locale("player.menu.gang"),
        "gun",
        Config.IconAnimation,
        string.format("%s | %s", orgs.gangData.label, orgs.gangData.grade),
        ExecuteCommand,
        "gang"
    )

    if Utils.isBoss(playerData, "gang") or Utils.isRecruiter(playerData, "gang") then
        options[#options + 1] = Utils.createMenuItem(
            locale("player.menu.manageGang"),
            "users",
            Config.IconAnimation,
            locale("player.menu.manageGangDescription"),
            ExecuteCommand,
            "+tablet:gang"
        )
    end

    if GetResourceState("cw-rep") == "started" then
        options[#options + 1] = Utils.createMenuItem(
            locale("player.menu.rep"),
            "book",
            Config.IconAnimation,
            locale("player.menu.repDescription"),
            ExecuteCommand,
            "rep"
        )
        options[#options + 1] = Utils.createMenuItem(
            locale("player.menu.skill"),
            "fa-solid fa-book-bookmark",
            Config.IconAnimation,
            locale("player.menu.skillDescription"),
            ExecuteCommand,
            "skill"
        )
    end

    if GetResourceState("pickle_waypoints") == "started" then
        options[#options + 1] = Utils.createMenuItem(
                locale("player.menu.waypoints"),
            "location-dot",
            Config.IconAnimation,
            locale("player.menu.waypointsDescription"),
            ExecuteCommand,
            "waypoints"
        )
    end

    -- Adicione mais menus fixos aqui :)

    return options
end

local function loadRuntimeMenuItems(finalMenu, runtimeMenu)
    if (not runtimeMenu == nil) or (#runtimeMenu > 0) then
        for k, v in pairs(runtimeMenu) do
            finalMenu[#finalMenu + 1] = v
        end
    end
    return finalMenu
end

local function registerMenu(menu)
    local PlayerData = QBX.PlayerData
    local options = loadFixedMenuItems(PlayerData)
    options = loadRuntimeMenuItems(options, menu)

    lib.registerContext({
        id = 'menu_jogador',
        title = locale("player.menu.title", Config.ImgUrl, PlayerData.name),
        description = locale("player.menu.description"),
        options = options
    })
end

return {
    registerMenu = function(menu)
        registerMenu(menu)
    end
}
