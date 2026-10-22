extends Node3D



func _ready() -> void:
	Actions.meter_Progress.connect(meter_length)
	


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ProgressMeter"):
		visible = !visible
		
func meter_length(length:float,track:int):

	match track:
		1: $progress_meter_bar_player/Plane.scale.x = length
		2: $progress_meter_bar2/Plane.scale.x = length
		3: $progress_meter_bar3/Plane.scale.x = length
		4: $progress_meter_bar4/Plane.scale.x = length
