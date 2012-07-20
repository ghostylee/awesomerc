-- {{{ Basic
-- Standard awesome library
require("awful")
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")
-- revelationi - quickly view all open clients
require("revelation")
-- vicious widgets
local vicious = require("vicious")

-- useful for debugging, marks the beginning of rc.lua exec
print("Entered rc.lua: " .. os.time())

-- load theme
beautiful.init(awful.util.getdir("config") .. "/themes/ghosty/theme.lua")

-- This is used later as the default terminal and editor to run.
browser = "chromium"
terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key, I suggest you to remap
-- Mod4 to another key using xmodmap or other tools.  However, you can use
-- another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}
-- {{{ Colours
blk   = "#1a1a1a"
red   = "#b23535"
gre   = "#60801f"
yel   = "#be6e00"
blu   = "#1f6080"
mag   = "#8f46b2"
cya   = "#73afb4"
whi   = "#b2b2b2"
brblk = "#333333"
brred = "#ff4b4b"
brgre = "#9bcd32"
bryel = "#d79b1e"
brblu = "#329bcd"
brmag = "#cd64ff"
brcya = "#9bcdff"
brwhi = "#d2d2d2"
trblk = "#000000"
trwhi = "#ffffff"

-- Pango colour codes
coldef  = "</span>"
colblk  = "<span color='" .. blk .. "'>"
colred  = "<span color='" .. red .. "'>"
colgre  = "<span color='" .. gre .. "'>"
colyel  = "<span color='" .. yel .. "'>"
colblu  = "<span color='" .. blu .. "'>"
colmag  = "<span color='" .. mag .. "'>"
colcya  = "<span color='" .. cya .. "'>"
colwhi  = "<span color='" .. whi .. "'>"
colbblk = "<span color='" .. brblk .. "'>"
colbred = "<span color='" .. brred .. "'>"
colbgre = "<span color='" .. brgre .. "'>"
colbyel = "<span color='" .. bryel .. "'>"
colbblu = "<span color='" .. brblu .. "'>"
colbmag = "<span color='" .. brmag .. "'>"
colbcya = "<span color='" .. brcya .. "'>"
colbwhi = "<span color='" .. brwhi .. "'>"
-- }}}
-- {{{ Shifty configured tags.
shifty.config.tags = {
    ["1-Term"] = {
        layout    = awful.layout.suit.max,
        mwfact    = 0.55,
        exclusive = false,
        position  = 1,
        spawn     = terminal,
        slave     = true
    },
    ["2-Web"] = {
        layout      = awful.layout.suit.max,
        mwfact      = 0.65,
        exclusive   = true,
        max_clients = 1,
        position    = 2,
        spawn       = browser,
    },
    ["3-Vim"] = {
        layout    = awful.layout.suit.max,
        mwfact    = 0.60,
        exclusive = false,
        position  = 1,
        init      = true,
        screen    = 3,
        slave     = true,
    },
    ["4-Media"] = {
        layout    = awful.layout.suit.max,
        exclusive = false,
        position  = 4,
    },
    ["5-Office"] = {
        layout   = awful.layout.suit.max,
        position = 5,
    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "urxvt",
            "xterm",
        },
        tag = "1-Term",
    },
    {
        match = {
            "chromium",
            "firefox",
            "Vimperator",
        },
        tag = "2-Web",
    },
    {
        match = {
            "vim",
            "gvim",
        },
        tag = "3-Vim",
    },
    {
        match = {
            "Mplayer.*",
            "Mirage",
            "gimp",
            "gtkpod",
            "Ufraw",
            "easytag",
        },
        tag = "Media",
        nopopup = true,
    },
    {
        match = {
            "MPlayer",
            "Gnuplot",
            "galculator",
        },
        float = true,
    },
    {
        match = {
            terminal,
        },
        honorsizehints = false,
        slave = true,
    },
    {
        match = {""},
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
                end),
            awful.button({modkey}, 3, awful.mouse.client.resize)
            )
    },
}

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.tile.bottom,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}
-- }}}
-- {{{ Wibox
-- {{{ widgets
-- {{{ widget separator
separator = widget({ type = "textbox", name = "separator"})
separator.text = " "
-- }}}
-- {{{ widget clock
mytextclock = awful.widget.textclock({align = "right"})
-- }}}
-- {{{ widget laucher
myawesomemenu = {
    {"manual", terminal .. " -e man awesome"},
    {"edit config",
     editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}
mymainmenu = awful.menu(
    {
        items = {
            {"awesome", myawesomemenu, beautiful.awesome_icon},
              {"open terminal", terminal}}
          })
mylauncher = awful.widget.launcher({image = image(beautiful.awesome_icon),
                                     menu = mymainmenu})
-- }}}
-- {{{ widget systray
mysystray = widget({type = "systray", align = "right"})
-- }}}
-- {{{ widget volume
volwidget = widget({ type = "textbox" })
	vicious.register(volwidget, vicious.widgets.volume,
		function (widget, args)
			if args[1] == 0 or args[2] == "♩" then
				return "" .. colcya .. "vol " .. coldef .. colbred .. "mute" .. coldef .. "" 
			else
				return "" .. colcya .. "vol " .. coldef .. colbwhi .. args[1] .. "% " .. coldef .. ""
			end
		end, 2, "Master" )
	volwidget:buttons(
		awful.util.table.join(
			awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle")   end),
			awful.button({ }, 3, function () awful.util.spawn( terminal .. " -e alsamixer")   end),
			awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 2dB+") end),
			awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 2dB-") end)
		)
	)
-- }}}
-- {{{ widget cpu
cpuwidget = widget({ type = "textbox" })
  vicious.register(cpuwidget, vicious.widgets.cpu,
  function (widget, args)
    if  args[1] >= 50 and args[1] <= 75 then
      return "" .. colyel .. "cpu " .. coldef .. colbyel .. args[1] .. "% " .. coldef .. ""
    elseif args[1] > 75 then
      return "" .. colred .. "cpu " .. coldef .. colbred .. args[1] .. "% " .. coldef .. ""
    else
      return "" .. colcya .. "cpu " .. coldef .. colbwhi .. args[1] .. "% " .. coldef .. ""
    end
  end )
cpuwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )
---- }}}
-- {{{ widget temp
tempwidget = widget({ type = "textbox" })
  vicious.register(tempwidget, vicious.widgets.thermal,
  function (widget, args)
    if  args[1] >= 65 and args[1] < 75 then
      return "" .. colyel .. "temp " .. coldef .. colbyel .. args[1] .. "°C " .. coldef .. ""
    elseif args[1] >= 75 and args[1] < 80 then
      return "" .. colred .. "temp " .. coldef .. colbred .. args[1] .. "°C " .. coldef .. ""
    elseif args[1] > 80 then
      naughty.notify({ title = "Temperature Warning", text = "Running hot! " .. args[1] .. "°C!\nTake it easy.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
      return "" .. colred .. "temp " .. coldef .. colbred .. args[1] .. "°C " .. coldef .. "" 
    else
      return "" .. colcya .. "temp " .. coldef .. colbwhi .. args[1] .. "°C " .. coldef .. ""
    end
  end, 19, {"coretemp.0", "core"} )
-- }}}
---- {{{ widget mem
memwidget = widget({ type = "textbox" })
  vicious.cache(vicious.widgets.mem)
  vicious.register(memwidget, vicious.widgets.mem, "" .. colcya .. "mem " .. coldef .. colbwhi .. "$1% ($2 MiB) " .. coldef .. "", 59)
---- }}}
---- {{{ widget battery
batwidget = widget({ type = "textbox" })
  vicious.register(batwidget, vicious.widgets.bat,
  function (widget, args)
    if args[2] >= 20 and args[2] < 30 and args[1] == "-" then
      return "" .. colyel .. "bat " .. coldef .. colbyel .. args[1] .. " " .. args[2] .. "% " .. coldef .. ""
    elseif args[2] >= 10 and args[2] < 20 and args[1] == "-" then
      return "" .. colred .. "bat " .. coldef .. colbred .. args[1] .. " " .. args[2] .. "% " .. coldef .. ""
    elseif args[2] < 10 and args[1] == "-" then
      naughty.notify({ title = "Battery Warning", text = "Battery low! "..args[2].."% left!\nBetter get some power.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
      return "" .. colred .. "bat " .. coldef .. colbred .. args[1] .. " " .. args[2] .. "% " .. coldef .. ""
    elseif args[2] < 10 then 
      return "" .. colred .. "bat " .. coldef .. colbred .. args[1] .. " " .. args[2] .. "% " .. coldef .. ""
    else
      return "" .. colcya .. "bat " .. coldef .. colbwhi .. args[1] .. " " .. args[2] .. "% " .. coldef .. ""
    end
  end, 236, "BAT0" )
---- }}}
---- {{{ widgets Filesystem
---- {{{ root
fsrwidget = widget({ type = "textbox" })
  vicious.register(fsrwidget, vicious.widgets.fs,
  function (widget, args)
    if  args["{/ used_p}"] >= 93 and args["{/ used_p}"] < 97 then
      infoswitch = 1
      return "" .. colyel .. "/ " .. coldef .. colbyel .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB avail) " .. coldef .. ""
    elseif args["{/ used_p}"] >= 97 and args["{/ used_p}"] < 99 then
      infoswitch = 1
      return "" .. colred .. "/ " .. coldef .. colbred .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB avail) " .. coldef .. ""
    elseif args["{/ used_p}"] >= 99 and args["{/ used_p}"] <= 100 then
      naughty.notify({ title = "Hard drive Warning", text = "No space left on root!\nMake some room.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
      infoswitch = 1
      return "" .. colred .. "/ " .. coldef .. colbred .. args["{/ used_p}"] .. "% (only " .. args["{/ avail_gb}"] .. " GiB avail) " .. coldef .. "" 
    else
      infoswitch = 0
      return "" .. colcya .. "/ " .. coldef .. colbwhi .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB avail) " .. coldef .. ""
    end
  end, 621)
---- }}}
---- {{{ /home
fshwidget = widget({ type = "textbox" })
  vicious.register(fshwidget, vicious.widgets.fs,
  function (widget, args)
    if  args["{/home used_p}"] >= 97 and args["{/home used_p}"] < 98 then
      return "" .. colyel .. "/home " .. coldef .. colbyel .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
    elseif args["{/home used_p}"] >= 98 and args["{/home used_p}"] < 99 then
      return "" .. colred .. "/home " .. coldef .. colbred .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
    elseif args["{/home used_p}"] >= 99 and args["{/home used_p}"] <= 100 then
			naughty.notify({ title = "Hard drive Warning", text = "No space left on /home!\nMake some room.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
      return "" .. colred .. "/home " .. coldef .. colbred .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. "" 
    else
      return "" .. colcya .. "/home " .. coldef .. colbwhi .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free) " .. coldef .. ""
    end
  end, 622)
---- }}}
---- }}}
-- {{{ widgets Net
-- {{{ eth
netupwidget = widget({ type = "textbox" })
  vicious.cache(vicious.widgets.net)
  vicious.register(netupwidget, vicious.widgets.net, "" .. colred .. "▲ " .. coldef .. colbwhi .. "${eth0 up_kb} " .. coldef .. "")

netdownwidget = widget({ type = "textbox" })
  vicious.register(netdownwidget, vicious.widgets.net, "" .. colgre .. "▼ " ..coldef .. colbwhi .. "${eth0 down_kb} " .. coldef .. "")

netwidget = widget({ type = "textbox" })
  vicious.register(netwidget, vicious.widgets.net,
  function (widget, args)
      function ip_addr()
        local ip = io.popen("ip addr show eth0 | grep 'inet '")
        local addr = ip:read("*a")
        ip:close()
        addr = string.match(addr, "%d+.%d+.%d+.%d+")
        return addr
      end
      if ip_addr() == nil then
        netdownwidget.visible = false
        netupwidget.visible = false
        return ""
      else
        netdownwidget.visible = true
        netupwidget.visible = true
        return "" .. colcya .. "eth0 " .. coldef .. colbwhi .. ip_addr() .. coldef .. " "
      end
    end, 5, "eth0")
-- }}}
-- {{{ wlan
wifiupwidget = widget({ type = "textbox" })
  vicious.register(wifiupwidget, vicious.widgets.net, "" .. colred .. "▲ " .. coldef .. colbwhi .. "${wlan0 up_kb} " .. coldef .. "")

wifidownwidget = widget({ type = "textbox" })
  vicious.register(wifidownwidget, vicious.widgets.net, "" .. colgre .. "▼ " .. coldef .. colbwhi .. "${wlan0 down_kb} " .. coldef .. "")

wifiwidget = widget({ type = "textbox" })
  vicious.register(wifiwidget, vicious.widgets.wifi,
  function (widget, args)
    function ip_addr()
      local ip = io.popen("ip addr show wlan0 | grep 'inet '")
      local addr = ip:read("*a")
      ip:close()
      addr = string.match(addr, "%d+.%d+.%d+.%d+")
      return addr
    end
    if args["{link}"] == 0 then
      wifidownwidget.visible = false
      wifiupwidget.visible = false
      return ""
    else
      wifidownwidget.visible = true
      wifiupwidget.visible = true
      if args["{link}"]/70*100 <= 50 then
        return "" .. colcya .. "wlan " .. coldef .. colbwhi .. ip_addr() .. coldef .. colwhi .. " on " .. coldef .. colbwhi .. args["{ssid}"] .. coldef .. colred .. " at " .. coldef .. colbred .. string.format("[%i%%]", args["{link}"]/70*100) .. coldef .. " "
      elseif args["{link}"]/70*100 > 50 and args["{link}"]/70*100 <=75 then
        return "" .. colcya .. "wlan " .. coldef .. colbwhi .. ip_addr() .. coldef .. colwhi .. " on " .. coldef .. colbwhi .. args["{ssid}"] .. coldef .. colyel .. " at " .. coldef .. colbyel .. string.format("[%i%%]", args["{link}"]/70*100) .. coldef .. " "
      else
        return "" .. colcya .. "wlan " .. coldef .. colbwhi .. ip_addr() .. coldef .. colwhi .. " on " .. coldef .. colbwhi .. args["{ssid}"] .. coldef .. colwhi .. " at " .. coldef .. colbwhi .. string.format("[%i%%]", args["{link}"]/70*100) .. coldef .. " "
      end
    end
  end, 5, "wlan0" )
-- }}}
-- }}}
-- {{{ widget MPD
mpdwidget = widget({ type = "textbox" })
  vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
      if args["{state}"] == "Stop" then
        return ""
      elseif args["{state}"] == "Play" then
        return "" .. colcya .. "mpd " .. coldef .. colbwhi .. args["{Artist}"] .. " - " .. args["{Album}"] .. " - " .. args["{Title}"] .. coldef .. ""
      elseif args["{state}"] == "Pause" then
        return "" .. colcya .. "mpd " .. coldef .. colbyel .. "paused" .. coldef .. ""
      end
    end, refresh_delay )
  mpdwidget:buttons(
    awful.util.table.join(
      awful.button({}, 1, function () awful.util.spawn("mpc toggle", false) end),
      awful.button({}, 2, function () awful.util.spawn( terminal .. " -e ncmpcpp")   end),
      awful.button({}, 4, function () awful.util.spawn("mpc prev", false) end),
      awful.button({}, 5, function () awful.util.spawn("mpc next", false) end)
    )
  )
-- }}}
-- }}}
-- {{{ wibox init
my_top_wibox = {}
my_bottom_wibox ={}
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({}, 1, awful.tag.viewonly),
awful.button({modkey}, 1, awful.client.movetotag),
awful.button({}, 3, function(tag) tag.selected = not tag.selected end),
awful.button({modkey}, 3, awful.client.toggletag),
awful.button({}, 4, awful.tag.viewnext),
awful.button({}, 5, awful.tag.viewprev)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({}, 1, function(c)
  if not c:isvisible() then
    awful.tag.viewonly(c:tags()[1])
  end
  client.focus = c
  c:raise()
end),
awful.button({}, 3, function()
  if instance then
    instance:hide()
    instance = nil
  else
    instance = awful.menu.clients({width=250})
  end
end),
awful.button({}, 4, function()
  awful.client.focus.byidx(1)
  if client.focus then client.focus:raise() end
end),
awful.button({}, 5, function()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end))
-- }}}
-- {{{ Create a wibox for each screen and add it
for s = 1, screen.count() do
  -- {{{ Create a promptbox for each screen
  mypromptbox[s] =
  awful.widget.prompt({layout = awful.widget.layout.leftright})
  -- }}}
  -- {{{ Create an imagebox widget which will contains an icon indicating which
  -- layout we're using.  We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
  awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
  awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
  awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
  awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
  -- }}}
  --  {{{ Create a taglist widget
  mytaglist[s] = awful.widget.taglist.new(s,
  awful.widget.taglist.label.all,
  mytaglist.buttons)
  mytasklist[s] = awful.widget.tasklist.new(function(c)
    return awful.widget.tasklist.label.currenttags(c, s)
  end,
  mytasklist.buttons)
  -- }}}
  -- {{{ wibox layout
  my_top_wibox[s] = awful.wibox({position = "top", screen = s})
  -- Add widgets to the wibox - order matters
  my_top_wibox[s].widgets = {
    {
      mytaglist[s],
      layout = awful.widget.layout.horizontal.leftright
    },
    mylayoutbox[s],
    mytextclock,
    s == 1 and mysystray or nil,
    mytasklist[s],
    layout = awful.widget.layout.horizontal.rightleft
  }
  my_top_wibox[s].skreen = s
  my_bottom_wibox[s] = awful.wibox({position = "bottom", screen = s})
  my_bottom_wibox[s].widgets = {
    {
      mylauncher,
      mypromptbox[s],
      layout = awful.widget.layout.horizontal.leftright
    },
    volwidget,
    batwidget,
    memwidget,
    --tempwidget,
    cpuwidget,
    netupwidget,
    netdownwidget,
    netwidget,
    wifiupwidget,
    wifidownwidget,
    wifiwidget,
    --fshwidget,
    fsrwidget,
    layout = awful.widget.layout.horizontal.rightleft
  }
  my_bottom_wibox[s].screen = s
  -- }}}
end
-- }}}
-- }}}
-- {{{ SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()
-- }}}
-- {{{ bindings
-- Mouse bindings
root.buttons(awful.util.table.join(
awful.button({}, 3, function() mymainmenu:toggle() end),
awful.button({}, 4, awful.tag.viewnext),
awful.button({}, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = awful.util.table.join(
-- Tags
--awful.key({modkey,}, "Left", awful.tag.viewprev),
--awful.key({modkey,}, "Right", awful.tag.viewnext),
awful.key({modkey,}, "Escape", awful.tag.history.restore),

awful.key({modkey,}, "h", awful.tag.viewprev),
awful.key({modkey,}, "l", awful.tag.viewnext),

awful.key({modkey,}, "p", revelation),
-- Shifty: keybindings specific to shifty
awful.key({modkey, "Shift"}, "d", shifty.del), -- delete a tag
awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
awful.key({modkey}, "n", shifty.send_next), -- client to next tag
awful.key({modkey, "Control"},
"n",
function()
  local t = awful.tag.selected()
  local s = awful.util.cycle(screen.count(), t.screen + 1)
  awful.tag.history.restore()
  t = shifty.tagtoscr(s, t)
  awful.tag.viewonly(t)
end),
awful.key({modkey}, "a", shifty.add), -- creat a new tag
awful.key({modkey,}, "e", shifty.rename), -- rename a tag
awful.key({modkey, "Shift"}, "a", -- nopopup new tag
function()
  shifty.add({nopopup = true})
end),

awful.key({modkey,}, "j",
function()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end),
awful.key({modkey,}, "k",
function()
  awful.client.focus.byidx(1)
  if client.focus then client.focus:raise() end
end),
awful.key({modkey,}, "w", function() mymainmenu:show(true) end),

-- Layout manipulation
awful.key({modkey, "Shift"}, "j",
function() awful.client.swap.byidx(1) end),
awful.key({modkey, "Shift"}, "k",
function() awful.client.swap.byidx(-1) end),
awful.key({modkey, "Control"}, "j", function() awful.screen.focus(1) end),
awful.key({modkey, "Control"}, "k", function() awful.screen.focus(-1) end),
awful.key({modkey,}, "u", awful.client.urgent.jumpto),
awful.key({modkey,}, "Tab",
function()
  awful.client.focus.history.previous()
  if client.focus then
    client.focus:raise()
  end
end),

-- Standard program
awful.key({modkey,}, "Return", function() awful.util.spawn(terminal) end),
awful.key({modkey, "Control"}, "r", awesome.restart),
awful.key({modkey, "Shift"}, "q", awesome.quit),

awful.key({modkey,}, "Right", function() awful.tag.incmwfact(0.05) end),
awful.key({modkey,}, "Left", function() awful.tag.incmwfact(-0.05) end),
awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1) end),
awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
awful.key({modkey,}, "space", function() awful.layout.inc(layouts, 1) end),
awful.key({modkey, "Shift"}, "space",
function() awful.layout.inc(layouts, -1) end),

-- Prompt
awful.key({modkey}, "r", function()
  awful.prompt.run({prompt = "Run: "},
  mypromptbox[mouse.screen].widget,
  awful.util.spawn, awful.completion.shell,
  awful.util.getdir("cache") .. "/history")
end),

awful.key({modkey}, "F4", function()
  awful.prompt.run({prompt = "Run Lua code: "},
  mypromptbox[mouse.screen].widget,
  awful.util.eval, nil,
  awful.util.getdir("cache") .. "/history_eval")
end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
clientkeys = awful.util.table.join(
awful.key({modkey,}, "f", function(c) c.fullscreen = not c.fullscreen  end),
awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
awful.key({modkey, "Control"}, "Return",
function(c) c:swap(awful.client.getmaster()) end),
awful.key({modkey,}, "o", awful.client.movetoscreen),
awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
awful.key({modkey}, "t", awful.client.togglemarked),
awful.key({modkey,}, "m",
function(c)
  c.maximized_horizontal = not c.maximized_horizontal
  c.maximized_vertical   = not c.maximized_vertical
end)
)

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
  globalkeys = awful.util.table.join(globalkeys,
  awful.key({modkey}, i, function()
    local t =  awful.tag.viewonly(shifty.getpos(i))
  end),
  awful.key({modkey, "Control"}, i, function()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end),
  awful.key({modkey, "Control", "Shift"}, i, function()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end),
  -- move clients to other tags
  awful.key({modkey, "Shift"}, i, function()
    if client.focus then
      t = shifty.getpos(i)
      awful.client.movetotag(t)
      awful.tag.viewonly(t)
    end
  end))
end

-- Set keys
root.keys(globalkeys)

-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_focus
  end
end)
-- }}}
-- {{{ Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_normal
  end
end)
-- }}}
