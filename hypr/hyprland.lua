-- Migrado desde hyprland.conf (hyprlang) a Lua para Hyprland 0.57.
-- El original se conserva en hyprland.conf (ya no se carga).

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"

-- Tema activo. Lo cambia scripts/set-theme.sh; no editar a mano la línea sin recargar.
local themeName = "catppuccin-latte"

-- Tema activo (themes/<nombre>/<nombre>.lua)
local theme = require("themes." .. themeName .. "." .. themeName)

-- Nombre del CSS de wofi del tema (si el módulo no lo define, usa themeName)
local wofiName = theme.wofi or themeName

-- Ejecuta varios comandos en un solo bind
local function run(...)
    local cmds = { ... }
    return function()
        for _, cmd in ipairs(cmds) do
            hl.dispatch(hl.dsp.exec_cmd(cmd))
        end
    end
end

---------------
---- ENV ----
---------------

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("HYPRLAND_LOG_WLR", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland,x11")

---------------
---- MONITORS ----
---------------

-- Generado por nwg-displays (monitors.lua)
require("monitors")

hl.workspace_rule({ workspace = "1", monitor = "eDP-2", default = true })
hl.workspace_rule({ workspace = "2", persistent = true })
for i = 1, 4 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", persistent = true })

---------------
---- AUTOSTART ----
---------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets,pkcs11,ssh")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("swaync")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("docking")
    hl.exec_cmd("sh ~/.config/hypr/scripts/switch-theme.sh " .. themeName)
end)

---------------
---- LOOK AND FEEL ----
---------------

-- Gaps, bordes, sombras, grupos, curvas y animaciones vienen del tema
theme.apply()

hl.config({
    misc = {
        layers_hog_keyboard_focus = true,
        focus_on_activate = true,
    },
})

---------------
---- LAYOUTS ----
---------------

hl.config({
    master = {
        new_status = "master",
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "latam,us",
        kb_variant = ",intl",
        numlock_by_default = true,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },

    cursor = {
        inactive_timeout = 0,
        no_hardware_cursors = false,
    },

    gestures = {
        workspace_swipe_forever = true,
        workspace_swipe_cancel_ratio = 0.3,
    },

    binds = {
        workspace_back_and_forth = true,
    },
})

hl.gesture({ fingers = 4, direction = "vertical", action = "workspace" })
hl.gesture({ fingers = 3, direction = "left",  action = function() hl.dispatch(hl.dsp.window.cycle_next()) end })
hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.window.cycle_next({ next = false })) end })
hl.gesture({ fingers = 4, direction = "left",  action = function() hl.dispatch(hl.dsp.window.move({ workspace = "r+1" })) end })
hl.gesture({ fingers = 4, direction = "right", action = function() hl.dispatch(hl.dsp.window.move({ workspace = "r-1" })) end })
hl.gesture({ fingers = 3, direction = "down", action = function() hl.dispatch(hl.dsp.focus({ workspace = "empty" })) end })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen", mode = "maximize" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER", action = "move" })
hl.gesture({ fingers = 2, direction = "pinchout", action = "cursor_zoom", zoom_level = 2 })

hl.device({ name = "epic mouse V1", sensitivity = -0.5 })
hl.device({ name = "at-translated-set-2-keyboard", kb_layout = "latam,us", kb_variant = ",intl" })
hl.device({ name = "corsair-corsair-k70-rgb-mk.2-mechanical-gaming-keyboard", kb_layout = "es,us", kb_variant = ",intl" })

---------------
---- WINDOW AND LAYER RULES ----
---------------

hl.layer_rule({ name = "no-anim-selection", match = { namespace = "selection" }, no_anim = true })

-- Waybar: blur detrás de la barra; ignore_alpha excluye las esquinas redondeadas
-- para que no queden transparentes (causa del parpadeo negro/transparente).
hl.layer_rule({ name = "waybar-blur", match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.5 })

hl.window_rule({ name = "pavucontrol", match = { class = "^(pavucontrol)$" }, max_size = { 600, 800 }, center = true, float = true })
hl.window_rule({ name = "libreoffice-tile", match = { class = "^(libreoffice)$" }, tile = true })
hl.window_rule({ name = "libreoffice-no-fullscreen", match = { class = "^(.*libreoffice.*)$" }, suppress_event = "fullscreen" })
hl.window_rule({ name = "blueman", match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ name = "calculator", match = { class = "^(org.gnome.Calculator)$" }, size = { 490, 600 }, float = true })
hl.window_rule({ name = "polkit-agent", match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true })
hl.window_rule({ name = "replace-files", match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ name = "file-operation-progress", match = { title = "^(File Operation Progress)$" }, float = true })
hl.window_rule({ name = "viewers-center-float", match = { class = "^(eog|vlc)$" }, center = true, float = true })
hl.window_rule({ name = "imv", match = { class = "^(imv)$" }, float = true })
hl.window_rule({ name = "steam-news", match = { title = "^(Steam - News)$" }, float = true })

