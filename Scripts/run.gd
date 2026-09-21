extends PathFollow3D

@export var trackNumber : int = 0
var runAmount : float = 0.0
var evalTime : float = 8.25
#var progressNormalized : float 

func _ready() -> void:
	#progressNormalized = get_parent().curve.get_baked_length()
	#print(progressNormalized,"progressNormalized")
	progress_ratio = 0
	Actions.goForward.connect(running)
	if trackNumber == 1:
		Actions.beatOff.connect(modRun)
	
func _physics_process(delta: float) -> void:

	
	#progress_ratio = lerp(progress_ratio,runAmount + progress_ratio,delta*evalTime)
	progress = lerp(progress,runAmount + progress,delta*evalTime)
	runAmount = lerp(runAmount,0.0, delta* 11.0)
	
	
func running(inch:float,track:int):
	if track == trackNumber:
		runAmount = inch
		
func modRun(beatInt:float,delta:float,time:float):
	
	
	runAmount = lerp(runAmount, runAmount * beatInt,time* delta)
	
	
	

			
