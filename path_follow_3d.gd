extends PathFollow3D

var isForward = false

@export var  move_speed: float = 54.0
@export_range(0.0,1.0) var progressStart = 0.0
func _ready() -> void:
	$".".progress_ratio = progressStart
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if isForward == false:
		if $".".progress_ratio < 1:
			$".".progress += move_speed * delta
			
		else :
			isForward = true
			$".".use_model_front = true
	else:
		if $".".progress_ratio > 0:
			$".".progress -= move_speed * delta
		else :
			isForward = false
			$".".use_model_front = false

			
