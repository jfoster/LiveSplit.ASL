/*
 * GTA TBOGT LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave, updated to work with the Complete Edition by hoxi.
 * https://github.com/jfoster/LiveSplit.ASL/tree/dev/GTAIV
 */

// isLoading before 1.2.0.32: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// isLoading in 1.2.0.32: 0 if loading, random values if not loading
// isFirstMission: 30000 when I Luv LC... appears on screen

// current Complete Edition
state("GTAIV", "1.2.0.43") {
	uint isLoading : 0xD747A4;
	uint isFirstMission : 0xD8DFD0;
	uint episodeID : 0xD73240;
}

// old Complete Edition
state("GTAIV", "1.2.0.32") {
	uint isLoading : 0xDD5F60;
	uint isFirstMission : 0xD8E050;
	uint episodeID : 0xDD7040;
}
 
// Patch 3
state("EFLC", "1.1.3.0") {
	uint isLoading : 0x16EB80, 0x10;
	uint isFirstMission : 0xD6A7E0;
	uint episodeID : 0xD43DB4;
}

// Patch 2
state("EFLC", "1.1.2.0") {
	uint isLoading : 0x99F90, 0x10;
	uint isFirstMission : 0xD0D8B8;
	uint episodeID : 0xC4D7C4; // could also use 0xC619D8
}

startup {
	refreshRate = 60;

	vars.prevPhase = null; // keeps track of previous timer phase
	vars.splits = new HashSet<string>(); // keeps track of splitted splits

	vars.offsets = new Dictionary<string, int> {
		// newest first
		{"1.2.0.43", 0x112118},
		{"1.2.0.32", 0x112188},
		{"1.1.3.0", -0xC020},
		{"1.1.2.0", 0x0},
	};

	vars.stats = new Dictionary<string, int> {
		{"fBasejumps", 0xDA563C},
		{"fSeagulls", 0xDA564C},
		{"fSeagullsCE", 0xDA57E4},
		{"fDrugWars", 0xDA56CC},
		{"iMissionsPassed", 0xDA58B0},
		{"iMissionsFailed", 0xDA58B4},
		{"iMissionsAttempted", 0xDA58B8},
		{"iRandomEncounters", 0xDA5934},
	};

	Action<string, string, string, string, bool> addSetting = (parent, id, label, tooltip, defaultVal) => {
		settings.Add(id, defaultVal, label, parent);
		settings.SetToolTip(id, tooltip);
	};

	addSetting(null, "iMissionsPassed", "Story Missions (Any%)", "Split upon completion of a main story mission", true);
	addSetting("iMissionsPassed", "splitOnStart", "Split on Mission Start (Experimental)", "Delay splitting until next mission start", false);

	addSetting(null, "fSeagulls", "Seagulls", "Split upon seagull being exterminated", false);

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
			print("[LiveSplit.GTATLAD.asl] " + obj.ToString());
		}
	};
	vars.debugInfo = DbgInfo;

	// Get exe version
	var fvi = modules.First().FileVersionInfo; // Don't use FileVersionInfo.FileVersion as it produces string with commas and spaces.
	version = string.Join(".", fvi.FileMajorPart, fvi.FileMinorPart, fvi.FileBuildPart, fvi.FilePrivatePart);

	vars.version = new Version(version);
	vars.debugInfo("EFLC.exe " + version);

	vars.isCE = vars.version.Major == 1 && vars.version.Minor >= 2; // GTAIV 1.2.x.x

	int voffset = 0x0;
	bool versionCheck = vars.offsets.TryGetValue(version, out voffset); // true if version exists within version dictionary
	vars.voffset = voffset;


	bool xlivelessCheck;

	// Get xlive.dll ModuleMemorySize - not needed for CE
	if (vars.isCE) // GTAIV 1.2.x.x
	{
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
		vars.debugInfo("enabling splitter");
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

	// fix stuff located at different addresses in CE
	// this is a bit of a hack and should be changed.
	if (vars.isCE) {
		var gulls = vars.memoryWatchers["fSeagulls"];
		var gullsce = vars.memoryWatchers["fSeagullsCE"];

		vars.memoryWatchers.Remove(gulls);
		vars.memoryWatchers.Remove(gullsce);

		gullsce.Name = gulls.Name;
		vars.memoryWatchers.Add(gullsce);
	}
}

update {
	// disable timer control actions if not enabled
	if (!vars.enabled) return;

	vars.correctEpisode = current.episodeID == 2;
	if (!vars.correctEpisode) return;

	vars.memoryWatchers.UpdateAll(game);


	// loop through memory watchers and if it matches an enabled setting then check if it's increased
	foreach (var mw in vars.memoryWatchers) {
		var key = mw.Name;
		if (settings.ContainsKey(key) && settings[key]) {
			if (!vars.splits.Contains(key+mw.Current) && mw.Current == mw.Old + 1) {
				vars.splits.Add(key+mw.Current);
				vars.queueSplit = true;

				vars.debugInfo(string.Format("Split queued: {0} - current: {1} old: {2}", key, mw.Current, mw.Old));
			}
		}
	}

	// if doResetStart was set to true on previous update, reset it to false
	vars.doResetStart = false;

	// Triggers when "I Luv LC..." is visible on-screen.
	bool startCheck = old.isFirstMission != 30000 && current.isFirstMission == 30000 && current.isLoading == 0;

	// Check if the timer is not running or has been running for more than 1 seconds.
	double ts = timer.CurrentTime.RealTime.GetValueOrDefault().TotalSeconds;
	bool timerCheck = timer.CurrentPhase == TimerPhase.NotRunning || ts >= 1.0;

	// check if missions attempted is set to 0.
	bool missionCheck = vars.memoryWatchers["iMissionsAttempted"].Current == 0;

	if (startCheck && timerCheck && missionCheck && vars.correctEpisode) {
		vars.doResetStart = true;
		vars.splits.Clear();
		vars.debugInfo("starting timer");
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
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	bool doSplit = false;

	if (vars.queueSplit) {
		if (settings["splitOnStart"]) {
			var mw = vars.memoryWatchers["iMissionsAttempted"];
			if (mw.Current == mw.Old + 1) {
				doSplit = true;
			}
		} else {
			doSplit = true;
		}
	}

	if (doSplit) {
		vars.queueSplit = false;
		vars.debugInfo("doing split");
	}

	return doSplit;
}

reset {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	return vars.doResetStart;
}

start {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	return vars.doResetStart;
}

isLoading {
	// Disable timer control actions if not enabled
	if (!vars.enabled) return false;

	if (!vars.correctEpisode) return false;

	return current.isLoading == 0; 
}
