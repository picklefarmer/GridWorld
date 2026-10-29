extends Node3D

var tracks : Array = [0,0,0,0]
var trackEnds : Array = [false,false,false,false]
@export var lapCap : int = 2

func _ready() -> void:
	Actions.meter_Progress.connect(meter_length)
	Actions.meter_Progress.connect(changeColor)


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ProgressMeter"):
		visible = !visible
		
func meter_length(length:float,trackInd:int):

	match trackInd:
		1: $progress_meter_bar_player/Plane.scale.x = length
		2: $progress_meter_bar2/Plane.scale.x = length
		3: $progress_meter_bar3/Plane.scale.x = length
		4: $progress_meter_bar4/Plane.scale.x = length

func changeColor(length:float,trackInd:int):
	if trackEnds[trackInd-1] == true and length >= 0 and length < 0.97:
		trackEnds[trackInd-1] = false
	elif trackEnds[trackInd -1 ] == false and length >= 0.98 :
		trackEnds[trackInd - 1] = true
		if tracks[trackInd-1] <= lapCap:
			Actions.meterColor.emit(tracks[trackInd-1],trackInd)
			tracks[trackInd-1] = tracks[trackInd-1] +1
		else:
			if trackInd == 1:
				Actions.changeLevel.emit(1)
			print(trackInd, " Won ")
		
		
