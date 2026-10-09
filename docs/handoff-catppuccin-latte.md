# Handoff: catppuccin-latte

Documento de contexto para la sesión que revisa el tema **catppuccin-latte**. Viene de la sesión de catppuccin-mocha, donde se corrigieron el lanzador, el estilo de wofi, la sombra de notificaciones, el apagado, los menús de teclado y bluetooth y el buscador (v0.4.0 a v0.4.5). Ver `CHANGELOG.md` y `docs/handoff-catppuccin-mocha.md`.

## Reglas de trabajo

- **No tocar otros temas.** Summer-day, summer-night, mocha y everforest no se modifican salvo que el usuario lo pida.
- **Un bug a la vez.** Corregir uno, verificarlo, versionarlo y pasar al siguiente. El usuario quiere ir por partes.
- **Versionar cada cambio** con Semantic Versioning, anotarlo en `CHANGELOG.md` (en español), hacer commit local. Tag y push solo cuando el usuario lo pida.
- **Si el usuario dice "espera"**, no tocar nada hasta que lo pida.
- **Verificar visualmente** antes de versionar:
  - Capturar con `grim -g "x,y WxH" archivo.png` y revisar la imagen. Guardar capturas en el scratchpad de la sesión.
  - Para probar un menú de wofi: lanzar el comando exacto que usa el on-click (con `-o $MAIN_DISPLAY`, cargado con `source ~/.config/hypr/scripts/detect-outputs.sh`), esperar 3 s, capturar y cerrar con `pkill -x wofi`. Cuidado con `timeout N wofi ...`: deja el proceso vivo y el shell puede quedarse colgado.
  - Para probar el dock: `docking` solo lee la configuración al arrancar. Reiniciarlo con `pkill -f "^/usr/bin/python3 -m docking.app"` (patrón anclado; `pkill -f docking.app` mata el propio shell).
- **Versionamiento de la documentación:** los handoffs se versionan como PATCH.
- **No añadir `Co-Authored-By` a los commits.**

## Cómo se activa un tema

- `hypr/hyprland.conf` (no versionado, solo en `~/.config/hypr/`) hace `source` del tema activo. En `~/.config/hypr/themes/<tema>/<tema>.conf` está `exec = sh ~/.config/hypr/scripts/switch-theme.sh <tema>`.
- `switch-theme.sh` lee `~/.config/hypr/themes/<tema>/<tema>.json` y aplica: hyprpaper, waybar (`~/.config/waybar/<colorScheme>/`), swaync (symlink `style.css`), GTK, fuente, iconos, kitty y, si el json define `dockTheme`, el dock.
- **Dock (`docking`):** el tema viene de `~/.config/docking/dock.json` (`theme`). El tema de usuario va en `~/.config/docking/themes/<nombre>.json`. En el repo están `docking/themes/everforest-dark.json` y `docking/themes/catppuccin-mocha.json`.
- **Scripts de menús:** `waybar/scripts/get-theme.sh` devuelve el nombre del tema de wofi (para latte, `catppuccin-latte`). `keyboardmenu.sh` y `bluetoothmenu.sh` usan ese nombre para cargar `~/.config/wofi/themes/<tema>.css`. El argumento que se les pasa desde waybar se usa como opciones de wofi, así que debe ser `"-o $MAIN_DISPLAY"`.

## Estado de catppuccin-latte (sin revisar)

Archivos en el repo: `hypr/themes/catppuccin-latte/`, `waybar/catppuccin-latte/`, `waybar/colors/catppuccin-latte.css`, `wofi/colors/catppuccin-latte.css`, `wofi/themes/catppuccin-latte.css`, `kitty/colors/catppuccin-latte.conf`, `swaync/style-catppuccin-latte.css`, `hypr/colors/catppuccin-latte.conf`, `hypr/hyprpaper/catppuccin-latte.conf`. Los archivos de latte revisados en esta sesión (`hypr/themes/catppuccin-latte/catppuccin-latte.conf`, `waybar/catppuccin-latte/config`, `waybar/catppuccin-latte/style.css`, `waybar/colors/catppuccin-latte.css`, `wofi/colors/catppuccin-latte.css`) son idénticos a `~/.config` (verificado con `cmp`). El resto no se ha comparado.

Problemas detectados, sin corregir (comprobados con grep y lectura de archivos en v0.4.5):

