extends PathFollow3D
@onready var camera : Camera3D = $birdsEye/LR/Path3D/UD/BirdsEyeCamera

# 
var rate : float = 0.0125


func _ready() -> void:
	camera.make_current()
	
	
func _process(delta: float) -> void:
	progress_ratio += wrapf(rate * delta,0.0,1.0)
