local theme = {}

theme.font = "sarasa mono k bold 13"
theme.font_large = "sarasa mono k bold 16"
theme.font_extra_large = "sarasa mono k bold 20"

theme.light_white   = "#fafafa"
theme.white         = "#d7dae0"
theme.pink          = "#f4b8e4"
theme.purple        = "#ca9ee6"
theme.red           = "#e78284"
theme.orange        = "#ef9f76"
theme.yellow        = "#e5c890"
theme.green         = "#a6d189"
theme.light_blue    = "#99d1db"
theme.blue          = "#a4b9ef"
theme.text          = "#c6d0f5"
theme.grey          = "#949cbb"
theme.dark_grey     = "#737994"
theme.darker_grey   = "#494d64"
theme.black         = "#303446"
theme.deep_black    = "#232634"


-- theme.bg_normal = theme.black
-- theme.bg_focus = theme.deep_black
-- theme.bg_urgent = theme.white
-- theme.bg_minimize = theme.grey
-- theme.bg_systray = theme.black

-- theme.fg_normal = theme.white
-- theme.fg_focus = theme.pink
-- theme.fg_urgent = theme.red
-- theme.fg_minimize = theme.light_white

theme.border_width = 1
theme.border_normal = theme.black

-- Wibar
theme.wibar_width = 40
theme.wibar_stretch = true
theme.wibar_bg = theme.black
theme.wibar_fg = theme.text
theme.wibar_border_width = 1
theme.wibar_border_color = theme.darker_grey


theme.taglist_font = theme.font
theme.taglist_bg_focus = theme.black
theme.tag_colors = {theme.red, theme.orange, theme.yellow, theme.green, theme.light_blue, theme.blue, theme.purple}
-- theme.taglist_fg_focus = theme.pink

return theme

