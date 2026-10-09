# hyprland-themes

Temas de escritorio Hyprland basados en Everforest:

- **everforest** — variante oscura (`colorScheme: everforest`).
- **summer-day** — tema claro, usa la paleta `everforest-light`.
- **summer-night** — tema oscuro, usa la paleta `everforest`.

Los archivos conservan la estructura original de `~/.config` para que se puedan copiar tal cual:

- `hypr/` — temas, paletas de colores, wallpapers de hyprpaper y scripts de cambio de tema.
- `kitty/colors/` — paletas de kitty.
- `waybar/` — paletas y configuración de barra por tema.
- `wofi/` — paletas, temas y script de selección de tema.
- `swaync/` — estilos de notificaciones.

Para cambiar de tema: `sh ~/.config/hypr/scripts/switch-theme.sh summer-day`.

Nota: `kitty.conf` no está incluido; el script de cambio de tema reemplaza su primera línea con `include colors/<tema>.conf`.

## Versionado

- Se usa [Semantic Versioning](https://semver.org/lang/es/). Historial en `CHANGELOG.md`.
- **MAJOR**: cambios que rompen la estructura o los nombres de temas.
- **MINOR**: temas o archivos nuevos, o cambios de apariencia en un tema.
- **PATCH**: correcciones que no cambian el diseño previsto.
- Cada cambio va en su propio commit, con su entrada en el changelog y, si corresponde, su tag `vX.Y.Z`.
- Un cambio en un tema no debe modificar los archivos de los otros temas.
