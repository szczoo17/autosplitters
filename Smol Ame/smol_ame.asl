state("Smol Ame") {
    float clock : "UnityPlayer.dll", 0x0127E0F8, 0x1C8, 0x19C, 0x4C, 0x24, 0x14, 0x18, 0x1C;
    bool ameSpin : "UnityPlayer.dll", 0x012A2EB8, 0xCC, 0x54, 0x1C, 0xC, 0xC, 0x3C, 0x6E;
    bool ameDance : "mono-2.0-bdwgc.dll", 0x0039FC4C, 0x18, 0x60, 0x60, 0x60, 0xF36;
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
