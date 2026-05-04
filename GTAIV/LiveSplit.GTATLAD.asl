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
// VideoEditor (CE only): 0 in gameplay, 256 in video editor
// VideoEditor (pre-CE only): 0 in gameplay, 1 on save menu, 256 during vid warp freeze, 257 in menus and video editor
// Xcoord, Ycoord, Zcoord are player coordinates. Zcoords are commented out as there's no use for them in autosplitting.
// Characters names are their respective mission progress percentage.

// current Complete Edition
state("GTAIV", "1.2.0.59") {
	uint isLoading : 0xD747A4;
	uint episodeID : 0xD73240;
	uint isFirstMission : 0xD8DFD0;
	int LastMissionName : 0xEB6FAC;
	// int isCutsceneRunning : 0xE9475C;
	int MissionsAttempted : 0xEB79D0;
	int ScreenFade : 0xC39294;
	int VideoEditor : 0xD60C3C;
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
	uint episodeID : 0xD73240;
	uint isFirstMission : 0xD8DFD0;
	int LastMissionName : 0xEB6FAC;
	// int isCutsceneRunning : 0xE9475C;
	int MissionsAttempted : 0xEB79D0;
	int ScreenFade : 0xC39294;
	int VideoEditor : 0xD60C3C;
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
	// int isCutsceneRunning : 0xD073F0;
	int MissionsAttempted : 0xDA58B8;
	int ScreenFade : 0xB17A44;
	int VideoEditor : 0xD6E428;
	float Xcoord : 0x12462F0;
	float Ycoord : 0x12462F4;
	//float Zcoord : 0x12462F8;
	float Billy : 0xDA54E4, 0xC, 0x0;
	float Jim : 0xDA54E8, 0xC, 0x0;
	float Stubbs : 0xDA54F4, 0xC, 0x0;
	float Ashley : 0xDA54F8, 0xC, 0x0;
	float Elizabeta : 0xDA54FC, 0xC, 0x0;
	float Ray : 0xDA5500, 0xC, 0x0;
}

