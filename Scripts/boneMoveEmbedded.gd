extends Node3D


var track : int

func _ready() -> void:
	if owner.track:
		track = owner.track
