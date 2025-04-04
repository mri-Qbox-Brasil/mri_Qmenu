local defaultCategory = {
    displayName = "Default",
    description = "Default category",
    icon = "fa-solid fa-folder",
    iconAnimation = Config.IconAnimation,
}

local function OpenSubMenu(categoryName, categoryData, menu)
    local options = {}
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

return {
    getSpaces = function(qtd)
        local result = ""
        for i = 1, qtd do
            result = result .. " "
        end
        return result
    end,
    getPlayerOrgs = function(playerData)
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
    end,
    isBoss = function(playerData, org)
        if GetResourceState("mri_Qjobsystem") == "started" then
            return exports.mri_Qjobsystem:CheckPlayerIsbossByJobSystemData(org, playerData)
        end
        return false
    end,
    isRecruiter = function(playerData, org)
        if GetResourceState("mri_Qjobsystem") == "started" then
            return exports.mri_Qjobsystem:CheckPlayerIrecruiterByJobSystemData(org, playerData)
        -- return = exports.mri_Qjobsystem:CheckPlayerIsRecruiterByJobSystemData(org, playerData)
        end
        return false
    end,
    createMenuItem = function(item)
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
    end,
    loadRuntimeMenuItems = function(finalMenu, runtimeMenu, categories)
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
}
