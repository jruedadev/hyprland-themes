# Changelog

Este proyecto sigue [Semantic Versioning](https://semver.org/lang/es/).

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
