/*
 * GTA IV LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave, updated to work with the Complete Edition by hoxi, expanded upon features by Kocurro14.
 * https://github.com/Kocurro14/LiveSplit.ASL/tree/stable/GTAIV
 */

// isLoading before 1.2.0.32: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// isLoading in/after 1.2.0.32: 0 if loading, random values if not loading
// whiteLoadingScreen: a number that isn't 0 while white screen is showing (65536), 0 on black screen

// LastMissionName values refer to: https://github.com/Kocurro14/LiveSplit.ASL/blob/stable/GTAIV/LastMissionName_details

// isCutsceneRunning: 0 if not running, 8 if running, 10 if skipped
// the cinematic cutscenes, not scripted ones with pre-made animations

// current Complete Edition
state ("GTAIV", "1.2.0.59") {
	uint isLoading : 0xD747A4;
	uint whiteLoadingScreen : 0x017B37D0;
	int LastMissionName : 0xEB6FA8;
	int isCutsceneRunning : 0xE9475C;
}

// Complete Edition until 9/02/2023
state ("GTAIV", "1.2.0.43") {
	uint isLoading : 0xD747A4;
	uint whiteLoadingScreen : 0x017B37D0;
	int LastMissionName : 0xEB6FA8;
	int isCutsceneRunning : 0xE9475C;
}

// original Complete Edition
state ("GTAIV", "1.2.0.32") {
	uint isLoading : 0xD74824;
	uint whiteLoadingScreen : 0x017B3840;
	int LastMissionName : 0xEB6F38;
	int isCutsceneRunning : 0xE946EC;
}

// Patch 8
state ("GTAIV", "1.0.8.0") {
	uint isLoading : 0xDF800C;
	uint whiteLoadingScreen : 0x014CB06C;
	int LastMissionName : 0xE2AF68;
	int isCutsceneRunning : 0xD515D0;
}

// Patch 7
state ("GTAIV", "1.0.7.0") {
	uint isLoading : 0xCF9AD4;
	uint whiteLoadingScreen : 0x014A8238;
	int LastMissionName : 0x011C38A8;
	int isCutsceneRunning : 0xDE45F0;
}

// Patch 4
state ("GTAIV", "1.0.4.0") {
	uint isLoading : 0xC07A0C;
	uint whiteLoadingScreen : 0x01223EA8;
	int LastMissionName : 0xC60A88;
	int isCutsceneRunning : 0xC80EBC;
}

