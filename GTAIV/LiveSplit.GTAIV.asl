/*
 * GTA IV LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave, updated to work with the Complete Edition by hoxi, expanded upon features by Kocurro14.
 * https://github.com/jfoster/LiveSplit.ASL/tree/stable/GTAIV
 */

// isLoading before 1.2.0.32: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// isLoading in/after 1.2.0.32: 0 if loading, random values if not loading
// whiteLoadingScreen: a number that isn't 0 while white screen is showing (65536), 0 on black screen
// LastMissionName values refer to: https://github.com/jfoster/LiveSplit.ASL/blob/stable/GTAIV/LastMissionName_details
// isCutsceneRunning: 0 if not running, 8 if running, 10 if skipped. The cinematic mo-cap cutscenes, not scripted ones with pre-made animations.
// ScreenFade: 0 if not fading, 15 if fading. Opening esc menu fade does _not_ fall under it.
// VideoEditor (CE only): 0 in gameplay, 256 in video editor.
// VideoEditor (pre-CE only): 0 in gameplay, 1 on save menu, 256 during vid warp freeze, 257 in menus and video editor.
// LastMenuFade (CE only): length in milliseconds of last menu screen fade that occured. In other words: in gameplay shows 800/1000 and in menus 0/1/5/400. Shows 0 from new game, until menu is opened for first time.
// isMenuOpen (CE only): 0 in game, 1 in menus, 1 in video editor, 1 during vid warp freeze.
// isGameplayVisible (CE only): 1 in game, 0/1 in menus, 0 in video editor, 1 during vid warp freeze.
// Character names are their respective mission progress percentage.

// current Complete Edition
state ("GTAIV", "1.2.0.59") {
	uint isLoading : 0xD747A4;
	uint whiteLoadingScreen : 0x017B37D0;
	int LastMissionName : 0xEB6FA8;
	int isCutsceneRunning : 0xE9475C;
	//int ScreenFade : 0xC39294; //unused for now
	int VideoEditor : 0xD60C3C;
	int LastMenuFade : 0xD61520;
	int isMenuOpen : 0xD73590;
	int isGameplayVisible : 0xC3E428;
	
	float Roman : 0xEB75BC;
	float Michelle : 0xEB7640;
	float Vlad : 0xEB75C0;
	float Jacob : 0xEB75CC;
	float Brucie : 0xEB75F0;
	float Faustin : 0xEB75D0;
	float Manny : 0xEB75D4;
	float Elizabeta : 0xEB75D8;
	float Playboy : 0xEB75F4;
	float Dwayne : 0xEB75E4;
	float Francis : 0xEB75F8;
	float Packie : 0xEB7608;
	float Gerry : 0xEB7610;
	float Derrick : 0xEB7614;
	float ULP : 0xEB75FC;
	float Bernie : 0xEB7618;
	float Ray : 0xEB760C;
	float Bell : 0xEB761C;
	float Pegorino : 0xEB7624;
	float Gravelli : 0xEB7620;
}

// Complete Edition until 9/02/2023
state ("GTAIV", "1.2.0.43") {
	uint isLoading : 0xD747A4;
	uint whiteLoadingScreen : 0x017B37D0;
	int LastMissionName : 0xEB6FA8;
	int isCutsceneRunning : 0xE9475C;
	//int ScreenFade : 0xC39294; //unused for now
	int VideoEditor : 0xD60C3C;
	int LastMenuFade : 0xD61520;
	int isMenuOpen : 0xD73590;
	int isGameplayVisible : 0xC3E428;
	
	float Roman : 0xEB75BC;
	float Michelle : 0xEB7640;
	float Vlad : 0xEB75C0;
	float Jacob : 0xEB75CC;
	float Brucie : 0xEB75F0;
	float Faustin : 0xEB75D0;
	float Manny : 0xEB75D4;
	float Elizabeta : 0xEB75D8;
	float Playboy : 0xEB75F4;
	float Dwayne : 0xEB75E4;
	float Francis : 0xEB75F8;
	float Packie : 0xEB7608;
	float Gerry : 0xEB7610;
	float Derrick : 0xEB7614;
	float ULP : 0xEB75FC;
	float Bernie : 0xEB7618;
	float Ray : 0xEB760C;
	float Bell : 0xEB761C;
	float Pegorino : 0xEB7624;
	float Gravelli : 0xEB7620;
}

