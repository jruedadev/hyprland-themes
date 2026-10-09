# Handoff: catppuccin-mocha

Documento de contexto para la sesión que revisa el tema **catppuccin-mocha**. Viene de la sesión de summer-night, donde se corrigieron **summer-day** (v0.1.0 a v0.1.11) y **summer-night** (v0.1.12 a v0.3.0). Ver `CHANGELOG.md` y `docs/handoff-summer-night.md`.

## Reglas de trabajo

- **No tocar otros temas.** Summer-day, summer-night, everforest claro y catppuccin-latte no se modifican salvo que el usuario lo pida.
- **Versionar cada cambio** con Semantic Versioning, anotarlo en `CHANGELOG.md`, hacer commit, tag y push a `main`. Tag y push solo cuando el usuario lo pida.
- **Trabajar por partes.** Si el usuario dice "espera", no tocar nada hasta que lo pida.
- **Verificar visualmente** antes de versionar:
  - Capturar con `grim -g "x,y WxH" archivo.png` y revisar la imagen.
  - Para probar waybar sin tirar la barra real: `pkill -x waybar`, arrancar `waybar --config <test> --style <test.css>`, capturar, cerrar y volver a arrancar la configuración real.
  - Para probar wofi: lanzar el script, capturar la pantalla completa y recortar.
  - Para probar el dock: `docking` solo lee la configuración al arrancar; reiniciarlo con `pkill -f "^/usr/bin/python3 -m docking.app"` y volver a lanzar `docking`. Evitar `pkill -f docking.app` a secas: coincide con el propio comando de bash y lo mata.
- **Versionamiento de la documentación:** los handoffs se versionan como PATCH.

## Cómo se activa un tema

- `hypr/hyprland.conf` (no versionado, solo en `~/.config/hypr/`) hace `source` del tema activo. En `~/.config/hypr/themes/<tema>/<tema>.conf` está `exec = sh ~/.config/hypr/scripts/switch-theme.sh <tema>`.
- `switch-theme.sh` lee `~/.config/hypr/themes/<tema>/<tema>.json` y aplica: hyprpaper, waybar (`~/.config/waybar/<colorScheme>/`), swaync (symlink `style.css`), GTK, fuente, iconos, kitty y, desde v0.3.0, el dock.
- **Dock (`docking`):** el tema viene de `~/.config/docking/dock.json` (`theme`). Si el json del tema define `dockTheme`, `switch-theme.sh` lo aplica y reinicia docking solo si cambió. El tema de usuario va en `~/.config/docking/themes/<nombre>.json`. Ejemplo: `everforest-dark.json`, en el repo en `docking/themes/`.

## Estado de catppuccin-mocha (sin revisar en esta sesión)

Archivos en el repo: `hypr/themes/catppuccin-mocha/`, `waybar/catppuccin-mocha/`, `waybar/colors/catppuccin-mocha.css`, `wofi/colors/catppuccin-mocha.css`, `wofi/themes/catppuccin-mocha.css`, `kitty/colors/catppuccin-mocha.conf`, `swaync/style-catppuccin-mocha.css`, `hypr/colors/catppuccin-mocha.conf`, `hypr/hyprpaper/catppuccin-mocha.conf`. Los archivos del repo son idénticos a `~/.config` (verificado con `cmp`).

Problemas detectados, sin corregir:

- **Keybindings ausentes.** `hypr/themes/catppuccin-mocha/catppuccin-mocha.conf` no tiene ningún `bind` (0 líneas), mientras que summer-night tiene 17. Con mocha activo no hay atajos para lanzador (`$mainMod, D`), menú de apagado (`B`), calculadora (`C`), portapapeles (`V`) ni emojis (`period`). Hay que confirmar si se definen en otro archivo antes de añadirlos.
- **Lanzador de waybar** (ver también el punto de keybindings, ya resuelto) (`waybar/catppuccin-mocha/config`, línea 54): `--width=20%` y `-s ~/.config/wofi/themes/everforest-light.css`. Es el mismo error que tenía summer-night: usa la paleta clara y el ancho pequeño. Debe quedar como el de summer-night: `--width=35% --height=50%` y el CSS de la paleta que corresponda (ver abajo).
- **Paleta del lanzador:** no existe un CSS de wofi oscuro para catppuccin-mocha con el mismo estilo que `everforest.css`. Hay que decidir si se usa `themes/catppuccin-mocha.css` (ya existe, tiene el import relativo roto) o se crea un estilo propio.
- **Import relativo roto:** `wofi/themes/catppuccin-mocha.css` (y `catppuccin-latte.css`) usa `@import "../colors/catppuccin-mocha.css";`. GTK lo resuelve desde el directorio de trabajo, no desde el archivo, así que las variables quedan vacías. Corregir con ruta absoluta, como en v0.1.1 y v0.1.2. El usuario pidió esperar antes de corregir catppuccin; confirmar antes de tocarlo.
- **Menú de apagado:** `powermenu.sh` usa `themes/<tema>-power.css` si existe. Para `catppuccin-mocha` no existe, así que cae en `catppuccin-mocha.css`, que tiene márgenes grandes y puede cortar el contenedor como pasaba en summer-night antes de v0.2.2. Revisar con `grim` antes de decidir.
- **Dock:** `catppuccin-mocha.json` no tiene `dockTheme`. Al activar mocha, el dock se queda con el último tema aplicado (ahora `everforest-dark`, de summer-night). Hay que crear un tema de dock para mocha (p. ej. `catppuccin-mocha.json` en `docking/themes/`, con la paleta de `waybar/colors/catppuccin-mocha.css`) y añadir `"dockTheme"` a `catppuccin-mocha.json`.
- **Notificaciones:** `waybar/catppuccin-mocha/style.css`, línea 127: `#custom-notifications` usa `border-bottom-color: @blue`, igual que summer-night antes de v0.2.1. La paleta de mocha no tiene `border_notifications`. Añadir el color a `waybar/colors/catppuccin-mocha.css` y usarlo en el estilo, como en everforest.
- **Detección de tema:** `waybar/scripts/get-theme.sh` mapea `catppuccin-mocha` a `catppuccin-mocha`, así que el menú de apagado sí busca el CSS de mocha. Los scripts de teclado y bluetooth (`keyboardmenu.sh everforest`, `bluetoothmenu.sh everforest`) están fijos en `everforest`, así que en mocha usan la paleta de everforest. Revisar si conviene parametrizarlos.

## Lecciones técnicas

- **`@import` relativo en GTK/wofi** se resuelve desde el directorio de trabajo, no desde el archivo. Usar rutas absolutas.
- **`text-align` no es válido en el CSS de waybar.** Para centrar, usar padding.
- **Waybar y el wifi apagado:** con el radio apagado, waybar usa `format-disabled`, no `format-disconnected`.
- **wofi rechaza flags inválidos** (`--hide_search` no existe, `--hide-search` sí) y no abre el menú. La salida de error lo muestra.
- **Ancho de wofi:** `--width=20%` deja el menú cortado. Los temas que funcionan usan `--width=35%` y `--height=50%`.
- **`powermenu.sh` es compartido por todos los temas.** Un cambio ahí afecta a catppuccin y a everforest.
- **Locale:** nmcli sale en español con `es_CO.UTF-8`. Forzar `LANGUAGE=C` donde se parsee su salida.
- **Dock:** `docking` no recarga `dock.json` en caliente. Reiniciar tras cualquier cambio.
- **Warning de GTK** `gtk.css:1048 border-spacing` aparece en waybar, wofi y docking. Es inofensivo; no tapa errores reales.

## Pendiente

1. ~~Keybindings de mocha~~ (hecho en v0.4.1: añadidos al conf de mocha, verificados con `hyprctl binds`). Falta el estilo de los menús, ver punto 3. **Latte tiene el mismo problema** (`catppuccin-latte.conf` sin binds); no se ha tocado.
2. ~~Lanzador de waybar~~ (hecho en v0.4.2).
3. ~~Import relativo de `wofi/themes/catppuccin-mocha.css`~~ (hecho en v0.4.2). Falta el de `catppuccin-latte.css`.
4. Verificar el menú de apagado con `grim` y crear `wofi/themes/catppuccin-mocha-power.css` si se corta.
5. ~~`border_notifications` en mocha~~ (hecho en v0.4.2).
6. Crear el tema de dock para mocha y `dockTheme` en `catppuccin-mocha.json`.
7. Revisar `keyboardmenu.sh` y `bluetoothmenu.sh`, que están fijos en everforest.
