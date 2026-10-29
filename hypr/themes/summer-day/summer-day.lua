-- Tema summer-day (Everforest claro) para Hyprland 0.57 (Lua).
-- Equivalente a themes/summer-day/summer-day.conf (hyprlang).
-- Uso desde hyprland.lua:
--   local theme = require("themes.summer-day.summer-day")
--   theme.apply()

local M = {}

-- Nombre de los CSS de wofi (~/.config/wofi/themes/<wofi>.css); distinto del nombre del tema
M.wofi = "everforest-light"

M.colors = {
    fg = "rgb(5c6a72)",
    bg5 = "rgb(bdc3af)",
    shadow = "rgb(2e3538)",
    shadow_inactive = "rgb(61694f)",
    red = "rgb(bf616a)",
    -- el escape del modo resize restaura ambos bordes con este valor (como el conf original)
    resize_off = "rgb(8fbcbb)",
}

-- Aplica look and feel, curvas y animaciones del tema
function M.apply()
    hl.config({
        general = {
            gaps_in = 10,
            gaps_out = 20,
            border_size = 4,
            col = {
                active_border = M.colors.fg,
                inactive_border = M.colors.bg5,
            },
            layout = "dwindle",
            resize_on_border = true,
        },

        decoration = {
            rounding = 10,
            blur = { enabled = true },
            shadow = {
                enabled = true,
                range = 0,
                render_power = 4,
                color = M.colors.shadow,
                color_inactive = M.colors.shadow_inactive,
                scale = 1.0,
                offset = "0 10",
            },
            dim_inactive = false,
            dim_strength = 0.1,
            dim_around = 0.0,
        },

        group = {
            col = {
                border_active = M.colors.bg5,
                border_inactive = M.colors.fg,
            },
        },

        dwindle = {
            preserve_split = true,
        },
    })

    hl.curve("myBezier",  { type = "bezier", points = { { 0.05, 0.9 },  { 0.1, 1.05 } } })
    hl.curve("myBezier2", { type = "bezier", points = { { 0.65, 0 },    { 0.35, 1 } } })
    hl.curve("linear",    { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
    hl.curve("slow",      { type = "bezier", points = { { 0, 0.85 },    { 0.3, 1 } } })
    hl.curve("overshot",  { type = "bezier", points = { { 0.7, 0.6 },   { 0.1, 1.1 } } })
    hl.curve("bounce",    { type = "bezier", points = { { 1, 1.6 },     { 0.1, 0.85 } } })
    hl.curve("slingshot", { type = "bezier", points = { { 1, -1 },      { 0.15, 1.25 } } })
    -- "nice" original tenía Y=6.9 / -4.2 (fuera de rango en Lua); se acota a [-1, 2]. No se usa.
    hl.curve("nice",      { type = "bezier", points = { { 0, 1 },       { 0.5, -1 } } })

    hl.config({ animations = { enabled = true } })

    hl.animation({ leaf = "windows",     enabled = true, speed = 5,  bezier = "bounce",   style = "popin" })
    hl.animation({ leaf = "border",      enabled = true, speed = 20, bezier = "default" })
    hl.animation({ leaf = "fade",        enabled = true, speed = 5,  bezier = "overshot" })
    hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "overshot", style = "slidevert" })
    hl.animation({ leaf = "windowsIn",   enabled = true, speed = 5,  bezier = "slow",     style = "popin" })
    hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "default" })
end

-- Borde rojo mientras se redimensiona (modo resize)
function M.resize_highlight_on()
    hl.config({ general = { col = { active_border = M.colors.red } } })
    hl.config({ group = { col = { border_active = M.colors.red } } })
end

-- Restaura el borde al salir del modo resize
function M.resize_highlight_off()
    hl.config({ general = { col = { active_border = M.colors.resize_off } } })
    hl.config({ group = { col = { border_active = M.colors.resize_off } } })
end

return M
