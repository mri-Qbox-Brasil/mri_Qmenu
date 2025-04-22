local defaultCategory = {
    displayName = "Default",
    description = "Default category",
    icon = "fa-solid fa-folder",
    iconAnimation = Config.IconAnimation
}

local function debug(msg)
    if Config.Debug then
        print(string.format("[Qmenu] %s", msg))
    end
end

local function deepCopy(element)
    if type(element) ~= "table" then
        return element
    end
    local copy = {}
    for k, v in pairs(element) do
        copy[k] = deepCopy(v)
    end
    return copy
end

local function OpenSubMenu(categoryName, categoryData, menu)
    local options = {}
    debug(string.format("Opening submenu: %s", categoryName))
    debug(string.format("Category data: %s", json.encode(categoryData, {indent = true})))
    for k, v in pairs(menu) do
        if v.category == categoryName then
            options[#options + 1] = v
        end
    end
    lib.registerContext(
        {
            id = Config.MenuNameConstant .. categoryData.name,
            title = categoryData.displayName,
            description = categoryData.description,
            menu = Config.MenuNameConstant .. categoryData.parentMenu,
            options = options
        }
    )
    lib.showContext(Config.MenuNameConstant .. categoryData.name)
end

local function getCategory(categories, name)
    local category = categories[name]
    if not category then
        print(string.format("Category '%s' not found", name))
        return defaultCategory
    end
    return category
end

local function getSpaces(qtd)
    local result = ""
    for i = 1, qtd do
        result = result .. " "
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

local function isBoss(playerData, org)
    if not GetResourceState("mri_Qjobsystem") == "started" then
        return false
    end
    return exports.mri_Qjobsystem:CheckPlayerIsbossByJobSystemData(org, playerData)
end

local function isRecruiter(playerData, org)
    if not GetResourceState("mri_Qjobsystem") == "started" then
        return false
    end
    return exports.mri_Qjobsystem:CheckPlayerIrecruiterByJobSystemData(org, playerData)
    -- return = exports.mri_Qjobsystem:CheckPlayerIsRecruiterByJobSystemData(org, playerData)
end

local function createMenuItem(item)
    return {
        title = item.title,
        icon = item.icon,
        iconAnimation = item.iconAnimation,
        description = item.description,
        arrow = item["arrow"] or false,
        category = item["category"] or nil,
        onSelect = function()
            if item.onSelectArg then
                item.onSelectFunction(item.onSelectArg)
            else
                item.onSelectFunction()
            end
        end
    }
end

local function loadRuntimeMenuItems(finalMenu, runtimeMenu, categories)
    if (#runtimeMenu > 0) then
        for k, v in pairs(runtimeMenu) do
            if v["category"] then
                local category = getCategory(categories, v.category)
                local found = false
                for k2, v2 in pairs(finalMenu) do
                    if v2.title == category.displayName then
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
                            OpenSubMenu(v.category, category, runtimeMenu)
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

return {
    debug = debug,
    deepCopy = deepCopy,
    getSpaces = getSpaces,
    getPlayerOrgs = getPlayerOrgs,
    isBoss = isBoss,
    isRecruiter = isRecruiter,
    createMenuItem = createMenuItem,
    loadRuntimeMenuItems = loadRuntimeMenuItems,
}
