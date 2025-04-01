return {
    getSpaces = function(qtd)
        local result = ""
        for i = 1, qtd do
            result = result .." "
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
            arrow = item['arrow'] or false,
            category = item['category'] or nil,
            onSelect = function()
                if item.onSelectArg then
                    item.onSelectFunction(item.onSelectArg)
                else
                    item.onSelectFunction()
                end
            end
        }
    end
}
