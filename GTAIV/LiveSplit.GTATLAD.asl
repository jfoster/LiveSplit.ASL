/*
 * GTA TLAD LiveSplit Autosplitter
 * Originally created by possessedwarrior, adapted by Rave, updated to work with the Complete Edition by hoxi, expanded upon features by Kocurro14.
 * https://github.com/jfoster/LiveSplit.ASL/tree/stable/GTAIV
 */

// isLoading before 1.2.0.32: 0 if loading, 4 in normal gameplay, sometimes seemingly random values in fade ins/outs
// isLoading in/after 1.2.0.32: 0 if loading, random values if not loading
// episodeID: 0 is IV, 1 is TLAD, 2 is TBOGT
// isFirstMission: 30000 when Clean and Serene... appears on screen
// LastMissionName values refer to: https://github.com/jfoster/LiveSplit.ASL/blob/stable/GTAIV/LastMissionName_details
// isCutsceneRunning: 0 if not running, 8 if running, 10 if skipped. The cinematic mo-cap cutscenes, not scripted ones with pre-made animations.
// MissionsAttempted: amount of attempted story missions
// ScreenFade: 0 if not fading, 15 if fading. Opening esc menu fade does _not_ fall under it.
// onMission: is player on a mission flag. 0 if false, 1 if true
// Xcoord, Ycoord, Zcoord are player coordinates. Zcoords are commented out as there's no use for them in autosplitting.
// Characters names are their respective mission progress percentage.

// current Complete Edition
state("GTAIV", "1.2.0.59") {
	uint isLoading : 0xD747A4;
	uint episodeID : 0xD73240;
	uint isFirstMission : 0xD8DFD0;
	int LastMissionName : 0xEB6FAC;
	int isCutsceneRunning : 0xE9475C;
	int MissionsAttempted : 0xEB79D0;
	int ScreenFade : 0xC39294;
	int onMission : 0x1266C80;
	float Xcoord : 0x124BA70;
	float Ycoord : 0x124BA74;
	//float Zcoord : 0x124BA78;
	float Billy : 0xEB7794;
	float Jim : 0xEB7798;
	float Elizabeta : 0xEB77AC;
	float Stubbs : 0xEB77A4;
	float Ashley : 0xEB77A8;
	float Ray : 0xEB77B0;
}

// Complete Edition until 9/02/2023
state("GTAIV", "1.2.0.43") {
	uint isLoading : 0xD747A4;
	uint isFirstMission : 0xD8DFD0;
	uint episodeID : 0xD73240;
	int LastMissionName : 0xEB6FAC;
	int isCutsceneRunning : 0xE9475C;
	int MissionsAttempted : 0xEB79D0;
	int ScreenFade : 0xC39294;
	int onMission : 0x1266C80;
	float Xcoord : 0x124BA70;
	float Ycoord : 0x124BA74;
	//float Zcoord : 0x124BA78;
	float Billy : 0xEB7794;
	float Jim : 0xEB7798;
	float Elizabeta : 0xEB77AC;
	float Stubbs : 0xEB77A4;
	float Ashley : 0xEB77A8;
	float Ray : 0xEB77B0;
}

// Patch 2
state("EFLC", "1.1.2.0") {
	uint isLoading : 0x99F90, 0x10;
	uint episodeID : 0xC4D7C4; // could also use 0xC619D8
	uint isFirstMission : 0xD0D8B8;
	int LastMissionName : 0xDA4CFC;
	int isCutsceneRunning : 0xD073F0;
	int MissionsAttempted : 0xDA58B8;
	int ScreenFade : 0xB17A44;
	int onMission : 0x11E80E8;
	float Xcoord : 0x12462F0;
	float Ycoord : 0x12462F4;
	//float Zcoord : 0x12462F8;
	float Billy : 0xDA3DA4;
	float Jim : 0xDA3DA8;
	float Elizabeta : 0xDA3DBC;
	float Stubbs : 0xDA3DB4;
	float Ashley : 0xDA3DB8;
	float Ray: 0xDA3DC0;
}

