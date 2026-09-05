extends PathFollow3D

@export var trackNumber : int = 0
var runAmount : float = 0

func _ready() -> void:
	progress_ratio = 0
	Actions.goForward.connect(running)
	
func _process(delta: float) -> void:
	
	progress_ratio = lerp(progress_ratio,runAmount+ progress_ratio,delta*10)
	runAmount = lerp(runAmount,0.0, delta*10)
	
func running(inch:float,track:int):
	if track == trackNumber:
		runAmount = inch
	
	
	

			
