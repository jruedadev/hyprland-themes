# Handoff: summer-night (everforest oscuro)

Documento de contexto para la sesión que corrige el tema **summer-night**. Viene de la sesión `hyprland-themes-settings-summer-day`, donde se corrigió **summer-day** (ver `CHANGELOG.md`, versiones 0.1.0 a 0.1.11).

## Reglas de trabajo

- **No tocar otros temas.** Summer-day, catppuccin y everforest claro no se modifican salvo que el usuario lo pida. Esto ya causó daños en sesiones anteriores.
- **Versionar cada cambio** con Semantic Versioning, anotarlo en `CHANGELOG.md`, hacer commit, tag y push a `main`.
- **Trabajar por partes.** Si el usuario dice "espera", no tocar nada hasta que lo pida.
- **Verificar visualmente** antes de versionar:
  - Capturar con `grim -g "x,y WxH" archivo.png` y revisar con la herramienta de lectura de imágenes.
  - Para probar waybar sin tirar la barra real: `pkill -x waybar`, arrancar `waybar --config <test> --style <test.css>`, capturar, cerrar y volver a arrancar la configuración real.
  - Para probar wofi: lanzar el script, capturar la pantalla completa y recortar.

## Estado de summer-day (cerrado en v0.1.11)

Sirve de referencia para summer-night, porque los problemas suelen repetirse.

- **Kitty:** se eliminó un `include` duplicado de `colors/everforest-light.conf`.
- **Waybar** (`~/.config/waybar/everforest-light/`, paleta en `~/.config/waybar/colors/everforest-light.css`):
  - Paleta corregida. Se añadió `border_notifications` para la sombra del botón de notificaciones (v0.1.10).
  - Wifi apagado: usa `format-disabled` con el icono `\U000F05AA` (v0.1.5). Estilo igual al de volumen muted y padding `9px` izquierda / `13px` derecha para centrar el icono (v0.1.6 a v0.1.9).
- **Wofi** (`~/.config/wofi/themes/everforest-light.css`): import con ruta absoluta (v0.1.1) y texto sin negrilla.
- **Menú de apagado** (`~/.config/wofi/scripts/powermenu.sh`, v0.1.11):
  - Flag `--hide_search=true` reemplazado por `--hide-search`, porque wofi no lo reconoce y no abre el menú.
  - Tamaño fijo `--width 260 --height 290`. Ignora el `--height=17%` que pasa waybar.
  - Estilo propio `themes/everforest-light-power.css`. El script lo usa solo si existe `themes/<tema>-power.css`; si no, usa el estilo normal.
- **Menú wifi** (`~/.config/wofi/scripts/wifimenu.sh`): `CONSTATE=$(LANGUAGE=C nmcli -fields WIFI g)` para que nmcli no devuelva texto en español (v0.1.3).

## Lecciones técnicas

- **`@import` relativo en GTK/wofi** se resuelve desde el directorio de trabajo, no desde el archivo. Usar siempre rutas absolutas.
- **`text-align` no es válido en el CSS de waybar.** Para centrar, usar padding.
- **Waybar y el wifi apagado:** con el radio apagado, waybar usa `format-disabled`, no `format-disconnected`. Si falta, el módulo se oculta.
- **wofi rechaza flags inválidos** y no abre el menú. Revisar la salida de error para comprobarlo.
- **`powermenu.sh` es compartido por todos los temas.** Sus cambios afectan a catppuccin y a everforest oscuro.
- **Locale:** nmcli sale en español con `es_CO.UTF-8`. Forzar `LANGUAGE=C` donde se parsee su salida.

## Pendiente para summer-night (everforest oscuro)

- Revisar **waybar** (`~/.config/waybar/everforest/`): probablemente le falta `format-disabled` en el bloque `network`.
- Revisar **wofi** (`~/.config/wofi/themes/everforest.css`): el import ya es absoluto (v0.1.2), pero falta revisar contraste, tamaño y estilo de sombras, igual que en summer-day.
- Revisar si aplica la sombra del botón de notificaciones (`#custom-notifications`), con un color oscuro propio de la paleta, como en summer-day.
- Revisar el menú de apagado. Usa el estilo normal de `everforest.css` hasta que se cree `everforest-power.css`, si hace falta. Verificar que el tamaño fijo de 290px quede bien con ese tema.
- **No tocar catppuccin (latte/mocha).** Sus archivos de wofi tienen el mismo import relativo roto, pero el usuario pidió esperar antes de corregirlos.
