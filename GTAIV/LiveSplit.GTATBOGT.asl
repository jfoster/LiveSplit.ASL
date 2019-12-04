/*
 * GTA TBOGT LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave.
 * https://gist.github.com/jfoster/37f266491e3caacc807d8be9d144e38b
 */

// EFLC.exe

// isLoading: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// isFirstMission: 30000 when I Luv LC... appears on screen

// Patch 3
state("EFLC", "1.1.3.0") {
	uint isLoading : 0x16EB80, 0x10;
	uint isFirstMission : 0xD6A7E0;
	string8 missionID : 0xC58EEC; // TODO:
}

// Patch 2
state("EFLC", "1.1.2.0") {
	uint isLoading : 0x99F90, 0x10;
	uint isFirstMission : 0xD0D8B8;
	string8 missionID : 0xC58EEC;
}

startup {
	refreshRate = 60;

	vars.prevPhase = null; // keeps track of previous timer phase
	vars.splits = new List<string>(); // keeps track of splitted splits
	vars.tick = 0; // keeps track of ticks since script init

	vars.offsets = new Dictionary<string, int> {
		{ "1.1.3.0", -0xC020 },
		{ "1.1.2.0", 0x0 },
	};

	vars.addresses = new Dictionary<string, int> {
		{ "fBasejumps", 0xDA563C },
		{ "fSeagulls", 0xDA564C },
		{ "fDrugWars", 0xDA56CC },
		{ "iMissionsPassed", 0xDA58B0 },
		{ "iMissionsFailed", 0xDA58B4 },
		{ "iMissionsAttempted", 0xDA58B8 },
		{ "iRandomEncounters", 0xDA5934 },
	};

	Action<string, bool, string, string, string> addSetting = (id, defaultVal, label, parent, tooltip) => {
		settings.Add(id, defaultVal, label, parent);
		settings.SetToolTip(id, tooltip);
	};

	addSetting("iMissionsPassed", true, "Story Missions (Any%)", null, "Split upon completion of a main story mission");
	addSetting("fSeagulls", false, "Seagulls", null, "Split upon seagull being exterminated");

	addSetting("splitOnStart", false, "Split on Mission Start (experimental)", null, "Split upon mission start instead of mission ending");
	addSetting("debug", false, "Debug", null, "Print debug messages to the windows error console");
}

init {
	vars.enabled = true;
	vars.doResetStart = false;
	vars.queueSplit = false;

	// print() wrapper
	Action<object> DbgInfo = (obj) => {
		if (settings["debug"]) {
			print("[LiveSplit.GTATLAD.asl] " + obj.ToString());
		}
	};
	vars.print = DbgInfo;

	// Delay init
	System.Threading.Thread.Sleep(2000);

	// Get EFLC.exe version
	var fvi = modules.First().FileVersionInfo;
	version = string.Join(".", fvi.FileMajorPart, fvi.FileMinorPart, fvi.FileBuildPart, fvi.FilePrivatePart);
	int voffset = 0x0;
	bool v = vars.offsets.TryGetValue(version, out voffset);
	vars.print("EFLC.exe " + version);

	// Get xlive.dll ModuleMemorySize
	int mms = modules.Where(m => m.ModuleName == "xlive.dll").First().ModuleMemorySize;
	bool listenerxliveless = mms > 50000 && mms < 200000;
	vars.print("xlive.dll ModuleMemorySize: " + mms.ToString());

	if (v && listenerxliveless) {
		vars.enabled = true;
	}

	// Set offset for specific game version
	vars.voffset = voffset;

	// Create new empty MemoryWatcherList
	vars.memoryWatchers = new MemoryWatcherList();

	// MemoryWatcher wrapper
	Action<string, int, int, int> mw = (name, address, aoffset, poffset) => {
		var dp = new DeepPointer(address + aoffset, poffset);
		var type = name.Substring(0, 1);
		if (type == "f") {
			vars.memoryWatchers.Add(new MemoryWatcher<float>(dp) { Name = name });
		} else if (type == "i") {
			vars.memoryWatchers.Add(new MemoryWatcher<int>(dp) { Name = name });
		}
	};

	// Add memory watcher for each address
	foreach (var a in vars.addresses) {
		mw(a.Key, a.Value, vars.voffset, 0x10);
	}
}

update {
	// disable timer control actions if not enabled
	if (!vars.enabled) return;

	// Prevent actions happening until atleast 2 ticks have occured since script startup
	if (vars.tick < 2) {
		vars.tick++;
		return;
	}

	vars.doResetStart = false;
	vars.memoryWatchers.UpdateAll(game);

	// Splitting logic
	foreach (var a in vars.addresses) {
		if (settings.ContainsKey(a.Key) && settings[a.Key]) {
			var val = vars.memoryWatchers[a.Key];
			if (val.Current > val.Old && !vars.splits.Contains(a.Key + val.Current)) {
				vars.splits.Add(a.Key + val.Current);
				vars.queueSplit = true;

				vars.print(string.Format("Split reason: {0} - ({1} > {2})", a.Key, val.Current, val.Old));
			}
		}
	}

	// Triggers when "I Luv LC..." is visible on-screen.
	if (old.isFirstMission != 30000 && current.isFirstMission == 30000 && current.isLoading == 0 && vars.memoryWatchers["iMissionsAttempted"].Current == 0) {
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
	// disable splitting if not enabled
	if (!vars.enabled) return false;

	// do not split unless 2 ticks have passed since initialization
	if (vars.tick < 2) return false;

	bool doSplit = false;

	if (vars.queueSplit) {
		if (settings["splitOnStart"]) {
			if (current.missionID != old.missionID) {
				doSplit = true;
			}
		} else {
			doSplit = true;
		}
	}

	if (doSplit) {
		vars.queueSplit = false;
	}

	return doSplit;
}

reset {
	return vars.doResetStart;
}

start {
	return vars.doResetStart;
}

isLoading {
	return current.isLoading == 0;
}