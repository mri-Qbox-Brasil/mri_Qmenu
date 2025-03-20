lib.callback.register(
    "mri_Qmenu:server:HasPermission",
    function(source)
        local source = source
        for k, v in pairs(Config.AllowedAces) do
            print(k, v)
            if IsPlayerAceAllowed(source, v) then
                print("allowed")
                return true
            end
        end
        return false
    end
)