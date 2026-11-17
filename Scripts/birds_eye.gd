extends Path3D

@export var turnSpeed : float = 0.035
@export var transformScale : float = 30.0 : 
	get():
		return scale.x
	set(value): 
		scale = Vector3.ONE*value


func _process(delta: float) -> void:
	progressCamera(delta)	



func progressCamera(delta:float):
	$FollowPath3D.progress_ratio = wrapf($FollowPath3D.progress_ratio + turnSpeed*delta, 0.0, 1.0)
