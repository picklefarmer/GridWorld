extends PathFollow3D
var runAmount : float = 0
func _ready() -> void:
	progress_ratio = 0
	Actions.goForward.connect(running)
	
func _process(delta: float) -> void:
	
	progress_ratio = lerp(progress_ratio,runAmount+ progress_ratio,delta*10)
	runAmount = lerp(runAmount,0.0, delta*10)
	
func running(inch:float):
	runAmount = inch
	
	
	

			