startup {
	vars.offsets = new Dictionary<string, int> {
		// newest first
		{"1.2.0.59", -0x30CA98},
		{"1.2.0.43", -0x30CA98},
		{"1.2.0.32", -0x30CA28},  
		{"1.0.8.0", -0x398940},
		{"1.0.7.0", 0x0},
		{"1.0.5.2", -0x1020},
		{"1.0.6.0", -0xFE0},
		{"1.0.0.4", -0x4B7BC8},
		{"1.0.4.0", -0x563040},
	};

	vars.stats = new Dictionary<string, int> {
		{"fGameTime", 0x011C3F60},
		{"iMissionsPassed", 0x011C4460},
		{"iMissionsFailed", 0x011C4464},
		{"iMissionsAttempted", 0x011C4468},
		{"iStuntJumps", 0x011C44A4},
		{"iDrugJobs", 0x011C44DC},
		{"iQUB3DHighScore", 0x011C45E8}, // 10,950 default hiscore
		{"iMostWanted", 0x011C460C},
		{"iVigilante", 0x011C4608},
		{"iPigeons", 0x011C4610},
		{"iRandomEncounters", 0x011C21C4},
	};

	refreshRate = 60;

	vars.prevPhase = null; // keeps track of previous timer phase
	vars.splits = new HashSet<string>(); // keeps track of splitted splits

	Action<string, string, string, string, bool> addSetting = (parent, id, label, tooltip, defaultVal) => {
		settings.Add(id, defaultVal, label, parent);
		settings.SetToolTip(id, tooltip);
	};

	addSetting(null, "iMissionsPassed", "Split on Mission End", "Split upon completion of selected main story mission(s)", true);	
		addSetting("iMissionsPassed", "ROM0", "Roman Bellic", null, true);
			addSetting("ROM0", "ROM1", "The Cousins Bellic", null, true);
			addSetting("ROM0", "ROM2", "It's Your Call", null, true);
			addSetting("ROM0", "ROM3", "Three's a Crowd", null, true);
			addSetting("ROM0", "ROM4", "Bleed Out", null, true);
			addSetting("ROM0", "ROM5", "Easy Fare", null, true);
			addSetting("ROM0", "ROM6", "Jamaican Heat", null, true);
			addSetting("ROM0", "ROM7", "Uncle Vlad", null, true);
			addSetting("ROM0", "ROM8", "Crime and Punishment", null, true);
			addSetting("ROM0", "ROM9", "Logging On", null, true);
			addSetting("ROM0", "ROM10", "Roman's Sorrow", null, true);
			addSetting("ROM0", "ROM11", "Hostile Negotiation", null, true);
			addSetting("ROM0", "ROM12", "Weekend at Florian's", null, true);
			addSetting("ROM0", "ROM13", "That Special Someone", null, true);
			
		addSetting("iMissionsPassed", "KD", "Michelle", null, true);
			addSetting("KD", "FD", "First Date", null, true);
			
		addSetting("iMissionsPassed", "VL0", "Vlad Glebov", null, true);
			addSetting("VL0", "VL1", "Bull in a China Shop", null, true);
			addSetting("VL0", "VL2", "Hung Out to Dry", null, true);
			addSetting("VL0", "VL3", "Clean Getaway", null, true);
			addSetting("VL0", "VL4", "Ivan the Not So Terrible", null, true);
			
		addSetting("iMissionsPassed", "LJ0", "Little Jacob", null, true);
			addSetting("LJ0", "LJ1", "Concrete Jungle", null, true);
			addSetting("LJ0", "LJ2", "Shadow", null, true);
			
		addSetting("iMissionsPassed", "BK0", "Brucie Kibbutz", null, true);
			addSetting("BK0", "BK1", "Search and Delete", null, true);
			addSetting("BK0", "BK2", "Easy as Can Be", null, true);
			addSetting("BK0", "BK3", "Out of the Closet...", null, true);
			addSetting("BK0", "BK4", "...Out of the Closet", "Not required to beat the game, but completing it gets rid of constant date reminders", true);
			addSetting("BK0", "BK5", "No. 1", "Not required to beat the game", false);
			
		addSetting("iMissionsPassed", "FA0", "Mikhail Faustin", null, true);
			addSetting("FA0", "FA1", "Do You Have Protection?", null, true);
			addSetting("FA0", "FA2", "Final Destination", null, true);
			addSetting("FA0", "FA3", "No Love Lost", null, true);
			addSetting("FA0", "FA4", "Rigged to Blow", null, true);
			
		addSetting("iMissionsPassed", "DR0", "Dimitri Rascalov", null, true);
			addSetting("DR0", "DR1", "The Master and the Molotov", null, true);
			addSetting("DR0", "DR2", "Russian Revolution", null, true);
			
		addSetting("iMissionsPassed", "MN0", "Manny Escuela", null, true);
			addSetting("MN0", "MN1", "Escuela of the Streets", null, true);
			addSetting("MN0", "MN2", "Street Sweeper", null, true);
			addSetting("MN0", "MN3", "The Puerto Rican Connection", null, true);
			
		addSetting("iMissionsPassed", "EL0", "Elizabeta Torres", null, true);
			addSetting("EL0", "EL1", "Luck of the Irish", null, true);
			addSetting("EL0", "EL2", "Blow Your Cover", null, true);
			addSetting("EL0", "EL3", "The Snow Storm", null, true);
			addSetting("EL0", "EL4", "Have a Heart", null, true);
			
		addSetting("iMissionsPassed", "PX0", "Playboy X", null, true);
			addSetting("PX0", "PX1", "Deconstruction for Beginners", null, true);
			addSetting("PX0", "PX2", "Photo Shoot", null, true);
			addSetting("PX0", "PX3", "The Holland Play...", "Not required to beat the game", false);
			addSetting("PX0", "PX4", "...The Holland Play", "Not required to beat the game", false);
			
		addSetting("iMissionsPassed", "DW0", "Dwayne Forge", null, false);
			addSetting("DW0", "DW1", "Ruff Rider", "Not required to beat the game", false);
			addSetting("DW0", "DW2", "Undress to Kill", "Not required to beat the game", false);
			
		addSetting("iMissionsPassed", "FM0", "Francis McReary", null, true);
			addSetting("FM0", "FM1", "Call and Collect", null, true);
			addSetting("FM0", "FM2", "Final Interview...", null, true);
			addSetting("FM0", "FM3", "...Final Interview", null, true);
			addSetting("FM0", "FM4", "Holland Nights", null, true);
			addSetting("FM0", "FM5", "Lure", null, true);
			addSetting("FM0", "FM6", "Blood Brothers", null, true);
			addSetting("FM0", "FM7", "Undertaker", null, true);
			
		addSetting("iMissionsPassed", "PM0", "Packie McReary", null, true);
			addSetting("PM0", "PM1", "Harboring a Grudge", null, true);
			addSetting("PM0", "PM2", "Waste Not Want Knots", null, true);
			addSetting("PM0", "PM3", "Three Leaf Clover", null, true);
			
		addSetting("iMissionsPassed", "GM0", "Gerry McReary", null, true);
			addSetting("GM0", "GM1", "Actions Speak Louder than Words", null, true);
			addSetting("GM0", "GM2", "I Need Your Clothes, Your Boots, and Your Motorcycle", null, true);
			addSetting("GM0", "GM3", "I'll Take Her...", null, true);
			addSetting("GM0", "GM4", "...I'll Take Her", null, true);
			//addSetting("GM0", "GM5", "Ransom", "Experimental", false); //is here to keep mission tree structure
			addSetting("GM0", "GM6", "She's A Keeper", null, true);
			addSetting("GM0", "GM7", "Diamonds are a Girl's Best Friend", null, true);
			
		addSetting("iMissionsPassed", "DM0", "Derrick McReary", null, true);
			addSetting("DM0", "DM1", "Smackdown", null, true);
			addSetting("DM0", "DM2", "Babysitting", null, true);
			addSetting("DM0", "DM3", "Tunnel of Death", null, true);
			
		addSetting("iMissionsPassed", "ULP0", "United Liberty Paper", null, true);
			addSetting("ULP0", "ULP1", "Wrong is Right", null, true);
			addSetting("ULP0", "ULP2", "Portrait of a Killer", null, true);
			addSetting("ULP0", "ULP3", "Dust Off", null, true);
			addSetting("ULP0", "ULP4", "Paper Trail", null, true);
			
		addSetting("iMissionsPassed", "BC0", "Bernie Crane", null, true);
			addSetting("BC0", "BC1", "Hating the Haters", null, true);
			addSetting("BC0", "BC2", "Union Drive", null, true);
			addSetting("BC0", "BC3", "Buoys Ahoy", null, true);
			
		addSetting("iMissionsPassed", "RB0", "Ray Boccino", null, true);
			addSetting("RB0", "RB1", "A Long Way to Fall", null, true);
			addSetting("RB0", "RB2", "Taking in the Trash", null, true);
			addSetting("RB0", "RB3", "Meltdown", null, true);
			addSetting("RB0", "RB4", "Museum Piece", null, true);
			addSetting("RB0", "RB5", "No Way on the Subway", null, true);
			addSetting("RB0", "RB6", "Late Checkout", null, true);
			
		addSetting("iMissionsPassed", "PB0", "Phil Bell", null, true);
			addSetting("PB0", "PB1", "Truck Hustle", null, true);
			addSetting("PB0", "PB2", "Catch The Wave", null, true);
			addSetting("PB0", "PB3", "Trespass", null, true);
			addSetting("PB0", "PB4", "To Live and Die in Alderney", null, true);
			
		addSetting("iMissionsPassed", "JP0", "Jimmy Pegorino", null, true);
			addSetting("JP0", "JP1", "Pegorino's Pride", null, true);
			addSetting("JP0", "JP2", "Payback", null, true);
			addSetting("JP0", "JP3", "Flatline", null, true);
			addSetting("JP0", "JP4", "Pest Control...", null, true);
			addSetting("JP0", "JP5", "...Pest Control", null, true);
			
		addSetting("iMissionsPassed", "GG0", "Jon Gravelli", null, true);
			addSetting("GG0", "GG1", "Entourage", null, true);
			addSetting("GG0", "GG2", "Dining Out", null, true);
			addSetting("GG0", "GG3", "Liquidize the Assets", null, true);
			
		addSetting("iMissionsPassed", "FIN", "Finale", null, true);
			addSetting("FIN", "FIN1", "One Last Thing...", null, true);
			addSetting("FIN", "FIN2", "If the Price is Right | A Dish Served Cold", null, true);
			//addSetting("FIN", "FIN3", "Mr. & Mrs. Bellic", null, true); //is here to keep mission tree structure
			addSetting("FIN", "FIN4", "In Mourning", null, true);
			addSetting("FIN", "FIN5", "A Revenger's Tragedy | Out of Commission", "Any% / Classic final split - first frame of final cutscene", true);
			addSetting("FIN", "FIN6", "Credits", "Split after finishing credits", false);
			
	addSetting(null, "splitOnStart", "Split on Mission Start (Experimental)", "Delay splitting until starting any next story mission", false);
	
	addSetting(null, "iPigeons", "Pigeons", "Split upon extermination of any Flying Rat", false);
	addSetting(null, "iStuntJumps", "Stunt Jumps", "Split upon completion of any Unique Stunt Jump", false);
	addSetting(null, "iMostWanted", "Most Wanted", "Split upon neutralization of any Most Wanted target", false);

	addSetting(null, "gameTime", "In-Game Time (Experimental)", "Game Timer shows IGT rather than Loadless time", false);
	
	addSetting(null, "debug", "Debug", "Print debug messages to the Windows error console", false);

}

