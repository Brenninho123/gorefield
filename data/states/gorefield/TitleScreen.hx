import flixel.text.FlxTextBorderStyle;
import funkin.backend.MusicBeatState;
import flixel.util.FlxAxes;

static var skippedIntro:Bool = false;
var transitioning:Bool = false;

var house:FlxSprite;
var logoBl:FlxSprite;
var textGroup:FlxGroup;
var ngSpr:FlxSprite;
var titleText:FlxSprite;

var wiggleGorefield:FlxSprite;
var vigentte:FlxSprite;

function create() {
	FlxG.sound.playMusic(Paths.music('gorefield-menuLOOP'),0);
	FlxG.camera.bgColor = FlxColor.fromRGB(17,5,33);
	FlxG.mouse.visible = false;

	if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
		FlxG.sound.music.fadeIn(0.5, 0, 0.7);
		FlxG.sound.music.play();
	}

	textGroup = new FlxGroup();

	house = new FlxSprite(560, 45).loadGraphic(Paths.image('menus/mainmenu/house'));
	house.updateHitbox();
	add(house);

	logoBl = new FlxSprite(16, 10);
	logoBl.frames = Paths.getSparrowAtlas('menus/logoMod');
	logoBl.animation.addByPrefix('bump', 'logo bumpin', 24,false);
	logoBl.scale.set(0.8, 0.8);
	logoBl.updateHitbox();
	logoBl.antialiasing = true;
	add(logoBl);

	ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('menus/titlescreen/newgrounds_logo'));
	add(ngSpr);
	ngSpr.visible = false;
	ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
	ngSpr.updateHitbox();
	ngSpr.screenCenter(FlxAxes.X);
	ngSpr.antialiasing = true;

	titleText = new FlxSprite(100, 576);
	titleText.frames = Paths.getSparrowAtlas('menus/titlescreen/titleEnter');
	titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
	titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
	titleText.antialiasing = true;
	titleText.animation.play('idle');
	titleText.updateHitbox();
	add(titleText);

	if(skippedIntro) return;
	blackScreen = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.fromRGB(17,5,33));
	add(blackScreen);
	add(textGroup);

	wiggleGorefield = new FlxSprite(0, 224 - 240).loadGraphic(Paths.image("menus/mainmenu/garfie"), true, 498, 280);
	wiggleGorefield.animation.add("_",  [for (_ in 0...34) _], 24, true);
	wiggleGorefield.animation.play("_");
	wiggleGorefield.visible = false;
	wiggleGorefield.screenCenter();
	add(wiggleGorefield);

	FlxG.sound.playMusic(Paths.music('gorefield-menuINTRO'),1,false);
	Conductor.changeBPM(115);
}

function getIntroTextShit():Array<Array<String>> {
	var fullText:String = Assets.getText(Paths.txt('titlescreen/introText'));

	var firstArray:Array<String> = fullText.split('\n');
	var swagGoodArray:Array<Array<String>> = [];

	for (i in firstArray)
		swagGoodArray.push(i.split('--'));
	return swagGoodArray;
}

function createCoolText(textArray:Array<String>) {
	for (i => text in textArray) {
		if (text == "" || text == null) continue;
		var textShit = new FlxText(0, (i * 90) + 200, FlxG.width, text, 19, true);
		textShit.setFormat("fonts/pixelart.ttf", 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		textShit.scrollFactor.set();
		textShit.screenCenter(FlxAxes.X);
		textGroup.add(textShit);
	}
}

function addMoreText(text:String) {
	var moretextShit = new FlxText(0, (textGroup.length * 90) + 200, FlxG.width, text, 19, true);
	moretextShit.setFormat("fonts/pixelart.ttf", 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	moretextShit.scrollFactor.set();
	moretextShit.screenCenter(FlxAxes.X);
	textGroup.add(moretextShit);
}

function deleteCoolText() {
	while (textGroup.members.length > 0) {
		textGroup.members[0].destroy();
		textGroup.remove(textGroup.members[0], true);
	}
}

function beatHit(curBeat:Int) {
	logoBl.animation.play('bump',true);

	FlxTween.tween(FlxG.camera, {zoom: 1.02}, 0.3, {ease: FlxEase.quadOut, type: FlxTween.BACKWARD});

	if(skippedIntro) return;
	switch (curBeat)
	{
		case 2: createCoolText(["FNF' Gorefield Team"]);
		case 4: addMoreText('Present');
		case 5: deleteCoolText();
		case 6: createCoolText(['In not association', 'with'], -40);
		case 8: addMoreText('newgrounds', -40); ngSpr.visible = true;
		case 9: deleteCoolText(); ngSpr.visible = false;
		case 10: createCoolText(["Dathree estuvo aqui"]);
		case 12: addMoreText("'Dathree'");
		case 13: deleteCoolText();
		case 14: createCoolText(["I don't speak spanish"]);
		case 15: addMoreText("'Lean'");
		case 16: deleteCoolText();
		case 17: createCoolText(["Gorefield para ti BB"]);
		case 18: addMoreText("'Nexus'");
		case 19: deleteCoolText();
		case 20: createCoolText(["Jon requiero enchiladas"]);
		case 21: addMoreText("'Bitfox'");
		case 22: deleteCoolText();
		case 23: createCoolText(["Fifa 24"]);
		case 24: addMoreText("'Jloor'");
		case 25: deleteCoolText();
		case 26: createCoolText(["JLoorcito fiu fiu"]);
		case 27: addMoreText("'Zero'");
		case 28: deleteCoolText();
		case 29: createCoolText(["el peor mod de fnf"]);
		case 30: addMoreText("'Keneth'");
		case 31: deleteCoolText();
		case 32: addMoreText("FNF'");
		case 33: addMoreText('Vs Gorefield');
		case 34: addMoreText('Part II');
		case 35:
			if(!FlxG.random.bool(10)) return;
			deleteCoolText();
			wiggleGorefield.visible = true;
		case 36: skipIntro();
	}
}

function skipIntro() {
	if (!skippedIntro) {
		remove(ngSpr);
		remove(textGroup);
		remove(blackScreen);
		FlxG.camera.flash(FlxColor.WHITE, 2);
		wiggleGorefield.visible = false;
		skippedIntro = true;
		FlxG.sound.playMusic(Paths.music('gorefield-menuLOOP'));
	}
}


function update(elapsed:Float) {
	var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

	if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;

	if (pressedEnter) {
		if (!skippedIntro)
			skipIntro();
		else if (!transitioning)
			pressEnter();
	}

	if (FlxG.keys.justPressed.TAB) FlxG.switchState(new ModState("gorefield/easteregg/ArlenesCage"));
}

function pressEnter() {
	titleText.animation.play('press',true);

	FlxG.camera.flash(FlxColor.WHITE, 1);
	FlxG.sound.play(Paths.sound('menu/confirmMenu'), 1);

	transitioning = true;
	// FlxG.sound.music.stop();

	new FlxTimer().start(seenMenuCutscene ? 1.2 : 1.4, (_) -> 	FlxG.switchState(new MainMenuState()));

	FlxTween.tween(logoBl, {y: logoBl.y + (FlxG.height*1.4)}, 2, {ease: FlxEase.circInOut});
	FlxTween.tween(house, {y: house.y + (FlxG.height*1.4)}, 2, {ease: FlxEase.circInOut});
	FlxTween.tween(titleText, {y: titleText.y + (FlxG.height*1.4)}, 2, {ease: FlxEase.circInOut});

	MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = !seenMenuCutscene;
}