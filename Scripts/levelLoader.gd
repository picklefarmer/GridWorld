extends Node3D


@export var Raceways : Array[PackedScene] = []
var loadedPlayers : Array = []
var raceWayInd : int = 0
var currentRaceway:Node3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("trackLeft"):
		swap(-1)
		
	if Input.is_action_just_pressed("trackRight"):
		swap(1)

	
func swap(direction:int):
	currentRaceway = get_child(0)
	if direction < 0:
		raceWayInd = (raceWayInd+direction)%(Raceways.size())
		#print(playerInd,"up")
	elif raceWayInd == 0:
		raceWayInd = Raceways.size()-1	
	else :
		raceWayInd = abs((raceWayInd-1)%(Raceways.size()*-1))
		#print(playerInd,"down")
	
	var racewayInstance = Raceways[raceWayInd].instantiate()
	self.add_child(racewayInstance)
	
	#print(currentRaceway.get_node("Microphone"))
	#currentRaceway.get_node("Microphone").stop()
	currentRaceway.get_node("Path3D2/track1/PlayerHolder").get_child(0).active = true
	Actions.syncLip.emit()
	
	currentRaceway.queue_free()
	#racewayInstance.get_node("Microphone").play()
	currentRaceway = racewayInstance
	
	
