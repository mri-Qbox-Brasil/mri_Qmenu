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
    createMenuItem = function(title, icon, iconAnimation, description, onSelectFunction, onSelectArg, arrow)
        return {
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
}