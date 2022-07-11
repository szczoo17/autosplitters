state("Smol Ame") {
    float clock : "UnityPlayer.dll", 0x01171170, 0x7F8, 0x24, 0xD8, 0x3C, 0x1C;
    bool ameSpin : "UnityPlayer.dll", 0x01197098, 0xCC, 0x54, 0x40, 0x1C, 0x24, 0x18, 0x5E;
    bool ameDance : "mono-2.0-bdwgc.dll", 0x0039EC4C, 0x18, 0x30, 0xFC6;
    int currentTrack : "UnityPlayer.dll", 0x011711BC, 0, 0x8, 0x1C, 0x24, 0x94, 0x18, 0x18;
    string11 levelName : "UnityPlayer.dll", 0x01197098, 0x28, 0x88, 0x8, 0x64, 0, 0xC, 0x2C;
} 

startup {}

init {
    refreshRate = 100;
    vars.isAfterLevel = false;
}

update {
    if (!old.ameDance && current.ameDance) {
        vars.isAfterLevel = true;
    }
}

isLoading {
    if (current.ameSpin) {
        return true;
    }
    return false;
}

gameTime {}

reset {}

split {
    // split after each level
    if (vars.isAfterLevel && !old.ameSpin && current.ameSpin) {
        vars.isAfterLevel = false;
        return true;
    }
    // split on calli button
    if (current.levelName == "LevelSelect" && old.currentTrack != 2 && current.currentTrack == 2) {
        return true;
    }
}

start {
    if (old.clock > current.clock) {
        return true;
    }
}
