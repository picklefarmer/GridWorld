extends Node3D

var active = false
@export var minimum:float = 0.05
@export var runSpeed : float = 1.0

func _ready() -> void:
	#Actions.emit_signal("resetMic")
	get_child(0).get_child(0).get_child(0).owner = self
		
	