init {
	vars.enabled = false;
	vars.doResetStart = false;
	vars.queueSplit = false;
	vars.correctEpisode = false;

	// Create new empty MemoryWatcherList
	vars.memoryWatchers = new MemoryWatcherList();

	// print() wrapper 
	Action<object> DbgInfo = (obj) => {
		if (settings["debug"]) {
			print("[LiveSplit.GTAIV.asl] " + obj.ToString());
		}
	};
	vars.debugInfo = DbgInfo;

	// Get exe version
	var fvi = modules.First().FileVersionInfo; // Don't use FileVersionInfo.FileVersion as it produces string with commas and spaces.
	version = string.Join(".", fvi.FileMajorPart, fvi.FileMinorPart, fvi.FileBuildPart, fvi.FilePrivatePart);

	vars.version = new Version(version);
	vars.debugInfo("GTAIV.exe " + version);

	vars.isCE = vars.version.Major == 1 && vars.version.Minor >= 2; // GTAIV 1.2.x.x

	int voffset = 0x0;
	bool versionCheck = vars.offsets.TryGetValue(version, out voffset); // true if version exists within version dictionary
	vars.voffset = voffset;

	bool xlivelessCheck;

	// Get xlive.dll ModuleMemorySize - not needed for CE
	if (vars.isCE) // GTAIV 1.2.x.x
	{
		if (vars.version.ToString() == "1.2.0.43" || vars.version.ToString() == "1.2.0.59") {
			vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer("GTAIV.exe", 0xDD6FD0)){ Name = "EpisodeID"});
		}		
		else if (vars.version.ToString() == "1.2.0.32") {
			vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer("GTAIV.exe", 0xDD7040)){ Name = "EpisodeID"}); // 0 for IV, 1 for TLAD, 2 for TBOGT
		}	
		xlivelessCheck = true;
	}
	else
	{
		// Get xlive.dll ModuleMemorySize
		int mms = modules.Where(m => m.ModuleName == "xlive.dll").First().ModuleMemorySize;
		vars.debugInfo("xlive.dll ModuleMemorySize: " + mms.ToString());

		// listener's xliveless should be within this range
		xlivelessCheck = mms > 50000 && mms < 200000;
	}

	if (xlivelessCheck && versionCheck) {
		vars.enabled = true;
	}

	// MemoryWatcher wrapper
	Action<string, int, int, int> mw = (name, address, aoffset, poffset) => {
		var dp = new DeepPointer(address+aoffset);

		if (poffset != 0x0) {
			dp = new DeepPointer(address+aoffset, poffset);
		}

		var type = name.Substring(0,1);
		if (type == "f") {
			vars.memoryWatchers.Add(new MemoryWatcher<float>(dp) { Name = name });
		} else if (type == "i") {
			vars.memoryWatchers.Add(new MemoryWatcher<int>(dp){ Name = name });
		}
	};

	// Add memory watcher for each address
	foreach (var a in vars.stats) {
		if (vars.isCE) {
			mw(a.Key, a.Value, vars.voffset, 0x0);
		} else {
			mw(a.Key, a.Value, vars.voffset, 0x10);
		}
	}

}

