extends Node3D

#var ischecked : bool = true
@export var outIn : float = 40
@export var outOut : float = 20
@export var inIn : float = 120
@export var inOut : float = 78
@export var trackMultiplier : float = 1.0
@export var micSpan : float = 200
@export var proximityTracks : bool = false
@onready var main : Camera3D = $Path3D2/track1/Camera3D
@export var top : Camera3D 
@export var birdsEye :Camera3D
@onready var zoomin :Tween
@onready var progressMeter : Node3D = $Path3D2/track1/Camera3D/Progress_Meter
enum cameraState {MAIN, BIRDSEYE,FOllOW}
var currentCamera : cameraState = cameraState.MAIN
@onready var music : Array[AudioStreamPlayer] = [$Microphone,$"Track 2 streamer", $"Track 3 streamer", $"Track 4 streamer"]
var musicProximity : Array[AudioStreamPlayer3D] = []

func _ready() -> void:
	if proximityTracks:
		musicProximity = [$"Path3D2/track2/Track 2 Proximity",$"Path3D2/track3/Track 3 Proximity",$"Path3D2/track4/Track 4 Proximity"]
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwapCamera"):
		
		
		match currentCamera:
			cameraState.MAIN:
				generateTween()
				zoom(main,birdsEye)
				#moveProgressMeter(birdsEye)
				currentCamera = cameraState.BIRDSEYE
			cameraState.BIRDSEYE:
				generateTween()
				zoom(birdsEye,top)
				#moveProgressMeter(top)
				currentCamera = cameraState.FOllOW
			cameraState.FOllOW:
				generateTween()
				zoom(top,main)
				#moveProgressMeter(main)
				currentCamera = cameraState.MAIN

func pauseMusic():
	for instrument in music:
		instrument.stop()
	if proximityTracks:
		for proximity in musicProximity:
			proximity.stop()

func playMusic():
	for instrument in music:
		instrument.play()		
	if proximityTracks:
		for proximity in musicProximity:
			proximity.play()	
		
func zoom(reference:Camera3D,out: Camera3D):
	
	if currentCamera != cameraState.FOllOW:		
		zoomin.tween_property(reference,"fov",inIn,0.5)
		zoomin.tween_callback(switchCamera.bind(out))
		zoomin.tween_property(out,"fov",outOut,1.0)
		progressMeter.visible = false
	else :
		zoomin.tween_property(reference,"fov",inOut,1.0)
		zoomin.tween_callback(switchCamera.bind(out))
		zoomin.tween_property(out,"fov",outIn,0.25)
		progressMeter.visible = true
		
func switchCamera(reference:Camera3D):
	reference.make_current()
	
func moveProgressMeter(parent:Camera3D):
	pass 
	#progressMeter.reparent(parent,false)

	
func generateTween():
	if zoomin and zoomin.is_valid():
		zoomin.kill()
	zoomin = create_tween()
	zoomin.set_trans(Tween.TRANS_CUBIC)
	zoomin.set_ease(Tween.EASE_IN)