// Patch 4
state ("GTAIV", "1.0.4.0") {
	uint isLoading : 0xC07A0C;
	uint whiteLoadingScreen : 0x01223EA8;
	int LastMissionName : 0xC60A88;
	int isCutsceneRunning : 0xC80EBC;
	//int ScreenFade : 0xAA9E10; //unused for now
	int VideoEditor : 0xBCCDE0;
	
	float Roman : 0x00C60E7C, 0x10;
	float Vlad : 0x00C60E80, 0x10;
	float Jacob : 0x00C60E8C, 0x10;
	float Faustin : 0x00C60E90, 0x10;
	float Manny : 0x00C60E94, 0x10;
	float Elizabeta : 0x00C60E98, 0x10;
	float Dwayne : 0x00C60EA4, 0x10;
	float Brucie : 0x00C60EB0, 0x10;
	float Playboy : 0x00C60EB4, 0x10;
	float Francis :0x00C60EB8, 0x10;
	float ULP : 0x00C60EBC, 0x10;
	float Packie : 0x00C60EC8, 0x10;
	float Ray : 0x00C60ECC, 0x10;
	float Gerry : 0x00C60ED0, 0x10;
	float Derrick : 0x00C60ED4, 0x10;
	float Bernie : 0x00C60ED8, 0x10;
	float Bell : 0x00C60EDC, 0x10;
	float Gravelli : 0x00C60EE0, 0x10;
	float Pegorino : 0x00C60EE4, 0x10;
	float Michelle : 0x00C60F00, 0x10;
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

	addSetting(null, "splitOnEnd", "Split on Mission End", "Split upon completion of selected main story mission(s)", true);	
		addSetting("splitOnEnd", "ROM0", "Roman Bellic", null, true);
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
			
		addSetting("splitOnEnd", "KD", "Michelle", null, true);
			addSetting("KD", "FD", "First Date", null, true);
			
		addSetting("splitOnEnd", "VL0", "Vlad Glebov", null, true);
			addSetting("VL0", "VL1", "Bull in a China Shop", null, true);
			addSetting("VL0", "VL2", "Hung Out to Dry", null, true);
			addSetting("VL0", "VL3", "Clean Getaway", null, true);
			addSetting("VL0", "VL4", "Ivan the Not So Terrible", null, true);
			
		addSetting("splitOnEnd", "LJ0", "Little Jacob", null, true);
			addSetting("LJ0", "LJ1", "Concrete Jungle", null, true);
			addSetting("LJ0", "LJ2", "Shadow", null, true);
			
		addSetting("splitOnEnd", "BK0", "Brucie Kibbutz", null, true);
			addSetting("BK0", "BK1", "Search and Delete", null, true);
			addSetting("BK0", "BK2", "Easy as Can Be", null, true);
			addSetting("BK0", "BK3", "Out of the Closet...", null, true);
			addSetting("BK0", "BK4", "...Out of the Closet", "Not required to beat the game, but completing it gets rid of constant date reminders", true);
			addSetting("BK0", "BK5", "No. 1", "Not required to beat the game", false);
			
		addSetting("splitOnEnd", "FA0", "Mikhail Faustin", null, true);
			addSetting("FA0", "FA1", "Do You Have Protection?", null, true);
			addSetting("FA0", "FA2", "Final Destination", null, true);
			addSetting("FA0", "FA3", "No Love Lost", null, true);
			addSetting("FA0", "FA4", "Rigged to Blow", null, true);
			
		addSetting("splitOnEnd", "DR0", "Dimitri Rascalov", null, true);
			addSetting("DR0", "DR1", "The Master and the Molotov", null, true);
			addSetting("DR0", "DR2", "Russian Revolution", null, true);
			
		addSetting("splitOnEnd", "MN0", "Manny Escuela", null, true);
			addSetting("MN0", "MN1", "Escuela of the Streets", null, true);
			addSetting("MN0", "MN2", "Street Sweeper", null, true);
			addSetting("MN0", "MN3", "The Puerto Rican Connection", null, true);
			
		addSetting("splitOnEnd", "EL0", "Elizabeta Torres", null, true);
			addSetting("EL0", "EL1", "Luck of the Irish", null, true);
			addSetting("EL0", "EL2", "Blow Your Cover", null, true);
			addSetting("EL0", "EL3", "The Snow Storm", null, true);
			addSetting("EL0", "EL4", "Have a Heart", null, true);
			
		addSetting("splitOnEnd", "PX0", "Playboy X", null, true);
			addSetting("PX0", "PX1", "Deconstruction for Beginners", null, true);
			addSetting("PX0", "PX2", "Photo Shoot", null, true);
			addSetting("PX0", "PX3", "The Holland Play...", "Not required to beat the game", false);
			addSetting("PX0", "PX4", "...The Holland Play", "Not required to beat the game", false);
			
		addSetting("splitOnEnd", "DW0", "Dwayne Forge", null, false);
			addSetting("DW0", "DW1", "Ruff Rider", "Not required to beat the game", false);
			addSetting("DW0", "DW2", "Undress to Kill", "Not required to beat the game", false);
			
		addSetting("splitOnEnd", "FM0", "Francis McReary", null, true);
			addSetting("FM0", "FM1", "Call and Collect", null, true);
			addSetting("FM0", "FM2", "Final Interview...", null, true);
			addSetting("FM0", "FM3", "...Final Interview", null, true);
			addSetting("FM0", "FM4", "Holland Nights", null, true);
			addSetting("FM0", "FM5", "Lure", null, true);
			addSetting("FM0", "FM6", "Blood Brothers", null, true);
			addSetting("FM0", "FM7", "Undertaker", null, true);
			
		addSetting("splitOnEnd", "PM0", "Packie McReary", null, true);
			addSetting("PM0", "PM1", "Harboring a Grudge", null, true);
			addSetting("PM0", "PM2", "Waste Not Want Knots", null, true);
			addSetting("PM0", "PM3", "Three Leaf Clover", null, true);
			
		addSetting("splitOnEnd", "GM0", "Gerry McReary", null, true);
			addSetting("GM0", "GM1", "Actions Speak Louder than Words", null, true);
			addSetting("GM0", "GM2", "I Need Your Clothes, Your Boots, and Your Motorcycle", null, true);
			addSetting("GM0", "GM3", "I'll Take Her...", null, true);
			addSetting("GM0", "GM4", "...I'll Take Her", null, true);
			//addSetting("GM0", "GM5", "Ransom (Experimental)", null, false); //is here to keep mission tree structure
			addSetting("GM0", "GM6", "She's A Keeper", null, true);
			addSetting("GM0", "GM7", "Diamonds are a Girl's Best Friend", null, true);
			
		addSetting("splitOnEnd", "DM0", "Derrick McReary", null, true);
			addSetting("DM0", "DM1", "Smackdown", null, true);
			addSetting("DM0", "DM2", "Babysitting", null, true);
			addSetting("DM0", "DM3", "Tunnel of Death", null, true);
			
		addSetting("splitOnEnd", "ULP0", "United Liberty Paper", null, true);
			addSetting("ULP0", "ULP1", "Wrong is Right", null, true);
			addSetting("ULP0", "ULP2", "Portrait of a Killer", null, true);
			addSetting("ULP0", "ULP3", "Dust Off", null, true);
			addSetting("ULP0", "ULP4", "Paper Trail", null, true);
			
		addSetting("splitOnEnd", "BC0", "Bernie Crane", null, true);
			addSetting("BC0", "BC1", "Hating the Haters", null, true);
			addSetting("BC0", "BC2", "Union Drive", null, true);
			addSetting("BC0", "BC3", "Buoys Ahoy", null, true);
			
		addSetting("splitOnEnd", "RB0", "Ray Boccino", null, true);
			addSetting("RB0", "RB1", "A Long Way to Fall", null, true);
			addSetting("RB0", "RB2", "Taking in the Trash", null, true);
			addSetting("RB0", "RB3", "Meltdown", null, true);
			addSetting("RB0", "RB4", "Museum Piece", null, true);
			addSetting("RB0", "RB5", "No Way on the Subway", null, true);
			addSetting("RB0", "RB6", "Late Checkout", null, true);
			
		addSetting("splitOnEnd", "PB0", "Phil Bell", null, true);
			addSetting("PB0", "PB1", "Truck Hustle", null, true);
			addSetting("PB0", "PB2", "Catch The Wave", null, true);
			addSetting("PB0", "PB3", "Trespass", null, true);
			addSetting("PB0", "PB4", "To Live and Die in Alderney", null, true);
			
		addSetting("splitOnEnd", "JP0", "Jimmy Pegorino", null, true);
			addSetting("JP0", "JP1", "Pegorino's Pride", null, true);
			addSetting("JP0", "JP2", "Payback", null, true);
			addSetting("JP0", "JP3", "Flatline", null, true);
			addSetting("JP0", "JP4", "Pest Control...", null, true);
			addSetting("JP0", "JP5", "...Pest Control", null, true);
			
		addSetting("splitOnEnd", "GG0", "Jon Gravelli", null, true);
			addSetting("GG0", "GG1", "Entourage", null, true);
			addSetting("GG0", "GG2", "Dining Out", null, true);
			addSetting("GG0", "GG3", "Liquidize the Assets", null, true);
			
		addSetting("splitOnEnd", "FIN", "Finale", null, true);
			addSetting("FIN", "FIN1", "One Last Thing...", null, true);
			addSetting("FIN", "FIN2", "If the Price is Right | A Dish Served Cold", null, true);
			addSetting("FIN", "FIN3", "Mr. & Mrs. Bellic", "Split after second church cutscene ends", false);
			addSetting("FIN", "FIN4", "In Mourning", "Split after standing up from bed", true);
			addSetting("FIN", "FIN5", "A Revenger's Tragedy | Out of Commission (Any% / Classic End)", "Any% / Classic final split - first frame of last cutscene", true);
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

	// =====================================================================
	// Split on Mission End
	// =====================================================================
	// If setting is enabled AND specified character mission progress raises to a certain threshold AND mission passed amount raises by 1 THEN do split.
	
	var mp = vars.memoryWatchers["iMissionsPassed"];
	
	if (settings["ROM2"] && (current.Roman == 13.33333397f && old.Roman == 6.666666985f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM3"] && (current.Roman == 20f && old.Roman == 13.33333397f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM4"] && (current.Roman == 26.66666794f && old.Roman == 20f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM5"] && (current.Roman == 33.33333588f && old.Roman == 26.66666794f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM6"] && (current.Roman == 40f && old.Roman == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM7"] && (current.Roman == 46.66666794f && old.Roman == 40f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM8"] && (current.Faustin == 14.2857151f && old.Faustin == 0f && mp.Current == mp.Old + 1)) return true; // Crime and Punishment
	if (settings["ROM9"] && (current.Roman == 53.33333588f && old.Roman == 46.66666794f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM10"] && (current.Roman == 60.00000381f && old.Roman == 53.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM11"] && (current.Roman == 66.66667175f && old.Roman == 60.00000381f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM12"] && (current.Roman == 73.33333588f && old.Roman == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	if (settings["ROM13"] && (current.Roman == 80f && old.Roman == 73.33333588f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["FD"] && (current.Michelle >= 4f && old.Michelle == 0f && mp.Current == mp.Old + 1)) return true; // 60% after First Date

	if (settings["VL1"] && (current.Vlad == 25f && old.Vlad == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["VL2"] && (current.Vlad == 50f && old.Vlad == 25f && mp.Current == mp.Old + 1)) return true;
	if (settings["VL3"] && (current.Vlad == 75f && old.Vlad == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["VL4"] && (current.Vlad == 100f && old.Vlad == 75f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["LJ1"] && (current.Jacob == 50f && old.Jacob == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["LJ2"] && (current.Jacob == 100f && old.Jacob == 50f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["FA1"] && (current.Faustin == 28.57143021f && old.Faustin == 14.2857151f && mp.Current == mp.Old + 1)) return true;
	if (settings["FA2"] && (current.Faustin == 42.8571434f && old.Faustin == 28.57143021f && mp.Current == mp.Old + 1)) return true;
	if (settings["FA3"] && (current.Faustin == 57.14286041f && old.Faustin == 42.8571434f && mp.Current == mp.Old + 1)) return true;
	if (settings["FA4"] && (current.Faustin == 71.42857361f && old.Faustin == 57.14286041f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["DR1"] && (current.Faustin == 85.7142868f && old.Faustin == 71.42857361f && mp.Current == mp.Old + 1)) return true;
	if (settings["DR2"] && (current.Faustin == 100f && old.Faustin == 85.7142868f && mp.Current == mp.Old + 1)) return true;
		
	if (settings["BK1"] && (current.Brucie == 25f && old.Brucie == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["BK2"] && (current.Brucie == 50f && old.Brucie == 25f && mp.Current == mp.Old + 1)) return true;
	//if (settings["BK3"] //out of the closet 1
	if (settings["BK4"] && (current.Brucie == 75f && old.Brucie == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["BK5"] && (current.Brucie == 100f && old.Brucie == 75f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["FM1"] && (current.Francis == 16.66666794f && old.Francis == 0f && mp.Current == mp.Old + 1)) return true;
	//if (settings["FM2"] //final interview 1
	if (settings["FM3"] && (current.Francis == 33.33333588f && old.Francis == 16.66666794f && mp.Current == mp.Old + 1)) return true;
	if (settings["FM4"] && (current.Francis == 50f && old.Francis == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["FM5"] && (current.Francis == 66.66667175f  && old.Francis == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["FM6"] && (current.Francis == 83.33332825f && old.Francis == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	if (settings["FM7"] && (current.Francis == 100f && old.Francis == 83.33332825f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["PM1"] && (current.Packie == 33.33333588f && old.Packie == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["PM2"] && (current.Packie == 66.66667175f && old.Packie == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["PM3"] && (current.Packie == 100f && old.Packie == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["MN1"] && (current.Manny == 33.33333588f && old.Manny == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["MN2"] && (current.Manny == 66.66667175f && old.Manny == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["MN3"] && (current.Manny == 100f && old.Manny == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["EL1"] && (current.Elizabeta == 25f && old.Elizabeta == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["EL2"] && (current.Elizabeta == 50f && old.Elizabeta == 25f && mp.Current == mp.Old + 1)) return true;
	if (settings["EL3"] && (current.Elizabeta == 75f && old.Elizabeta == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["EL4"] && (current.Elizabeta == 100f && old.Elizabeta == 75f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["DM1"] && (current.Derrick == 33.33333588f && old.Derrick == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["DM2"] && (current.Derrick == 66.66667175f && old.Derrick == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["DM3"] && (current.Derrick == 100f && old.Derrick == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["GM1"] && (current.Gerry == 20f && old.Gerry == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["GM2"] && (current.Gerry == 40f && old.Gerry == 20f && mp.Current == mp.Old + 1)) return true;
	//if (settings["GM3"] // ill take her 1
	if (settings["GM4"] && (current.Gerry == 60.00000381f && old.Gerry == 40f && mp.Current == mp.Old + 1)) return true;
	//if (settings["GM5"] // ransom, not a mission
	if (settings["GM6"] && (current.Gerry == 80f && old.Gerry == 60.00000381f && mp.Current == mp.Old + 1)) return true;
	if (settings["GM7"] && (current.Gerry == 100f && old.Gerry == 80f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["ULP1"] && (current.ULP == 25f && old.ULP == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["ULP2"] && (current.ULP == 50f && old.ULP == 25f && mp.Current == mp.Old + 1)) return true;
	if (settings["ULP3"] && (current.ULP == 75f && old.ULP == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["ULP4"] && (current.ULP == 100f && old.ULP == 75f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["BC1"] && (current.Bernie == 33.33333588f && old.Bernie == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["BC2"] && (current.Bernie == 66.66667175f && old.Bernie == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["BC3"] && (current.Bernie == 100f && old.Bernie == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["GG1"] && (current.Gravelli == 33.33333588f && old.Gravelli == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["GG2"] && (current.Gravelli == 66.66667175f && old.Gravelli == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["GG3"] && (current.Gravelli == 100f && old.Gravelli == 66.66667175f && mp.Current == mp.Old + 1)) return true;

	if (settings["PX1"] && (current.Playboy == 33.33333588f && old.Playboy == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["PX2"] && (current.Playboy == 66.66667175f && old.Playboy == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	//if (settings["PX3"] //holland play 1
	if (settings["PX4"] && (current.Playboy == 100f && old.Playboy == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["DW1"] && (current.Dwayne == 50f && old.Dwayne == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["DW2"] && (current.Dwayne == 100f && old.Dwayne == 50f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["JP1"] && (current.Pegorino == 25f && old.Pegorino == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["JP2"] && (current.Pegorino == 50f && old.Pegorino == 25f && mp.Current == mp.Old + 1)) return true;
	if (settings["JP3"] && (current.Pegorino == 75f && old.Pegorino == 50f && mp.Current == mp.Old + 1)) return true;
	//if (settings["JP4"] //pest control 1
	if (settings["JP5"] && (current.Pegorino == 100f && old.Pegorino == 75f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["PB1"] && (current.Bell == 25f && old.Bell == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["PB2"] && (current.Bell == 50f && old.Bell == 25f && mp.Current == mp.Old + 1)) return true;
	if (settings["PB3"] && (current.Bell == 75f && old.Bell == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["PB4"] && (current.Bell == 100f && old.Bell == 75f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["RB1"] && (current.Ray == 16.66666794f && old.Ray == 0f && mp.Current == mp.Old + 1)) return true;
	if (settings["RB2"] && (current.Ray == 33.33333588f && old.Ray == 16.66666794f && mp.Current == mp.Old + 1)) return true;
	if (settings["RB3"] && (current.Ray == 50f && old.Ray == 33.33333588f && mp.Current == mp.Old + 1)) return true;
	if (settings["RB4"] && (current.Ray == 66.66667175f && old.Ray == 50f && mp.Current == mp.Old + 1)) return true;
	if (settings["RB5"] && (current.Ray == 83.33332825f && old.Ray == 66.66667175f && mp.Current == mp.Old + 1)) return true;
	if (settings["RB6"] && (current.Ray == 100f && old.Ray == 83.33332825f && mp.Current == mp.Old + 1)) return true;
	
	if (settings["FIN2"] && (current.Roman == 86.66666412f && old.Roman == 80f && mp.Current == mp.Old + 1)) return true; // deal || revenge
	if (settings["FIN6"] && (current.Roman == 100f && old.Roman == 93.33333588f && mp.Current == mp.Old + 1)) return true; // split after credits
	
	
	// Exceptions
	// =====================================
	
	// unused
	// Loading check instead of mission passed check, because it's first mission
	//if (settings["ROM1"] && (current.Roman == 6.666666985f && old.Roman == 0f && current.isLoading != 0)) return true;

	// Percentage and mission passed value are changing earlier than LastMissionName value
	if (settings["ROM1"] && (current.LastMissionName == 3235661 && old.LastMissionName != 3235661 && current.isLoading != 0)) return true;

	// Character mission progress percentage for these missions do not increase, so LastMissionName values are used
	if (settings["BK3"] && (current.LastMissionName == 808738637 && old.LastMissionName != 808738637 && mp.Current == mp.Old + 1)) return true;
	if (settings["FM2"] && (current.LastMissionName == 942956365 && old.LastMissionName != 942956365 && mp.Current == mp.Old + 1)) return true;
	if (settings["GM3"] && (current.LastMissionName == 959864653 && old.LastMissionName != 959864653 && mp.Current == mp.Old + 1)) return true;
	if (settings["PX3"] && (current.LastMissionName == 1127231811 && old.LastMissionName != 1127231811 && mp.Current == mp.Old + 1)) return true;
	if (settings["JP4"] && (current.LastMissionName == 1127494211 && old.LastMissionName != 1127494211 && mp.Current == mp.Old + 1)) return true;
	if (settings["FIN1"] && (current.LastMissionName == 1229140294 && old.LastMissionName != 1229140294 && mp.Current == mp.Old + 1)) return true; // one last thing
	
	//  Mr. & Mrs. Bellic - this mission doesn't have LastMissionName value and percentage doesn't increase
	// so check if either of FIN2 values are unchanged, but mission passed value increases
	if (settings["FIN3"] 
		&& (((current.LastMissionName == 825843533 && old.LastMissionName == 825843533) && (mp.Current == mp.Old + 1)) 
		|| ((current.LastMissionName == 842620749 && old.LastMissionName == 842620749) && (mp.Current == mp.Old + 1))))
		return true;
		
	// In Mourning - character percentage doesn't work, for some reason
	if (settings["FIN4"] && (current.LastMissionName == 1179464006 && old.LastMissionName != 1179464006 && mp.Current == mp.Old + 1)) return true;
	
	// Any% / Classic Final Split - first frame of last cutscene at the end of 'A Revenger's Tragedy' or 'Out of Commission'
	// If setting is enabled
	//		AND In Mourning is finished 
	//		AND cinematic cutscene starts playing
	//		AND game is not loading:
	// That means player completed the game a.k.a. finished any% / classic speedrun
	// It works, because after finishing In Mourning there's no other possible cutscene to play besides the final one
	if (settings["FIN5"] && (current.LastMissionName == 1179464006 && current.isCutsceneRunning == 8 && old.isCutsceneRunning != 8 && current.isLoading != 0)) return true;
	

	
	// =======================================================================
	// Miscellaneous stuff to split on
	// =======================================================================

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

	// stop the loadless timer when the game freezes while doing video editor warp
	if (current.VideoEditor == 256) {
		if (vars.enabled && vars.correctEpisode) {
			if (vars.isCE) {
				if ((current.LastMenuFade >= 800 || current.LastMenuFade == 0) && current.isGameplayVisible == 1 && current.isMenuOpen == 1) {
					return true;
				}
			} else {
				return true;
			}
		}
	}

	return current.isLoading == 0;
}

gameTime {
	if (!vars.enabled) return null;

	if (!vars.correctEpisode) return null;

	if (!settings["gameTime"]) return null;

	var gt = vars.memoryWatchers["fGameTime"];
	return TimeSpan.FromMilliseconds(gt.Current);
}
