extends VBoxContainer

var startToggle : bool = false
var micArray : Array = []
var micOptionpath = "res://Scenes/mic_button.tscn"
@onready var micOptionButton : PackedScene = load(micOptionpath)
func _ready():
	$HSlider.value_changed.connect(updateMinimum)
	$HSlider2.value_changed.connect(difficultyUpdate)
	$HSlider3.value_changed.connect(volumeMain)
	for i in AudioServer.get_input_device_list():
		createButton(i)
		

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("startButton"):
		startToggle = !startToggle
		$"../..".visible = startToggle
		
		Global.startMenu = startToggle
		
		if startToggle:
			
			grab_focus()
			var defaultMic : OptionButton = get_child(6) 
			defaultMic.grab_focus()
		else:
			release_focus()
func volumeMain(value:float):
	$Volume.text = "Volume: " + str(int(value*10))
	AudioServer.set_bus_volume_linear(0,value)
	
func difficultyUpdate(value:int):	
	$Difficulty.text = "Difficulty: " + str(value)
	Global.difficulty = value
	
func updateMinimum(value:float):
	$Label.text = "Mic Sensitivity: " + str(value)
	
	if $"../../../".get_child_count() == 4:
		$"../../../".get_child(3).get_node("Track 2 streamer").minimum = value
	Global.minimum = value
			
func createButton(device:String):
	
	var button : OptionButton = micOptionButton.instantiate()
	button.text = device
	button.pressed.connect(assignMic.bind(device))
	add_child(button)
	
	#micArray.append(button)
	
func assignMic(device:String):
	#print(device)
	AudioServer.set_input_device(device)
	startToggle = !startToggle
	$"../..".visible = startToggle
	Global.startMenu = startToggle
	release_focus()
