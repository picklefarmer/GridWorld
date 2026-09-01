extends PathFollow3D

func _ready() -> void:
	progress_ratio = 0
	Actions.goForward.connect(running)


func running(inch:float):
	var delta = get_physics_process_delta_time()
	progress_ratio = lerp(progress_ratio,progress_ratio+ inch,delta* 10)
	
	

			
