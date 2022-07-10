state("Grim Leaper") {
    double inGameTimer : "UnityPlayer.dll", 0x0127DF00, 0x1A0, 0x24, 0x20, 0x70, 0x40;
    int screen : "UnityPlayer.dll", 0x012B1784, 0x8, 0x8, 0x1C, 0x3C, 0x60, 0x18, 0x10;
    int gameState : "UnityPlayer.dll", 0x0129E4F8, 0x64, 0x70, 0xC, 0xC, 0x10, 0x4, 0x78, 0xCC;
} 

startup {}

init
{
	vars.furthestScreen = current.screen;
}

update {}

isLoading {}

gameTime {
    return TimeSpan.FromSeconds(current.inGameTimer);
}

reset {
    if (old.gameState != 0 && current.gameState == 0) {
	    return true;
    }
}

split
{
    // split after each screen
    if (current.screen > vars.furthestScreen) {
        vars.furthestScreen = current.screen;
        return true;
    }
    // final split
    if (old.gameState == 1 && current.gameState == 3) {
        return true;
    }
}

onStart
{
	vars.furthestScreen = current.screen;
}

start
{
    // start after title
    if (old.gameState == 0 && current.gameState == 1) {
        return true;
    }    
	// start after each screen
    if (current.screen > old.screen) {
        vars.furthestScreen = current.screen;
        return true;
    }
}