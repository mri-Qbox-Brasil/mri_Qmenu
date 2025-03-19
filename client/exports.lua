local function OpenPlayerMenu(source)
    print(string.format("Open player menu for: %s", source))
end

exports('OpenPlayerMenu', OpenPlayerMenu)

local function OpenAdminMenu(source)
    print(string.format("Open admin menu for: %s", source))
end

exports('OpenAdminMenu', OpenAdminMenu)
