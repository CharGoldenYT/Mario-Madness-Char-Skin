package;

import flixel.sound.FlxSound;
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import lime.app.Application;
import flixel.input.keyboard.FlxKey;

using StringTools;

class WarpStateLegacy extends MusicBeatState //I WANNA SEE LEMME SEE
{
	var tween:FlxTween;
	var tween2:FlxTween;
	public static var curSelected:Int = 0;
	public static var selectedModifier:Int = 0;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	public static var canciones:Array<Dynamic> = [];

	var bg:FlxSprite;
	var pibemapa:FlxSprite;
	var warpPipe:FlxSprite;
	var cartel:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var msg:FlxText;
	var instPlaying:Bool = false;
	var unlockedSecret:Bool = false;
	public static var instance:WarpStateLegacy;
	override function create()
	{
		instance = this;
		References.checkSecretSaveFlags();
		doSaveCheck();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the (legacy) Warp Zone - Char Skin for Mario's Madness", null);
		#end
		FlxG.sound.playMusic(Paths.music('warpzone/0'), 0.7);

		openfl.Lib.application.window.title = 'Friday Night Funkin\': Mario\'s Madness | WELCOME TO WARP ZONE! (Warp State Legacy)';

		bg = new FlxSprite(800, 250).loadGraphic(Paths.image('warpworld/warpmap'));
		bg.setGraphicSize(Std.int(bg.width * 5));
		bg.antialiasing = false;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...canciones.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, canciones[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if (isSelectable)
			{
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			// optionText.yMult = 90;
			optionText.targetY = i;
			// grpOptions.add(optionText);
		}

		cartel = new FlxSprite(570, 620).loadGraphic(Paths.image('warpworld/textwarp'));
		cartel.setGraphicSize(Std.int(cartel.width * 5));
		cartel.antialiasing = false;
		add(cartel);

		descText = new FlxText(50, 590, 1180, "", 32);
		descText.setFormat(Paths.font("mario2.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 4.4;
		add(descText);

		warpPipe = new FlxSprite(1076, 311).loadGraphic('mods/images/warpworld/warpPipe.png');
		warpPipe.setGraphicSize(Std.int(warpPipe.width * 5));
		warpPipe.antialiasing = false;
		warpPipe.updateHitbox();
		warpPipe.alpha = !ClientPrefs.secretSave[5] ? 0 : 1;
		add(warpPipe);

		pibemapa = new FlxSprite(347, 316);
		pibemapa.frames = Paths.getSparrowAtlas('warpworld/mariomap');
		pibemapa.animation.addByPrefix('idle', "mario pose", 4);
		pibemapa.animation.play('idle');
		pibemapa.setGraphicSize(Std.int(pibemapa.width * 5));
		pibemapa.antialiasing = false;
		pibemapa.updateHitbox();
		add(pibemapa);

		msg = new FlxText(0, 0, 1180, "WARNING:\nThis is still an early rewrite of the legacy Warp Zone.\nExpect these songs to change!", 16);
		msg.setFormat(Paths.font("mario2.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		msg.scrollFactor.set();
		msg.borderSize = 2.2;
		add(msg);

		changeSelection();
		if (curSelected != selectedModifier) curSelected = selectedModifier;
		if (curSelected >= canciones.length)
			curSelected = canciones.length - 1;
		caminar(); // double make sure bro goes to the right area lmao
		super.create();
	}

	public function new (?curSelectedModifier:Int = 0) {
		super();
		curSelected = curSelectedModifier;
		selectedModifier = curSelectedModifier;
	}

	var doReset:Bool = false;
	var weirdSave:Bool = false;
	/**
	 * Basically this does several checks
	 * It checks if the first save in secretSave is false, and if so will make it true because you literally cant access any songs without it, and reset state |                                             
	 * then if any song has the seen flag set, but the next song's flag isnt set, set it and reset state. |                                         
	 * if ANY song's flag is set that shouldn't be, set it to default and reset
	 */
	function doSaveCheck() {
		var secretSeen = ClientPrefs.secretSeen;
		var secretSave = ClientPrefs.secretSave;
		trace('Cur Save: "$secretSave" | Cur Seen: "$secretSeen"');
		for (i in 0...5) {
			var truePos:Int = i + 1;
			trace('TruePos: $truePos');
			if (secretSeen[i] == false && secretSave[truePos] == true) {
				trace('secretSeen[$i] is false, but secretSave[$truePos] is true???');
				 ClientPrefs.secretSave[truePos] = false;
				 weirdSave = true;
				 }
			if (secretSeen[i] == false && secretSeen[truePos] == true) {
				trace('secretSeen[$i] is false, but secretSeen[$truePos] is true???'); 
				ClientPrefs.secretSeen[truePos] = false;
				weirdSave = true;
				}
		}
		if (weirdSave) doReset = true;
		if (ClientPrefs.secretSave[0] == false) {
			ClientPrefs.secretSave[0] = true; 
			ClientPrefs.saveSettings();
			doReset = true;
			}

		if (ClientPrefs.secretSeen[0] == true) {
			if (ClientPrefs.secretSave[1] == false) {
				ClientPrefs.secretSave[1] = true; 
				ClientPrefs.saveSettings();
				doReset = true;
				}

			if (ClientPrefs.secretSeen[1] == true) {
				if (ClientPrefs.secretSave[2] == false) {
					ClientPrefs.secretSave[2] = true; 
					ClientPrefs.saveSettings();
					doReset = true;
					}
				
				if (ClientPrefs.secretSeen[2] == true){
					if (ClientPrefs.secretSave[3] == false) {
						ClientPrefs.secretSave[3] = true; 
						ClientPrefs.saveSettings();
						doReset = true;
						}

					if (ClientPrefs.secretSeen[3] == true){
						if (ClientPrefs.secretSave[4] == false) {
							ClientPrefs.secretSave[4] = true; 
							ClientPrefs.saveSettings();
							doReset = true;
							}

						if (ClientPrefs.secretSeen[4] == true) {
							if (ClientPrefs.secretSave[5] == false){
									ClientPrefs.secretSave[5] = true;
									ClientPrefs.saveSettings();
									doReset = true;
							}
						} 
					}
				}
			} 
		}
		canciones = References.getLegacyWarpSongs();
	}

	var quieto:Bool = false;
	var isDebugMode:Bool = false;
	var initialized:Bool = false;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_LEFT_P;
		var downP = controls.UI_RIGHT_P;
		var debugKey = FlxG.keys.justPressed.F10;

		if (doReset && initialized) FlxG.resetState();

		if (!quieto && !isDebugMode)
		{
			if (upP)
			{
				changeSelection(-1);
				caminar();
				quieto = true;
			}
			if (downP)
			{
				changeSelection(1);
				caminar();
				quieto = true;
			}
			if (controls.ACCEPT && !FlxG.keys.justPressed.SPACE)
			{
				if (ClientPrefs.secretSave[curSelected] == false) {
					FlxG.sound.play(Paths.sound('wrong'));
					return;
				} else {
				if (instPlaying){
					FlxG.sound.playMusic(Paths.music('warpzone/0'), 0.7);
					instPlaying = false;
				}
				quieto = true;
				PlayState.isLegacyWarp = true;
				FlxG.sound.play(Paths.sound('gotolevel'));
				PlayState.SONG = Song.loadFromJson(canciones[curSelected][1], canciones[curSelected][1]);
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				new FlxTimer().start(0.55, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
					FlxG.sound.music.volume = 0;
					//FreeplayState.destroyFreeplayVocals();
				});
				}
			}
			if (FlxG.keys.justPressed.SPACE)
			{
				if (canciones[curSelected][0] != 'World ?\n(???)') {
					var song:String = canciones[curSelected][1];
					FlxG.sound.playMusic(Paths.inst(song));
					instPlaying = true;
				} else {
					FlxG.sound.play(Paths.sound('wrong'));
				}
			}
			if (debugKey) {
				isDebugMode = !isDebugMode;
				trace('ACTIVATED DEBUG MODE!!!');
				FlxG.sound.playMusic(Paths.music('test'), 0.7);
			}
		}
		else if (isDebugMode)
		{
			if (upP)
			{
				warpPipe.y -= 1;
				trace('New Y: ' + warpPipe.y);
			}
			if (downP)
			{
				warpPipe.y += 1;
				trace('New Y: ' + warpPipe.y);
			}
			if (debugKey) {
				isDebugMode = !isDebugMode;
				trace('DEACTIVATED DEBUG MODE!!!');
				FlxG.sound.playMusic(Paths.music('warpzone/0'), 0.7);
			}
			if (FlxG.keys.justPressed.F9)
			{
				trace('RESETTING SECRET SAVE');
				for (i in 0...ClientPrefs.secretSeen.length){
					ClientPrefs.secretSeen[i] = false;
				}
				for (i in 0...ClientPrefs.secretSave.length){
					ClientPrefs.secretSave[i] = false;
				}
				ClientPrefs.saveSettings();
				FlxG.resetState();
			}
			if (FlxG.keys.justPressed.F2)
			{
				trace('SETTING SECRET SAVE/SEEN TO ALL TRUE');
				for (i in 0...ClientPrefs.secretSave.length){
					ClientPrefs.secretSave[i] = true;
				}
				for (i in 0...ClientPrefs.secretSeen.length){
					ClientPrefs.secretSeen[i] = true;
				}
				Application.current.window.alert("Set Secret Save to 100%!", 'CHEATER!');
				ClientPrefs.saveSettings();
				FlxG.resetState();
			}

			var justPressedArray:Array<Bool> = [FlxG.keys.justPressed.ONE, FlxG.keys.justPressed.TWO, FlxG.keys.justPressed.THREE, FlxG.keys.justPressed.FOUR, FlxG.keys.justPressed.FIVE, FlxG.keys.justPressed.SIX];
			for (i in 0...justPressedArray.length) {
				if (justPressedArray[i] == true) {
					ClientPrefs.setSecretSave(i, !ClientPrefs.secretSave[i]);
					FlxG.resetState();
				}
			}
		}

		if (controls.BACK)
		{
			if (colorTween != null)
			{
				colorTween.cancel();
			}
			PlayState.isWarp = false;
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MainMenuState.canselectshit = true;// Menu Breaks if i dont set this??????
			MusicBeatState.switchState(new MainMenuState());
		}
		if (FlxG.keys.justPressed.RBRACKET) {
			trace('Secret Save: ' + ClientPrefs.secretSave);
			trace('Secret Seen: ' + ClientPrefs.secretSeen);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		do
		{
			curSelected += change;
		if (initialized && 
			curSelected != -1 && 
			curSelected != (canciones.length)) FlxG.sound.play(Paths.sound('bros3pass'), 1); // LO QUE HACE EL JUEGO ES MANDARTE AL I HATE YOU SI LO PONES EN 0, TEN EN CUENTA ESTO
			if (curSelected < 0)
				curSelected = 0;
			if (curSelected >= canciones.length)
				curSelected = canciones.length - 1;
		}
		while (unselectableCheck(curSelected));

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (!unselectableCheck(bullShit - 1))
			{
				item.alpha = 0.6;
				if (item.targetY == 0)
				{
					item.alpha = 1;
				}
			}
		}
		descText.text = canciones[curSelected][0];
		//trace(curSelected);
	}

	private function unselectableCheck(num:Int):Bool
	{
		return canciones[num].length <= 0;
	}

	private function caminar()
	{
		switch (curSelected)
		{
			case 0:
				tween = FlxTween.tween(pibemapa, {x: 347}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 1:
				tween = FlxTween.tween(pibemapa, {x: 507}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 2:
				tween = FlxTween.tween(pibemapa, {x: 667}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 3:
				tween = FlxTween.tween(pibemapa, {x: 827}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 4:
				tween = FlxTween.tween(pibemapa, {x: 987}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 5:
				tween = FlxTween.tween(pibemapa, {x: 1147}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 6:
				tween = FlxTween.tween(pibemapa, {x: 1307}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
			case 7:
				tween = FlxTween.tween(pibemapa, {x: 1467}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						quieto = false;
					}
				});
		}
		do {}
		while (unselectableCheck(curSelected));
		initialized = true;
	}
}