startup {
	vars.offsets = new Dictionary<string, int> {
		// newest first
		{"1.2.0.59", 0x1122B0},
		{"1.2.0.43", 0x1122B0},
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
	
	vars.missEnd = new Dictionary<string, List<int>> {
		{"B3", new List<int>{50, 4456498}},
		{"B4", new List<int>{51, 4456499}},
		{"B5", new List<int>{52, 4456500}},
		{"B6", new List<int>{54, 4456502}},
		{"J1", new List<int>{55, 4456503}},
		{"J2", new List<int>{56, 4456504}},
		{"J3", new List<int>{12337, 1409298481}},
		{"J4", new List<int>{12593, 1409298737}},
		{"J5", new List<int>{12849, 1409298993}},
		{"E1", new List<int>{53, 4456501}},
		{"E2", new List<int>{14641, 1409300785}},
		{"E3", new List<int>{12338, 1409298482}},
		{"E4", new List<int>{12594, 1409298738}},
		{"S1", new List<int>{13105, 1409299249}},
		{"S2", new List<int>{13361, 1409299505}},
		{"S4", new List<int>{1414087749, 1414087749}},
		{"A1", new List<int>{14129, 1409300273}},
		{"A2", new List<int>{14385, 1409300529}},
		{"R1", new List<int>{12850, 1409298994}},
		{"R2", new List<int>{13106, 1409299250}},
		{"R3", new List<int>{13362, 1409299506}},
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
			addSetting("A00", "A11", "Coming Down", null, false);
			addSetting("A00", "A22", "Roman's Holiday", null, false);
			
		addSetting("splitOnStart", "R00", "Ray Boccino", null, false);
			addSetting("R00", "R11", "Diamonds In The Rough", null, false);
			addSetting("R00", "R22", "Collector's Item", null, false);
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

	// Timer ResetStart
	if (startCheck && timerCheck && missionCheck && vars.correctEpisode) {
		vars.doResetStart = true;
		vars.debugInfo("ResetStart");
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

	foreach (var mse in vars.missEnd) {
		var k = mse.Key;
		var v = mse.Value;

		if (
			// check if setting is enabled 
			settings.ContainsKey(k) && settings[k] 

			// AND hasn't been split for
			&& !vars.splits.Contains(k)

			// AND last finished mission changes
			&& v.Contains(current.LastMissionName) && !v.Contains(old.LastMissionName)

			// AND missions attempted value remains unchanged (to prevent split upon loading a savefile)
			&& current.MissionsAttempted == old.MissionsAttempted
			)
			{
			vars.splits.Add(k); // add split to hashset, as it has been split for
			vars.debugInfo((k));
			return true; // do split
		}
	}

	// Exceptions
	// ====================================

	// Pretty Boy split
	// If setting is enabled
	//		AND hasn't been split for
	// 		AND current mission progress with Billy is at 0% (no missions are completed - player is doing "Clean and Serene")
	// 		AND if screen starts fading to black
	//		AND player is in the area of "Clean and Serene" chop shop destination marker:
	// That means the marker has been entered and split needs to happen
	// exact marker coordinates from billy1.sco {914.23260000, 1556.08400000, 18.26000000}
	if (settings["B1"] 
		&& !vars.splits.Contains("B1")
		&& (current.Billy == 0f)
		&& (current.ScreenFade == 15 && old.ScreenFade != 15) 
		&& ((current.Xcoord < 918.23f && current.Xcoord > 910.23f) && (current.Ycoord < 1560.08f && current.Ycoord > 1552.08f)))
	{ 
		vars.splits.Add("B1");
		vars.debugInfo("B1");
		return true;
	}

	// Clean And Serene split
	// If setting is enabled
	//		AND the mission hasn't been split for 
	// 		AND your progress with Billy raises from 0% (that means one mission for Billy has been finished which would be 'Clean And Serene')
	//		AND MissionsAttempted value remains unchanged (to prevent a split while loading a savefile)
	// That means mission has been finished and split needs to happen
	// LastMissionName method cannot apply here, because when you start a new game from savefile
	// the LastMissionName value carries over from savefile new game was started from.
	// So if the new game is started from savefile that has 'Clean And Serene' finished, split fails to happen.
	if (settings["B2"] && !vars.splits.Contains("B2") && (current.Billy > 14f && old.Billy == 0f) && (current.MissionsAttempted == old.MissionsAttempted))
	{
		vars.splits.Add("B2");
		vars.debugInfo("B2");
		return true;
	}

	// Any% / Classic Final Split - hitting last marker at the end of 'Get Lost'
	// If setting is enabled
	// 		AND hasn't been split for
	//		AND 'Was It Worth it?' is last finished mission (as its the only possible story mission to complete before starting 'Get Lost')
	//		AND player is in the area of last marker at the end of 'Get Lost' 
	//		AND screen starts fading to black 
	// That means marker has been entered and split needs to happen as the player completed the game a.k.a. finished any% / classic speedrun.
	// exact marker coordinates from stubbs4.sco {-1720.96800000, 368.84040000, 24.32380000}
	if (settings["S3"] 
		&& !vars.splits.Contains("S3")
		&& ((current.LastMissionName == 13362 || current.LastMissionName == 1409299506) 
		&& ((current.Xcoord < -1716.96f && current.Xcoord > -1724.96f) && (current.Ycoord > 364.84f && current.Ycoord < 374.84f)) 
		&& (current.ScreenFade == 15 && old.ScreenFade != 15))) 
	{
		vars.splits.Add("S3");
		vars.debugInfo("S3 - Any% Final Split");
		return true;
	}

	// ==================================================================
	// Split on Mission Start
	// ==================================================================
	// If setting is enabled 
	// 		AND hasn't been split for
	//		AND specified character mission progress is at certain threshold
	// 		AND player is in area of static mission start marker associated with this setting
	// 		AND missions attempted value raises:
	// That means mission marker has been entered, mission has been started, and split needs to happen.
	// Any coordinates below are mission start markers locations taken from main.sco
	// ===================================================================

	// for all Billy's missions: {-1718.45900000, 361.44560000, 24.39980000}
	if (settings["B33"]
		&& !vars.splits.Contains("B33")
		&& ((current.Billy > 14f && current.Billy < 18f)
		&& ((current.Xcoord > -1728.45f && current.Xcoord < -1708.45f) && (current.Ycoord > 351.44f && current.Ycoord < 371.44f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1))) 
	{
		vars.splits.Add("B33");
		vars.debugInfo("B33");
		return true;
	}
	if (settings["B44"]
		&& !vars.splits.Contains("B44")
		&& ((current.Billy > 31f && current.Billy < 35f)
		&& ((current.Xcoord > -1728.45f && current.Xcoord < -1708.45f) && (current.Ycoord > 351.44f && current.Ycoord < 371.44f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1))) 
	{
		vars.splits.Add("B44");
		vars.debugInfo("B44");
		return true;
	}
	if (settings["B55"]
		&& !vars.splits.Contains("B55")
		&& ((current.Billy == 50f)
		&& ((current.Xcoord > -1728.45f && current.Xcoord < -1708.45f) && (current.Ycoord > 351.44f && current.Ycoord < 371.44f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("B55");
		vars.debugInfo("B55");
		return true; // Action/Reaction
	}
	// 66.67% now Buyer's Market should've happen, but this mission is moved to Elizabeta
	if (settings["B66"]
		&& !vars.splits.Contains("B66")
		&& ((current.Billy > 81f && current.Billy < 85f)
		&& ((current.Xcoord > -1728.45f && current.Xcoord < -1708.45f) && (current.Ycoord > 351.44f && current.Ycoord < 371.44f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("B66");
		vars.debugInfo("B66");
		return true; // This Shit's Cursed
	}
	// {-1837.80200000, 281.17250000, 21.95570000}
	if (settings["J11"]
		&& !vars.splits.Contains("J11")
		&& ((current.Jim == 0f)
		&& ((current.Xcoord > -1847.8f && current.Xcoord < -1824.8f) && (current.Ycoord > 271.17f && current.Ycoord < 291.17f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("J11");
		vars.debugInfo("J11");
		return true;
	}

	// {-1632.97400000, 794.95300000, 28.76430000}
	if (settings["J22"]
		&& !vars.splits.Contains("J22")
		&& ((current.Jim == 20f)
		&& ((current.Xcoord > -1642.97f && current.Xcoord < -1622.97f) && (current.Ycoord > 784.95f && current.Ycoord < 804.95f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("J22");
		vars.debugInfo("J22");
		return true;
	}

	// {-338.90340000, 1601.72000000, 19.42150000}
	if (settings["J33"]
		&& !vars.splits.Contains("J33")
		&& ((current.Jim == 40f)
		&& ((current.Xcoord > -348.9f && current.Xcoord < -328.9f) && (current.Ycoord > 1591.72f && current.Ycoord < 1611.72f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("J33");
		vars.debugInfo("J33");
		return true;
	}

	// {-1460.73000000, 817.10820000, 18.56550000}
	if (settings["J44"]
		&& !vars.splits.Contains("J44")
		&& ((current.Jim > 58f && current.Jim < 62f)
		&& ((current.Xcoord > -1470.73f && current.Xcoord < -1450.73f) && (current.Ycoord > 807.1f && current.Ycoord < 827.10f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("J44");
		vars.debugInfo("J44");
		return true;
	}

	// {-1110.09500000, 1317.83100000, 23.43190000} 
	if (settings["J55"]
		&& !vars.splits.Contains("J55")
		&& ((current.Jim == 80f)
		&& ((current.Xcoord > -1129.09f && current.Xcoord < -1100.09f) && (current.Ycoord > 1307.83f && current.Ycoord < 13.83f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("J55");
		vars.debugInfo("J55");
		return true;
	}

	// for all Elizabeta's missions: {362.82160000, 1504.80200000, 15.97050000}
	if (settings["E11"]
		&& !vars.splits.Contains("E11")
		&& ((current.Billy > 64f && current.Billy < 68f)
		&& ((current.Xcoord < 372.82f && current.Xcoord > 352.82f) && (current.Ycoord < 1514.8f && current.Ycoord > 1496.8f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("E11");
		vars.debugInfo("E11");
		return true; // Buyer's Market
	}
	if (settings["E22"]
		&& !vars.splits.Contains("E22")
		&& ((current.Elizabeta == 0f && current.Jim > 58f) // hit the pipe must be completed
		&& ((current.Xcoord < 372.82f && current.Xcoord > 352.82f) && (current.Ycoord < 1514.8f && current.Ycoord > 1496.8f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("E22");
		vars.debugInfo("E22");
		return true; // Heavy Toll
	}
	if (settings["E33"]
		&& !vars.splits.Contains("E33")
		&& ((current.Elizabeta > 31f && current.Elizabeta < 35f)
		&& ((current.Xcoord < 372.82f && current.Xcoord > 352.82f) && (current.Ycoord < 1514.8f && current.Ycoord > 1496.8f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("E33");
		vars.debugInfo("E33");
		return true;
	}
	if (settings["E44"]
		&& !vars.splits.Contains("E44")
		&& ((current.Elizabeta > 64f && current.Elizabeta < 68f)
		&& ((current.Xcoord < 372.82f && current.Xcoord > 352.82f) && (current.Ycoord < 1514.8f && current.Ycoord > 1496.8f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("E44");
		vars.debugInfo("E44");
		return true;
	}

	// {-35.08080000, 764.47520000, 13.71320000}
	if (settings["S11"]
		&& !vars.splits.Contains("S11")
		&& ((current.Stubbs == 0f && current.Billy < 85f) // buyer's market must be completed
		&& ((current.Xcoord > -45.08f && current.Xcoord < -25.08f) && (current.Ycoord > 754.47f && current.Ycoord < 774.47f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("S11");
		vars.debugInfo("S11");
		return true;
	}
	// {-35.08080000, 764.47520000, 13.71320000}
	if (settings["S22"]
		&& !vars.splits.Contains("S22")
		&& ((current.Stubbs > 31f && current.Stubbs < 35f)
		&& ((current.Xcoord > -45.08f && current.Xcoord < -25.08f) && (current.Ycoord > 754.47f && current.Ycoord < 774.47f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("S22");
		vars.debugInfo("S22");
		return true;
	}	

	// {-1718.45900000, 361.44560000, 24.39980000}
	if (settings["S33"]
		&& !vars.splits.Contains("S33")
		&& ((current.Stubbs > 64f && current.Stubbs < 68f)
		&& ((current.Xcoord > -1728.45f && current.Xcoord < -1708.45f) && (current.Ycoord > 351.44f && current.Ycoord < 371.44f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("S33");
		vars.debugInfo("S33");
		return true;
	}
	
	// {-1469.90200000, 490.41190000, 18.56540000}
	if (settings["A22"]
		&& !vars.splits.Contains("A22")
		&& ((current.Ashley == 50f)
		&& ((current.Xcoord > -1479.9f && current.Xcoord < -1459.9f) && (current.Ycoord > 480.41f && current.Ycoord < 500.41f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("A22");
		vars.debugInfo("A22");
		return true;
	}

	// {-123.63790000, -256.57810000, 11.68540000}
	if (settings["R11"]
		&& !vars.splits.Contains("R11")
		&& ((current.Ray == 0f && current.Jim == 100f && current.Elizabeta == 100f) // bad standing & shifting weight must be completed
		&& ((current.Xcoord > -133.63f && current.Xcoord < -113.63f) && (current.Ycoord > -266.57f && current.Ycoord < -246.57f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("R11");
		vars.debugInfo("R11");
		return true;
	}
	// {-123.63790000, -256.57810000, 11.68540000}
	if (settings["R33"]
		&& !vars.splits.Contains("R33")
		&& ((current.Ray > 64f && current.Ray < 68f)
		&& ((current.Xcoord > -133.63f && current.Xcoord < -113.63f) && (current.Ycoord > -266.57f && current.Ycoord < -246.57f))
		&& (current.MissionsAttempted == old.MissionsAttempted + 1)))
	{
		vars.splits.Add("R33");
		vars.debugInfo("R33");
		return true;
	}

	// Exceptions
	// ===============================
	// These are phonecall-activated missions which do not start from static markers like others

	// Coming Down start split
	// This mission is unlocked after finishing Politics
	// If setting is enabled
	// 		AND hasn't been split for
	// 		AND mission progress with Ashley is at less than 49% (which is at 0%, while starting Coming Down)...
	//		...alongside progress with Stubbs being at more than 31%... 
	//		...which means at least one mission with him has been finished and that would be Politics (33.34% after finishing it)
	//		AND game isn't loading (to assure there's no conflict between missions starting from static marker) 
	// 		AND current missions attempted value changes (this check assures that story mission has been started, not stuff like bike thefts etc.)
	// That means some kind of mission has been started somewhere...
	// ...and under such restricted circumstances only possible story mission to start would be Coming Down.
	if (settings["A11"]
		&& !vars.splits.Contains("A11")
		&& ((current.Ashley < 49f && current.Stubbs > 31f)
		&& (current.isLoading != 0)
		&& (current.MissionsAttempted != old.MissionsAttempted))) 
	{ 
		vars.splits.Add("A11");
		vars.debugInfo("A11");
		return true;
	}

	// Collector's Item start split
	// This mission is unlocked after finishing Diamonds In The Rough AND Roman's Holiday
	// If setting is enabled
	// 		AND mission progress with Ray is at 33.34%...
	//		...that means one mission for him has been finished and that would be Diamonds in the Rough...
	// 		...alongside progress with Ashley being 100% (all her mission finished, which includes Roman's Holiday)
	//		AND game isn't loading (to assure there's no conflict between missions starting from static marker) 
	// 		AND current missions attempted value changes (this check assures that story mission has been started, not stuff like bike thefts etc.)
	// That means some kind of mission has been started somewhere...
	// ...and under such restricted circumstances only possible story mission to start would be Collector's Item.
	if (settings["R22"]
		&& !vars.splits.Contains("R22")
		&& (((current.Ray > 31f && current.Ray < 35f) && current.Ashley == 100f)
		&& (current.isLoading != 0)
		&& (current.MissionsAttempted != old.MissionsAttempted)))
	{ 
		vars.splits.Add("R22");
		vars.debugInfo("R22");
		return true;
	}


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

	// Pre-Complete Edition only: pause the loadless timer when the game freezes while doing video editor warp
	if (vars.enabled && vars.correctEpisode && !vars.isCE && current.VideoEditor == 256) return true;

	return current.isLoading == 0;
}

gameTime {
	if (!vars.enabled) return null;

	if (!vars.correctEpisode) return null;

	if (!settings["gameTime"]) return null;

	var gt = vars.memoryWatchers["fGameTime"];
	return TimeSpan.FromMilliseconds(gt.Current);
}
