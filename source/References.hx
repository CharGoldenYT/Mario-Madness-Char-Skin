package;

class References
{
    public static var WarpWorlds:Array<String> = [
        'World 2\n(Abandoned)',
        'World 3\n(Last Course)',
        'World 4\n(Dictator)',
        'World 5\n(Race Traitors)',
        'World 6\n(Day Out)',
        'World 7\n(Nourishing Blood)',
        'World ?\n(???)',// ALWAYS MAKE THIS THE LAST ONE.
    ];
    
    public static var WarpSongs:Array<String> = [
        'abandoned',
        'last-course',
        'dictator',
        'racetraitors',
        'day-out',
        'nourishing-blood' // to be replaced by an actual song lmao.
    ];

    static var descTxt:Array<String> = [
        'This is a placeholder desc!',
        'This is placeholder credits!'
    ];

    public static function checkSecretSaveFlags(?isPlayState:Bool = false, ?intUsed:Int = 0, ?forceReset:Bool = false, ?forceTrue:Bool = false) {
        var seen = ClientPrefs.secretSeen;
        var save = ClientPrefs.secretSave;

        trace('seen flag array length = "' + seen.length + '"');
        trace('save flag array length = "' + save.length + '"');
        var traceMsg:String = isPlayState ? 'length too big from PlayState! ReSaving with only the first 5 Bools! int it saved to: $intUsed' : 'length too big! ReSaving with only the first 5 Bools!';
        if (!forceReset){
        if (save.length > 6) {
            trace('save ' + traceMsg);
            var tempArray:Array<Bool> = [save[0], save[1], save[2], save[3], save[4], save[5]];
            ClientPrefs.secretSave = tempArray;
            ClientPrefs.saveSettings();
        }
        if (seen.length > 6) {
            trace('seen ' + traceMsg);
            var tempArray:Array<Bool> = [seen[0], seen[1], seen[2], seen[3], seen[4], seen[5]];
            ClientPrefs.secretSeen = tempArray;
            ClientPrefs.saveSettings();
        }
        } else {
            trace('Forcing all values to $forceTrue');
            var array:Array<Bool> = [forceTrue, forceTrue, forceTrue, forceTrue, forceTrue, forceTrue];
            ClientPrefs.secretSave = array;
            ClientPrefs.secretSeen = array;
            ClientPrefs.saveSettings();
        }
    }

    /**
     * Moreso to make it easier to include
     * @param forceGrab whether to force it to show the secret song.
     * @return `Array<Array<String>>`
     */
    public static function getLegacyWarpSongs(?forceGrab:Bool = false):Array<Array<String>>
    {
        var finalArray:Array<Array<String>> = [];

        if (ClientPrefs.secretSave[5] == true || forceGrab) {
                finalArray = [
            [viewStatus(0), WarpSongs[0]],
            [viewStatus(1), WarpSongs[1]],
            [viewStatus(2), WarpSongs[2]],
            [viewStatus(3), WarpSongs[3]],
            [viewStatus(4), WarpSongs[4]],
            [viewStatus(5), WarpSongs[5]],
        ];
        } else {
            finalArray = [
                [viewStatus(0), WarpSongs[0]],
                [viewStatus(1), WarpSongs[1]],
                [viewStatus(2), WarpSongs[2]],
                [viewStatus(3), WarpSongs[3]],
                [viewStatus(4), WarpSongs[4]],
            ];
        }
        trace('"return $finalArray"');
        return finalArray;
    }

    static function viewStatus(num:Int) {
        var hasSeen:Bool = ClientPrefs.secretSeen[num];
        var int:Int = WarpWorlds.length - 1;
        //trace('The int is:$int');
        if (hasSeen) return WarpWorlds[num]; else return WarpWorlds[int];
    }

    /**
     * Legacy Warp State Breaks shit lmao
     * @param song the song to look up credits for.
     */
    public static function legacyWarpWorkaround(song:String, ?num:Int = null):Array<String> {
        var finalNum:String = '';
        if (num != null) finalNum = Std.string(num);
        var combinedString:String = song + '/desc$finalNum';
        descTxt = CoolUtil.coolTextFile(Paths.txt('data/songData/$combinedString'));
        var compareArray:String = Std.string(descTxt);
        if (compareArray == '[]') {
            //trace('First Pass Fail! Reloading from Paths.txt(songData/$combinedString)');
            descTxt = CoolUtil.coolTextFile(Paths.txt('songData/$combinedString'));
            //trace('descTxt from Paths.txt(songData/$combinedString): $descTxt');
            compareArray = Std.string(descTxt);
            if (compareArray == '[]') {
                //trace('Failed to load a desc.txt! check that "assets/data/songData/$combinedString.txt" exists!');
                descTxt = ['Failed to load a description :/\ngot "null" from "assets/data/songData/$combinedString.txt"', 'Failed to load credits :/'];
            }
        }
        return descTxt;
    }
}