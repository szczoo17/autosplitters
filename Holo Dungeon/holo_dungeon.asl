state("Holo Dungeon") {
    int mainMenuSelection : "UnityPlayer.dll", 0x0179C3A0, 0x8, 0x0, 0x30, 0x30, 0x38, 0x150, 0x60, 0x70;
    bool mainMenuActive : "UnityPlayer.dll", 0x0179C3A0, 0x8, 0x0, 0x30, 0x30, 0x38, 0x150, 0x60, 0x74;
    bool kiaraInParty : "UnityPlayer.dll", 0x017BC058, 0x8, 0x10, 0x30, 0x28, 0x28, 0xCC;
    bool guraInParty : "UnityPlayer.dll", 0x017BC058, 0x8, 0x10, 0x30, 0x28, 0x28, 0xCD;
    bool inaInParty : "UnityPlayer.dll", 0x017BC058, 0x8, 0x10, 0x30, 0x28, 0x28, 0xCE;
    bool inCombat : "UnityPlayer.dll", 0x017BC058, 0x8, 0x10, 0x30, 0x28, 0x28, 0x99;
    int combatId : "UnityPlayer.dll", 0x017BC058, 0x8, 0x10, 0x30, 0x28, 0x28, 0x40, 0x38;
    string58 cutsceneAfterCombat : "UnityPlayer.dll", 0x017BC058, 0x8, 0x10, 0x30, 0x28, 0x28, 0x78, 0x14;
    string78 currentDialogue : "UnityPlayer.dll", 0x017F6E98, 0x8, 0x0, 0x28, 0x8, 0xF0, 0x68, 0x20, 0x14;
    int enemyHealth : "UnityPlayer.dll", 0x017B8868, 0xC8, 0x40, 0xE0, 0x60, 0x28, 0x70, 0x20, 0x48;
}

startup {}

init {}

update {}

isLoading {}

gameTime {}

reset {}

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
    // split after boss battles
    if (old.inCombat && !current.inCombat) {
        // split after barrel
        if (current.combatId == 2) {
            return true;
        }
        // split after gnomes
        if (current.cutsceneAfterCombat == "cutscene-aftercallignomefight") {
            return true;
        }
        // split after haachama
        if (current.combatId == 1) {
            return true;
        }
    }
    // split on MOM
    if (current.inCombat && current.cutsceneAfterCombat == "smolame-aftermom" && old.enemyHealth > 0 && current.enemyHealth == 0) {
        return true;
    }
    // split on sleep
    if (old.currentDialogue == "You decided to go to sleep for the day." && current.currentDialogue == null) {
        return true;
    }
}

start {
    if (old.mainMenuActive && !current.mainMenuActive && old.mainMenuSelection == 0) {
        return true;
    }
}
