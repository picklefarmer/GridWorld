extends Node

@export var lore : Array[String]
var loreIndex : int = 0
var loreWindow : RichTextLabel
var titleScreen : Label
var loreTween : Tween
var charSelect : bool = false
var gameStart : bool = false
var introDone : bool = false
func _ready() -> void:
	$IntroMusic.play()
	loreWindow = $RichTextLabel
	titleScreen = $TitleScreen2d.get_child(0)
	#loreTween = create_tween()
	updateLabel()



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm") and gameStart == false and !Global.startMenu:
		loreIndex = loreIndex+1
		if loreIndex == lore.size():
			loreWindow.visible = false
			$"../CharacterSelect/TitleScreen2d/Label".visible = true
			introDone = true
			$IntroMusic.stop()
			$CharacterSelectMusic.play()
			#$TitleScreen2d.titleScreen.visible = true
			#get_tree().create_timer(1.5).timeout.connect(fadeTitle)
		elif charSelect or introDone:
			$"../CharacterSelect/".visible = false
			$"../CharacterSelect/WorldEnvironment".queue_free()
			$"../CharacterSelect/TitleScreen2d/Label".visible = false
			
			$CharacterSelectMusic.stop()
			gameStart = true
			
			$"..".startGame()
		
		else:
			updateLabel()
	
func fadeTitle():
	titleScreen.visible = false
	
func updateLabel():
	#
	if loreTween and loreTween.is_valid():
		loreTween.kill()
	loreTween = create_tween()
	#tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

	loreTween.tween_property(loreWindow,"theme_override_colors/default_color",Color(0.0,0.0,0.0,0.5),0.5)
	loreTween.tween_callback(updateText)
	loreTween.tween_property(loreWindow,"theme_override_colors/default_color",Color(1.0,1.0,1.0,1.0),0.5)
	
	
	
func updateText():
	if introDone == false:
		loreWindow.text = "[center]"+lore[loreIndex]+"[/center]"
	
	
	
