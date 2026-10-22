extends Node3D

@export var PlayableCharacters : Array[PackedScene] = []
var runSpeed : float = 1.0

var player : Node3D
var loadedPlayers : Array = []
var playerInd : int = 9

func _ready() -> void:
	#for character in PlayableCharacters:
		#loadedPlayers.append(character.instantiate())
	player = get_child(0)
	#playerInd = Global.globalPlayerIndex
	#startingCharacter()
	
	#playerInd = get_tree().root.get_node("Main").playerIndex 
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("playerLeft"):
		swap(-1)
		
	if Input.is_action_just_pressed("playerRight"):
		swap(1)

#func startingCharacter():
	#var playerInstantiated = PlayableCharacters[playerInd].instantiate()
	#self.add_child(playerInstantiated)
	#var newPlayer:Node3D = get_child(1)
	#playerInstantiated.set("active",true)
	#Actions.syncLip.emit()
	#
	#newPlayer.runSpeed = player.runSpeed
	#newPlayer.transform = player.transform
	#
	#player.queue_free()
	#player = newPlayer
	
	#playerInd = posmod(playerInd, PlayableCharacters.size())
	#Global.globalPlayerIndex =  playerInd
	
func swap(direction:int):
	var tempInd : int = posmod(playerInd+direction, PlayableCharacters.size())
	var playerInstantiated = PlayableCharacters[tempInd].instantiate()
	self.add_child(playerInstantiated)
	var newPlayer:Node3D = get_child(1)
	playerInstantiated.set("active",true)
	Actions.syncLip.emit()
	
	newPlayer.runSpeed = player.runSpeed
	newPlayer.transform = player.transform
	
	player.queue_free()
	player = newPlayer
	
	
	
	playerInd = tempInd
	#Global.globalPlayerIndex =  playerInd
	
