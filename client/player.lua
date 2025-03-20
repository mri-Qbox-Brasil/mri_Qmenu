local function isBoss(playerData, org)
    local result = false
    if GetResourceState("mri_Qjobsystem") == "started" then
        result = exports.mri_Qjobsystem:CheckPlayerIsbossByJobSystemData(org, playerData)
    end
end

local function isRecruiter(playerData, org)
    local result = false
    if GetResourceState("mri_Qjobsystem") == "started" then
        result = exports.mri_Qjobsystem:CheckPlayerIsRecruiterByJobSystemData(org, playerData)
    end
end

local function getSpaces(qtd)
    local result = ""
    for i = 1, qtd do
        result = result .." "
    end
    return result
end

local function getPlayerOrgs(playerData)
    return {
        jobData = {
            label = playerData.job.label,
            grade = playerData.job.grade.name
        },
        gangData = {
            label = playerData.gang.label,
            grade = playerData.gang.grade.name
        }
    }
end

local function formatPlayerData(data)
    return locale("player.menu.info",
        data.source,
        data.citizenid,
        getSpaces(130),
        data.name,
        getSpaces(130),
        data.money.coin
    )
end

local function createMenuEntry(menu, title, icon, iconAnimation, description, onSelectFunction, onSelectArg, arrow)
    menu[#menu + 1 = {
        title = title,
        icon = icon,
        iconAnimation = iconAnimation,
        description = description,
        arrow = arrow or false,
        onSelect = function()
            if onSelectArg then
                onSelectFunction(onSelectArg)
            else
                onSelectFunction()
            end
        end
    }
end

local loadFixedMenuItems()
    local PlayerData = QBX.PlayerData
    local orgs = getPlayerOrgs(PlayerData)
    local isBoss = exports.mri_Qjobsystem:CheckPlayerIsbossByJobSystemData("job", PlayerData)
    local isRecruiter = exports.mri_Qjobsystem:CheckPlayerIsRecruiterByJobSystemData("job", PlayerData)
    local options = {}
    
    createMenuEntry(
        options,
        locale("player.menu.id"),
        "fas fa-address-card",
        "fade",
        formatPlayerData(PlayerData),
        ExecuteCommand,
        "id"
    )

    createMenuEntry(
        options,
        locale("player.menu.job"),
        "fas fa-briefcase",
        "fade",
        string.format("%s | %s", orgs.jobData.label, orgs.jobData.grade),
        ExecuteCommand,
        "job"
    )

    if isBoss(PlayerData, "job") or isRecruiter(PlayerData, "job") then
        createMenuEntry(
            options,
            locale("player.menu.manageJob"),
            "users",
            "fade",
            locale("player.menu.manageJobDescription"),
            ExecuteCommand,
            "+tablet:job"
        )
    end

    createMenuEntry(
        options,
        locale("player.menu.gang"),
        "gun",
        "fade",
        string.format("%s | %s", orgs.gangData.label, orgs.gangData.grade),
        ExecuteCommand,
        "gang"
    )

    if isBoss(PlayerData, "gang") or isRecruiter(PlayerData, "gang") then
        createMenuEntry(
            options,
            locale("player.menu.manageJob"),
            "users",
            "fade",
            locale("player.menu.manageJobDescription"),
            ExecuteCommand,
            "+tablet:gang"
        )
    end

    if GetResourceState("cw-rep") == "started" then
        createMenuEntry(
            options,
            locale("player.menu.rep"),
            "book",
            "fade",
            locale("player.menu.repDescription"),
            ExecuteCommand,
            "rep"
        )    
    end
end

local function registerMenu(menu)
    local orgData = getPlayerData()

end

return {
    function = registerMenu(menu)
        registerMenu(menu)
    end
}