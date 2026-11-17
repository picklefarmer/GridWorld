extends Path3D

@export var turnSpeed : float = 0.12
@export var transformScale : float = 30.0 : 
	get():
		return scale.x
	set(value): 
		scale = Vector3.ONE*value


func _process(delta: float) -> void:
	var rotateInputLR: float = Input.get_axis("stickL","stickR")
	var rotateInputUD: float = Input.get_axis("stickU","stickD")
	
	progressCamera(delta,rotateInputLR,rotateInputUD)	



func progressCamera(delta:float,influenceLR:float,influenceUD:float):
	$LR.progress_ratio = wrapf($LR.progress_ratio + influenceLR *delta* turnSpeed, 0.0, 1.0)
	$LR/Path3D/UD.progress_ratio = wrapf($LR/Path3D/UD.progress_ratio + influenceUD *delta*turnSpeed, 0.0, 1.0)
