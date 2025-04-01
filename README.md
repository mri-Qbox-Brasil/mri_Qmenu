# 📗 mri_Qmenu

- Um sistema de menus feito para Qbox;
- Utiliza `ox_lib`

## 🛠 Instalação

-   Baixe o recurso e coloque-o na pasta de recursos(`resources/[mri]`). Certifique-se de que a pasta se chama `mri_Qmenu`.

## ⚙ Configuração

Normalmente não é necessário nenhum ajuste neste script. Em casos específicos, tudo que pode ser alterado está em `shared/config.lua`. Exemplo:

```lua
Config = {
    MenuNameConstant = "mri_Qmenu_",
    ServerName = "MRI QBOX",
    Debug = true,                                    -- true, false
    ImgUrl = "https://cfx-nui-mri_Qbox/web-side/icones/logo24.png",
    IconAnimation = "fade",                          -- spin, spinPulse, spinReverse, pulse, beat, fade, beatFade, bounce
    AllowedAces = { "admin", "mod" },                -- admin, mod, support,...
    PlayerMenuKeybind = "F9",                        -- F9, F10, F11, F12, ...
    AdminMenuKeybind = "F10",                        -- F9, F10, F11, F12, ...
}
```

## 👨‍👩‍👧‍👦 Permissões

O menu utiliza o sistema de Aces, padrão do FiveM.

## 📚 Menus

-   `admin` - Menu de administração (Keybind padrão: `F10`);
-   `player` - Menu do jogador (Keybind padrão: `F9`);

### 🤵 Menu Player

Contém informações e atalhos de comandos pertinentes a cada player. Não necessita de permissões para ser aberto.

#### ➕ Adicionar menus

##### 🧲 Fixos

Para adicionar menus fixos ao menu de players, basta seguir o padrão no arquivo `client/player.lua`. Lembrando que novos menus devem ser adicionados após o comentário, para que a ordenação seja mantida corretamente. Menus fixos estarão sempre presentes no menu do player.
```lua
    ...
    -- Adicione mais menus fixos aqui :)
    ...
```

##### 🔁 Dinâmicos

Menus dinâmicos podem ser adicionados/removidos dinamicamente(em execução) ao menu de players. Para adicionar menus dinâmicos, deve-se usar as exports disponíves em `client/exports.lua` diretamente no client de seu script. Exemplo:
```lua
    -- Client do seu script que precisa de um menu dinâmico
    ...
    exports["mri_Qmenu"]:AddPlayerMenu({
        title = "Menu dinâmico",
        description = "Descrição do menu dinâmico",
        onSelectFunction = function()
            print("Menu dinâmico selecionado")
        end,
        onSelectArg = 'arg'
    })
    ...
```

### 👷‍♂️ Menu Admin

Contém menus e atalhos de configuração dos scripts da base. Exige permissões configuradas para ser aberto. Deve ser usado por staff/administradores do servidor para configurar o servidor.

#### ➕ Adicionar menus

##### 🧲 Fixos

Para adicionar menus fixos ao menu de admin, basta seguir o padrão no arquivo `client/admin.lua`. Lembrando que novos menus devem ser adicionados após o comentário, para que a ordenação seja mantida corretamente. Menus fixos estarão sempre presentes no menu de administração.
```lua
    ...
    -- Adicione mais menus fixos aqui :)
    ...
```

##### 🔁 Dinâmicos

Menus dinâmicos também podem ser adicionados/removidos dinamicamente(em execução) ao menu de admin. Para adicionar menus dinâmicos, deve-se usar as exports disponíves em `client/exports.lua` diretamente no client de seu script. Exemplo:
```lua
    -- Client do seu script que precisa de um menu dinâmico
    ...
    exports["mri_Qmenu"]:AddManageMenu({
        title = "Menu dinâmico",
        description = "Descrição do menu dinâmico",
        onSelectFunction = function()
            print("Menu dinâmico selecionado")
        end,
        onSelectArg = 'arg'
    })
    ...
```

## 📦 Exports

-   `AddManageMenu` - Adiciona um menu dinâmico ao menu de administração. Exemplo:
    ```lua
    exports["mri_Qmenu"]:AddManageMenu({
        title = "Menu dinâmico",
        description = "Descrição do menu dinâmico",
        onSelectFunction = function()
            print("Menu dinâmico selecionado")
        end,
        onSelectArg = 'arg'
    })
    ```
-   `RemoveManageMenu` - Remove um menu dinâmico do menu de administração. Exemplo:
    ```lua
    exports["mri_Qmenu"]:RemoveManageMenu({
        title = "Menu dinâmico"
    })
    ```
-   `AddPlayerMenu` - Adiciona um menu dinâmico ao menu do jogador. Exemplo:
    ```lua
    exports["mri_Qmenu"]:AddPlayerMenu({
        title = "Menu dinâmico",
        description = "Descrição do menu dinâmico",
        onSelectFunction = function()
            print("Menu dinâmico selecionado")
        end,
        onSelectArg = 'arg'
    })
    ```
-   `RemovePlayerMenu` - Remove um menu dinâmico do menu do jogador. Exemplo:
    ```lua
    exports["mri_Qmenu"]:RemovePlayerMenu({
        title = "Menu dinâmico"
    })
    ```
-   `AddItemToMenu` - Adiciona um item a um menu. Exemplo:
    ```lua
    exports["mri_Qmenu"]:AddItemToMenu("admin", {
        title = "Item 1",
        description = "Descrição do item 1",
        onSelectFunction = function()
            print("Item 1 selecionado")
        end,
    })
    ```
-   `RemoveItemFromMenu` - Remove um item de um menu. Exemplo:
    ```lua
    exports["mri_Qmenu"]:RemoveItemFromMenu("admin", "Item 1")
    ```
-   `AddCategory` - Adiciona uma categoria a um menu. Exemplo:
    ```lua
    exports["mri_Qmenu"]:AddCategory({
        displayName = "GFX",
        description = "Configurações gráficas",
        icon = "clapperboard",
        iconAnimation = "fade",
        parentMenu = "admin"
    })
    ```
-   `RemoveCategory` - Remove uma categoria de um menu. Exemplo:
    ```lua
    exports["mri_Qmenu"]:RemoveCategory("GFX")
    ```
