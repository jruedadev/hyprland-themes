# Changelog

Este proyecto sigue [Semantic Versioning](https://semver.org/lang/es/).

## [0.5.4] - 2026-10-09

### Cambiado
- Colores de wofi en los temas summer-day y summer-night, que tenían valores fijos fuera de la paleta. Los valores no cambian; se usan como tokens:
  - `everforest.css` (summer-night): `#inner-box` pasa de `rgba(52, 63, 68, 0.9)` a `alpha(@bg1, 0.9)`, que es el mismo color.
  - `everforest-light.css` (summer-day): `@outer_bg`, `@inner_bg` y `@input_border` definidos en `wofi/colors/everforest-light.css`. Sustituyen a `#ece8d0`, `rgba(235, 230, 206, 0.9)` y `#465000`.
  - `everforest-light-power.css`: usa `@outer_bg` y `@power_fg` (`#2b3a42`, definido en la misma paleta).
- Verificado con `grim`: el fondo de las cajas da los mismos píxeles antes y después en el menú de summer-day, en el de summer-night y en el de apagado de summer-day.

### Cambiado
- Colores de los menús de wofi en `catppuccin-mocha` (`wofi/themes/catppuccin-mocha.css`): `#outer-box` usaba `#2a2a40` y `#inner-box` usaba `rgba(49, 50, 68, 0.9)`, colores fijos fuera de la paleta. Ahora se definen como tokens en `wofi/colors/catppuccin-mocha.css` (`@outer_bg` y `@surface0`) y el tema los usa por nombre. Los valores no cambian: se comprobó con `grim` que el fondo de ambas cajas da los mismos píxeles antes y después.

### Corregido en la documentación
- La entrada 0.5.2 decía que mocha tenía el mismo beige que latte. No es así: en mocha no hay beige, solo colores oscuros fijos. El cambio de 0.5.3 es de parametrización, no de corrección visual.

## [0.5.2] - 2026-10-09

### Corregido
- Colores de los menús de wofi en `catppuccin-latte` (`wofi/themes/catppuccin-latte.css`): `#inner-box` tenía el beige fijo de summer-day (`rgba(220, 208, 192, 0.9)`) y `#outer-box` tenía `#e3e5e8`, fuera de la paleta. Ahora usan `alpha(@bg0, 0.9)` y `@bg1`. Verificado con `grim` en el menú de teclado. Mocha tiene el mismo patrón y queda pendiente.

## [0.5.1] - 2026-10-09

### Documentación
- `docs/handoff-catppuccin-latte.md`: resultado de la pasada de los menús de wofi de los cuatro temas. Sin cambios de código. Quedan sin corregir, para decidir aparte: el menú de `theme-switcher.sh` sale sin estilo (llamado sin argumentos), `hypr/scripts/toggle-theme.sh` lee un `hyprland.lua` que no existe, y `waybar/start-waybar-theme.sh` no está en el repo.

## [0.5.0] - 2026-10-09

### Añadido
- Tema de dock `catppuccin-latte` (`docking/themes/catppuccin-latte.json`): fondo claro con la paleta de latte y acento azul (`#1e66f5`) para el indicador y el brillo del activo. Va en `~/.config/docking/themes/`.
- `dockTheme: "catppuccin-latte"` en `hypr/themes/catppuccin-latte/catppuccin-latte.json`. Verificado con `hyprctl reload`: `switch-theme.sh` actualiza `dock.json` y reinicia `docking` con el tema de latte, sin duplicar instancias.

## [0.4.12] - 2026-10-09

### Corregido
- Menú de apagado en `catppuccin-latte`: el script buscaba `catppuccin-latte-power.css`, no existía, y usaba el estilo normal, cuyos márgenes cortaban la opción Suspend. Nuevo `wofi/themes/catppuccin-latte-power.css`, basado en `catppuccin-mocha-power.css` con la paleta de latte. Verificado con `grim`: Reboot, Shutdown, Logout y Suspend se ven completos.

## [0.4.11] - 2026-10-09

### Corregido
- Buscador de wofi en `catppuccin-latte` (selector de teclado, bluetooth y demás menús): el campo tenía fondo `@blue` y texto `@bg0`, y el placeholder casi no se veía. Ahora usa fondo `@bg1` y texto `@fg`, igual que en mocha (v0.4.5). Verificado con `grim`: "Keyboard layout:" se lee en el campo. No se probó escribir texto (no hay `wtype` instalado).

## [0.4.10] - 2026-10-09

### Corregido
- Barra de waybar en `catppuccin-latte`: el botón de notificaciones no tenía sombra inferior porque usaba `@blue`, igual que el fondo. Añadido `border_notifications` (`#1557c0`, un azul más oscuro) a `waybar/colors/catppuccin-latte.css` y usado como `border-bottom-color`. Verificado con `grim`.

## [0.4.9] - 2026-10-09

### Corregido
- Lanzador de waybar en `catppuccin-latte` (icono de Arch): abría wofi con `--width=20%` y el CSS de summer-day (`everforest-light.css`). Ahora usa `--width=35% --height=50%` y `catppuccin-latte.css`, igual que el atajo Super+D.
- Menús de teclado y bluetooth en `catppuccin-latte` (`waybar/catppuccin-latte/config`): el on-click pasaba `everforest` como opciones de wofi, sin efecto. Ahora pasa `-o $MAIN_DISPLAY`, igual que en mocha (v0.4.4). Verificado con `grim`: ambos menús abren en el monitor principal con el estilo de latte.

## [0.4.8] - 2026-10-09

### Corregido
- `wofi/themes/catppuccin-latte.css`: el import de la paleta era relativo (`../colors/...`) y GTK no lo resolvía, así que las variables quedaban vacías. Ahora usa la ruta absoluta, igual que en mocha (v0.4.2). Verificado con `grim` abriendo el lanzador con el comando del atajo: ya aparecen los colores de la paleta de latte.

## [0.4.7] - 2026-10-09

### Corregido
- `catppuccin-latte` no tenía keybindings: `hypr/themes/catppuccin-latte/catppuccin-latte.conf` no definía ningún `bind`. Añadidos los mismos que en `catppuccin-mocha` (lanzador, apagado, calculadora, portapapeles, emojis, scroll de workspaces y modo resize), con los wofi de latte y el rojo y azul de su paleta en el modo resize. Definido también `$mainMod = SUPER`. Verificado con `hyprctl binds` (17 binds nuevos) y `hyprctl configerrors` sin errores.

## [0.4.6] - 2026-10-09

### Añadido
- `docs/handoff-catppuccin-latte.md`: contexto para la sesión de catppuccin-latte (reglas de trabajo, cómo se activa un tema, estado y problemas detectados sin corregir, lecciones técnicas y pendientes en orden sugerido).

## [0.4.5] - 2026-10-09

### Corregido
- Buscador de wofi en `catppuccin-mocha` (selector de teclado, bluetooth y demás menús): el campo tenía fondo `@blue` y texto `@bg0`, y el texto del placeholder casi no se veía. Ahora usa fondo `@bg1` y texto `@fg`, igual que el resto de la paleta de mocha. Verificado con `grim`.

## [0.4.4] - 2026-10-09

### Corregido
- Menús de teclado y bluetooth en `catppuccin-mocha` (`waybar/catppuccin-mocha/config`): el on-click pasaba `everforest` como opciones de wofi, un resto de copiar la configuración de everforest. El estilo ya salía bien porque los scripts lo toman de `get-theme.sh`, pero el argumento no hacía nada. Ahora pasan `-o $MAIN_DISPLAY`, igual que el lanzador y el apagado. Verificado con `grim`.

## [0.4.3] - 2026-10-09

### Corregido
- Menú de apagado en `catppuccin-mocha`: el script buscaba `catppuccin-mocha-power.css`, no existía, y usaba el estilo normal, cuyos márgenes cortaban la opción Suspend. Nuevo `wofi/themes/catppuccin-mocha-power.css`, basado en `everforest-power.css` con la paleta de mocha.

## [0.4.2] - 2026-10-09

### Corregido
- Lanzador de waybar en `catppuccin-mocha` (icono de Arch): abría wofi con `--width=20%` y el CSS de summer-day (`everforest-light.css`). Ahora usa `--width=35% --height=50%` y `catppuccin-mocha.css`, igual que el atajo Super+D.
- `wofi/themes/catppuccin-mocha.css`: el import de la paleta era relativo y GTK no lo resolvía, así que los menús salían sin colores. Ahora usa la ruta absoluta. Solo afecta a mocha; latte sigue pendiente.
- Botón de notificaciones en `catppuccin-mocha` sin sombra inferior: `#custom-notifications` usaba `@blue`, igual que el fondo. Añadido `border_notifications` (`#4d6fa8`) a la paleta y usado como `border-bottom-color`.

## [0.4.1] - 2026-10-09

### Corregido
- `catppuccin-mocha` no tenía keybindings: `hypr/themes/catppuccin-mocha/catppuccin-mocha.conf` no definía ningún `bind`. Añadidos los mismos que en summer-night: lanzador (`$mainMod, D`), apagado (`B`), calculadora (`C`), portapapeles (`V`), emojis (`period`), scroll de workspaces y modo resize (`R`). Definido también `$mainMod = SUPER`, porque el conf se lee antes que la definición global de `hyprland.conf`.
- El lanzador y los demás menús de mocha usan `~/.config/wofi/themes/catppuccin-mocha.css`. El import relativo de ese archivo sigue roto (pendiente en `docs/handoff-catppuccin-mocha.md`), así que los menús abren pero sin estilo.

## [0.4.0] - 2026-10-09

### Añadido
- Tema de dock `catppuccin-mocha` (`docking/themes/catppuccin-mocha.json`): fondo gris lavanda con la paleta de mocha y acento lavanda (`#b4befe`) para el indicador y el brillo del activo. Va en `~/.config/docking/themes/`.
- `dockTheme: "catppuccin-mocha"` en `hypr/themes/catppuccin-mocha/catppuccin-mocha.json`.

### Corregido
- `hypr/scripts/switch-theme.sh`: al reiniciar docking, el script no esperaba a que el proceso anterior cerrara, así que quedaban dos instancias. Ahora espera hasta 5 s y, si sigue vivo, lo fuerza con `SIGKILL`.

## [0.3.1] - 2026-10-09

### Añadido
- `docs/handoff-catppuccin-mocha.md`: contexto para la sesión de catppuccin-mocha (reglas de trabajo, cómo se activa un tema, estado y problemas detectados sin corregir, lecciones técnicas y pendientes).

## [0.3.0] - 2026-10-09

### Añadido
- Tema oscuro para el dock `docking`: `docking/themes/everforest-dark.json` (paleta everforest, misma geometría que el tema `paper`). Va en `~/.config/docking/themes/`.
- Campo `dockTheme` en los json de tema: `summer-night` usa `everforest-dark` y `summer-day` usa `paper` (el valor que ya tenía el dock).
- `docking/dock.json.template`: plantilla de `~/.config/docking/dock.json` para el instalador, sin apps fijadas ni estadísticas personales. Tema por defecto `paper`; el instalador debe copiarla como `dock.json` y ajustar `theme` según el tema activo.
- `hypr/scripts/switch-theme.sh`: al cambiar de tema, si el json define `dockTheme`, actualiza `theme` en `~/.config/docking/dock.json` y reinicia docking solo si el valor cambió.

## [0.2.2] - 2026-10-09

### Corregido
- Menú de apagado en `summer-night`: el contenedor de las opciones salía cortado. El script buscaba `everforest-power.css`, no existía y usaba `everforest.css`, cuyos márgenes de 20px y padding de 15px dejaban el contenido fuera de la ventana de 260x290. Nuevo `wofi/themes/everforest-power.css`, equivalente al de summer-day con la paleta oscura.

## [0.2.1] - 2026-10-09

### Corregido
- Barra de waybar en `summer-night`: el botón de notificaciones no tenía sombra inferior. Añadido el color `border_notifications` (#3f6b66) a la paleta `waybar/colors/everforest.css` y usado como `border-bottom-color`, igual que en `summer-day`.

## [0.2.0] - 2026-10-09

### Añadido
- Archivos de los temas catppuccin-latte y catppuccin-mocha copiados desde `~/.config` para que el instalador pueda montarlos: `hypr/themes/`, `hypr/colors/`, `hypr/hyprpaper/`, `hypr/wallpapers/`, `waybar/catppuccin-*`, `waybar/colors/`, `wofi/colors/`, `wofi/themes/`, `kitty/colors/`, `swaync/style-catppuccin-*.css`.
- Scripts y configuración compartida que referencian los cuatro temas: `hypr/scripts/` (notify-*, media-control, freeze-screenshot, toggle-gaps), `waybar/scripts/` (bluetooth, keyboardmenu, notification-status), `wofi/config`, `wofi/scripts/wofi-calc.sh` y `wofi/scripts/wofi-emoji.sh`, `swaync/config.json`, `gtk-3.0/settings.ini` y `waybar/start-waybar.sh`.

## [0.1.13] - 2026-10-09

### Corregido
- Icono de Arch en waybar (`summer-day` y `summer-night`): el lanzador abría wofi con `--width=20%`, y el menú salía cortado. Ahora usa `--width=35%`, igual que Win+D.
- Icono de Arch en `summer-night`: el lanzador cargaba el CSS del tema claro (`everforest-light.css`). Ahora usa `everforest.css`.

## [0.1.12] - 2026-10-09

### Añadido
- `docs/handoff-summer-night.md`: contexto para la sesión de summer-night (reglas de trabajo, estado de summer-day, lecciones técnicas y pendientes).

## [0.1.11] - 2026-10-09

### Corregido
- Menú de apagado (wofi, `scripts/powermenu.sh`): el flag `--hide_search=true` no existe en wofi y hacía que el menú fallara al abrir; cambiado a `--hide-search`.
- Menú de apagado: el `--height=17%` que llega desde waybar dejaba visible solo una opción. Ahora el script fija `--width 260 --height 290`.
- Menú de apagado: nuevo estilo `themes/everforest-light-power.css` con más contraste en el texto, márgenes equilibrados y sin cortes. El script lo usa si existe `themes/<tema>-power.css`; si no, usa el estilo normal, así que los demás temas no cambian.

## [0.1.10] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: el botón de notificaciones no tenía sombra inferior porque usaba el mismo azul que el fondo. Añadido el color `border_notifications` (#1f5a7d) a la paleta y usado como `border-bottom-color`, igual que la sombra del botón de apagado.

## [0.1.9] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: el icono de wifi apagado quedaba 1px hacia la derecha dentro de su cápsula. Ajustado el padding de `#network.disabled` y `#network.disconnected` a 9px izquierda y 13px derecha, con el mismo ancho total, para que los márgenes queden iguales (9px a cada lado).

## [0.1.8] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: el módulo de wifi apagado ahora usa el mismo estilo que el volumen en mute (sin `min-width` ni padding forzado), de modo que el icono queda centrado en una cápsula del mismo ancho.

## [0.1.7] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: el icono de wifi apagado quedaba desplazado a la izquierda dentro de su cápsula. Ajustado `padding-left` a 3px en `#network.disabled` y `#network.disconnected`. (`text-align` no es válido en waybar.)

## [0.1.6] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: la cápsula del icono de wifi apagado era demasiado estrecha. Añadido `min-width: 40px` y sin padding lateral para los estados `disabled` y `disconnected`, para que el icono quede centrado.

## [0.1.5] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: con el radio wifi apagado (`nmcli radio wifi off`) el módulo de red seguía oculto. Waybar usa `format-disabled` en ese caso, no `format-disconnected`. Añadido `format-disabled` con el icono `md-wifi_off`.

## [0.1.4] - 2026-10-09

### Corregido
- Barra de waybar en `summer-day`: al desactivar el wifi el módulo de red desaparecía, porque `format-disconnected` era una cadena vacía. Ahora muestra el icono `md-wifi_off` (U+F05AA) en rojo, según `#network.disconnected`.

## [0.1.3] - 2026-10-09

### Corregido
- Menú de wifi (`wofi/scripts/wifimenu.sh`): la detección del estado de wifi dependía del idioma de nmcli. Con locale español la salida es `activado`, no coincidía con `enabled` y el primer item (toggle) quedaba vacío. Ahora fuerza `LANGUAGE=C`, igual que ya se hacía para el SSID activo. Afecta a todos los temas, porque el script es compartido.

## [0.1.2] - 2026-10-09

### Corregido
- Tema oscuro de wofi (`wofi/themes/everforest.css`, usado por everforest y summer-night): mismo problema de import relativo que en 0.1.1. Ahora usa la ruta absoluta a la paleta.

## [0.1.1] - 2026-10-09

### Corregido
- Menú de selección de teclado en `summer-day` (`wofi/themes/everforest-light.css`): el import de la paleta era relativo y no se resolvía, así que las variables quedaban sin valor y las entradas salían en blanco. Ahora usa la ruta absoluta.
- Entradas del menú sin negrilla y en color `@fg`, igual que el texto del buscador.

## [0.1.0] - 2026-10-09

Línea base: temas everforest, summer-day y summer-night.

### Añadido
- Archivos de temas para hypr, kitty, waybar, wofi y swaync.
- README con la estructura del repo.

### Corregido
- Barra de waybar en `summer-day`: `everforest-light/style.css` importaba la paleta oscura; ahora importa `everforest-light.css`.
- Añadida la variable `border_bar_module` a la paleta clara.
- Reemplazada la variable inexistente `@sky` por `@aqua` en el hover de notificaciones.