update {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return;

	if (vars.isCE)
	{		
		if (vars.memoryWatchers["EpisodeID"].Current == 0) 
		{
			vars.correctEpisode = true;
		}
		else {
			vars.correctEpisode = false;
			return;
		}	
	}
	else {
		vars.correctEpisode = true;
	}

	// Update all MemoryWatchers
	vars.memoryWatchers.UpdateAll(game);

	// if doResetStart was set to true on previous update, reset it to false
	vars.doResetStart = false;

	// Detect when the loading screen transitions from white to black.
	// Ideally this should trigger on the first frame of black, sometimes it triggers late.
	bool startCheck = current.whiteLoadingScreen == 0 && old.whiteLoadingScreen != 0 && current.isLoading == 0;

	// Check if the timer is not running or has been running for more than 1 seconds.
	double ts = timer.CurrentTime.RealTime.GetValueOrDefault().TotalSeconds;
	bool timerCheck = timer.CurrentPhase == TimerPhase.NotRunning || ts >= 1.0;

	// check if missions attempted is set to 0.
	bool missionCheck = vars.memoryWatchers["iMissionsAttempted"].Current == 0;

	if (startCheck && timerCheck && missionCheck && vars.correctEpisode) {
		vars.doResetStart = true;
		vars.splits.Clear();
	}

	// If timer state changes.
	if (timer.CurrentPhase != vars.prevPhase) {
		// Cleanup when the timer is stopped.
		if (timer.CurrentPhase == TimerPhase.NotRunning) {
			vars.splits.Clear();
		}
		// Stores the current phase the timer is in, so we can use the old one on the next frame.
		vars.prevPhase = timer.CurrentPhase;
	}


}

