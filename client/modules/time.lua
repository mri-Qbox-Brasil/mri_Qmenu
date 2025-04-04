ColorScheme = GlobalState.UIColors or {}
local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "time"

local function OpenMenu(mainMenu)
    local freezeTime = GlobalState.freezeTime or 0
    lib.registerContext(
        {
            id = menuName,
            title = locale("time.menu.title"),
            description = locale("time.menu.description"),
            menu = mainMenu,
            options = {
                {
                    title = locale("time.menu.set"),
                    description = locale("time.menu.setDescription"),
                    icon = "clock",
                    iconAnimation = Config.IconAnimation,
                    onSelect = function()
                        local input =
                            lib.inputDialog(
                            locale("time.menu.set"),
                            {
                                {type = "number", label = locale("time.dialog.hour"), default = 12, min = 0, max = 24},
                                {type = "number", label = locale("time.dialog.minute"), default = 0, min = 0, max = 59}
                            }
                        )
                        if not input then
                            return
                        end

                        ExecuteCommand("time " .. input[1] .. " " .. input[2])
                    end
                },
                {
                    title = locale("time.menu.timescale"),
                    description = locale("time.menu.timescaleDescription", GlobalState.timeScale),
                    icon = "stopwatch",
                    iconAnimation = Config.IconAnimation,
                    onSelect = function()
                        local input =
                            lib.inputDialog(
                            locale("time.menu.timescale"),
                            {
                                {
                                    type = "number",
                                    label = locale("time.dialog.timescale"),
                                    description = locale("time.dialog.timescaleDescription"),
                                    default = GlobalState.timeScale,
                                    min = 3000
                                }
                            }
                        )
                        if not input then
                            return
                        end

                        ExecuteCommand("timescale " .. input[1])
                    end
                },
                {
                    title = locale("time.menu.freeze"),
                    description = locale(
                        "time.menu.freezeDescription",
                        freezeTime and locale("misc.yes") or locale("misc.no")
                    ),
                    icon = freezeTime and "snowflake" or "snowflake-slash",
                    iconColor = freezeTime and ColorScheme.info or ColorScheme.success,
                    iconAnimation = Config.IconAnimation,
                    onSelect = function()
                        if freezetime == 0 then
                            freezetime = 1
                        else
                            freezetime = 0
                        end
                        ExecuteCommand("freezetime " .. freezeTime)
                    end
                }
            }
        }
    )

    lib.showContext(menuName)
end

return {
    openMenu = OpenMenu
}
