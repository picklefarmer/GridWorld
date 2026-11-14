extends Node3D

@onready var labelText : Label = $Control/Label
@onready var cameraFollow: PathFollow3D = $Path3D/PathFollow3D
@onready var camera: Camera3D = $Path3D/PathFollow3D/Camera3D
@export var cameraSpeed: float = 0.2


func _ready() -> void:
	updateLabel()
	camera.make_current()

func _process(delta: float) -> void:
	Global.revolveCamera = true
	if Input.is_action_just_pressed("confirm"):
		Actions.startStat.emit()
	progressCamera(delta)

func progressCamera(delta:float):
	turnCamera()
	cameraFollow.progress_ratio += wrapf(cameraSpeed* delta,0.0,1.0)
	
func turnCamera():
	camera.look_at($target.global_position,cameraFollow.global_transform.basis.y)


func updateLabel():
	if Global.winners[0] == 1:
		labelText.text = "You Win!"
