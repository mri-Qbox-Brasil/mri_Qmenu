# mri_Qmenu 📋

Sistema de menus para Qbox Framework com menu de jogador (F9) e menu admin (F10). Atua como hub central para gerenciar diversos resources da suite MRI Qbox.

## Principais recursos

- 👤 **Menu do Jogador (F9)** — Informações do jogador, job/gang, reputação, skills, waypoints.
- 🔧 **Menu Admin (F10)** — Painel admin, tempo, clima, gerenciamento de resources.
- 📑 **Menu items dinâmicos** — Adicione/remova items via exports em runtime.
- 🗂️ **Categorias de submenu** — Organização por categoria no menu admin.
- 🎨 **Ícones animados** — Suporte a FA icon animations (spin, pulse, fade, bounce).
- 🌐 **Internacionalização** — Suporte a en.json e pt-br.json.
- 🔌 **Integração condicional** — Itens aparecem apenas se o resource correspondente está rodando.

## Instalação rápida

1. Copie a pasta `mri_Qmenu` para a pasta de resources do servidor.
2. Adicione `ensure mri_Qmenu` no `server.cfg` (após `qbx_core`, `ox_lib`).

## Configuração (shared/config.lua) ⚙️

| Opção | Padrão | Descrição |
|---|---|---|
| `MenuNameConstant` | `"mri_Qmenu_"` | Prefixo para IDs de menu context. |
| `ServerName` | `"MRI QBOX"` | Nome do servidor no player menu. |
| `Debug` | `true` | Habilitar debug prints. |
| `ImgUrl` | URL da logo | Imagem do logo nos headers. |
| `IconAnimation` | `"fade"` | Animação dos ícones FA. |
| `AllowedAces` | `{"admin", "mod"}` | Permissões ACE para menu admin. |
| `PlayerMenuKeybind` | `"F9"` | Tecla do menu do jogador. |
| `AdminMenuKeybind` | `"F10"` | Tecla do menu admin. |

## Menu do Jogador (F9)

### Informações exibidas
- Server ID
- Citizen ID
- Nome do jogador
- Coins

### Itens do menu
| Item | Condição | Ação |
|---|---|---|
| **Manage Job** | Boss/recruiter (mri_Qjobsystem) | Abre tablet de gerenciamento. |
| **Manage Gang** | Boss/recruiter (mri_Qjobsystem) | Abre tablet de gerenciamento. |
| **Reputation** | cw-rep rodando | Mostra reputação. |
| **Skills** | cw-rep rodando | Mostra skills. |
| **Waypoints** | pickle_waypoints rodando | Submenu de waypoints. |

## Menu Admin (F10)

### Itens principais
| Item | Comando | Descrição |
|---|---|---|
| **Admin Panel** | `/adm` | Abre painel admin externo. |
| **Vehicle Custom** | `/customs` | Abre vehicle customs (apenas no veículo). |
| **Time** | Submenu | Gerenciamento de tempo. |
| **Weather** | `/weather` | Controle do clima. |

### Submenu Time
| Item | Comando | Descrição |
|---|---|---|
| Set Time | `/time <hh> <mm>` | Definir hora. |
| Timescale | `/timescale <ms>` | Velocidade do tempo. |
| Freeze/Unfreeze | `/freezetime <0/1>` | Congelar tempo. |

### Management Category (condicional)

| Item | Resource Requerido | Comando |
|---|---|---|
| Doors | `ox_doorlock` | `/doorlock` |
| Blips | `mri_Qblips` | `/blip` |
| Stashes | `mri_Qstashes` | `/bau` |
| NPCs | `mri_Qnpc` | `/npc` |
| Props | `mri_Qobjects` | `/objectspawner` |
| Elevators | `mri_Qelevators` | `/elevador` |
| Posters | `mri_Qdraw` | Submenu (create/remove/dev) |
| Garages | `rhd_garage` | `/garagelist` |
| Crafting | `mri_Qcrafting` | Submenu (create/edit) |
| Jobs/Groups | `mri_Qjobsystem` | Submenu (create/list) |
| Spotlights | `mri_Qspotlights` | Submenu (add/remove) |
| Vinewood | `mri_Qvinewood` | `/vinewood` |

## Exports (Client)

### Gerenciamento de menus

| Export | Descrição |
|---|---|
| `AddManageMenu(item)` | Adicionar item ao menu admin. |
| `RemoveManageMenu(item)` | Remover item do menu admin. |
| `AddPlayerMenu(item)` | Adicionar item ao menu do jogador. |
| `RemovePlayerMenu(item)` | Remover item do menu do jogador. |
| `AddItemToMenu(menuName, item)` | Adicionar item a qualquer menu. |
| `RemoveItemFromMenu(menuName, itemName)` | Remover item de qualquer menu. |
| `AddCategory(category)` | Adicionar subcategoria. |
| `RemoveCategory(name)` | Remover subcategoria. |