startup {
	vars.offsets = new Dictionary<string, int> {
		// newest first
		{"1.2.0.59", 0x1122B0},
		{"1.2.0.43", 0x1122B0},
		{"1.2.0.32", 0x112240},
		{"1.1.3.0", -0xC020},
		{"1.1.2.0", 0x0},
	};

	vars.stats = new Dictionary<string, int> {
		{"fGameTime", 0xDA53B0},
		{"fSeagulls", 0xDA553C},
		{"fGangWars", 0xDA55C4},
		{"fDirtyLaundry", 0xDA5544},
		{"fRacesWon", 0xDA5538},
		{"fBikesStolen", 0xDA5540},
		{"iRandomEncounters", 0xDA5934}, 
	};

	refreshRate = 60;

	vars.prevPhase = null; // keeps track of previous timer phase
	vars.splits = new HashSet<string>(); // keeps track of splitted splits

	Action<string, string, string, string, bool> addSetting = (parent, id, label, tooltip, defaultVal) => {
		settings.Add(id, defaultVal, label, parent);
		settings.SetToolTip(id, tooltip);
	};

	addSetting(null, "splitOnEnd", "Split on Mission End", "Split upon completion of selected main story mission(s)", true);
		addSetting("splitOnEnd", "B0", "Billy Grey", null, true);
			addSetting("B0", "B1", "Pretty Boy", "Split upon reaching Chop Shop on \"Clean And Serene\"", false);
			addSetting("B0", "B2", "Clean And Serene", null, true);
			addSetting("B0", "B3", "Angels In America", null, true);
			addSetting("B0", "B4", "It's War", null, true);
			addSetting("B0", "B5", "Action/Reaction", null, true);
			addSetting("B0", "B6", "This Shit's Cursed", null, true);
			
		addSetting("splitOnEnd", "J0", "Jim Fitzgerald", null, true);
			addSetting("J0", "J1", "Liberty City Choppers", null, true);
			addSetting("J0", "J2", "Bad Cop Drop", null, true);
			addSetting("J0", "J3", "Hit The Pipe", null, true);
			addSetting("J0", "J4", "End Of Chapter", null, true);
			addSetting("J0", "J5", "Bad Standing", null, true);
			
		addSetting("splitOnEnd", "E0", "Elizabeta Torres", null, true);
			addSetting("E0", "E1", "Buyer's Market", null, true);
			addSetting("E0", "E2", "Heavy Toll", null, true);
			addSetting("E0", "E3", "Marta Full Of Grace", null, true);
			addSetting("E0", "E4", "Shifting Weight", null, true);
			
		addSetting("splitOnEnd", "S0", "Tom Stubbs", null, true);
			addSetting("S0", "S1", "Politics", null, true);
			addSetting("S0", "S2", "Off Route", null, true);
			addSetting("S0", "S3", "Get Lost (Any% / Classic End)", "Any% / Classic final split - hitting last marker", true);
			addSetting("S0", "S4", "Credits", "Split after finishing credits", false);
			
		addSetting("splitOnEnd", "A0", "Ashley Butler", null, true);
			addSetting("A0", "A1", "Coming Down", null, true);
			addSetting("A0", "A2", "Roman's Holiday", null, true);
			
		addSetting("splitOnEnd", "R0", "Ray Boccino", null, true);
			addSetting("R0", "R1", "Diamonds In The Rough", null, true);
			addSetting("R0", "R2", "Collector's Item", null, true);
			addSetting("R0", "R3", "Was It Worth it?", null, true);
			
	addSetting(null, "splitOnStart", "Split on Mission Start", "Split upon start of selected main story mission(s)", false);
		addSetting("splitOnStart", "B00", "Billy Grey", null, false);
			addSetting("B00", "B33", "Angels In America", null, false);
			addSetting("B00", "B44", "It's War", null, false);
			addSetting("B00", "B55", "Action/Reaction", null, false);
			addSetting("B00", "B66", "This Shit's Cursed", null, false);
			
		addSetting("splitOnStart", "J00", "Jim Fitzgerald", null, false);
			addSetting("J00", "J11", "Liberty City Choppers", null, false);
			addSetting("J00", "J22", "Bad Cop Drop", null, false);
			addSetting("J00", "J33", "Hit The Pipe", null, false);
			addSetting("J00", "J44", "End Of Chapter", null, false);
			addSetting("J00", "J55", "Bad Standing", null, false);
			
		addSetting("splitOnStart", "E00", "Elizabeta Torres", null, false);
			addSetting("E00", "E11", "Buyer's Market", null, false);
			addSetting("E00", "E22", "Heavy Toll", null, false);
			addSetting("E00", "E33", "Marta Full Of Grace", null, false);
			addSetting("E00", "E44", "Shifting Weight", null, false);
			
		addSetting("splitOnStart", "S00", "Tom Stubbs", null, false);
			addSetting("S00", "S11", "Politics", null, false);
			addSetting("S00", "S22", "Off Route", null, false);
			addSetting("S00", "S33", "Get Lost", null, false);
			
		addSetting("splitOnStart", "A00", "Ashley Butler", null, false);
			addSetting("A00", "A11", "Coming Down (Experimental)", "This is a phone activated mission", false);
			addSetting("A00", "A22", "Roman's Holiday", null, false);
			
		addSetting("splitOnStart", "R00", "Ray Boccino", null, false);
			addSetting("R00", "R11", "Diamonds In The Rough", null, false);
			addSetting("R00", "R22", "Collector's Item (Experimental)", "This is a phone activated mission", false);
			addSetting("R00", "R33", "Was It Worth it?", null, false);
			
	addSetting(null, "misc", "Miscellaneous", null, false);
		addSetting("misc", "fSeagulls", "Seagulls", "Split upon extermination of any Seagull", false);
		addSetting("misc", "fRacesWon", "Bike Races", "Split upon winning any bike race", false);
		addSetting("misc", "fBikesStolen", "Angus' Bike Thefts", "Split upon delivering any requested bike for Angus", false);
		addSetting("misc", "fDirtyLaundry", "Stubbs' Dirty Laundry", "Split upon washing any Dirty Laundry for Stubbs", false);
		addSetting("misc", "fGangWars", "Gang Wars", "Split upon winning any Gang War", false);
		addSetting("misc", "iRandomEncounters", "Random Characters", "Split upon finishing any random character encounter", false);

	addSetting(null, "gameTime", "In-Game Time (Experimental)", "Game Timer shows IGT rather than Loadless time", false);
	addSetting(null, "debug", "Debug", "Print debug messages to the Windows error console", false);
}

