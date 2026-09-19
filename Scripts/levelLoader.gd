extends Node3D


@export var Raceways : Array[PackedScene] = []
var loadedPlayers : Array = []
var raceWayInd : int = 5
var currentRaceway:Node3D

func _ready() -> void:
	Actions.resetMic.connect(resetMicFunc)
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("trackLeft"):
		swap(1)
		
	if Input.is_action_just_pressed("trackRight"):
		swap(-1)

func resetMicFunc():
	#print(currentRaceway.get_node("Microphone"))
	#currentRaceway.get_node("Microphone").stop()
	#currentRaceway.get_node("Microphone").play()
	#print("resetMicFunc")
	#
	print(currentRaceway.get_node("Microphone"),"raceway instance")
	currentRaceway.get_node("Microphone").stop()
	await get_tree().create_timer(0.15).timeout
	currentRaceway.get_node("Microphone").play()
	print(currentRaceway.get_node("Microphone").playing,"raceway instance")
	
func swap(direction:int):
	raceWayInd = posmod(raceWayInd+direction, Raceways.size())
	currentRaceway = get_child(0)
	print(raceWayInd)
	var racewayInstance = Raceways[raceWayInd].instantiate()
	self.add_child(racewayInstance)
	
	

	#racewayInstance.get_node("Path3D2/track1/PlayerHolder").get_child(0).active = true
	Actions.syncLip.emit()
	#currentRaceway.get_node("Microphone").stop()
	currentRaceway.queue_free()
	
	currentRaceway = racewayInstance
	
	resetMicFunc()

	
	
	
		
	

	
