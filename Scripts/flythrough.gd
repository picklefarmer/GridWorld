extends Node3D



@export var raceways : Array[PackedScene] = []

var path : Path3D
var preview : Node3D
var previewScript:  = preload("res://Scripts/preview.gd")
var previewCamera: PackedScene = preload("res://Scenes/preview_camera.tscn")


func _ready() -> void:
	if Global.globalRacewayIndex+1 < raceways.size() :
		preview = raceways[Global.globalRacewayIndex+1].instantiate()
		preview.set_script(previewScript)
		add_child(preview)
		path = preview.get_node("Path3D2")
		var previewCameraInstantiated = previewCamera.instantiate()
		path.add_child(previewCameraInstantiated)
	
