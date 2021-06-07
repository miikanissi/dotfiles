//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/        /*Command*/		/*Update Interval*/	/*Update Signal*/
        {"",            "volume.sh",            0,                      6},
        {"",            "caffeine.sh",          0,                      5},
        {"",            "connection.sh",        5,                      4},
        {"",            "battery.sh",           5,                      3},
        {"",            "clock.sh",             30,                     2},
        {"",            "power.sh",             0,                      1},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  |  ";
static unsigned int delimLen = 7;
