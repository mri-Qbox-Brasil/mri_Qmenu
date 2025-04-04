local Config = lib.require("shared/config")
local menuName = Config.MenuNameConstant .. "time"

local function OpenMenu(mainMenu)
    local freezeTime = GlobalState.freezeTime or 0
    lib.registerContext(
        {
            id = menuName,
            title = "Gerenciar Horário",
            menu = mainMenu,
            options = {
                {
                    title = "Alterar horário",
                    description = "Modificar a hora atual do servidor.                                         " ..
                        "*/time [hh] [mm]*",
                    icon = "clock",
                    iconAnimation = "fade",
                    onSelect = function()
                        local input =
                            lib.inputDialog(
                            "Alterar horário",
                            {
                                {type = "number", label = "Hora", default = 12, min = 0, max = 24},
                                {type = "number", label = "Minutos", default = 0, min = 0, max = 59}
                            }
                        )

                        ExecuteCommand("time " .. input[1] .. " " .. input[2])
                    end
                },
                {
                    title = "Escala do tempo",
                    description = "Modificar durará 1 minuto.                                                       " ..
                        "**Valor atual: " ..
                            GlobalState.timeScale ..
                                "**                                                                 " ..
                                    "*/timescale [ms]*",
                    icon = "stopwatch",
                    iconAnimation = "fade",
                    onSelect = function()
                        local input =
                            lib.inputDialog(
                            "Escala do tempo",
                            {
                                {
                                    type = "number",
                                    label = "Modificar",
                                    description = "Quanto será 1 minuto no jogo (Ex.: 3000, a cada 3 segundos irá passar 1 minuto no relógio do jogo)",
                                    default = 3000,
                                    min = 3000
                                }
                            }
                        )

                        ExecuteCommand("timescale " .. input[1])
                    end
                },
                {
                    title = "Congelar/Descongelar",
                    description = "Congele ou descongele o tempo.                                                                " ..
                        "**Valor atual: " ..
                            freezeTime ..
                                "**                                                                   " ..
                                    "*/freezetime [1 ou 0]*",
                    icon = "snowflake",
                    iconAnimation = "fade",
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
