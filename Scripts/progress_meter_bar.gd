extends Node3D
@export var trackMeterIndex : int = 0
var material : StandardMaterial3D
var materialOve : StandardMaterial3D

var colors : Array = [Color.AQUAMARINE,Color.WEB_PURPLE,Color.MIDNIGHT_BLUE]

func _ready() -> void:
	
	material = StandardMaterial3D.new()
	#materialOve =  as StandardMaterial3D
	
	Actions.meterColor.connect(changeColor)
	
	
	
func changeColor(lap:int,trackInd:int):
	if trackInd == trackMeterIndex:
		material.albedo_color = colors[lap]
		material.emission = colors[lap]
		$Plane.set_surface_override_material(0,material)
		
