package;

class References
{
    public static var legacyWarpSongs:Array<Array<String>> = [
            // Name, song name
            ['World 2\n(I HATE YOU)', 'i-hate-you'],
            ['World 3\n(All Stars)', 'all-stars'],
            ['World 4\n(Starman Slaughter)', 'starman-slaughter'],
            ['World 5\n(Overdue)', 'overdue'],
            ['World 6\n(Day Out)', 'day-out'],
        ];

    static var descTxt:Array<String> = [
        'This is a placeholder desc!',
        'This is placeholder credits!'
    ];

    /**
     * Moreso to make it easier to include
     * @param forceGrab whether to force it to show the secret song.
     * @return `Array<Array<String>>`
     */
    public static function getLegacyWarpSongs(forceGrab:Bool):Array<Array<String>>
    {
        var tempArray:Array<String> = ClientPrefs.firstSecretView ? ['World ?\n(???)', 'nourishing-blood'] : ['World Secret\n(Nourishing Blood)', 'nourishing-blood']; // to be replaced by an actual song lmao.
        if (ClientPrefs.unlockedSecretSong || forceGrab) legacyWarpSongs.push(tempArray);
        return legacyWarpSongs;
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
            trace('First Pass Fail! Reloading from Paths.txt(songData/$combinedString)');
            descTxt = CoolUtil.coolTextFile(Paths.txt('songData/$combinedString'));
            //trace('descTxt from Paths.txt(songData/$combinedString): $descTxt');
            compareArray = Std.string(descTxt);
            if (compareArray == '[]') {
                trace('Failed to load a desc.txt! check that "assets/data/songData/$combinedString.txt" exists!');
                descTxt = ['Failed to load a description :/\ngot "null" from "assets/data/songData/$combinedString.txt"', 'Failed to load credits :/'];
            }
        }
        return descTxt;
    }
}