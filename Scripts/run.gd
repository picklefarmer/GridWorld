extends PathFollow3D

@export var trackNumber : int = 0
var runAmount : float = 0

func _ready() -> void:
	progress_ratio = 0
	Actions.goForward.connect(running)
	if trackNumber == 1:
		Actions.beatOff.connect(modRun)
	
func _process(delta: float) -> void:
	
	progress_ratio = lerp(progress_ratio,runAmount+ progress_ratio,delta*4)
	runAmount = lerp(runAmount,0.0, delta*10)


func running(inch:float,track:int):
	if track == trackNumber:
		runAmount = inch
func modRun(beatInt):
	print(beatInt)
	runAmount *= beatInt	
	
	

			
