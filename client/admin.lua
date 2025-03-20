local function registerMenu(adminMenu, managementMenu)
    print("Registering admin menu")
end

return {
    registerMenu = function(adminMenu, managementMenu)
        registerMenu(adminMenu, managementMenu)
    end
}