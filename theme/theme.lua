local theme = {}

theme.light_white =   "#fafafa"
theme.white =         "#d7dae0"
theme.pink =          "#f4b8e4"
theme.purple =        "#ca9ee6"
theme.red =           "#e78284"
theme.orange =        "#ef9f76"
theme.yellow =        "#e5c890"
theme.green =         "#a6d189"
theme.light_blue =    "#99d1db"
theme.blue =          "#a4b9ef"
theme.text =          "#c6d0f5"
theme.grey =          "#949cbb"
theme.dark_grey =     "#737994"
theme.black =         "#303446"
theme.deep_black =    "#232634"


theme.bg_normal = theme.black
theme.bg_focus = theme.deep_black
theme.bg_urgent = theme.white
theme.bg_minimize = theme.grey
theme.bg_systray = theme.black

theme.fg_normal = theme.white
theme.fg_focus = theme.orange
theme.fg_urgent = theme.red
theme.fg_minimize = theme.light_white

theme.border_width = 1
theme.border_normal = theme.white

return theme




-- local xresources = require("beautiful.xresources")
-- local dpi = xresources.apply_dpi
-- local gfs = require('gears.filesystem')

-- local theme = {}

-- -- themes

-- theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

-- theme.font         = "Sarasa Mono K 13"

-- theme.primary      = "#232634"
-- theme.secondary    = "#c6d0f5"

-- theme.red          = "#e78284"
-- theme.pink         = "#f4b8e4"
-- theme.blue         = "#8caaee"
-- theme.light_blue   = "#99d1db"
-- theme.green        = "#a6d189"
-- theme.yellow       = "#e5c890"
-- theme.orange       = "#ef9f76"

-- theme.bg_normal     = "#24283B"
-- theme.bg_focus      = "#24283B"
-- theme.bg_urgent     = "#24283B"
-- theme.bg_minimize   = "#24283B"
-- theme.bg_systray    = theme.bg_normal

-- -- theme.useless_gap   = 5
-- theme.border_width  = 1
-- theme.border_radius = 20
-- theme.border_normal = "#3f4859"
-- theme.border_focus  = "#3f4859"
-- theme.border_marked = "#3f4859"

-- -- widgets

-- theme.taglist_fg = "#80d1ff"
-- theme.taglist_fg_empty = "#3f4859"
-- theme.taglist_fg_occupied = "#949eb3"
-- theme.taglist_font = "Sarasa Mono K Bold 13"

-- -- menu

-- theme.menu_submenu_icon = gfs.get_configuration_dir() .. "theme/submenu.png"
-- theme.menu_height = dpi(25)
-- theme.menu_width = dpi(120)
-- theme.menu_bg = "#1b1f27"
-- theme.menu_font = "Sarasa Mono K Bold 13"

-- -- awesome icon

-- theme.awesome_icon = gfs.get_configuration_dir() .. "theme/awesome.png"

-- -- tag preview don't know how to toggle this tho

-- theme.tag_preview_widget_border_radius = 10
-- theme.tag_preview_client_border_radius = 10
-- theme.tag_preview_client_opacity = 0.1
-- theme.tag_preview_client_bg = "#1b1f27"
-- theme.tag_preview_client_border_color = "#3f4859"
-- theme.tag_preview_client_border_width = 2
-- theme.tag_preview_widget_bg = "#1b1f27"
-- theme.tag_preview_widget_border_color = "#3f4859"
-- theme.tag_preview_widget_border_width = 2
-- theme.tag_preview_widget_margin = 0

-- -- titlebar no se tampoco en que momento se supone que salga esto

-- theme.titlebar_close_button_normal = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
-- theme.titlebar_close_button_focus  = gfs.get_configuration_dir() .. "theme/titlebar/close.png"
-- theme.titlebar_close_button_focus_hover = gfs.get_configuration_dir() .. "theme/titlebar/close_hover.png"

-- theme.titlebar_minimize_button_normal = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
-- theme.titlebar_minimize_button_focus  = gfs.get_configuration_dir() .. "theme/titlebar/minimize.png"
-- theme.titlebar_minimize_button_focus_hover  = gfs.get_configuration_dir() .. "theme/titlebar/minimize_hover.png"

-- theme.titlebar_floating_button_normal_inactive = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
-- theme.titlebar_floating_button_focus_inactive  = gfs.get_configuration_dir() .. "theme/titlebar/floating.png"
-- theme.titlebar_floating_button_normal_active = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
-- theme.titlebar_floating_button_focus_active  = gfs.get_configuration_dir() .. "theme/titlebar/floating.png"
-- theme.titlebar_floating_button_focus_active_hover  = gfs.get_configuration_dir() .. "theme/titlebar/floating_hover.png"
-- theme.titlebar_floating_button_focus_inactive_hover  = gfs.get_configuration_dir() .. "theme/titlebar/floating_hover.png"

-- theme.icon_theme = nil

-- return theme
