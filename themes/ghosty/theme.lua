--awesome colors
green="#7fb219"
cyan="#7f4de6"
red="#e04613"
lblue="#00afaf"
dblue="#005fdf"
black="#000000"
lgrey="#d2d2d2"
dgrey="#333333"
white="#ffffff"

theme = {}

theme.font          = "DejaVu Sans Mono 8"

theme.bg_normal     = black.."dd"
theme.bg_focus      = dgrey
theme.bg_urgent     = red
theme.bg_minimize   = dgrey

theme.fg_normal     = lgrey
theme.fg_focus      = lblue
theme.fg_urgent     = white
theme.fg_minimize   = white

theme.border_width  = "1"
theme.border_normal = black
theme.border_focus  = white
theme.border_marked = red

-- There are other variable sets
-- overriding the black_blue one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:

theme.tasklist_bg_focus = black
theme.tasklist_fg_focus = green

--font color fort textbox widget used as label in my wibox
theme.textbox_widget_as_label_font_color = white
theme.textbox_widget_margin_top =1

--font colors for textbox widget
theme.text_font_color_1 = green
theme.text_font_color_2 = dblue
theme.text_font_color_3 = white

--font colors for naughty popups
theme.notify_font_color_1 = green
theme.notify_font_color_2 = dblue
theme.notify_font_color_3 = black
theme.notify_font_color_4 = white
theme.notify_font= "DejaVu Sans Mono 8"
theme.notify_fg = theme.fg_normal
theme.notify_bg = theme.bg_normal
theme.notify_border = theme.border_focus
--colors,height for all awfull widgets
theme.awful_widget_bckgrd_color = dgrey
theme.awful_widget_border_color = dgrey
theme.awful_widget_color= dblue
theme.awful_widget_gradien_color_1= orange
theme.awful_widget_gradien_color_2= orange
theme.awful_widget_gradien_color_3= orange
theme.awful_widget_height=14
theme.awful_widget_margin_top=2
config_dir = awful.util.getdir("config")
-- Display the taglist squares
theme.taglist_squares_sel   = config_dir .. "/themes/ghosty/taglist/squarefw.png"
theme.taglist_squares_unsel = config_dir .. "/themes/ghosty/taglist/squarew.png"

theme.tasklist_floating_icon = config_dir .. "/themes/ghosty/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = config_dir .. "/themes/ghosty/submenu.png"
theme.menu_height = "12"
theme.menu_width  = "120"
theme.menu_border_color = dgrey
theme.menu_border_width = 1

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget =

-- Define the image to load
theme.titlebar_close_button_normal = config_dir .. "/themes/ghosty/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = config_dir .. "/themes/ghosty/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = config_dir .. "/themes/ghosty/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = config_dir .. "/themes/ghosty/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = config_dir .. "/themes/ghosty/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = config_dir .. "/themes/ghosty/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = config_dir .. "/themes/ghosty/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = config_dir .. "/themes/ghosty/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = config_dir .. "/themes/ghosty/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = config_dir .. "/themes/ghosty/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = config_dir .. "/themes/ghosty/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = config_dir .. "/themes/ghosty/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = config_dir .. "/themes/ghosty/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = config_dir .. "/themes/ghosty/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = config_dir .. "/themes/ghosty/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = config_dir .. "/themes/ghosty/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = config_dir .. "/themes/ghosty/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = config_dir .. "/themes/ghosty/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg ".. config_dir .. "/themes/ghosty/background.png"}

-- You can use your own layout icons like this:
theme.layout_fairh = config_dir .. "/themes/ghosty/layouts/fairhw.png"
theme.layout_fairv = config_dir .. "/themes/ghosty/layouts/fairvw.png"
theme.layout_floating  = config_dir .. "/themes/ghosty/layouts/floatingw.png"
theme.layout_magnifier = config_dir .. "/themes/ghosty/layouts/magnifierw.png"
theme.layout_max = config_dir .. "/themes/ghosty/layouts/maxw.png"
theme.layout_fullscreen = config_dir .. "/themes/ghosty/layouts/fullscreenw.png"
theme.layout_tilebottom = config_dir .. "/themes/ghosty/layouts/tilebottomw.png"
theme.layout_tileleft   = config_dir .. "/themes/ghosty/layouts/tileleftw.png"
theme.layout_tile = config_dir .. "/themes/ghosty/layouts/tilew.png"
theme.layout_tiletop = config_dir .. "/themes/ghosty/layouts/tiletopw.png"
theme.layout_spiral  = config_dir .. "/themes/ghosty/layouts/spiralw.png"
theme.layout_dwindle = config_dir .. "/themes/ghosty/layouts/dwindlew.png"

theme.awesome_icon = config_dir .. "/themes/ghosty/awesome.png"
theme.mpdicon = config_dir .. "/themes/ghosty/icons/note-48x48.png"
theme.shortcut = config_dir .. "/themes/ghosty/icons/keyboard_shortcut.png"
theme.shutdown = config_dir .. "/themes/ghosty/icons/shutdown.png"
theme.reboot = config_dir .. "/themes/ghosty/icons/reboot.png"
theme.accept = config_dir .. "/themes/ghosty/icons/accept.png"
theme.cancel = config_dir .. "/themes/ghosty/icons/cancel.png"
theme.calendar = config_dir .. "/themes/ghosty/icons/calendar.png"
theme.task = config_dir .. "/themes/ghosty/icons/task.png"
theme.tasks = config_dir .. "/themes/ghosty/icons/tasks.png"
theme.task_done = config_dir .. "/themes/ghosty/icons/task_done.png"
theme.project = config_dir .. "/themes/ghosty/icons/project.png"
theme.udisks_glue = config_dir .. "/themes/ghosty/icons/udisk-glue.png"
theme.usb = config_dir .. "/themes/ghosty/icons/usb.png"
theme.cdrom = config_dir .. "/themes/ghosty/icons/cdrom.png"
return theme
