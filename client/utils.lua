local Utils = {}
local ColorScheme = {
    success = '#51CF66',
    info = '#668CFF',
    warning = '#FFD700',
    danger = '#FF6347'
}
GlobalState:set('UIColors', ColorScheme, true)
local imageUrl = 'https://cfx-nui-mri_Qbox/web-side/icones/logo24.png'

local f10Menu = {}

function Utils.getSpaces(qtd)
    local result = ''
    for i = 1, qtd do
        result = result ..' '
    end
    return result
end

return Utils