- **Keybindings ausentes.** `hypr/themes/catppuccin-latte/catppuccin-latte.conf` no tiene ninguna línea `bind` (0 de 69 líneas) y no define `$mainMod`. Mocha ya los tiene desde v0.4.1: copiar ese bloque, con `$mainMod = SUPER` al principio y la paleta de latte en los wofi. Los wofi de latte deben usar `~/.config/wofi/themes/catppuccin-latte.css`.
- **Import relativo roto:** `wofi/themes/catppuccin-latte.css`, línea 1: `@import "../colors/catppuccin-latte.css";`. GTK lo resuelve desde el directorio de trabajo, así que las variables quedan vacías. Corregir con ruta absoluta, como en mocha (v0.4.2) y en `everforest.css` (v0.1.2).
- **Buscador de wofi:** `#input` usa `background-color: @blue` y `color: @bg0`. Es el mismo patrón que tenía mocha (placeholder casi invisible). Mocha se corrigió en v0.4.5 con `@bg1` y `@fg`. Revisar latte con `grim` antes de cambiarlo, porque la paleta es clara y el contraste puede ser distinto.
- **Lanzador de waybar:** `waybar/catppuccin-latte/config`, línea 54: `--width=20%` y `-s ~/.config/wofi/themes/everforest-light.css`. Es el mismo error que tenía mocha: carga el CSS de summer-day y el ancho es pequeño. Debe quedar como en mocha: `--width=35% --height=50%` y `~/.config/wofi/themes/catppuccin-latte.css`.
- **Menús de teclado y bluetooth:** `waybar/catppuccin-latte/config`, líneas 19 y 27: `keyboardmenu.sh everforest` y `bluetoothmenu.sh everforest`. Mismo arreglo que en mocha (v0.4.4): `\"-o $MAIN_DISPLAY\"`.
- **Notificaciones sin sombra:** `waybar/catppuccin-latte/style.css`, línea 127: `#custom-notifications` usa `border-bottom-color: @blue`, el mismo color que el fondo. `waybar/colors/catppuccin-latte.css` no tiene `border_notifications`. Mismo arreglo que en mocha (v0.4.2): añadir el color a la paleta y usarlo en el estilo. Con la paleta clara conviene un azul algo más oscuro que `@blue` (`#1e66f5`), y verificarlo con `grim`.
- **Menú de apagado:** `powermenu.sh` usa `wofi/themes/<tema>-power.css` si existe. Para latte no existe (`wofi/themes/` solo tiene `catppuccin-mocha-power.css`, `everforest-light-power.css` y `everforest-power.css`), así que cae en `catppuccin-latte.css`, que puede cortar la opción Suspend como pasaba en mocha antes de v0.4.3. Revisar con `grim` y, si se corta, crear `catppuccin-latte-power.css` a partir de `everforest-power.css` (como en v0.4.3).
- **Dock:** `docking/themes/` no tiene tema para latte, y `hypr/themes/catppuccin-latte/catppuccin-latte.json` no tiene `dockTheme`. Al activar latte el dock se queda con el último tema aplicado. Crear `docking/themes/catppuccin-latte.json` con la paleta de `waybar/colors/catppuccin-latte.css` (fondo claro, acento `@blue`) y añadir `"dockTheme": "catppuccin-latte"` al json del tema. Ojo: el dock de summer-day usa `paper`, que es claro; comparar antes de decidir.

## Lecciones técnicas

- **`@import` relativo en GTK/wofi** se resuelve desde el directorio de trabajo, no desde el archivo. Usar rutas absolutas.
- **Argumentos de los scripts de menú:** lo que pasa waybar como `$1` se usa como opciones de wofi. `everforest` no es una opción válida y se ignora sin error, pero no fija el monitor. Pasar `"-o $MAIN_DISPLAY"`.
- **Estilo de los menús:** `keyboardmenu.sh` y `bluetoothmenu.sh` toman el CSS de `get-theme.sh`, no del argumento. El nombre de tema que aparezca en el on-click no determina el estilo.
- **`text-align` no es válido en el CSS de waybar.** Para centrar, usar padding.
- **Waybar y el wifi apagado:** con el radio apagado, waybar usa `format-disabled`, no `format-disconnected`.
- **wofi rechaza flags inválidos** (`--hide_search` no existe, `--hide-search` sí) y no abre el menú.
- **Ancho de wofi:** `--width=20%` deja el menú cortado. Los temas que funcionan usan `--width=35%` y `--height=50%`.
- **`powermenu.sh` es compartido por todos los temas.** Un cambio ahí afecta a los demás. Preferir un `-power.css` por tema.
- **Dock:** `docking` no recarga `dock.json` en caliente. Reiniciar tras cualquier cambio.
- **Warning de GTK** `gtk.css:1048 border-spacing` aparece en waybar, wofi y docking. Es inofensivo.

## Pendiente

Orden sugerido, uno a uno, con versión propia para cada punto:

1. Keybindings: copiar el bloque de `hypr/themes/catppuccin-mocha/catppuccin-mocha.conf` a latte, con los CSS de latte. Verificar con `hyprctl binds`. (PATCH)
2. Import relativo de `wofi/themes/catppuccin-latte.css`: ruta absoluta. (PATCH)
3. Lanzador de waybar y menús de teclado y bluetooth en `waybar/catppuccin-latte/config`. (PATCH)
4. Sombra de notificaciones: `border_notifications` en la paleta de latte y uso en `style.css`. (PATCH)
5. Buscador de wofi (`#input`), si con `grim` se ve mal. (PATCH)
6. Menú de apagado: verificar con `grim` y crear `catppuccin-latte-power.css` si se corta. (PATCH)
7. Tema de dock para latte y `dockTheme` en `catppuccin-latte.json`. (MINOR, porque es un archivo nuevo de tema)
8. Después de latte: revisar los menús de wofi de los cuatro temas en una sola pasada (`wifimenu.sh`, `theme-switcher.sh`) por si quedan rutas o argumentos fijos.

Fuera de este handoff, sin empezar: el instalador (`install.sh`). Los tags v0.4.x y el push de los commits locales se hacen solo cuando el usuario lo pida.
