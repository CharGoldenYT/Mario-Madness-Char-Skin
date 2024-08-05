package;

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

using StringTools;

class WarpStateLegacy extends MusicBeatState //I WANNA SEE LEMME SEE
{
	var tween:FlxTween;
	var tween2:FlxTween;
	public static var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	public static var canciones:Array<Dynamic> = References.getLegacyWarpSongs(false);

	var bg:FlxSprite;
	var pibemapa:FlxSprite;
	var warpPipe:FlxSprite;
	var cartel:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var msg:FlxText;
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Warp Zone", null);
		#end
		FlxG.sound.playMusic(Paths.music('warp theme'), 0.7);

		if (ClientPrefs.storySave == [true, true, true, true, true, true, true, true, true, false] || ClientPrefs.storySave == [true, true, true, true, true, true, true, true, true, true])
		{
			if (ClientPrefs.firstSecretView == true) {
				if (!ClientPrefs.unlockedSecretSong){
					ClientPrefs.unlockedSecretSong = true;
					trace('Unlocking Secret Song!');
					ClientPrefs.saveSettings();
					canciones = References.getLegacyWarpSongs(true);
					curSelected = 7;
				}
			}
		} else {
			if (ClientPrefs.unlockedSecretSong == true || ClientPrefs.firstSecretView == false) {
				trace('Not Enough Story Progress To Unlock Secret Song!');
				ClientPrefs.firstSecretView = true; // just in case testing f'd it up.
				ClientPrefs.unlockedSecretSong = false; // just in case testing f'd it up.
				ClientPrefs.saveSettings();
				canciones = References.getLegacyWarpSongs(false);
			}
		}

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
		warpPipe.alpha = !ClientPrefs.unlockedSecretSong ? 0 : 1;
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
		caminar(); // double make sure bro goes to the right area lmao
		super.create();
	}

	var quieto:Bool = false;
	var isDebugMode:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_LEFT_P;
		var downP = controls.UI_RIGHT_P;
		var debugKey = FlxG.keys.justPressed.F10;

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
			if (controls.ACCEPT)
			{
				if (ClientPrefs.firstSecretView && curSelected == 7) ClientPrefs.firstSecretView = false;
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
				FlxG.sound.playMusic(Paths.music('warp theme'), 0.7);
			}
		}

		if (controls.BACK)
		{
			if (ClientPrefs.firstSecretView) ClientPrefs.firstSecretView = false;
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
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('bros3pass'), 1); // LO QUE HACE EL JUEGO ES MANDARTE AL I HATE YOU SI LO PONES EN 0, TEN EN CUENTA ESTO

		do
		{
			curSelected += change;
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
	}
}
