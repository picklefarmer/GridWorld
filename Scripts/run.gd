extends PathFollow3D

@export var trackNumber : int = 0
var runAmount : float = 0.0
var nonPlayerMultiplier: float = 1.0
var evalTime : float = 11.0
var trackNorm : float = 1.0
var micProgress: float = 0.0
var micSpan : float = 200.0

var progressNormalized : int 

func _ready() -> void:
	progressNormalized = get_parent().curve.get_baked_length()
	micSpan = progressNormalized/ 6
	#print(progressNormalized,"progressNormalized")
	trackNorm = owner.trackMultiplier
	progress_ratio = 0
	Actions.goForward.connect(running)
	if trackNumber != 1:
		Actions.updateProgress.connect(errorBoost)
	#if trackNumber == 1:
		#Actions.beatOff.connect(modRun)
	#else:
		#nonPlayerMultiplier = 4.0
	
	
func _physics_process(delta: float) -> void:

	
	#progress_ratio = lerp(progress_ratio,runAmount + progress_ratio,delta*evalTime)
	progress = lerp(progress,(runAmount*trackNorm) + progress,delta*evalTime)
	runAmount = lerp(runAmount,0.0, delta* 11.0)
	
	
func running(inch:float,track:int):
	if track == trackNumber:
		#if track == 1 and inch <= 1:
			#rangeOfAudible(progress)
		runAmount = inch
		
#func rangeOfAudible(micProg:float):
	#Actions.updateProgress.emit(micProg)
	

func errorBoost(micAmp:float,micProg:float):
	
	var range :float = evalRange(micProg,progress,progressNormalized)
	if  range <=micSpan:
		runAmount = runAmount * micAmp +range/6
		
		print(trackNumber," error boost: ",micAmp," difference: ",range)
		
		
		
		
func evalRange(micProg:float,npcProg:float,progLength:float):
	var difference = abs(micProg - npcProg)
	difference = posmod(difference,progLength)
	if difference > progLength/2.0:
		difference = progLength - difference
	return difference
		
	
func modRun(beatInt:float,delta:float,time:float):
	
	
	runAmount = lerp(runAmount, runAmount * beatInt,time* delta)
	print(runAmount)
	


			
