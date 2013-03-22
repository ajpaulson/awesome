-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--Wiget Library
local vicious = require("vicious")
require("wibox")

--Load Debian menu entries
require("debian.menu")
require("freedesktop.utils")
freedesktop.utils.icon_theme = { 'gnome' }
require("freedesktop.menu")

-- r.run for run once
local r = require("runonce")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
local configdir = awful.util.getdir ("config")
beautiful.init(configdir .. "/monokai.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium"
file = "nautilus"
chat = "pidgin"

awful.util.spawn_with_shell("synclient TapButton1=1 && synclient TapButton2=3  && synclient TapButton3=2")
awful.util.spawn_with_shell("xscreensaver -no-splash")
awful.util.spawn_with_shell("xmodmap -e 'keycode 135 = Super_R'")
awful.util.spawn_with_shell("xmodmap -e 'remove Lock = Caps_Lock' && xmodmap -e 'keysym Caps_Lock = Escape'")
awful.util.spawn_with_shell("xrandr --output LVDS1 --mode 1600x900")
awful.util.spawn_with_shell("xrandr --output VGA1 --mode 1920x1080")
awful.util.spawn_with_shell("xrandr --output VGA1 --right-of LVDS1")
awful.util.spawn_with_shell("dropbox start")
r.run("sleep 10s && xcompmgr -o .75 &")
r.run("volumeicon")
r.run("parcellite")
r.run("xfce4-power-manager")
r.run("wicd-client")
r.run("urxvtd -q -o -f")
r.run("gnome-keyring-daemon --start -c pkcs11 &")
r.run("eval $(gpg-agent --daemon) &")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
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
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Tags
 -- Define a tag table which will hold all screen tags.
 tags = {
   names  = { "ᨁ", "ᨅ", "ᨇ", "ᨑ"},
   layout = { layouts[5], layouts[1], layouts[1], layouts[5]
 }}
 for s = 1, screen.count() do
 tags[s] = awful.tag(tags.names, s, tags.layout)
    end
 -- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myfreedesktopmenu = freedesktop.menu.new()
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit },
   { "shutdown" , "sudo shutdown -hP now" },
   { "reboot" , "sudo reboot" },
   { "hibernate" , "sudo pm-suspend-hybrid" },
   { "sleep" , "sudo pm-suspend" },
   { "lock" , "lxlock" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
				    { "Menu" , myfreedesktopmenu, freedesktop.utils.lookup_icon({ icon = 'debian-swirl' }) },
--				    { "Debian", debian.menu.Debian_menu.Debian, freedesktop.utils.lookup_icon({ icon = 'debian-swirl' }) },
                                    { "open terminal", terminal, freedesktop.utils.lookup_icon({ icon = 'terminal' }) }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox

-- Initialize widget
timewidget = widget({ type = "textbox" })
-- Register widget
vicious.register(timewidget, vicious.widgets.date, '<span foreground="#585656" background="#cac6ce" weight="bold"></span><span foreground="#cac6ce" weight="bold"> %F ≀ %R </span>')
timewidget.bg = "#585656"

-- Initialize widget
batwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(batwidget, vicious.widgets.bat, '<span foreground="#cac6ce" background="#FD971F"></span><span foreground="#585656" weight="bold"> 🔋 $1$2% </span>', 20, "BAT0")
batwidget.bg = "#cac6ce"

-- VolWidget
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume, '<span foreground="#1B1D1E"> 🔊 $1% </span>', 2, "Master")
volwidget.bg = "#FD971F"

volarr = widget({ type = "textbox" })
volarr.text = '<span foreground="#FD971F"></span>'
volarr.bg = "#1B1D1E00"

space = widget({ type = "textbox" })
space.text = " "

rightarr = widget({ type = "textbox" })
rightarr.text = '<span foreground="#82B414"></span>'
rightarr.bg = "#1B1D1E00"

wrapa = widget({ type = "textbox" })
wrapa.text = "{"

wrapb = widget({ type = "textbox" })
wrapb.text = "}"

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "14", screen = s, bg = beautiful.wibox_bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
           mytaglist[s],
           rightarr,
           space,
           mylayoutbox[s],
           space,
           mypromptbox[s],
           layout = awful.widget.layout.horizontal.leftright
        },
        timewidget,
        batwidget,
        volwidget,
        volarr,
        layout = awful.widget.layout.horizontal.rightleft
    }
    --bottombar
    mywibox[s] = awful.wibox({ position = "bottom", height = "18", screen = s })
    --add widgets
    mywibox[s].widgets = {
        space,
        space,
        s == 1 and mysystray or nil,
        space,
        mytasklist[s],
        space,
        space,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

--mylayoutbox[s],
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    --Volume manipulation  
     awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5+") end),
     awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5-") end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Shift"   }, "d",     function () awful.util.spawn("lxlock")   end),
    awful.key({ modkey, "Shift"   }, "p",     function () awful.util.spawn("sudo pm-suspend") end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
		     size_hints_honor = false,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "VLC" },
      properties = { floating = false } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { instance = "exe" },
      properties = { floating = true } },
    { rule = { instance = "plugin-container" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "URxvt" },
      properties = { opacity = 0.85 } },
    { rule = { class = "XTerm" },
      properties = { opacity = 0.8 } },
    { rule = { class = "Pidgin" },
      properties = { opacity = 0.95 } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

