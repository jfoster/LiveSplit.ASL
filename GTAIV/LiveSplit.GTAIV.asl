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
// MenuDelay: If new game starts from title screen, it shows 400, if from an existing game/inside game menu, it shows 0.
// VideoEditor (CE only): 0 in gameplay, 256 in video editor.
// VideoEditor (pre-CE only): 0 in gameplay, 1 on save menu, 256 during vid warp freeze, 257 in menus and video editor.
// CellphoneSubmenus (pre-CE only): Different values depending on which cellphone submenu is currently open (messages, organizer etc.) Shows 1000 if phone is not pulled out.
// PickedUpFromGround: Starts from 0 and goes up +1 any time something is picked up from ground (money/weapons/healthpacks). Resets back to zero after vid warping or loading a save.
// Xcoord, Ycoord, Zcoord are player coordinates. Zcoords are commented out as there's no use for them in autosplitting.
// Character names are their respective mission progress percentage.

// current Complete Edition
state ("GTAIV", "1.2.0.59") {
	uint isLoading : 0xD747A4;
	uint whiteLoadingScreen : 0x017B37D0;
	int LastMissionName : 0xEB6FA8;
	int isCutsceneRunning : 0xE9475C;
	int MenuDelay : 0xD61520;
	int VideoEditor : 0xD60C3C;
	int PickedUpFromGround : 0x1215574;

	float Xcoord : 0x124BA70;
	float Ycoord : 0x124BA74;
	//float Zcoord : 0x124BA78;

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
	int MenuDelay : 0xD61520;
	int VideoEditor : 0xD60C3C;
	int PickedUpFromGround : 0x1215574;

	float Xcoord : 0x124BA70;
	float Ycoord : 0x124BA74;
	//float Zcoord : 0x124BA78;

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
	int MenuDelay : 0xBC40B8;
	int VideoEditor : 0xBCCDE0;
	int CellphoneSubmenus : 0x012257A8, 0x16C;
	int PickedUpFromGround : 0xE02684;

	float Xcoord : 0x10EE0D0;
	float Ycoord : 0x10EE0D4;
	//float Zcoord : 0x10EE0D8;

	float Roman : 0xC60E7C, 0x10;
	float Vlad : 0xC60E80, 0x10;
	float Jacob : 0xC60E8C, 0x10;
	float Faustin : 0xC60E90, 0x10;
	float Manny : 0xC60E94, 0x10;
	float Elizabeta : 0xC60E98, 0x10;
	float Dwayne : 0xC60EA4, 0x10;
	float Brucie : 0xC60EB0, 0x10;
	float Playboy : 0xC60EB4, 0x10;
	float Francis :0xC60EB8, 0x10;
	float ULP : 0xC60EBC, 0x10;
	float Packie : 0xC60EC8, 0x10;
	float Ray : 0xC60ECC, 0x10;
	float Gerry : 0xC60ED0, 0x10;
	float Derrick : 0xC60ED4, 0x10;
	float Bernie : 0xC60ED8, 0x10;
	float Bell : 0xC60EDC, 0x10;
	float Gravelli : 0xC60EE0, 0x10;
	float Pegorino : 0xC60EE4, 0x10;
	float Michelle : 0xC60F00, 0x10;
}

