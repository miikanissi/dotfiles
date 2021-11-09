# ~/.config/qtile/config.py
# Miika Nissi, https://miikanissi.com

# Standard library imports
import os
import subprocess
from typing import List

# Qtile imports
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# Third party imports
# For dynamic multiscreen, install xlib from pip
from Xlib import display

# Global variables
mod = "mod4"
terminal = "st"
browser = "brave-browser"
file_browser = "pcmanfm"
launcher = "dmenu_run -fn 'UbuntuNerdFont:size=11' -nb '#f9f5d7' -nf '#3c3836' -sb '#b16286' -sf '#7c6f64'"

# Dynamic multiscreen setup
d = display.Display()
s = d.screen()
r = s.root
res = r.xrandr_get_screen_resources()._data

screen_count = 0
for output in res["outputs"]:
    mon = d.xrandr_get_output_info(output, res["config_timestamp"])._data
    if mon["num_preferred"] and mon["crtc"]:
        screen_count += 1
if screen_count == 0:
    screen_count = 1


@hook.subscribe.screen_change
def restart_on_randr(qtile, _ev):
    qtile.cmd_restart()


@hook.subscribe.client_new
def transient_window(window):
    if window.window.get_wm_transient_for():
        window.floating = True


@hook.subscribe.startup_once
def autostart():
    """ Programs to start when window manager is loading """
    autostart = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([autostart])


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "comma", lazy.prev_screen(), desc="Focus to the left screen"),
    Key([mod], "period", lazy.next_screen(), desc="Focus to the right screen"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn(launcher), desc="Spawn a launcher"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen window"),
    # programs
    Key([mod], "w", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "b", lazy.spawn(file_browser), desc="Launch file browser"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(
        border_focus=["#b16286"],
        border_normal=["#928374"],
        border_width=2,
        # margin=2,
        insert_position=1,
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="Ubuntu",
    fontsize=12,
    padding=3,
    background="#f9f5d7",
    foreground="#3c3836",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(
                    highlight_method="line",
                    disable_drag=True,
                    hide_unused=True,
                    active="#3c3836",
                    inactive="#928374",
                    block_highlight_text_color="#3c3836",
                    this_screen_border="#b16286",
                    this_current_screen_border="#b16286",
                    other_screen_border="#928374",
                    other_current_screen_border="#3c3836",
                    highlight_color=["#928374"],
                ),
                widget.WindowName(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
                widget.Volume(volume_app="pavucontrol"),
                widget.Systray(),
            ],
            24,
            background="#f9f5d7",
            foreground="#3c3836",
        ),
    ),
]
if screen_count > 1:
    for screen in range(0, screen_count):
        screens.append(
            Screen(
                top=bar.Bar(
                    [
                        widget.CurrentLayoutIcon(),
                        widget.GroupBox(
                            highlight_method="line",
                            disable_drag=True,
                            hide_unused=True,
                            active="#444444",
                            inactive="#bcbcbc",
                            block_highlight_text_color="#444444",
                            this_screen_border="#005faf",
                            this_current_screen_border="#005faf",
                            other_screen_border="#bcbcbc",
                            other_current_screen_border="#444444",
                            highlight_color=["#bcbcbc"],
                        ),
                        widget.WindowName(),
                        widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                        widget.QuickExit(),
                        widget.Volume(volume_app="pavucontrol"),
                    ],
                    24,
                    background="#eeeeee",
                    foreground="#444444",
                ),
            ),
        )

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
auto_minimize = False

# Needed for some Java programs
wmname = "LG3D"
# Fixes QT apps
os.environ["QT_QPA_PLATFORMTHEME"] = "qt5ct"
