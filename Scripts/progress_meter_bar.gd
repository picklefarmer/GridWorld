extends Node3D
@export var trackMeterIndex : int = 0
@export var lapDisplay : Array[PackedScene] = []
var lapInd : int = 0
var currentLapDisplay : Node3D
var material : StandardMaterial3D
var materialOve : StandardMaterial3D

var colors : Array = [Color.AQUAMARINE,Color.WEB_PURPLE,Color.MIDNIGHT_BLUE]

func _ready() -> void:
	
	material = StandardMaterial3D.new()
	currentLapDisplay = get_child(2)
	#materialOve =  as StandardMaterial3D
	
	Actions.meterColor.connect(changeColor)
	
	
	
func changeColor(lap:int,trackInd:int):
	if trackInd == trackMeterIndex:
		material.albedo_color = colors[lap]
		material.emission = colors[lap]
		$Plane.set_surface_override_material(0,material)
		lapNumberSwap(lap)
		

func lapNumberSwap(lap:int):
	#var tempInd : int = posmod(lap, lapDisplay.size())
	var lapInstantiated = lapDisplay[lap+1].instantiate()
	self.add_child(lapInstantiated)
	var newLap:Node3D = get_child(3)

	
	
	newLap.transform = currentLapDisplay.transform
	
	currentLapDisplay.queue_free()
	currentLapDisplay = newLap
	
	lapInd = lap+1
	
	