startup {
	vars.offsets = new Dictionary<string, int> {
		// newest first
		{"1.2.0.59", 0x2565A8},
		{"1.2.0.43", 0x2565A8},
		{"1.0.4.0", 0x0},
	};

	vars.stats = new Dictionary<string, int> {
		{"fGameTime", 0xC60F20},
		{"iMissionsPassed", 0xC61420},
		{"iMissionsFailed", 0xC61424},
		{"iMissionsAttempted", 0xC61428},
		{"iPigeons", 0xC615D0},
		{"iStuntJumps", 0xC61464},
		{"iMostWanted", 0xC615CC},
		{"iRacesWon", 0xC6155C},
	};

	vars.missEnd = new Dictionary<string, int> {
		{"ROM1", 3235661},
		{"ROM2", 3301197},
		{"ROM3", 3366733},
		{"ROM4", 3432269},
		{"ROM5", 3497805},
		{"ROM6", 3563341},
		{"ROM7", 3628877},
		{"ROM8", 842161997},
		{"ROM9", 3759949},
		{"ROM10", 825319245},
		{"ROM11", 842096461},
		{"ROM12", 858873677},
		{"ROM13", 875650893},
		{"FD", 909729613},
		{"VL1", 892428109},
		{"VL2", 909205325},
		{"VL3", 925982541},
		{"VL4", 942759757},
		{"LJ1", 959536973},
		{"LJ2", 808607565},
		{"FA1", 858939213},
		{"FA2", 875716429},
		{"FA3", 892493645},
		{"FA4", 909270861},
		{"BK1", 942890829},
		{"BK2", 959668045},
		{"BK3", 808738637},
		{"BK4", 825515853},
		{"BK5", 842293069},
		{"DR1", 926048077},
		{"DR2", 942825293},
		{"FM1", 926179149},
		{"FM2", 942956365},
		{"FM3", 959733581},
		{"FM4", 808804173},
		{"FM5", 825581389},
		{"FM6", 842358605},
		{"FM7", 859135821},
		{"PM1", 943021901},
		{"PM2", 959799117},
		{"PM3", 808869709},
		{"MN1", 959602509},
		{"MN2", 808673101},
		{"MN3", 825450317},
		{"EL1", 842227533},
		{"EL2", 859004749},
		{"EL3", 875781965},
		{"EL4", 892559181},
		{"DM1", 859266893},
		{"DM2", 876044109},
		{"DM3", 892821325},
		{"GM1", 926310221},
		{"GM2", 943087437},
		{"GM3", 959864653},
		{"GM4", 808935245},
		{"GM6", 825712461},
		{"GM7", 842489677},
		{"ULP1", 875913037},
		{"ULP2", 892690253},
		{"ULP3", 909467469},
		{"ULP4", 926244685},
		{"BC1", 909598541},
		{"BC2", 926375757},
		{"BC3", 943152973},
		{"GG1", 943218509},
		{"GG2", 959995725},
		{"GG3", 809066317},
		{"PX1", 892624717},
		{"PX2", 875847501},
		{"PX3", 1127231811},
		{"PX4", 909401933},
		{"DW1", 909336397},
		{"DW2", 926113613},
		{"JP1", 876109645},
		{"JP2", 892886861},
		{"JP3", 909664077},
		{"JP4", 1127494211},
		{"JP5", 926441293},
		{"PB1", 842555213},
		{"PB2", 959930189},
		{"PB3", 825777997},
		{"PB4", 859332429},
		{"RB1", 825646925},
		{"RB2", 842424141},
		{"RB3", 859201357},
		{"RB4", 875978573},
		{"RB5", 892755789},
		{"RB6", 909533005},
		{"FIN1", 1229140294},
		{"FIN4", 1179464006},
		{"FIN6", 1128549957},
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

	addSetting(null, "misc", "Miscellaneous", null, false);
		addSetting("misc", "iPigeons", "Pigeons", "Split upon extermination of any Flying Rat", false);
		addSetting("misc", "iStuntJumps", "Stunt Jumps", "Split upon completion of any Unique Stunt Jump", false);
		addSetting("misc", "iMostWanted", "Most Wanted", "Split upon neutralization of any Most Wanted target", false);
		addSetting("misc", "iRacesWon", "Races End", "Split upon winning any Brucie's race", false);
		addSetting("misc", "iSweatshirt", "Sweatshirt", "Split upon collecting Sweatshirt on Happiness Island", false);

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

	// While loading the game from title screen
	// allow the timer to start only upon starting new game
	// and prevent start from firing while loading into a save.
	// It is done by checking if user has any game saves in savefile directories.

	bool noSaves = true; // by default always assume to start the timer
	string dnn = null;
	string stt = null;

	// Scenario 1
	// the savegames location path is dynamic - it varies between different users (different account ID) 
	// so first check the path only up to \Profiles and then find the folder with ID and navigate to it
	if (vars.version.ToString() == "1.2.0.59")
	{
		dnn = Environment.ExpandEnvironmentVariables(@"%USERPROFILE%\Documents\Rockstar Games\GTA IV\Profiles"); // after \Profiles there's a folder named after account ID
		// check if saves directory exist
		if (Directory.Exists(dnn))
		{
			string IDName = null;  // to store the name of the folder containing the account ID
			int folderCount = 0;
			// check the amount of folders that exist in said path
			foreach (var dir in Directory.EnumerateDirectories(dnn))
			{
				folderCount++;

				if (folderCount == 1)
				{
					// extract the folder name containing the account ID
					IDName = Path.GetFileName(dir);
				
					// now that account ID is known, combine it into a full path that contains game saves
					string fulldnn = Path.Combine(dnn, IDName);
					//vars.debugInfo(fulldnn); // print full path
				
					// check if any file starting with 'SGTA4' exist inside savegames directory
					foreach (var file in Directory.EnumerateFiles(fulldnn, "SGTA4*"))
					{
						// if there are no files starting with SGTA4*
						// that means upon launching from title screen user will start the new game
						// so the timer MUST start
						if (file == null)
						{
							noSaves = true;
						}
						// directory isn't empty AND game isn't starting from existing savefile
						// that means user is loading the game into a save, AND is doing it from title screen, so do NOT let the timer start
						else if (file != null && current.MenuDelay != 0)
						{
							noSaves = false;
						}
					}
				}
				// directory is empty or contains more than two folders
				// so assume default behavior and allow timer to start
				else if (folderCount == 0 || folderCount >= 2)
				{
					noSaves = true;
				}
			}
		}
		// directory doesn't exist, so assume the default behavior and allow the timer to start
		else
		{
			noSaves = true;
		}
	}
	// Scenario 2
	// the savegames location path is static - is always the same for any user (while using xliveless)
	if (vars.version.ToString() == "1.0.4.0")
	{
		stt = Environment.ExpandEnvironmentVariables(@"%USERPROFILE%\Documents\Rockstar Games\GTA IV\savegames");
		// check if saves directory exist
		if (Directory.Exists(stt))
		{
			// check if any file starting with 'SGTA4' exist inside savegames directory
			foreach (var file in Directory.EnumerateFiles(stt, "SGTA4*"))
			{
				// if there are no files starting with SGTA4*
				// that means upon launching from title screen user will start the new game
				// so the timer MUST start
				if (file == null)
				{
					noSaves = true;
				}
				// directory isn't empty AND game isn't starting from existing savefile
				// that means user is loading the game into a save, AND is doing it from title screen, so do NOT let the timer start
				else if (file != null && current.MenuDelay != 0)
				{
					noSaves = false;
				}
			}
		}
		// directory doesn't exist, so assume the default behavior and allow the timer to start
		else
		{
			noSaves = true;
		}
	}

	// Timer ResetStart
	if (startCheck && timerCheck && missionCheck && vars.correctEpisode && noSaves) {
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

	if (vars.queueSplit) {
		var mw = vars.memoryWatchers["iMissionsAttempted"];
		if (mw.Current == mw.Old + 1) {
			return true;
		}
	}

	// =====================================================================
	// Split on Mission End
	// =====================================================================

	foreach (var mse in vars.missEnd) {
		var k = mse.Key;
		var v = mse.Value;
		var rt = timer.CurrentTime.RealTime.GetValueOrDefault().TotalSeconds;

		if (
			// check if setting is enabled
			settings.ContainsKey(k) && settings[k] 
			
			// AND hasn't been split for
			&& !vars.splits.Contains(k)
			
			// AND last finished mission changes
			&& current.LastMissionName == v && old.LastMissionName != v
			
			// AND timer is running for more than 1 second (to prevent split right after timer start)
			&& rt >= 1.0
			
			// AND missions attempted value remains unchanged (to prevent split upon loading a savefile)
			&& vars.memoryWatchers["iMissionsAttempted"].Current == vars.memoryWatchers["iMissionsAttempted"].Old
			)
		{
			vars.splits.Add(k); // add split to hashset, as it has been split for
			vars.debugInfo((k));
			return true; // do split
		}
	}

	// Exceptions
	// =====================================

	// Deal or Revenge - both missions are associated with one setting
	if (settings["FIN2"]
		&& !vars.splits.Contains("FIN2")
		&& ((current.LastMissionName == 825843533 && old.LastMissionName != 825843533 && vars.memoryWatchers["iMissionsAttempted"].Current == vars.memoryWatchers["iMissionsAttempted"].Old) 
		|| (current.LastMissionName == 842620749 && old.LastMissionName != 842620749 && vars.memoryWatchers["iMissionsAttempted"].Current == vars.memoryWatchers["iMissionsAttempted"].Old)))
	{
		vars.splits.Add("FIN2");
		vars.debugInfo("FIN2");
		return true;
	}

	// Mr. & Mrs. Bellic - this mission doesn't have LastMissionName value and character percentage doesn't increase
	// so check if either of FIN2 values are unchanged, but mission passed value increases
	var mp = vars.memoryWatchers["iMissionsPassed"];
	if (settings["FIN3"] 
		&& !vars.splits.Contains("FIN3")
		&& (((current.LastMissionName == 825843533 && old.LastMissionName == 825843533) && (mp.Current == mp.Old + 1)) 
		|| ((current.LastMissionName == 842620749 && old.LastMissionName == 842620749) && (mp.Current == mp.Old + 1))))
	{
		vars.splits.Add("FIN3");
		vars.debugInfo("FIN3");
		return true;
	}

	// Any% / Classic Final Split - first frame of last cutscene at the end of 'A Revenger's Tragedy' or 'Out of Commission'
	// If setting is enabled AND hasn't been split for AND In Mourning is finished AND cinematic cutscene starts playing
	// That means player completed the game a.k.a. finished any% / classic speedrun
	// It works, because after finishing In Mourning there's no other possible cutscene to play besides the final one
	if (settings["FIN5"] && !vars.splits.Contains("FIN5") && (current.LastMissionName == 1179464006 && current.isCutsceneRunning == 8 && old.isCutsceneRunning != 8))
	{
		vars.splits.Add("FIN5");
		vars.debugInfo("FIN5 - Any% Final Split");
		return true;
	}


	// =======================================================================
	// Miscellaneous stuff to split on
	// =======================================================================

	// happiness island sweatshirt
	// check if player has picked something up at specified location
	if (settings["iSweatshirt"] 
		&& !vars.splits.Contains("iSweatshirt")
		&& ((current.PickedUpFromGround == old.PickedUpFromGround + 1) 
		&& ((current.Xcoord > -609.34f && current.Xcoord < -606.69f) && (current.Ycoord > -769.11f && current.Ycoord < -767.08f))))
	{
		vars.splits.Add("iSweatshirt");
		vars.debugInfo("iSweatshirt");
		return true;
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
				} else if (settings["iPigeons"] || settings["iStuntJumps"] || settings["iMostWanted"] || settings["iRacesWon"]) {
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

	// Pre-Complete Edition only: pause the loadless timer when the game freezes while doing video editor warp
	if (vars.enabled && vars.correctEpisode && !vars.isCE && current.VideoEditor == 256) return true;

	// Pre-Complete Edition only: loadless timer must continue to run during certain loading screens in multiplayer-related scenarios.
	if (vars.enabled && vars.correctEpisode && !vars.isCE) {
		// Opening and closing player model menu. 1047 is a value for whole multiplayer cellphone submenu.
		if (current.CellphoneSubmenus == 1047) {
			return false;
		}
		// "Disconnected from game session" screen (entering LAN lobby)
		if ((current.Xcoord > -2001f && current.Xcoord < -1998f) && (current.Ycoord > -2001f && current.Ycoord < -1998f)) {
			return false;
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