split {
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	if (vars.queueSplit) {
		var mw = vars.memoryWatchers["iMissionsAttempted"];
		if (mw.Current == mw.Old + 1) {
			return true;
		}
	}

	// loop through memory watchers and if it matches an enabled setting then check if it's increased
	foreach (var mw in vars.memoryWatchers) {
		var key = mw.Name;
		
		// if there's a settings enabled with the same key
		if (settings.ContainsKey(key) && settings[key]) {
			// if the value increases and it hasn't already been splitted for
			if (mw.Current == mw.Old + 1 && !vars.splits.Contains(key+mw.Current)) {
				vars.splits.Add(key+mw.Current);

				vars.debugInfo(string.Format("Split reason: {0} - current: {1} old: {2}", key, mw.Current, mw.Old));

				// delay splitting for mission passed if splitOnStart is enabled
				if (key == "iMissionsPassed" && settings["splitOnStart"]) {
					vars.queueSplit = true;
				} else if (settings["iPigeons"] || settings["iStuntJumps"] || settings["iMostWanted"]) {
					return true;
				}
			}
		}
	}

	// if setting is enabled + the mission associated with this settings is finished + game is not loading = do split
	// game loading check is here to prevent splitting after doing video editor warp or loading a savegame
	if (settings["ROM1"] && (current.LastMissionName == 3235661 && old.LastMissionName != 3235661 && current.isLoading != 0)) return true;
	if (settings["ROM2"] && (current.LastMissionName == 3301197 && old.LastMissionName != 3301197 && current.isLoading != 0)) return true;
	if (settings["ROM3"] && (current.LastMissionName == 3366733 && old.LastMissionName != 3366733) && current.isLoading != 0) return true;
	if (settings["ROM4"] && (current.LastMissionName == 3432269 && old.LastMissionName != 3432269 && current.isLoading != 0)) return true;
	if (settings["ROM5"] && (current.LastMissionName == 3497805 && old.LastMissionName != 3497805 && current.isLoading != 0)) return true;
	if (settings["ROM6"] && (current.LastMissionName == 3563341 && old.LastMissionName != 3563341 && current.isLoading != 0)) return true;
	if (settings["ROM7"] && (current.LastMissionName == 3628877 && old.LastMissionName != 3628877 && current.isLoading != 0)) return true;
	if (settings["ROM8"] && (current.LastMissionName == 842161997 && old.LastMissionName != 842161997 && current.isLoading != 0)) return true;
	if (settings["ROM9"] && (current.LastMissionName == 3759949 && old.LastMissionName != 3759949 && current.isLoading != 0)) return true;
	if (settings["ROM10"] && (current.LastMissionName == 825319245 && old.LastMissionName != 825319245 && current.isLoading != 0)) return true;
	if (settings["ROM11"] && (current.LastMissionName == 842096461 && old.LastMissionName != 842096461 && current.isLoading != 0)) return true;
	if (settings["ROM12"] && (current.LastMissionName == 858873677 && old.LastMissionName != 858873677 && current.isLoading != 0)) return true;
	if (settings["ROM13"] && (current.LastMissionName == 875650893 && old.LastMissionName != 875650893 && current.isLoading != 0)) return true;
	
	if (settings["FD"] && (current.LastMissionName == 909729613 && old.LastMissionName != 909729613 && current.isLoading != 0)) return true;
	
	if (settings["VL1"] && (current.LastMissionName == 892428109 && old.LastMissionName != 892428109 && current.isLoading != 0)) return true;
	if (settings["VL2"] && (current.LastMissionName == 909205325 && old.LastMissionName != 909205325 && current.isLoading != 0)) return true;
	if (settings["VL3"] && (current.LastMissionName == 925982541 && old.LastMissionName != 925982541 && current.isLoading != 0)) return true;
	if (settings["VL4"] && (current.LastMissionName == 942759757 && old.LastMissionName != 942759757 && current.isLoading != 0)) return true;
	
	if (settings["LJ1"] && (current.LastMissionName == 959536973 && old.LastMissionName != 959536973 && current.isLoading != 0)) return true;
	if (settings["LJ2"] && (current.LastMissionName == 808607565 && old.LastMissionName != 808607565 && current.isLoading != 0)) return true;
	
	if (settings["FA1"] && (current.LastMissionName ==  858939213 && old.LastMissionName != 858939213 && current.isLoading != 0)) return true;
	if (settings["FA2"] && (current.LastMissionName == 875716429 && old.LastMissionName != 875716429 && current.isLoading != 0)) return true;
	if (settings["FA3"] && (current.LastMissionName == 892493645 && old.LastMissionName != 892493645 && current.isLoading != 0)) return true;
	if (settings["FA4"] && (current.LastMissionName == 909270861 && old.LastMissionName != 909270861 && current.isLoading != 0)) return true;
	
	if (settings["BK1"] && (current.LastMissionName == 942890829 && old.LastMissionName != 942890829 && current.isLoading != 0)) return true;
	if (settings["BK2"] && (current.LastMissionName == 959668045 && old.LastMissionName != 959668045 && current.isLoading != 0)) return true;
	if (settings["BK3"] && (current.LastMissionName == 808738637 && old.LastMissionName != 808738637 && current.isLoading != 0)) return true;
	if (settings["BK4"] && (current.LastMissionName == 825515853 && old.LastMissionName != 825515853 && current.isLoading != 0)) return true;
	if (settings["BK5"] && (current.LastMissionName == 842293069 && old.LastMissionName != 842293069 && current.isLoading != 0)) return true;
	
	if (settings["DR1"] && (current.LastMissionName == 926048077 && old.LastMissionName != 926048077 && current.isLoading != 0)) return true;
	if (settings["DR2"] && (current.LastMissionName == 942825293 && old.LastMissionName != 942825293 && current.isLoading != 0)) return true;
	
	if (settings["FM1"] && (current.LastMissionName == 926179149 && old.LastMissionName != 926179149 && current.isLoading != 0)) return true;
	if (settings["FM2"] && (current.LastMissionName == 942956365 && old.LastMissionName != 942956365 && current.isLoading != 0)) return true;
	if (settings["FM3"] && (current.LastMissionName == 959733581 && old.LastMissionName != 959733581 && current.isLoading != 0)) return true;
	if (settings["FM4"] && (current.LastMissionName == 808804173 && old.LastMissionName != 808804173 && current.isLoading != 0)) return true;
	if (settings["FM5"] && (current.LastMissionName == 825581389 && old.LastMissionName != 825581389 && current.isLoading != 0)) return true;
	if (settings["FM6"] && (current.LastMissionName == 842358605 && old.LastMissionName != 842358605 && current.isLoading != 0)) return true;
	if (settings["FM7"] && (current.LastMissionName == 859135821 && old.LastMissionName != 859135821 && current.isLoading != 0)) return true;
	
	if (settings["PM1"] && (current.LastMissionName == 943021901 && old.LastMissionName != 943021901 && current.isLoading != 0)) return true;
	if (settings["PM2"] && (current.LastMissionName == 959799117 && old.LastMissionName != 959799117 && current.isLoading != 0)) return true;
	if (settings["PM3"] && (current.LastMissionName == 808869709 && old.LastMissionName != 808869709 && current.isLoading != 0)) return true;
	
	if (settings["MN1"] && (current.LastMissionName == 959602509 && old.LastMissionName != 959602509 && current.isLoading != 0)) return true;
	if (settings["MN2"] && (current.LastMissionName == 808673101 && old.LastMissionName != 808673101 && current.isLoading != 0)) return true;
	if (settings["MN3"] && (current.LastMissionName == 825450317 && old.LastMissionName != 825450317 && current.isLoading != 0)) return true;
	
	if (settings["EL1"] && (current.LastMissionName == 842227533 && old.LastMissionName != 842227533 && current.isLoading != 0)) return true;
	if (settings["EL2"] && (current.LastMissionName == 859004749 && old.LastMissionName != 859004749 && current.isLoading != 0)) return true;
	if (settings["EL3"] && (current.LastMissionName == 875781965 && old.LastMissionName != 875781965 && current.isLoading != 0)) return true;
	if (settings["EL4"] && (current.LastMissionName == 892559181 && old.LastMissionName != 892559181 && current.isLoading != 0)) return true;
	
	if (settings["DM1"] && (current.LastMissionName == 859266893 && old.LastMissionName != 859266893 && current.isLoading != 0)) return true;
	if (settings["DM2"] && (current.LastMissionName == 876044109 && old.LastMissionName != 876044109 && current.isLoading != 0)) return true;
	if (settings["DM3"] && (current.LastMissionName == 892821325 && old.LastMissionName != 892821325 && current.isLoading != 0)) return true;
	
	if (settings["GM1"] && (current.LastMissionName == 926310221 && old.LastMissionName != 926310221 && current.isLoading != 0)) return true;
	if (settings["GM2"] && (current.LastMissionName == 943087437 && old.LastMissionName != 943087437 && current.isLoading != 0)) return true;
	if (settings["GM3"] && (current.LastMissionName == 959864653 && old.LastMissionName != 959864653 && current.isLoading != 0)) return true;
	if (settings["GM4"] && (current.LastMissionName == 808935245 && old.LastMissionName != 808935245 && current.isLoading != 0)) return true;
	//if (settings["GM5"]  // ransom, not a mission
	if (settings["GM6"] && (current.LastMissionName == 825712461 && old.LastMissionName != 825712461 && current.isLoading != 0)) return true;
	if (settings["GM7"] && (current.LastMissionName == 842489677 && old.LastMissionName != 842489677 && current.isLoading != 0)) return true;
	
	if (settings["ULP1"] && (current.LastMissionName == 875913037 && old.LastMissionName != 875913037 && current.isLoading != 0)) return true;
	if (settings["ULP2"] && (current.LastMissionName == 892690253 && old.LastMissionName != 892690253 && current.isLoading != 0)) return true;
	if (settings["ULP3"] && (current.LastMissionName == 909467469 && old.LastMissionName != 909467469 && current.isLoading != 0)) return true;
	if (settings["ULP4"] && (current.LastMissionName == 926244685 && old.LastMissionName != 926244685 && current.isLoading != 0)) return true;
	
	if (settings["BC1"] && (current.LastMissionName == 909598541 && old.LastMissionName != 909598541 && current.isLoading != 0)) return true;
	if (settings["BC2"] && (current.LastMissionName == 926375757 && old.LastMissionName != 926375757 && current.isLoading != 0)) return true;
	if (settings["BC3"] && (current.LastMissionName == 943152973 && old.LastMissionName != 943152973 && current.isLoading != 0)) return true;
	
	if (settings["GG1"] && (current.LastMissionName == 943218509 && old.LastMissionName != 943218509 && current.isLoading != 0)) return true;
	if (settings["GG2"] && (current.LastMissionName == 959995725 && old.LastMissionName != 959995725 && current.isLoading != 0)) return true;
	if (settings["GG3"] && (current.LastMissionName == 809066317 && old.LastMissionName != 809066317 && current.isLoading != 0)) return true;

	if (settings["PX1"] && (current.LastMissionName == 892624717 && old.LastMissionName != 892624717 && current.isLoading != 0)) return true;
	if (settings["PX2"] && (current.LastMissionName == 875847501 && old.LastMissionName != 875847501 && current.isLoading != 0)) return true;
	if (settings["PX3"] && (current.LastMissionName == 1127231811 && old.LastMissionName != 1127231811 && current.isLoading != 0)) return true;
	if (settings["PX4"] && (current.LastMissionName == 909401933 && old.LastMissionName != 909401933 && current.isLoading != 0)) return true;
	
	if (settings["DW1"] && (current.LastMissionName == 909336397 && old.LastMissionName != 926113613 && current.isLoading != 0)) return true;
	if (settings["DW2"] && (current.LastMissionName == 926113613 && old.LastMissionName != 926113613 && current.isLoading != 0)) return true;
	
	if (settings["JP1"] && (current.LastMissionName == 876109645 && old.LastMissionName != 876109645 && current.isLoading != 0)) return true;
	if (settings["JP2"] && (current.LastMissionName == 892886861 && old.LastMissionName != 892886861 && current.isLoading != 0)) return true;
	if (settings["JP3"] && (current.LastMissionName == 909664077 && old.LastMissionName != 909664077 && current.isLoading != 0)) return true;
	if (settings["JP4"] && (current.LastMissionName == 1127494211 && old.LastMissionName != 1127494211 && current.isLoading != 0)) return true;
	if (settings["JP5"] && (current.LastMissionName == 926441293 && old.LastMissionName != 926441293 && current.isLoading != 0)) return true;
	
	if (settings["PB1"] && (current.LastMissionName == 842555213 && old.LastMissionName != 842555213 && current.isLoading != 0)) return true;
	if (settings["PB2"] && (current.LastMissionName == 959930189 && old.LastMissionName != 959930189 && current.isLoading != 0)) return true;
	if (settings["PB3"] && (current.LastMissionName == 825777997 && old.LastMissionName != 825777997 && current.isLoading != 0)) return true;
	if (settings["PB4"] && (current.LastMissionName == 859332429 && old.LastMissionName != 859332429 && current.isLoading != 0)) return true;
	
	if (settings["RB1"] && (current.LastMissionName == 825646925 && old.LastMissionName != 825646925 && current.isLoading != 0)) return true;
	if (settings["RB2"] && (current.LastMissionName == 842424141 && old.LastMissionName != 842424141 && current.isLoading != 0)) return true;
	if (settings["RB3"] && (current.LastMissionName == 859201357 && old.LastMissionName != 859201357 && current.isLoading != 0)) return true;
	if (settings["RB4"] && (current.LastMissionName == 875978573 && old.LastMissionName != 875978573 && current.isLoading != 0)) return true;
	if (settings["RB5"] && (current.LastMissionName == 892755789 && old.LastMissionName != 892755789 && current.isLoading != 0)) return true;
	if (settings["RB6"] && (current.LastMissionName == 909533005 && old.LastMissionName != 909533005 && current.isLoading != 0)) return true;
	
	if (settings["FIN1"] && (current.LastMissionName == 1229140294 && old.LastMissionName != 1229140294 && current.isLoading != 0)) return true; // one last thing
	if (settings["FIN2"] && (current.LastMissionName == 825843533 && old.LastMissionName != 825843533 && current.isLoading != 0) || (current.LastMissionName == 842620749 && old.LastMissionName != 842620749 && current.isLoading != 0)) return true; // deal || revenge
	//if (settings["FIN3"] // wedding, doesn't have LastMissionName value
	if (settings["FIN4"] && (current.LastMissionName == 1179464006 && old.LastMissionName != 1179464006 && current.isLoading != 0)) return true; // in mourning
	
	// Any% / Classic Final Split - first frame of final cutscene at the end of 'A Revenger's Tragedy' or 'Out of Commission'
	// if In Mourning is finished + there's a cinematic cutscene playing + game is not loading at the moment:
	// that means player completed the game, a.k.a. finished any% / classic speedrun
	// it works, because after finishing In Mourning there's no other possible cutscene to play besides the final one
	if (settings["FIN5"] && (current.LastMissionName == 1179464006 && current.isCutsceneRunning == 8 && old.isCutsceneRunning != 8 && current.isLoading != 0)) return true;
	
	if (settings["FIN6"] && (current.LastMissionName == 1128549957 && old.LastMissionName != 1128549957 && current.isLoading != 0)) return true; // split after credits

	return false;
}

reset {
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	return vars.doResetStart;
}

start {
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	return vars.doResetStart;
}

isLoading {
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	// this needs to be true to enable gameTime
	if (settings["gameTime"]) return true;

	return current.isLoading == 0;
}

gameTime {
	if (!vars.enabled) return null;

	if (!vars.correctEpisode) return null;

	if (!settings["gameTime"]) return null;

	var gt = vars.memoryWatchers["fGameTime"];
	return TimeSpan.FromMilliseconds(gt.Current);
}
