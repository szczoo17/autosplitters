state("Holo Dungeon") {
    int mainMenuSelection : "UnityPlayer.dll", 0x0179C3A0, 0x8, 0x0, 0x30, 0x30, 0x38, 0x150, 0x60, 0x70;
    bool mainMenuActive : "UnityPlayer.dll", 0x0179C3A0, 0x8, 0x0, 0x30, 0x30, 0x38, 0x150, 0x60, 0x74;
    bool kiaraInParty : "UnityPlayer.dll", 0x01762080, 0x18, 0xB8, 0x10, 0xB0, 0x118, 0xCC;
    bool guraInParty : "UnityPlayer.dll", 0x01762080, 0x18, 0xB8, 0x10, 0xB0, 0x118, 0xCD;
    bool inaInParty : "UnityPlayer.dll", 0x01762080, 0x18, 0xB8, 0x10, 0xB0, 0x118, 0xCE;
    bool inCombat : "UnityPlayer.dll", 0x01762080, 0x18, 0xB8, 0x10, 0xB0, 0x118, 0x99;
    int combatId : "UnityPlayer.dll", 0x01762080, 0x18, 0xB8, 0x10, 0xB0, 0x118, 0x40, 0x38;
    string36 sceneToReturnTo : "UnityPlayer.dll", 0x017FF028, 0x120, 0x38, 0x10, 0x28, 0xB0, 0x118, 0x70, 0x14;
    string78 currentDialogue : "UnityPlayer.dll", 0x017F6E98, 0x8, 0x0, 0x28, 0x8, 0xF0, 0x68, 0x20, 0x14;
} 

startup {}

init {}

update {}

isLoading {}

gameTime {}

reset {
    if (!old.mainMenuActive && current.mainMenuActive) {
        return true;
    }
}

split {
    // split at kiara
    if (!old.kiaraInParty && current.kiaraInParty) {
        return true;
    }
    // split at gura
    if (!old.guraInParty && current.guraInParty) {
        return true;
    }
    // split at ina
    if (!old.inaInParty && current.inaInParty) {
        return true;
    }
    // split after barrel
    if (current.combatId == 2 && old.inCombat && !current.inCombat) {
        return true;
    }
    // split after gnomes
    if (current.combatId == 0 && current.sceneToReturnTo != null && current.sceneToReturnTo.Equals("scene-northcottage") && old.inCombat && !current.inCombat) {
        return true;
    }
    // split after haachama
    if (current.combatId == 1 && old.inCombat && !current.inCombat) {
        return true;
    }
    // split on sleep
    if (old.currentDialogue != null && old.currentDialogue.Equals("You decided to go to sleep for the day.") && current.currentDialogue == null) {
        return true;
    }
}

start {
    if (old.mainMenuActive && !current.mainMenuActive && current.mainMenuSelection == 0) {
        return true;
    }
}