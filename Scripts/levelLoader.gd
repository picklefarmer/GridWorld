extends Node3D


@export var Raceways : Array[PackedScene] = []
var loadedPlayers : Array = []
var raceWayInd : int = 0
var currentRaceway:Node3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("trackLeft"):
		swap(1)
		
	if Input.is_action_just_pressed("trackRight"):
		swap(-1)

	
func swap(direction:int):
	currentRaceway = get_child(0)
	var racewayInstance = Raceways[raceWayInd].instantiate()
	self.add_child(racewayInstance)
	
	print(currentRaceway.get_node("Microphone"))
	currentRaceway.queue_free()
	#racewayInstance.get_node("Microphone").play()
	currentRaceway = racewayInstance
	
	raceWayInd = (raceWayInd+1)%Raceways.size()
