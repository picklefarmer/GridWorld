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
@onready var cameraTarget : Node3D = $Path3D2/track1/PlayerHolder
@export var top : Camera3D 
@export var birdsEye :Camera3D
@onready var zoomin :Tween
@onready var progressMeter : Node3D = $Path3D2/track1/Camera3D/Progress_Meter
@onready var players : Array = [$Path3D2/track1/PlayerHolder,$Path3D2/track2,$Path3D2/track3,$Path3D2/track4]
var playerFollowInd : int = 1
enum cameraState {MAIN, BIRDSEYE,FOllOW}
var currentCamera : cameraState = cameraState.MAIN
@onready var finishCamera: PackedScene = preload("res://Scenes/camera_revolve.tscn")
@onready var music : Array[AudioStreamPlayer] = [$Microphone,$"Track 2 streamer", $"Track 3 streamer", $"Track 4 streamer"]
var musicProximity : Array[AudioStreamPlayer3D] = []
@onready var startingOffset : float = $Path3D2/track1.progress_ratio
func _ready() -> void:
	Actions.revolveCamera.connect(finishCameraBegin)
	#$"..".resetPlayerPosition(self)
	
	if proximityTracks:
		musicProximity = [$"Path3D2/track2/Track 2 Proximity",$"Path3D2/track3/Track 3 Proximity",$"Path3D2/track4/Track 4 Proximity"]
	
	
func _process(delta: float) -> void:
	if currentCamera == cameraState.FOllOW and Input.is_action_just_pressed("confirm"):
		print(" is swapping")
		followSwap()
		
		
	if Input.is_action_just_pressed("SwapCamera"):
		
		
		match currentCamera:
			cameraState.MAIN:
				generateTween()
				zoom(main,birdsEye)
				
				currentCamera = cameraState.BIRDSEYE
				
				moveMeter(main,birdsEye)
				
				
			cameraState.BIRDSEYE:
				generateTween()
				zoom(birdsEye,top)
				
				currentCamera = cameraState.FOllOW
				moveMeter(birdsEye,top)
				
			cameraState.FOllOW:
				generateTween()
				zoom(top,main)
				
				
				currentCamera = cameraState.MAIN
				moveMeter(top,main)
				
				
			

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
		progressMeter.visible = false
		zoomin.tween_property(reference,"fov",inIn,0.5)
		zoomin.tween_callback(switchCamera.bind(out))
		zoomin.tween_property(out,"fov",outOut,0.25)
		zoomin.tween_callback(makeProgressVisible)
		
	else :
		progressMeter.visible = false
		zoomin.tween_property(reference,"fov",inOut,1.0)
		zoomin.tween_callback(switchCamera.bind(out))
		zoomin.tween_property(out,"fov",outIn,0.25)
		zoomin.tween_callback(makeProgressVisible)
	
		
func switchCamera(reference:Camera3D):
	reference.make_current()
	
func makeProgressVisible():
	progressMeter.visible = true

	
func generateTween():
	if zoomin and zoomin.is_valid():
		zoomin.kill()
	zoomin = create_tween()
	zoomin.set_trans(Tween.TRANS_CUBIC)
	zoomin.set_ease(Tween.EASE_IN)

func finishCameraBegin():
	var cameraFinished = finishCamera.instantiate()
	cameraFinished.main = main
	cameraTarget.add_child(cameraFinished)
	
	
	cameraFinished.transform = cameraTarget.transform
	
func followSwap():
	var cameraOffset = top.transform
	top.reparent(players[playerFollowInd])
	top.transform = cameraOffset
	print(top.get_parent(), "camera parent")
	playerFollowInd = ((playerFollowInd+1)%4)
	print(playerFollowInd)
	
func moveMeter(from:Camera3D,to:Camera3D):
	var progressMeter : Node3D = from.get_node("Progress_Meter")
	var startTransform = progressMeter.transform
	
	progressMeter.reparent(to)
	progressMeter.transform = startTransform
	
	if currentCamera != 0:
		progressMeter.position.z = -0.957
	else:
		progressMeter.position.z = -1.391
	

	
		
	
