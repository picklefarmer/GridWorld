extends Node3D

var active = false
@export var minimum:float = 0.05
@export var runSpeed : float = 1.0
@export var track : int = 0

func _ready() -> void:
	
	#minimum = Global.minimum
	#Actions.emit_signal("resetMic")
	get_child(0).get_child(0).get_child(0).owner = self
		
	
