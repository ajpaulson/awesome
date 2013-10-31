theme = {}

require("awful")
local configdir = awful.util.getdir ("config")

theme.font          = "monofur for Powerline 10.5"

theme.bg_normal     = "#1B1D1E"
theme.bg_focus      = "#1B1D1E"
theme.bg_urgent     = "#000000aa"
theme.bg_minimize   = "#000000aa"

theme.fg_normal     = "#56C2D6"
theme.fg_focus      = "#82B414"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#000000"

theme.border_width  = "4"
-- theme.border_normal = "#56C2D6FF"
theme.border_normal = "#1B1D1EFF"
--theme.border_focus  = "#585656FF"
theme.border_focus  = "#045E1188"
theme.border_marked = "#8C54FE"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_fg_focus = "#CaC7B4"
theme.taglist_bg_color = "#82B414"
theme.taglist_bg_normal = "#82B414"
theme.taglist_bg_focus = "#045E11"
theme.taglist_fg_color = "#045E11"
theme.wibox_bg_normal = "#1B1D1E88"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = "20"
theme.menu_width  = "150"
theme.menu_border_color = "#82B414"
theme.menu_bg_normal = "#1B1D1E"
theme.menu_bg_focus = "#1B1D1E"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
--theme.wallpaper_cmd = {"nitrogen --restore"}
theme.wallpaper_cmd = {"nitrogen --restore"}

-- You can use your own layout icons like this:
theme.layout_fairh = configdir .. "/icons/layouts-huge-fill/fairh.png"
theme.layout_fairv = configdir .. "/icons/layouts-huge-fill/fairv.png"
theme.layout_floating  = configdir .. "/icons/layouts-huge-fill/floating.png"
theme.layout_magnifier = configdir .. "/icons/layouts-huge-fill/magnifier.png"
theme.layout_max = configdir .. "/icons/layouts-huge-fill//max.png"
theme.layout_fullscreen = configdir .. "/icons/layouts-huge-fill/fullscreen.png"
theme.layout_tilebottom = configdir .. "/icons/layouts-huge-fill/tilebottom.png"
theme.layout_tileleft   = configdir .. "/icons/layouts-huge-fill/tileleft.png"
theme.layout_tile = configdir .. "/icons/layouts-huge-fill/tile.png"
theme.layout_tiletop = configdir .. "/icons/layouts-huge-fill/tiletop.png"
theme.layout_spiral  = configdir .. "/icons/layouts-huge-fill/spiral.png"
theme.layout_dwindle = configdir .. "/icons/layouts-huge-fill/dwindle.png"

theme.awesome_icon = configdir .. "/icons/debian-swirl.png"

return theme
 --vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
