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


    // im not letting these damn notes go to waste.
    public static var funnyNotes:String = 
"       * -- THESE NOTES COME FROM BEFORE I FIX ANY ISSUES BTW --
        *
        * -- Section 1 | General Notes about sticky-ing the notes to BF. --
        * So Cool Note 1: The visible area is less then desirable.
        * 
        * All Stars Note 1: The GX Section HAS to force disable sticky strum due to being slightly to completely offscreen during the reveal part, and near the end of the lyrical part.
        * All Stars Note 2: The Notes should generally be moved further Left for Act 4's Beginning.
        * All Stars Note 3: The part before the splitscreen section between ultra M and BF during Act 4 makes the notes a slight bit too far to the Left.
        * All Stars Note 4: The splitscreen section between ultra M and BF during Act 4 makes the notes veer too far away from BF.
        * All Stars Note 5: Might as well unsticky the notes during the final section due to the fact that its the same zoom, and the position basically lines up anyway.
        * All Stars Note 6: The notes stay on screen durinng the \"Game Over\" Section. implementing the fix from note 5 will probably fix this.
        * 
        * Apparition/Apparition (Legacy)/Forbidden Star Note 1: Damn this works perfectly, it genuinely shoulda been like this from the beginning! Reccomendation to get the opponent notes the fuck outta there or sized down though, 
        * right arrow can obscure left player arrow
        * 
        * Last Course Note 1: WARN PEOPLE THAT IT'LL BE PARTIALLY OBSCURED IN CERTAIN SECTIONS, BUT STILL PERFECTLY PLAYABLE.
        * 
        * Golden Land Note 1: The notes are too far to the right, changing this would ensure the chart remains playable lmao (With a small hitch of near the end being a little obscured.).
        * 
        * Oh God No Note 1: When fixded, the second song in chronological order to be perfectly playable.
        * 
        * Paranoia Note 1: HUD THAT SHIT WHEN THE DUPLICATING SCREEN THING HAPPENS.
        * 
        * Overdue Note 1: PERFECT. PEAKVERDUE.
        * 
        * Powerdown Note 1: HUD The beginning. like the VERY beginning. also the transition to the flagpole. also also slightly before the FUCKING LINE cutscene. just a precaution.
        * 
        * Demise Note 1: PERFECT. MAKE THE OPPONENT STRUMS GTFO AND ITS EXTRA PERFECT. also the transition to underground hides the notes, fix that lmao. also also the notes need to freeze for a second when GF picks up BF because its still setting its X based on the running ver lmao.
        * 
        * Time Out (Demise OG) Note 1: PERFECT. Same as Demise, but instead just the blank out part since theres no transition in this song.
        * 
        * Promotion Note 1: PERFECT. is what i would say if halfway through i didn't have to make the Notes part of the HUD again because it might as well have not moved at all.
        * 
        * The End Note 1: camHUD/Alpha = 0/Visible = false the notes at the beginning cutscene, they show when they arent supposed to, but besides that, Mostly Perfect. Requires making the notes to be on HUD again just before the \"Let's a go!\" part. and just before the \"WAHOOO\" (deja vu) part but this time kept like that.
        * 
        * Powerdown (Legacy) | Ironically besides slight memorization of the right note. mostly playable without needing to put the notes on HUD need to test further in case of any cutscenes.
        * 
        * All Stars Act 1 (Legacy) | HUD the beginning cutscene, rest is fine.
        * 
        * Generic Note 1: Some note effects seem to fucking break with how this is set up (e.g. Making Strum note invisible), FIX IT.
        * 
        * Generic Note 2: The notes tend to still be a smidgen off center most of the time.
        * 
        *  -- Section 2 | What about other songs? (Great track record huh? All of these will come with a warning that its not supported but can still be played like it is.)--
        * starman-slaughter | Right note is offscreen multiple times during opponent turns, requiring memorization to hit, can be fixed with making notes HUD but it happens so often, it might as well not change.
        * 
        * i-hate-you | Right Note is offscreen too long during the ending due to the back and forth. would otherwise be playable however can be fixed with making the notes HUD.
        * 
        * dark-forest | Hard to hit due to reduced visibility of the future notes. also impossible to play halfway through due to camera fucking up the oncoming notes, though this can probably be fixed by forcing the notes to be on the 
        * 
        * HUD again during this part due to the fact it works a little after the start of the 3rd part.
        * 
        * nourishing-blood | Hard to hit certain sections due to being off screen
        * 
        * alone | Theres a few sections thats hard to hit without memorization if Ghost BF drifts to the Right too far as well as the end of BF's part of the song.
        * 
        * thalassophobia | Partway in, you can't see your notes due to camera, requires memorization unless fixed with making the notes HUD shortly beforehand.
        * 
        * no-hope | While it is fucking hilarious that for a song called \"No Hope\" the notes are basically always offscreen when focusing on mario, you need to memorize the chart in order to play this with stickied notes.
        * 
        * golden-land-old | Too zoomed in, mostly playable but requires a bit of memorization.
        * 
        * i-hate-you-old | Ironically same issue as i-hate-you but worse.
        * 
        * alone-old | Right hold notes go offscreen due to opponent camera. requires some memorization.
        * 
        * PEAKVERDUE (overdue-old) | DAMNIT YOU WERE SUPPOSED TO BE PEAKVERDUE. It requires slight memorization of the Right note for anytime the opponent camera is used in the beginning. :pensive:
        * 
        *  -- Section 3 | Outright banned songs --
        * bad-day | The hud is actively messed with in this song, and it ends up doing basically nothing besides losing healthbar for a moment. it actually REMOVES difficulty.
        * 
        * (TO BE FIXED) oh-god-no | Literally unplayable, BotPlay literally cant hit the notes. Once i get note hit detection working, its good to go.
        * 
        * day-out | Luigi sings in this one, but due to how stickied notes work it wont properly move to luigi, thus obscuring the notes. fixable though.
        * 
        * dictator/dictator-old | Botplay cant even hit the damn Bullet Bill, its completely broken. and also the beginning is off screen anyway so its extremely hard to hit without memorization ans its offscreen in general when the camera is on the opponent.
        * 
        * racetraitors/racetraitors-old | Notes are constantly off screen during opponent turn, also its too close to its original position so it doesnt make sense to sticky them here, would rather just make the notes move side to side on the HUD layer.
        * 
        * unbeatable | Just doesn't make sense honestly. iirc some or all of this song uses forced middlescroll anyway. also it stays in the top-left corner, which gets confusing FAST.
        * 
        * no-party/no-party-old | Window's too small, goes entirely off screen. also it would break the layout anyway its meant to look like Bottom Screen then Top Screen.
        * 
        * mario-sing-and-game-rhythm-9 | Notes are too big, you can only see Left and Down.
        * 
        * abandoned | Zooms in too far during opponent turn. Requires Memorization/Making notes HUD, but it happens so frequently its not worth it.
        * 
        * its-a-me-old | Too zoomed in, camera goes too far on opponent turn.
        *";

    /*
     * BASICALLY Sticking the notes to the player can sometimes cause the damn notes to be entirely off screen, requiring complete timing mastery and total memorization of the chart to FC
     * so my fix is to look at every song and see if it looks alright, and if it is, it goes here.
     */
    public static var allowedStickySongs:Array<String> = [
        'its-a-me', // ★★★★★
        'so-cool', // ★★★★☆
        'oh-god-no', // Unfixed: ☆☆☆☆☆ Fixed: ★★★★★
        'all-stars', // ★★☆☆☆
        'apparition', // ★★★★★
        'last-course', //* ★★★★☆
        'golden-land', // Unfixed: ★★★★☆ // Fixed: ★★★★★
        'paranoia', // UnFixed: ★★★☆☆ // Fixed: ★★★★☆
        'overdue', // ★★★★★
        'powerdown', // ★★★★ 1.5/4
        'demise', // ★★★★★
        'promotion', // ★★★★☆
        'apparition-old', // ★★★★★
        'forbidden-star', // ★★★★★
        'time-out', // ★★★★★
        'all-stars-old', // ★★★★★
        'i-hate-you',
        'dark-forest',
        'the-end'
    ];

    /**
     * See Above for reasons
     */
    public static var forbiddenStickySongs:Array<String> = [
        'bad-day',
        'day-out',
        'dictator',
        'dictator-old',
        'no-party',
        'no-party-old',
        'racetraitors',
        'racetraitors-old',
        'unbeatable',
        'mario-sing-and-game-rhythm-9',
        'abandoned',
        'its-a-me-old',
        'i-hate-you',
        'nourishing-blood',
        'alone',
        'thalassophobia',
        'no-hope',
        'golden-land-old',
        'i-hate-you-old',
        'alone-old',
        'overdue-old',
        'powerdown-old',
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