### Formato de item

```lua
{
    title = "Nome do Item",
    description = "Descrição",
    icon = "icon-name",           -- opcional
    iconAnimation = "fade",       -- opcional
    onSelectFunction = function(arg) -- callback
    onSelectArg = any,            -- opcional, passado ao callback
    category = "categoria"        -- opcional
}
```

### Formato de categoria

```lua
{
    displayName = "Nome da Categoria",
    description = "Descrição",
    icon = "icon-name",
    iconAnimation = "fade",
    parentMenu = "admin"          -- "admin" ou "player"
}
```

### Exemplo de uso

```lua
-- Adicionar item ao menu admin
exports['mri_Qmenu']:AddManageMenu({
    title = "Meu Resource",
    description = "Abrir meu resource",
    icon = "star",
    onSelectFunction = function()
        TriggerEvent('my_resource:open')
    end,
    category = "management"
})
```

## Callbacks

| Callback | Direção | Descrição |
|---|---|---|
| `mri_Qmenu:server:HasPermission` | C→S | Verificar permissão ACE. |
| `AbrirMenuAdmin` | Any→C | Abre o menu admin via callback (client-side). |

## Utilitários

| Função | Descrição |
|---|---|
| `isBoss(playerData, org)` | Verificar se é boss (requer mri_Qjobsystem). |
| `isRecruiter(playerData, org)` | Verificar se é recruiter (requer mri_Qjobsystem). |
| `getPlayerOrgs(playerData)` | Extrair job/gang e grade do player data. |
| `createMenuItem(item)` | Converter item config para formato ox_lib. |
| `loadRuntimeMenuItems(finalMenu, runtimeMenu, categories)` | Merge de items dinâmicos com fixos. |

## Estrutura de arquivos 📁

```
mri_Qmenu/
├── fxmanifest.lua
├── shared/
│   └── config.lua               # Configurações
├── client/
│   ├── menu.lua                 # Sistema de menu (ox_lib context)
│   ├── keybinds.lua             # Registro de keybinds F9/F10
│   ├── exports.lua              # Exports de gerenciamento de menu
│   ├── utils.lua                # Utilitários
│   └── modules/
│       ├── player.lua           # Menu do jogador
│       ├── admin.lua            # Menu admin
│       ├── crafting.lua         # Submenu crafting
│       ├── jobs.lua             # Submenu jobs
│       ├── posters.lua          # Submenu posters
│       ├── spotlight.lua        # Submenu spotlights
│       ├── time.lua             # Submenu time
│       └── waypoint.lua         # Submenu waypoints
├── server/
│   └── admin.lua                # Callback de permissão
├── locales/
│   ├── en.json                  # Inglês
│   └── pt-br.json               # Português
└── README.md
```

## Dependências

### Obrigatórias
- `qbx_core` — Framework principal, player data.

### Opcionais (condicional)
| Resource | Funcionalidade |
|---|---|
| `ox_lib` | Menus context, keybinds, notificações, dialogs. |
| `ox_doorlock` | Gerenciamento de portas. |
| `mri_Qblips` | Gerenciamento de blips. |
| `mri_Qstashes` | Gerenciamento de stashes. |
| `mri_Qnpc` | Gerenciamento de NPCs. |
| `mri_Qobjects` | Gerenciamento de props. |
| `mri_Qelevators` | Gerenciamento de elevadores. |
| `mri_Qdraw` | Gerenciamento de posters. |
| `rhd_garage` | Gerenciamento de garages. |
| `mri_Qcrafting` | Gerenciamento de crafting tables. |
| `mri_Qjobsystem` | Job/gang management + boss checks. |
| `mri_Qspotlights` | Gerenciamento de spotlights. |
| `mri_Qvinewood` | Edição de placa vinewood. |
| `cw-rep` | Reputação e skills. |
| `pickle_waypoints` | Waypoints/points of interest. |

## Observações importantes ⚠️

- O resource **não registra comandos próprios** — atua como launcher para comandos de outros resources.
- Items de menu aparecem **condicionalmente** baseado em `GetResourceState()`.
- Os exports permitem **extensão em runtime** por outros resources sem modificar o código do menu.
- Ao adicionar items dinâmicos, items existentes com o mesmo título são removidos primeiro (evita duplicatas).
- Categorias são geradas automaticamente quando items são adicionados com `category` definido.

Contribuições e melhorias são bem-vindas — abra PRs ou issues. 🙌
