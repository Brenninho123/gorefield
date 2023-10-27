import flixel.util.FlxAxes;
import openfl.geom.ColorTransform;
import openfl.geom.Rectangle;
import flixel.addons.text.FlxTypeText;

var canPress:Bool = false;
var wind:FlxSound;

var eyes:FlxSprite;

var text:FlxText;
var bars:FlxSprite;

var black:FlxSprite;

function create()
{
    bars = new FlxSprite(0, 100);
    bars.loadGraphic(Paths.image("easteregg/Arlene_Box"));
    bars.scale.set(6, 6);
    bars.updateHitbox();
    bars.screenCenter(FlxAxes.X);

    FlxG.save.data.canVisitArlene = true; //This should be set to true when the credits video is shown -EstoyAburridow

    if (!FlxG.save.data.canVisitArlene)
    {
        add(bars);
        FlxG.sound.music.fadeOut(0.5);
        FlxG.sound.play(Paths.sound('easteregg/Wind_Sound'), 1, true);

        return;
    }

    eyes = new FlxSprite();
    eyes.loadGraphic(Paths.image("easteregg/Arlene_Eyes"), true, 80, 34);
    eyes.animation.add("eyes", [0, 1, 2, 3], 0, false);
    eyes.animation.play("eyes");
    eyes.scale.set(3.5, 3.5);
    eyes.updateHitbox();
    eyes.screenCenter(FlxAxes.X);
    eyes.y = bars.y + (bars.height - eyes.height) / 2;
    eyes.alpha = 0;
    eyes.antialiasing = false;
    add(eyes);

    add(bars);

    /*
    var box:FlxSprite = new FlxSprite(0, 370);
    box.makeGraphic(960, 250, FlxColor.WHITE);
    box.pixels.colorTransform(new Rectangle(5, 5, 950, 240),
        new ColorTransform(0, 0, 0, 1));
    box.screenCenter(FlxAxes.X);
    box.alpha = 0;
    add(box);

    text = new FlxText(0, box.y + 40, 930, "Aenean et egestas lorem. Nulla facilisi. Duis sodales erat semper erat elementum, ut iaculis libero iaculis. Aliquam sagittis sem quis nisi tempor molestie. Proin dignissim, odio congue placerat semper, diam.");
    text.setFormat("fonts/pixelart.ttf", 30, 0xFFFFFFFF, "lefter");
    text.screenCenter(FlxAxes.X);
    text.alpha = 0;
    add(text);
    */

    black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
    add(black);
}

var tottalTime:Float = 0;
function update(elapsed) {
    tottalTime += elapsed;

    eyes.y = bars.y + ((bars.height/2)-(eyes.height/2)) + Math.floor(6 * Math.sin(tottalTime));
    black.alpha = FlxMath.bound(1 - (Math.floor((tottalTime/4) * 8) / 8), 0, 1);

    if (tottalTime >= 4) eyes.alpha = FlxMath.bound((Math.floor(((tottalTime-4)/4) * 8) / 8), 0, 1);

    if (controls.BACK)
        FlxG.switchState(new TitleState());

    if (!canPress)
        return;

    // Arlene's dialogues
    
}