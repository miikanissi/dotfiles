/* See LICENSE file for copyright and license details. */

/* Constants */
#define TERMINAL "kitty -1 --listen-on=tcp:localhost:12344"
#define STATUSBAR "dwmblocks"

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "UbuntuNerdFont:size=11" };
static const char dmenufont[]       = "UbuntuNerdFont:size=11";
static char normbgcolor[]           = "#eeeeee";
static char normbordercolor[]       = "#eeeeee";
static char normfgcolor[]           = "#444444";
static char selfgcolor[]            = "#bcbcbc";
static char selbordercolor[]        = "#005faf";
static char selbgcolor[]            = "#005faf";
static char *colors[][3] = {
        /*               fg           bg           border   */
        [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
        [SchemeSel]  = { normfgcolor,  normbgcolor,  selbordercolor  },
	[SchemeStatus]  = { normfgcolor, normbgcolor,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { selfgcolor, selbgcolor,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
        [SchemeTagsNorm]  = { normfgcolor, normbgcolor,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
        [SchemeInfoSel]  = { normfgcolor, normbgcolor,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
        [SchemeInfoNorm]  = { normfgcolor, normbgcolor,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* staticstatus */
static const int statmonval = 0;

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class        instance        title       tags mask     isfloating   monitor */
	{ "Gimp",       NULL,           NULL,       0,            1,           -1 },
	{ "kitty",      "kitty",        "ncmpcpp",  5,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD, XK_j,     ACTION##stack, {.i = INC(+1) } }, \
	{ MOD, XK_k,     ACTION##stack, {.i = INC(-1) } }, \
	{ MOD, XK_v,     ACTION##stack, {.i = 0 } }, \

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "kitty", "-1", NULL, "--listen-on=tcp:localhost:12344", NULL };

static Key keys[] = {
	/* modifier                     key             function        argument */
	STACKKEYS(MODKEY,                               focus)
	STACKKEYS(MODKEY|ShiftMask,                     push)
	{ MODKEY,                       XK_d,           spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,      spawn,          {.v = termcmd } },
        { MODKEY|ShiftMask,		XK_q,           quit,           {0} },
	{ MODKEY,                       XK_o,           incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,           incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,           setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,           setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_space,       zoom,           {0} },
	{ MODKEY|Mod1Mask,              XK_0,           togglegaps,     {0} },
	{ MODKEY,                       XK_Tab,         view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,           killclient,     {0} },
	{ MODKEY,                       XK_t,           setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,           setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_t,           setlayout,      {.v = &layouts[2]} },
	/* { MODKEY,                       XK_space,       setlayout,      {0} }, */
	{ MODKEY|ShiftMask,             XK_space,       togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,           togglefullscr,  {0} },
	{ MODKEY,                       XK_0,           view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,           tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,       focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,      focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,       tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,      tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_F5,          xrdb,           {.v = NULL } },
	TAGKEYS(                        XK_1,                           0)
	TAGKEYS(                        XK_2,                           1)
	TAGKEYS(                        XK_3,                           2)
	TAGKEYS(                        XK_4,                           3)
	TAGKEYS(                        XK_5,                           4)
	TAGKEYS(                        XK_6,                           5)
	TAGKEYS(                        XK_7,                           6)
	TAGKEYS(                        XK_8,                           7)
	TAGKEYS(                        XK_9,                           8)
	{ MODKEY|ShiftMask,             XK_BackSpace,   quit,           {0} },
        { MODKEY,                       XK_minus,       spawn,          SHCMD("pactl set-sink-volume 0 -5%; kill -40 $(pidof dwmblocks)") },
        { MODKEY,                       XK_equal,       spawn,          SHCMD("pactl set-sink-volume 0 +5%; kill -40 $(pidof dwmblocks)") },
        { MODKEY|ShiftMask,             XK_m,           spawn,          SHCMD("pactl set-sink-mute 0 toggle; kill -40 $(pidof dwmblocks)") },
        { MODKEY,			XK_p,		spawn,		SHCMD("mpc toggle") },
        { MODKEY|ShiftMask,		XK_p,		spawn,		SHCMD("mpc clear") },
        { MODKEY,		        XK_n,	        spawn,		SHCMD("mpc next") },
        { MODKEY|ShiftMask,		XK_n,	        spawn,		SHCMD("mpc prev") },
        { MODKEY,		        XK_r,	        spawn,		SHCMD("mpc random") },
        /* launchers */
        { MODKEY,			XK_w,           spawn,	        SHCMD("brave-browser") },
        { MODKEY,			XK_e,           spawn,	        SHCMD("geary") },
        { MODKEY,			XK_s,           spawn,	        SHCMD("signal-desktop --start-in-tray --use-tray-icon") },
        { MODKEY,			XK_m,		spawn,		SHCMD(TERMINAL " --title ncmpcpp ncmpcpp") },
        { MODKEY,                       XK_b,           spawn,          SHCMD("pcmanfm") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkStatusText,        0,              Button4,        sigstatusbar,   {.i = 4} },
	{ ClkStatusText,        0,              Button5,        sigstatusbar,   {.i = 5} },
	{ ClkStatusText,        ShiftMask,      Button1,        sigstatusbar,   {.i = 6} },
	{ ClkStatusText,        ShiftMask,      Button3,        sigstatusbar,   {.i = 7} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
