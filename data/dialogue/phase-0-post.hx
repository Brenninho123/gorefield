//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "%Oh,&& it's you.&&& I see you don't have the note with you yet,&&& %but that's alright.", 
            message_es: "%Oh,&& eres tú.&&& Veo que aún no tienes la nota,&&& %pero está bien.", 
            typingSpeed: 0.06, startDelay: 0,
            onEnd: function () {
                dialscript.wind.fadeOut(0.8);
                __canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.wind.volume = 0.5; 
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
        {
            message_en: "%While you were away,&& I heard the other day that,& a cat kidnapped a dog.&&& %Seem's pretty interesting to think about.", 
            message_es: "%Mientras no estabas,&& escuché el otro día que,& un gato secuestró a un perro.&&& %Es bastante interesante pensar en eso.", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.wind.stop(); 
                        dialscript.menuMusic.play();
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
        {
            message_en: "%Well, thats all I have to share with you for now.& %Continue looking for that note!", 
            message_es: "%Bueno, eso es todo lo que tengo para compartir contigo por ahora.& %Sigue buscando esa nota!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
    ];

    dialscript.endingCallback = function () {
        dialscript.fadeOut = dialscript.fastFirstFade = true; dialscript.blackTime = 0;
        dialscript.menuMusic.fadeOut(2); dialscript.introSound.volume = 0.3;
        dialscript.eyes.animation.play("normal", true);
        (new FlxTimer()).start(2/8, function () dialscript.introSound.play(), 8);
        (new FlxTimer()).start(2.2, function () {FlxG.switchState(new StoryMenuState());});
    };
}

function postCreate() {
    dialscript.fastFirstFade = true; 
    dialscript.introSound = FlxG.sound.load(Paths.sound('easteregg/snd_test'), 0.4);
	(new FlxTimer()).start(2/8, function () dialscript.introSound.play(), 8);
	if (FlxG.save.data.arlenePhase == -1 || !FlxG.save.data.canVisitArlene) return;
	(new FlxTimer()).start(4.2, function () FlxG.sound.play(Paths.sound('easteregg/mus_sfx_cinematiccut'), 0.1));
	(new FlxTimer()).start(6, dialscript.progressDialogue);

    trace("ARLENE DIALOGUE PHASE 2 LOADED");
}