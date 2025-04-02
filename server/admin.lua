lib.callback.register(
    "mri_Qmenu:server:HasPermission",
    function(source)
        local source = source
        for k, v in pairs(Config.AllowedAces) do
            if IsPlayerAceAllowed(source, v) then
                return true
            end
        end
        return false
    end
)
