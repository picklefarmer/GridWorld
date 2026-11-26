extends PathFollow3D
@onready var camera : Camera3D = $birdsEye/LR/Path3D/UD/BirdsEyeCamera

# 
var rate : float = 0.5


func _ready() -> void:
	
	camera.make_current()
	Actions.previewSpeed.connect(previewSpeed)
	
func _process(delta: float) -> void:
	
	progress -= rate
	#progress_ratio += wrapf(rate * delta,0.0,1.0)
	
func previewSpeed(value:float):
	rate = value
