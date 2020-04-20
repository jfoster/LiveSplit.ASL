LiveSplit Autosplitter for GTA IV + EFLC
===

## Games For Windows Live is NOT supported, make sure to follow the [prerequisites](#Prerequisites).

## Prerequisites

1. Listener's XLiveless - place xlive.dll alongside the game .exe within the game directory. [[download]](https://gtaforums.com/topic/388658-relgtaiv-xliveless/) [[mirror]](https://github.com/jfoster/xliveless/releases)
2. Deletion of paul.dll - found alongside the game .exe within the game directory

## Supported Versions

<table>
<tr><th>GTAIV.exe</th><th>EFLC.exe</th></tr>
<tr><td>

| Version  |                  Notes                   | Supported? |
| :------: | :--------------------------------------: | :--------: |
| 1.2.0.32 | Complete Edition (Current Steam Release) |    Yes     |
| 1.0.8.0  |                 Patch 8                  |    Yes     |
| 1.0.7.0  |                 Patch 7                  |    Yes     |
| 1.0.6.0  |                 Patch 6                  |    Yes     |
| 1.0.0.4  |                 Patch 5                  |    Yes     |
| 1.0.4.0  |                 Patch 4                  |    Yes     |
| 1.0.3.0  |                 Patch 3                  |     No     |
| 1.0.2.0  |                 Patch 2                  |     No     |
| 1.0.1.0  |                 Patch 1                  |     No     |
| 1.0.0.0  |              Retail Release              |     No     |

</td><td>

| Version  |                             Notes                             | Supported? |
| :------: | :-----------------------------------------------------------: | :--------: |
| 1.2.0.32 | Complete Edition (bundled with GTA IV, Current Steam Release) |    Yes     |
| 1.1.3.0  |                            Patch 3                            |    Yes     |
| 1.1.2.0  |                            Patch 2                            |    Yes     |
| 1.1.1.0  |                            Patch 1                            |     No     |
| 1.1.0.0  |                        Retail Release                         |     No     |

</td></tr></table>

<!-- ## Download

Click the "Download Zip" button to download this repository, including autosplitter script, as a .zip file. Use your favourite unarchive utility to unzip the .zip file. -->

## Installation

<!-- Add a Scriptable Auto Splitter component to your Layout.
Right-click on LiveSplit and choose "Edit Layout..." to open the Layout Editor, then click on the Plus-sign and choose "Scriptable Auto Splitter" from the section "Control". You can set the Path of the Script by going into the component settings of the Scriptable Auto Splitter. To get to the settings of the component you can either double click it in the Layout Editor or go into to the Scriptable Auto Splitter Tab of the Layout Settings. Once you've set the Path, the script should automatically load and work. -->

Create or open existing splits and Activate the autosplitter within livesplit, click the settings button to customise the autosplitter for the desired category.

## Quirks/Bugs

Currently there is no logic to autosplit the final split correctly, meaning the final split will occur only when the mission is passed, remember to manually split in the correct place respective of each game's rules! TODO: fix this.

In IV, The wedding is split into two missions (the wedding cinematic cutscene, and the in-game niko waking up from the bed cutscene) this means the autosplitter will split on completion of each respective mission pass, remember to create splits for each! TODO: maybe fix this, but I'd hate to deprive everyone of In Mourning community golds.

## Support

@Rave#7710 on discord.

## License

[MIT](../LICENSE.txt)