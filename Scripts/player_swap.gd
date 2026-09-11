extends Node3D

@export var PlayableCharacters : Array[PackedScene] = []

var player : Node3D
var loadedPlayers : Array = []
var playerInd : int = 0 

func _ready() -> void:
	#for character in PlayableCharacters:
		#loadedPlayers.append(character.instantiate())
	player = get_child(0)
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("playerLeft"):
		swap(1)
		
	if Input.is_action_just_pressed("playerRight"):
		swap(-1)


func swap(direction:int):
	var playerInstantiated = PlayableCharacters[playerInd].instantiate()
	
	self.add_child(playerInstantiated)
	var newPlayer:Node3D = get_child(1)
	newPlayer.set("active",true)
	Actions.syncLip.emit()
	newPlayer.transform = player.transform
	player.queue_free()
	player = newPlayer
	
	playerInd = (playerInd+direction)%PlayableCharacters.size()
	if playerInd < 0 :
		playerInd = abs(playerInd)+1
	print(playerInd)
	
