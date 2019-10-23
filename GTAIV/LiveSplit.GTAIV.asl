/*
 * GTA IV LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave.
 * https://gist.github.com/jfoster/37f266491e3caacc807d8be9d144e38b
 */

// GTAIV.exe

// isLoading: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// whiteLoadingScreen: a number that isn't 0 while white screen is showing (65536), 0 on black screen

// Patch 8
state ("GTAIV", "1.0.8.0") {
	uint isLoading : 0xDF800C;
	uint whiteLoadingScreen : 0x014CB06C;
}

// Patch 7
state ("GTAIV", "1.0.7.0") {
	uint isLoading : 0xCF9AD4;
	uint whiteLoadingScreen : 0x014A8238;
}

// Patch 6
state ("GTAIV", "1.0.6.0") {
	uint isLoading : 0xCF8AC4;
	uint whiteLoadingScreen : 0x014A7248;
}

// Patch 4
state ("GTAIV", "1.0.4.0") {
	uint isLoading : 0xC07A0C;
	uint whiteLoadingScreen : 0x01223EA8;
}

startup {
	refreshRate = 60;

	vars.prevPhase = null; // keeps track of previous timer phase
	vars.splits = new List<string>(); // keeps track of splitted splits
	vars.tick = 0; // keeps track of ticks since script init

	vars.offsets = new Dictionary<string, int> {
		// newest first
		{"1.0.8.0", -0x398940},
		{"1.0.7.0", 0x0},
		{"1.0.6.1", 0x0},
		{"1.0.5.2", -0x1020},
		{"1.0.6.0", -0xFE0},
		{"1.0.4.0", -0x563040},
	};

	vars.addresses = new Dictionary<string, int> {
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

	Action<string, bool, string, string, string> addSetting = (id, defaultVal, label, parent, tooltip) => {
		settings.Add(id, defaultVal, label, parent);
		settings.SetToolTip(id, tooltip);
	};

	addSetting("iMissionsPassed", true, "Story Missions (Any%)", null, "Split upon completion of a main story mission");
	addSetting("iStuntJumps", false, "Stunt Jumps", null, "Split upon completion of any unique stunt jump");
	addSetting("iMostWanted", false, "Most Wanted", null, "Split upon killing a most wanted person(s)");
	addSetting("iPigeons", false, "Pigeons", null, "Split upon extermination of a flying rat");
	addSetting("debug", false, "Debug", null, "Print debug messages to the windows error console");
}

init {
	vars.enabled = false;
	vars.check1 = false;
	vars.check2 = false;
	vars.doResetAndStart = false;

	// print() wrapper
	Action<object> DbgInfo = (obj) => {
		if (settings["debug"]) {
			print("[LiveSplit.GTATLAD.asl] " + obj.ToString());
		}
	};
	vars.print = DbgInfo;

	// Return true if secs is less than timer has been running [currently unused]
	Func<double, bool> timerSecs = (secs) => {
		double ts = timer.CurrentTime.RealTime.GetValueOrDefault().TotalSeconds;
		return ts == 0 || ts > secs;
	};
	vars.timerSecs = timerSecs;

	// Get GTAIV.exe version
	var fvi = modules.First().FileVersionInfo;
	version = string.Join(".", fvi.FileMajorPart, fvi.FileMinorPart, fvi.FileBuildPart, fvi.FilePrivatePart);
	vars.print("GTAIV.exe " + version);

	// Get xlive.dll ModuleMemorySize
	int mms = modules.Where(m => m.ModuleName == "xlive.dll").First().ModuleMemorySize;
	vars.print("xlive.dll ModuleMemorySize: " + mms.ToString());
	bool listenerxliveless = mms > 50000 && mms < 200000;

	if (!String.IsNullOrEmpty(version) && listenerxliveless) {
		vars.enabled = true;
	}

	// Set offset for specific game version
	vars.voffset = 0x0;
	bool first = true;
	foreach (var v in vars.offsets) {
		if (first || v.Key == version) {
			first = false;
			vars.voffset = v.Value;
		}
	}

	// Create new empty MemoryWatcherList
	vars.memoryWatchers = new MemoryWatcherList();

	// MemoryWatcher wrapper
	Action<string, int, int, int> mw = (name, address, aoffset, poffset) => {
		var dp = new DeepPointer(address+aoffset, poffset);
		var type = name.Substring(0,1);
		if (type == "f") {
			vars.memoryWatchers.Add(new MemoryWatcher<float>(dp) { Name = name });
		} else if (type == "i") {
			vars.memoryWatchers.Add(new MemoryWatcher<int>(dp){ Name = name });
		}
	};

	// Add memory watcher for each address
	foreach (var a in vars.addresses) {
		mw(a.Key, a.Value, vars.voffset, 0x10);
	}
}

update {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return;

	// Prevent actions happening until atleast 2 ticks have occured since script init
	if (vars.tick < 2) {
		vars.tick++;
		return;
	}

	// Update all MemoryWatchers
	vars.memoryWatchers.UpdateAll(game);

	// if doResetAndStart was set to true on previous update, reset it to false
	if (vars.doResetAndStart) vars.doResetAndStart = false;

	// Detect when the loading screen transitions from white to black.
	// Ideally this should trigger on the first frame of black, sometimes it triggers late.
	bool check1 = current.whiteLoadingScreen == 0 && old.whiteLoadingScreen != 0;
	bool check2 = current.isLoading == 0 && (old.isLoading == 0xFFFFFF01 || old.isLoading == 1);

	vars.check1 = check1;
	if (check2) vars.check2 = true;

	if (vars.check1 || vars.check2) {
		vars.print(string.Format("check1: {0} - check2: {1}", vars.check1, vars.check2));
	}

	// If both whiteLoadingScreen and isLoading have evaluated to true
	if (vars.check1 && vars.check2) {
		// reset/start if missionsAttempted is 0
		if (vars.memoryWatchers["iMissionsAttempted"].Current == 0) {
			vars.doResetAndStart = true;
			vars.splits.Clear();
		}
		// reset checks
		vars.check1 = false;
		vars.check2 = false;
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

	// increment ticks on every update
	// vars.tick++;
}

split {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	// do not split unless 2 ticks have passed since script init
	if (vars.tick < 2) return false;

	foreach (var a in vars.addresses) {
		if (settings.ContainsKey(a.Key) && settings[a.Key]) {
			var val = vars.memoryWatchers[a.Key];
			if (val.Current == val.Old + 1 && !vars.splits.Contains(a.Key+val.Current)) {
				vars.splits.Add(a.Key+val.Current);
				vars.print(string.Format("Split reason: {0} - ({1} > {2})", a.Key, val.Current, val.Old));
				return true;
			}
		}
	}
	return false;
}

reset {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	// do not reset unless 2 ticks have passed since script init
	if (vars.tick < 2) return false;

	return vars.doResetAndStart;
}

start {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	// do not start unless 2 ticks have passed since script init
	if (vars.tick < 2) return false;

	return vars.doResetAndStart;
}

isLoading {
	return current.isLoading == 0;
}