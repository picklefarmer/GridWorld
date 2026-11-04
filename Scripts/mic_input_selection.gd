extends VBoxContainer

var startToggle : bool = false
var micArray : Array = []
var micOptionpath = "res://Scenes/mic_button.tscn"
@onready var micOptionButton : PackedScene = load(micOptionpath)
func _ready():
	$HSlider.value_changed.connect(updateMinimum)
	for i in AudioServer.get_input_device_list():
		createButton(i)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("startButton"):
		startToggle = !startToggle
		visible = startToggle
		Global.startMenu = startToggle
		if startToggle:
			grab_focus()
			var defaultMic : OptionButton = get_child(2) 
			defaultMic.grab_focus()
		else:
			release_focus()
			
func updateMinimum(value:float):
	if $"../../".get_child_count() == 3:
		$"../../".get_child(2).get_node("Track 2 streamer").minimum = value
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
	visible = startToggle
	Global.startMenu = startToggle
	release_focus()