init {
	vars.enabled = false;
	vars.doResetStart = false;
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
}

update {
	if (!vars.enabled) return;

	vars.correctEpisode = current.episodeID == 1;
	if (!vars.correctEpisode) return;

	vars.memoryWatchers.UpdateAll(game);

	// if doResetStart was set to true on previous update, reset it to false
	vars.doResetStart = false;

	// Triggers when "Clean and Serene..." is visible on-screen.
	bool startCheck = old.isFirstMission != 30000 && current.isFirstMission == 30000 && current.isLoading == 0;

	// Check if the timer is not running or has been running for more than 1 seconds.
	double ts = timer.CurrentTime.RealTime.GetValueOrDefault().TotalSeconds;
	bool timerCheck = timer.CurrentPhase == TimerPhase.NotRunning || ts >= 1.0;

	// check if missions progress with Billy is set to 0.
	bool missionCheck = current.Billy == 0f;

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

	// =====================================================================
	// Split on Mission End
	// =====================================================================
	// If setting is enabled AND the mission associated with this settings is finished AND game is not loading THEN do split.
	// Game loading check is here to prevent splitting after doing video editor warp or loading a savegame.
	// Each mission (except Story Complete) has two different LastMissionName values associated with it, both are correct.
	//======================================================================
	
	if (settings["B3"] 
		&& (current.LastMissionName == 50 && old.LastMissionName != 50 && current.isLoading != 0)
		|| (current.LastMissionName == 4456498 && old.LastMissionName != 4456498 && current.isLoading != 0))
		return true;
	if (settings["B4"]
		&& (current.LastMissionName == 51 && old.LastMissionName != 51 && current.isLoading != 0)
		|| (current.LastMissionName == 4456499 && old.LastMissionName != 4456499 && current.isLoading != 0)) 
		return true;
	if (settings["B5"]
		&& (current.LastMissionName == 52 && old.LastMissionName != 52 && current.isLoading != 0)
		|| (current.LastMissionName == 4456500 && old.LastMissionName != 4456500 && current.isLoading != 0))
		return true; // Action/Reaction
	if (settings["B6"]
		&& (current.LastMissionName == 54 && old.LastMissionName != 54 && current.isLoading != 0)
		|| (current.LastMissionName == 4456502 && old.LastMissionName != 4456502 && current.isLoading != 0)) 
		return true; // This Shit's Cursed
		
	if (settings["J1"] 
		&& (current.LastMissionName == 55 && old.LastMissionName != 55 && current.isLoading != 0)
		|| (current.LastMissionName == 4456503 && old.LastMissionName != 4456503 && current.isLoading != 0))
		return true;
	if (settings["J2"]
		&& (current.LastMissionName == 56 && old.LastMissionName != 56 && current.isLoading != 0)
		|| (current.LastMissionName == 4456504 && old.LastMissionName != 4456504 && current.isLoading != 0))
		return true;
	if (settings["J3"]
		&& (current.LastMissionName == 12337 && old.LastMissionName != 12337 && current.isLoading != 0)
		|| (current.LastMissionName == 1409298481 && old.LastMissionName != 1409298481 && current.isLoading != 0))
		return true;
	if (settings["J4"]
		&& (current.LastMissionName == 12593 && old.LastMissionName != 12593 && current.isLoading != 0)
		|| (current.LastMissionName == 1409298737 && old.LastMissionName != 1409298737 && current.isLoading != 0))
		return true;
	if (settings["J5"]
		&& (current.LastMissionName == 12849 && old.LastMissionName != 12849 && current.isLoading != 0)
		|| (current.LastMissionName == 1409298993 && old.LastMissionName != 1409298993 && current.isLoading != 0))
		return true;
	
	if (settings["E1"]
		&& (current.LastMissionName == 53 && old.LastMissionName != 53 && current.isLoading != 0)
		|| (current.LastMissionName == 4456501 && old.LastMissionName != 4456501 && current.isLoading != 0))
		return true; // Buyer's Market
	if (settings["E2"]
		&& (current.LastMissionName == 14641 && old.LastMissionName != 14641 && current.isLoading != 0)
		|| (current.LastMissionName == 1409300785 && old.LastMissionName != 1409300785 && current.isLoading != 0)) 
		return true; // Heavy Toll
	if (settings["E3"]
		&& (current.LastMissionName == 12338 && old.LastMissionName != 12338 && current.isLoading != 0)
		|| (current.LastMissionName == 1409298482 && old.LastMissionName != 1409298482 && current.isLoading != 0)) 
		return true;
	if (settings["E4"]
		&& (current.LastMissionName == 12594 && old.LastMissionName != 12594 && current.isLoading != 0)
		|| (current.LastMissionName == 1409298738 && old.LastMissionName != 1409298738 && current.isLoading != 0))
		return true;
	
	if (settings["S1"]
		&& (current.LastMissionName == 13105 && old.LastMissionName != 13105 && current.isLoading != 0)
		|| (current.LastMissionName == 1409299249 && old.LastMissionName != 1409299249 && current.isLoading != 0)) 
		return true;
	if (settings["S2"]
		&& (current.LastMissionName == 13361 && old.LastMissionName != 13361 && current.isLoading != 0)
		|| (current.LastMissionName == 1409299505 && old.LastMissionName != 1409299505 && current.isLoading != 0))
		return true;
	if (settings["S4"] && (current.LastMissionName == 1414087749 && old.LastMissionName != 1414087749 && current.isLoading != 0)) return true; // split after credits
	
	if (settings["A1"]
		&& (current.LastMissionName == 14129 && old.LastMissionName != 14129 && current.isLoading != 0)
		|| (current.LastMissionName == 1409300273 && old.LastMissionName != 1409300273 && current.isLoading != 0))
		return true;
	if (settings["A2"]
		&& (current.LastMissionName == 14385 && old.LastMissionName != 14385 && current.isLoading != 0)
		|| (current.LastMissionName == 1409300529 && old.LastMissionName != 1409300529 && current.isLoading != 0))
		return true;
	
	if (settings["R1"]
		&& (current.LastMissionName == 12850 && old.LastMissionName != 12850 && current.isLoading != 0) 
		|| (current.LastMissionName == 1409298994 && old.LastMissionName != 1409298994 && current.isLoading != 0)) 
		return true;
	if (settings["R2"]
		&& (current.LastMissionName == 13106 && old.LastMissionName != 13106 && current.isLoading != 0)
		|| (current.LastMissionName == 1409299250 && old.LastMissionName != 1409299250 && current.isLoading != 0))
		return true;
	if (settings["R3"]
		&& (current.LastMissionName == 13362 && old.LastMissionName != 13362 && current.isLoading != 0)
		|| (current.LastMissionName == 1409299506 && old.LastMissionName != 1409299506 && current.isLoading != 0)) 
		return true;
		
	// Exceptions
	// ====================================
		
	// Pretty Boy split
	// If setting is enabled
	// 		AND current mission progress with Billy is at 0% (no missions are completed - player is doing "Clean and Serene")
	// 		AND if screen starts fading to black
	//		AND player is in the area of "Clean and Serene" chop shop destination marker:
	// That means the marker has been entered and split needs to happen
	// exact marker coordinates from billy1.sco {914.23260000, 1556.08400000, 18.26000000}
	if (settings["B1"] 
		&& (current.Billy == 0f)
		&& (current.ScreenFade == 15 && old.ScreenFade != 15) 
		&& ((current.Xcoord < 918.23f && current.Xcoord > 910.23f) && (current.Ycoord < 1560.08f && current.Ycoord > 1552.08f)))
		return true;

	// Clean And Serene split
	// If setting is enabled AND your progress with Billy raises from 0% AND game is not loading THEN do split.
	// As that means one mission for Billy has been finished which would be 'Clean And Serene'
	// Game loading check is here to prevent splitting after doing video editor warp or loading a savegame.
	// LastMissionName method cannot apply here, because when you start a new game from savefile...
	// ...the LastMissionName value carries over from savefile new game was started from.
	// So if the new game was started from savefile that had 'Clean And Serene' finished, split would fail to happen.
	if (settings["B2"] && (current.Billy == 16.66666794f && old.Billy == 0f && current.isLoading != 0)) return true;
		
	// Any% / Classic Final Split - hitting last marker at the end of 'Get Lost'
	// If setting is enabled
	//		AND 'Was It Worth it?' is last finished mission (as its the only possible story mission to complete before starting 'Get Lost')
	//		AND player is in the area of last marker at the end of 'Get Lost' 
	//		AND screen starts fading to black 
	//		AND there's no cutscene running at the moment (this check is here to prevent splitting during last cutscene playing):
	// That means marker has been entered and split needs to happen as the player completed the game a.k.a. finished any% / classic speedrun.
	// exact marker coordinates from stubbs4.sco {-1720.96800000, 368.84040000, 24.32380000}
	if (settings["S3"] 
		&& ((current.LastMissionName == 13362 || current.LastMissionName == 1409299506) 
		&& ((current.Xcoord < -1716.96f && current.Xcoord > -1724.96f) && (current.Ycoord > 364.84f && current.Ycoord < 374.84f)) 
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.isCutsceneRunning == 0)))
		return true;
		
	
	
	// ==================================================================
	// Split on Mission Start
	// ==================================================================
	// If setting is enabled 
	//		AND specified character mission progress is at certain threshold
	// 		AND player is in area of static mission start marker associated with this setting
	// 		AND screen starts fading to black
	//		AND player is not on a mission, yet (this check is here to prevent splitting when second fade-out happen, after cutscene ends):
	// That means mission marker has been entered, mission has been started, and split needs to happen.
	// onMission flag changes to 1 around when screen fades fully to black.
	// Any coordinates below are mission start markers locations taken from main.sco
	// ===================================================================
	
	// for all Billy's missions: {-1718.45900000, 361.44560000, 24.39980000}
	if (settings["B33"] 
		&& (current.Billy == 16.66666794f)
		&& ((current.Xcoord > -1722.45f && current.Xcoord < -1714.45f) && (current.Ycoord > 357.44f && current.Ycoord < 365.44f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	if (settings["B44"]
		&& (current.Billy == 33.33333588f)
		&& ((current.Xcoord > -1722.45f && current.Xcoord < -1714.45f) && (current.Ycoord > 357.44f && current.Ycoord < 365.44f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	if (settings["B55"]
		&& (current.Billy == 50f)
		&& ((current.Xcoord > -1722.45 && current.Xcoord < -1714.45f) && (current.Ycoord > 357.44f && current.Ycoord < 365.44f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;// Action/Reaction
	// 66.67% now Buyer's Market should've happen, but this mission is moved to Elizabeta
	if (settings["B66"]
		&& (current.Billy == 83.33332825f)
		&& ((current.Xcoord > -1722.45f && current.Xcoord < -1714.45f) && (current.Ycoord > 357.44f && current.Ycoord < 365.44f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true; // This Shit's Cursed
		
	// {-1837.80200000, 281.17250000, 21.95570000}
	if (settings["J11"]
		&& (current.Jim == 0f)
		&& ((current.Xcoord > -1841.8f && current.Xcoord < -1834.8f) && (current.Ycoord > 277.17f && current.Ycoord < 287.17f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
		
	// {-1632.97400000, 794.95300000, 28.76430000}
	if (settings["J22"]
		&& (current.Jim == 20f)
		&& ((current.Xcoord > -1636.97f && current.Xcoord < -1628.97f) && (current.Ycoord > 790.95f && current.Ycoord < 798.95f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
		
	// {-338.90340000, 1601.72000000, 19.42150000}
	if (settings["J33"]
		&& (current.Jim == 40f)
		&& ((current.Xcoord > -342.9f && current.Xcoord < -334.9f) && (current.Ycoord > 1557.72f && current.Ycoord < 1605.72f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
		
	// {-1460.73000000, 817.10820000, 18.56550000}
	if (settings["J44"]
		&& (current.Jim == 60.00000381f)
		&& ((current.Xcoord > -1464.73f && current.Xcoord < -1456.73f) && (current.Ycoord > 813.1f && current.Ycoord < 821.10f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
		
	// {-1110.09500000, 1317.83100000, 23.43190000} 
	if (settings["J55"]
		&& (current.Jim == 80f)
		&& ((current.Xcoord > -1114.09f && current.Xcoord < -1106.09f) && (current.Ycoord > 1313.83f && current.Ycoord < 1321.83f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	
    // for all Elizabeta's missions: {362.82160000, 1504.80200000, 15.97050000}
	if (settings["E11"]
		&& (current.Billy == 66.66667175f)
		&& ((current.Xcoord < 366.82f && current.Xcoord > 358.82f) && (current.Ycoord < 1508.8f && current.Ycoord > 1500.8f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true; // Buyer's Market
	if (settings["E22"]
		&& (current.Elizabeta == 0f)
		&& ((current.Xcoord < 366.82f && current.Xcoord > 358.82f) && (current.Ycoord < 1508.8f && current.Ycoord > 1500.8f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true; // Heavy Toll
	if (settings["E33"]
		&& (current.Elizabeta == 33.33333588f)
		&& ((current.Xcoord < 366.82f && current.Xcoord > 358.82f) && (current.Ycoord < 1508.8f && current.Ycoord > 1500.8f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	if (settings["E44"]
		&& (current.Elizabeta == 66.66667175f)
		&& ((current.Xcoord < 366.82f && current.Xcoord > 358.82f) && (current.Ycoord < 1508.8f && current.Ycoord > 1500.8f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	
	// {-35.08080000, 764.47520000, 13.71320000}
	if (settings["S11"]
		&& (current.Stubbs == 0f)
		&& ((current.Xcoord > -39.08f && current.Xcoord < -31.08f) && (current.Ycoord > 760.47f && current.Ycoord < 768.47f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	// {-35.08080000, 764.47520000, 13.71320000}
	if (settings["S22"]
		&& (current.Stubbs == 33.33333588f)
		&& ((current.Xcoord > -39.08f && current.Xcoord < -31.08f) && (current.Ycoord > 760.47f && current.Ycoord < 768.47f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	// {-1718.45900000, 361.44560000, 24.39980000}
	if (settings["S33"]
		&& (current.Stubbs == 66.66667175f)
		&& ((current.Xcoord > -1722.45 && current.Xcoord < -1714.45f) && (current.Ycoord > 357.44f && current.Ycoord < 365.44f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
		
	// {-1469.90200000, 490.41190000, 18.56540000}
	if (settings["A22"]
		&& (current.Ashley == 50f)
		&& ((current.Xcoord > -1473.9f && current.Xcoord < -1465.9f) && (current.Ycoord > 486.41f && current.Ycoord < 494.41f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
		
	// {-123.63790000, -256.57810000, 11.68540000}
	if (settings["R11"]
		&& (current.Ray == 0f)
		&& ((current.Xcoord > -127.63f && current.Xcoord < -119.63f) && (current.Ycoord > -260.57f && current.Ycoord < -252.57f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	// {-123.63790000, -256.57810000, 11.68540000}
	if (settings["R33"]
		&& (current.Ray == 66.66667175f)
		&& ((current.Xcoord > -127.63f && current.Xcoord < -119.63f) && (current.Ycoord > -260.57f && current.Ycoord < -252.57f))
		&& (current.ScreenFade == 15 && old.ScreenFade != 15)
		&& (current.onMission == 0))
		return true;
	
	// Exceptions
	// ===============================
	// These are phonecall-activated missions which do not start from static markers like others
		
	// Coming Down start split
	// This mission is unlocked after finishing Politics
	// If setting is enabled
	// 		AND mission progress with Ashley is at less than 49% (which is at 0%, while starting Coming Down)...
	//		...alongside progress with Stubbs being more or equal 33.34%... 
	//		...which means at least one mission with him has been finished and that would be Politics
	//		AND onMission flag changes to 1 
	// 		AND current missions attempted value changes (this check assures that story mission has been started, not stuff like bike thefts etc.)
	// 		AND game is not loading (this check prevents splitting when replaying a mission after failing):
	// That means some kind of mission has been started somewhere...
	// ...and under such restricted circumstances only possible story mission to start would be Coming Down.
	if (settings["A11"]
		&& (current.Ashley < 49f && current.Stubbs >= 33.33333588f)
		&& (current.onMission == 1 && old.onMission == 0)
		&& (current.MissionsAttempted != old.MissionsAttempted)
		&& (current.isLoading != 0))
		return true;
		
	// Collector's Item start split
	// This mission is unlocked after finishing Diamonds In The Rough AND Roman's Holiday
	// If setting is enabled
	// 		AND mission progress with Ray is at 33.34%...
	//		...that means one mission for him has been finished and that would be Diamonds in the Rough...
	// 		...alongside progress with Ashley being 100% (all her mission finished, which includes Roman's Holiday)
	// 		AND onMission flag changes to 1
	// 		AND current missions attempted value changes (this check assures that story mission has been started, not stuff like bike thefts etc.)
	// 		AND game is not loading (this check prevents splitting when replaying a mission after failing):
	// That means some kind of mission has been started somewhere...
	// ...and under such restricted circumstances only possible story mission to start would be Collector's Item.
	if (settings["R22"]
		&& (current.Ray == 33.33333588f && current.Ashley == 100f)
		&& (current.onMission == 1 && old.onMission == 0)
		&& (current.MissionsAttempted != old.MissionsAttempted)
		&& (current.isLoading != 0))
		return true;
		
		
		
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

				if (settings["fSeagulls"] || settings["fRacesWon"] || settings["fBikesStolen"] 
				|| settings["fDirtyLaundry"] || settings["fGangWars"] || settings["iRandomEncounters"]) return true;
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

	return current.isLoading == 0;
}

gameTime {
	if (!vars.enabled) return null;

	if (!vars.correctEpisode) return null;

	if (!settings["gameTime"]) return null;

	var gt = vars.memoryWatchers["fGameTime"];
	return TimeSpan.FromMilliseconds(gt.Current);
}
