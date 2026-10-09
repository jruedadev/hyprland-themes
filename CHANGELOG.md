# Changelog

Este proyecto sigue [Semantic Versioning](https://semver.org/lang/es/).

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