---------------
---- KEYBINDINGS ----
---------------

-- Principales
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", function()
    theme.resize_highlight_on()
    hl.dispatch(hl.dsp.submap("resize"))
end)
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + A", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + MINUS", hl.dsp.focus({ workspace = "special" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + U", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/toggle-gaps.sh"))
hl.bind(mainMod .. " + F11", function()
    hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@74.99", position = "1920x0", scale = 1.25 })
end)
hl.bind(mainMod .. " + F12", function()
    hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@74.99", position = "1920x0", scale = 1 })
end)
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.reload_config())
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("docking"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("sh ~/.config/wofi/scripts/theme-switcher.sh"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/toggle-theme.sh"))
hl.bind(mainMod .. " + ALT + A", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/notify-airplane-mode.sh"))
hl.bind(mainMod .. " + SHIFT + F23", hl.dsp.exec_cmd("claude-desktop"))

-- Grupos
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mainMod .. " + CTRL + G", hl.dsp.window.move({ into_group = "right" }))
hl.bind(mainMod .. " + Tab", hl.dsp.group.next())

-- Ventanas: ALT+Tab alterna y trae al frente
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)
hl.bind("ALT + SHIFT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind("ALT + F2", hl.dsp.exec_cmd("wofi --show run"))
hl.bind("ALT + F10", hl.dsp.pass({ window = [[class:^(com\.obsproject\.Studio)$]] }))
hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd(terminal))

-- Lanzadores wofi (tema)
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd([[pkill wofi || wofi --show drun --term=kitty --width=35% --height=50% --columns 1 -I -s ~/.config/wofi/themes/]] .. wofiName .. [[.css -o $MAIN_DISPLAY]]))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd([[pkill wofi || sh ~/.config/wofi/scripts/powermenu.sh "]] .. wofiName .. [[" "--height=17% -o $MAIN_DISPLAY"]]))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd([[pkill wofi || sh ~/.config/wofi/scripts/wofi-calc.sh "]] .. wofiName .. [[" "-o $MAIN_DISPLAY"]]))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd([[pkill wofi || cliphist list | wofi --dmenu -o $MAIN_DISPLAY -s ~/.config/wofi/themes/]] .. wofiName .. [[.css | cliphist decode | wl-copy]]))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd([[pkill wofi || sh ~/.config/wofi/scripts/wofi-emoji.sh "]] .. wofiName .. [[" "-o $MAIN_DISPLAY"]]))

-- Foco y movimiento
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Workspaces: 1-9, 0 = 10
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.focus({ workspace = i }))
end

hl.bind(mainMod .. " + CTRL + up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + ALT + down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + Tab",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

-- Mouse: mover y redimensionar
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia y hardware
hl.bind("XF86AudioRaiseVolume", run("pactl -- set-sink-volume @DEFAULT_SINK@ +5%", "sh ~/.config/hypr/scripts/notify-volume.sh"), { repeating = true })
hl.bind("XF86AudioLowerVolume", run("pactl -- set-sink-volume @DEFAULT_SINK@ -5%", "sh ~/.config/hypr/scripts/notify-volume.sh"), { repeating = true })
hl.bind("XF86AudioMute", run("pactl set-sink-mute @DEFAULT_SINK@ toggle", "sh ~/.config/hypr/scripts/notify-volume.sh"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/notify-microphone.sh"))
hl.bind("XF86MonBrightnessUp", run("brightnessctl set +10%", "sh ~/.config/hypr/scripts/notify-brightness.sh"))
hl.bind("XF86MonBrightnessDown", run("brightnessctl set 10%-", "sh ~/.config/hypr/scripts/notify-brightness.sh"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/media-control.sh play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/media-control.sh prev"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/media-control.sh next"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/media-control.sh stop"), { locked = true })
hl.bind("XF86TouchpadOff", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/notify-touchpad.sh off"))
hl.bind("XF86TouchpadOn", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/notify-touchpad.sh on"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))

-- Capturas de pantalla
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/freeze-screenshot.sh 0"))
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/freeze-screenshot.sh 1"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

-- Modo resize (submap)
hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true })
    hl.bind("left",  hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true })
    hl.bind("escape", function()
        theme.resize_highlight_off()
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)
