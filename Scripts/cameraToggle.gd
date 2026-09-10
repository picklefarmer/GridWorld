extends Node3D

var ischecked : bool = true
@export var outIn : float = 40
@export var outOut : float = 20
@export var inIn : float = 120
@export var inOut : float = 78

@onready var main : Camera3D = $Path3D2/track1/Camera3D
@onready var top : Camera3D = $BirdsEye
@onready var zoomin :Tween


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwapCamera"):
		if ischecked:
			generateTween()
			zoom(main,top)
			
		else:
			generateTween()
			zoom(main,top)
			
			
func zoom(reference:Camera3D,out: Camera3D):
	
	if ischecked:		
		zoomin.tween_property(reference,"fov",inIn,0.5)
		zoomin.tween_callback(flip)
		zoomin.tween_property(out,"fov",outOut,1.0)
		
	else :
		zoomin.tween_property(out,"fov",inOut,1.0)
		zoomin.tween_callback(flip)
		zoomin.tween_property(reference,"fov",outIn,0.25)
		
		
		
		
		
		

func flip():
	if ischecked:
		main.clear_current()
		top.make_current()	
	else:
		top.clear_current()
		main.make_current()
	
	print(main.current,top.current,ischecked)
	ischecked = !ischecked
	
func generateTween():
	#if zoomin and zoomin.is_valid():
		#zoomin.kill()
	zoomin = create_tween()
	zoomin.set_trans(Tween.TRANS_CUBIC)
	zoomin.set_ease(Tween.EASE_IN)
