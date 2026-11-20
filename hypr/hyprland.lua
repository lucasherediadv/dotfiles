-- Hyprland config, mirrors sway/config.
-- See https://wiki.hypr.land/configuring/

--
-- Variables
--

local mod = "SUPER"

-- Home row direction keys, like vi
local dirs = { h = "left", j = "down", k = "up", l = "right" }

local term = "foot"
local screenshot = "grimshot"

local config_dir = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr"

--
-- Look and feel: rounded corners, soft shadows, dimmed inactive windows,
-- gruvbox borders. No blur or transparency.
--

local border = "rgb(8d836a)"          -- focused
local border_inactive = "rgb(504945)" -- gruvbox bg2, more muted

hl.config({
  general = {
    -- gaps_in is applied to each window side, so 2 gives 4px between windows
    gaps_in = 2,
    -- Matches the waybar margins. No bottom gap: waybar keeps a transparent
    -- 4px strip above the bar for its shadow, which already acts as the gap.
    gaps_out = { top = 4, right = 4, bottom = 0, left = 4 },
    border_size = 1,
    col = {
      active_border = border,
      inactive_border = border_inactive,
    },
    layout = "dwindle",
  },

  decoration = {
    -- Keep in sync with border-radius in waybar/style.*
    rounding = 6,
    rounding_power = 2,

    shadow = {
      enabled = true,
      range = 6,
      render_power = 3,
      color = "rgba(1d2021cc)",
    },

    dim_inactive = true,
    dim_strength = 0.1,

    blur = { enabled = false },
  },

  animations = {
    enabled = true,
  },

  -- Groups play the role of sway's tabbed layout
  group = {
    col = {
      border_active = border,
      border_inactive = border_inactive,
      border_locked_active = border,
      border_locked_inactive = border_inactive,
    },
    groupbar = {
      font_family = "JetBrains Mono",
      font_size = 11,
      height = 16,
      gradients = true,
      indicator_height = 0,
      text_color = "rgb(ebdbb2)",
      text_color_inactive = "rgb(a89984)",
      col = {
        active = "rgb(504945)",
        inactive = "rgb(282828)",
        locked_active = "rgb(504945)",
        locked_inactive = "rgb(282828)",
      },
    },
  },

  dwindle = {
    -- Required for togglesplit, and keeps splits stable like sway
    preserve_split = true,
  },

  binds = {
    -- Focus moves through tabs in a group before leaving it, like sway tabs
    movefocus_cycles_groupfirst = true,
  },

  -- Hide the update news and donation popups
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },

  input = {
    kb_layout = "us",
    follow_mouse = 1,
  },
})

--
-- Animations (Hyprland defaults)
-- See https://wiki.hypr.land/configuring/core/animations/
--

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, damping = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

--
-- Key bindings
--

-- Basics:

-- Kill focused window
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())

-- Reload the configuration file
hl.bind(mod .. " + SHIFT + C", hl.dsp.reload_config())

-- Start a terminal emulator
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(term))

-- Start firefox web browser
hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd("firefox"))

-- Drag windows with $mod + left mouse button, resize with $mod + right
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Exit Hyprland (logs you out of your Wayland session)
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd(
  "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit Hyprland? This will end your Wayland session.' "
    .. "-B 'Yes, exit Hyprland' \"hyprctl dispatch 'hl.dsp.exit()'\""
))

-- Moving around:

for key, dir in pairs(dirs) do
  -- Move your focus around
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
  -- Move the focused window with the same, but add Shift
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Workspaces:

for i = 1, 10 do
  local key = i % 10 -- workspace 10 maps to key 0
  -- Switch to workspace
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  -- Move focused window to workspace (without following it, like sway)
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Layout stuff:

-- Split horizontally/vertically: the next window opens to the right/below
hl.bind(mod .. " + B", hl.dsp.layout("preselect r"))
hl.bind(mod .. " + V", hl.dsp.layout("preselect d"))

-- Tabbed: group the focused window (toggle). New windows join the group,
-- $mod+h/l cycles through its tabs.
hl.bind(mod .. " + W", hl.dsp.group.toggle())

-- Toggle the split direction of the focused window
hl.bind(mod .. " + E", hl.dsp.layout("togglesplit"))

-- Make the current focus fullscreen
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())

-- Toggle the current focus between tiling and floating mode
hl.bind(mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))

-- Swap focus between the tiling area and the floating area
hl.bind(mod .. " + space", function()
  local win = hl.get_active_window()
  if win ~= nil and win.floating then
    hl.dispatch(hl.dsp.window.cycle_next({ tiled = true }))
  else
    hl.dispatch(hl.dsp.window.cycle_next({ floating = true }))
  end
end)

-- Scratchpad (a special workspace):

-- Move the currently focused window to the scratchpad
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- Show or hide the scratchpad
hl.bind(mod .. " + minus", hl.dsp.workspace.toggle_special("scratchpad"))

-- Resizing windows:

hl.bind(mod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
  hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })

  -- Return to default mode
  hl.bind("Return", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.submap("reset"))
end)

--
-- Utilities
--

-- Copy directly to clipboard without saving to disk
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot .. " copy area"))

--
-- Window rules
--

-- Ignore maximize requests from apps; tiling decides the size
hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

--
-- Status bar and wallpaper
--

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaybg -i " .. config_dir .. "/wallpaper.png -m fill")
end)

--
-- Outputs
--

hl.monitor({ output = "HDMI-A-3", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "1440x900@60", position = "1920x0", scale = 1 })

--
-- Workspace assignments to outputs
--

for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-3", default = i == 1 })
end

for i = 6, 10 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", default = i == 6 })
end

--
-- Auto launch applications
--

-- Named tmux sessions (-A attaches if they already exist) keep their order.
hl.on("hyprland.start", function()
  hl.exec_cmd("foot ~/.local/bin/herdr", { workspace = "1 silent" })
  hl.exec_cmd("foot tmux new-session -A -s 0", { workspace = "2 silent" })
  hl.exec_cmd("firefox", { workspace = "3 silent" })
  hl.exec_cmd("foot tmux new-session -A -s 1 btm", { workspace = "6 silent" })
  hl.dispatch(hl.dsp.focus({ workspace = 2 }))
end)
