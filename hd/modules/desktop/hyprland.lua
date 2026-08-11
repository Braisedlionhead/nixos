-- Repo-owned Hyprland configuration for Noctalia v5 on the hd work machine.
-- Home Manager links this file into ~/.config/hypr/hyprland.lua.

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

local terminal = "uwsm app -- kitty"
local fileManager = "uwsm app -- dolphin"
local mainMod = "SUPER"
local noctalia = "noctalia msg "

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(cba6f7ff)", "rgba(89b4faff)" },
                angle = 45,
            },
            inactive_border = "rgba(45475aaa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 20,
        rounding_power = 2,
        active_opacity = 1,
        inactive_opacity = 0.92,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
            popups = true,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
    },

    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            clickfinger_behavior = true,
        },
    },
})

hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})
hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0 }, { 0.35, 1 } },
})
hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "easeOutQuint", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "easeInOutCubic", style = "popin 85%" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "easeOutQuint", style = "slide" })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Windows-like Noctalia entry points, matching the previous configuration.
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(noctalia .. "settings-toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center notifications"))

-- Alt+Tab cycles the current workspace; Super+Tab is the global task view.
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next("prev"))
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.bring_to_top())
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(noctalia .. "window-switcher"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(noctalia .. "panel-toggle clipboard"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(noctalia .. "panel-toggle session"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(noctalia .. "session lock"))

-- Applications and session lifecycle.
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("CTRL + Space", hl.dsp.exec_cmd("fcitx5-remote -t"))

-- Window focus and layout.
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + down", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Windows-style virtual desktop and multi-monitor shortcuts.
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.exec_cmd("hyprctl dispatch movewindow mon:l"))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_cmd("hyprctl dispatch movewindow mon:r"))

-- Desktop and scratchpad behavior.
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = "empty" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + M", hl.dsp.window.move({ workspace = "special:minimized" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.workspace.toggle_special("minimized"))
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- Screenshots and color picking.
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(noctalia .. "screenshot-region"))
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Workspaces 1-10 remain visible in Noctalia even while empty.
for i = 1, 10 do
    local key = i % 10
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Noctalia owns volume and brightness OSDs.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctalia .. "volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctalia .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noctalia .. "volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(noctalia .. "mic-mute"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(noctalia .. "brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctalia .. "brightness-down"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "pavucontrol",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    float = true,
    size = { 900, 600 },
    center = true,
})

hl.window_rule({
    name = "network-editor",
    match = { class = "^(nm-connection-editor)$" },
    float = true,
})

hl.window_rule({
    name = "polkit-dialog",
    match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
    float = true,
})

hl.window_rule({
    name = "noctalia-settings",
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
    center = true,
})

hl.layer_rule({
    name = "noctalia-shell",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
