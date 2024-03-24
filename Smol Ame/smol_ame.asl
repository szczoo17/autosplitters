state("Smol Ame") {
    int currentTrack : "UnityPlayer.dll", 0x011711BC, 0, 0x8, 0x1C, 0x24, 0x94, 0x18, 0x18;
    string11 levelName : "UnityPlayer.dll", 0x01197098, 0x28, 0x88, 0x8, 0x64, 0, 0xC, 0x2C;
} 

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
}

init {
    refreshRate = 100;
    vars.isAfterLevel = false;
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["levelTime"] = mono.Make<float>("MainScript", "main", "levelTime");
        vars.Helper["isLoading"] = mono.Make<bool>("HUDScript", "HUD", "isLoading");
        vars.Helper["victory"] = mono.Make<bool>("MainScript", "victory");

        return true;
    });
}

update {
    if (!old.victory && current.victory) {
        vars.isAfterLevel = true;
    }
}

isLoading {
    if (current.isLoading) {
        return true;
    }
    return false;
}

gameTime {}

reset {}

split {
    // split after each level
    if (vars.isAfterLevel && !old.isLoading && current.isLoading) {
        vars.isAfterLevel = false;
        return true;
    }
    // split on calli button
    if (current.levelName == "LevelSelect" && old.currentTrack != 2 && current.currentTrack == 2) {
        return true;
    }
}

start {
    if (old.levelTime > current.levelTime) {
        return true;
    }
}
