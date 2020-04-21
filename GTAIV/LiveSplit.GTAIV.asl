/*
 * GTA IV LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave, updated to work with the Complete Edition by hoxi.
 * https://github.com/jfoster/LiveSplit.ASL/tree/dev/GTAIV
 */

// isLoading before 1.2.0.32: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// isLoading in 1.2.0.32: 0 if loading, random values if not loading
// whiteLoadingScreen: a number that isn't 0 while white screen is showing (65536), 0 on black screen

// Complete Editon
state ("GTAIV", "1.2.0.32") {
	uint isLoading : 0xD74824;
	uint whiteLoadingScreen : 0x017B3840;
	string10 scriptName : 0x0174AF74, 0x58, 0x70; // used for Ransom splitting
}

// Patch 8
state ("GTAIV", "1.0.8.0") {
	uint isLoading : 0xDF800C;
	uint whiteLoadingScreen : 0x014CB06C;
	string10 scriptName : 0x0150FDB8, 0x58, 0x70;
}

// Patch 7
state ("GTAIV", "1.0.7.0") {
	uint isLoading : 0xCF9AD4;
	uint whiteLoadingScreen : 0x014A8238;
	string10 scriptName : 0x1583310, 0x58, 0x70;
}

// Patch 6
state ("GTAIV", "1.0.6.0") {
	uint isLoading : 0xCF8AC4;
	uint whiteLoadingScreen : 0x014A7248;
	string10 scriptName : 0x01582320, 0x58, 0x70;
}

// Patch 5
state ("GTAIV", "1.0.0.4") {
	uint isLoading : 0xC7D18C;
	uint whiteLoadingScreen : 0x13DFCF0;
	string10 scriptName : 0x014DF6C8, 0x58, 0x70;
}

// Patch 4
state ("GTAIV", "1.0.4.0") {
	uint isLoading : 0xC07A0C;
	uint whiteLoadingScreen : 0x01223EA8;
	string10 scriptName : 0x013A02B8, 0x58, 0x70; 
}

startup {
	vars.offsets = new Dictionary<string, int> {
		// newest first
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
	};

	refreshRate = 60;

	vars.prevPhase = null; // keeps track of previous timer phase
	vars.splits = new HashSet<string>(); // keeps track of splitted splits

	Action<string, string, string, string, bool> addSetting = (parent, id, label, tooltip, defaultVal) => {
		settings.Add(id, defaultVal, label, parent);
		settings.SetToolTip(id, tooltip);
	};

	addSetting(null, "iMissionsPassed", "Story Missions (Any%)", "Split upon completion of a main story mission", true);
	addSetting("iMissionsPassed", "ransomSplit", "Split on Ransom Completion (Experimental)", "Splits on Ransom completion.", false);
	addSetting("iMissionsPassed", "splitOnStart", "Split on Mission Start (Experimental)", "Delay splitting until next mission start", false);

	addSetting(null, "iStuntJumps", "Stunt Jumps", "Split upon completion of any unique stunt jump", false);
	addSetting(null, "iMostWanted", "Most Wanted", "Split upon killing a most wanted person(s)", false);
	addSetting(null, "iPigeons", "Pigeons", "Split upon extermination of a flying rat", false);

	addSetting(null, "gameTime", "In-Game Time (Experimental)", "Game Timer shows IGT rather than loadless time", false);
	
	addSetting(null, "debug", "Debug", "Print debug messages to the windows error console", false);
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
		vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer("GTAIV.exe", 0xDD7040)){ Name = "EpisodeID"}); // 0 for IV, 1 for TLAD, 2 for TBOGT
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

	if (current.scriptName != old.scriptName) {
		vars.debugInfo(string.Format("scriptName old: {0} new: {1}", old.scriptName, current.scriptName));
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
				} else {
					return true;
				}
			}
		}
	}

	if (settings["ransomSplit"])
	{		
		if (current.scriptName != "gerry3c" && old.scriptName == "gerry3c") {
			return true;
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

	return current.isLoading == 0;
}

gameTime {
	if (!vars.enabled) return null;

	if (!vars.correctEpisode) return null;

	if (!settings["gameTime"]) return null;

	var gt = vars.memoryWatchers["fGameTime"];
	return TimeSpan.FromMilliseconds(gt.Current);
}
