extends Node3D

@export var minimum : float = 0.05
@export var startingTrack : PackedScene
@export var Raceways : Array[PackedScene] = []
@export var Vitamen: Array[PackedScene]= []
var _Vitamen : Array
var loadedPlayers : Array = []
var raceWayInd : int = 0
var currentRaceway:Node3D
var intro = true

#var playerIndex : int = 0

func _ready() -> void:
	Global.minimum = minimum
	Actions.resetMic.connect(resetMicFunc)
	Actions.changeLevel.connect(swap)
	Actions.endGame.connect(endGame)
	startingTrack = Raceways[0]
	Global.globalRacewaySize = Raceways.size()
	_Vitamen = Vitamen.duplicate()
	
func _process(delta: float) -> void:
	if $Lore.gameStart:
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

func startGame():
	Vitamen.remove_at(Global.globalPlayerIndex)
	add_child(startingTrack.instantiate())
	currentRaceway = get_child(2)
	assignRandomCharacters(currentRaceway)


func endGame():
	currentRaceway.queue_free()
	$Lore/OutroMusic.play()	
	var label = $Lore/TitleScreen2d/EndScreen
	label.visible = true
	
	
	
func assignRandomCharacters(raceway:Node3D):
	var trackIdx :int = 2
	for v in getTracks(raceway):
		createCharacter(v,trackIdx)
		trackIdx = trackIdx + 1
	Vitamen = _Vitamen.duplicate()
	
func getTracks(raceway:Node3D):
	#currentRaceway = get_child(2)
	
	var base = raceway.get_node("Path3D2")
	var tracks : Array =[]
	for i in range(2,5):
		print(i ,"idx of track ")
		tracks.append( base.get_node("track"+str(i)))
	return tracks
		
func createCharacter(track:PathFollow3D,trackIdx:int):
	var rnd_idx = randi() % Vitamen.size()
	var oldOpp : Node3D = track.get_child(0)
	var opponent : Node3D = Vitamen[rnd_idx].instantiate()
	Vitamen.erase(Vitamen[rnd_idx])
	
	
	opponent.transform = oldOpp.transform
	opponent.minimum = oldOpp.minimum
	opponent.runSpeed = oldOpp.runSpeed
	opponent.track = trackIdx
	track.add_child(opponent)
	track.move_child(opponent,1)
	oldOpp.queue_free()
		
func swap(direction:int):
	raceWayInd = posmod(raceWayInd+direction, Raceways.size())
	Global.globalRacewayIndex = raceWayInd
	currentRaceway = get_child(2)
	print(raceWayInd)
	var racewayInstance = Raceways[raceWayInd].instantiate()
	#print(racewayInstance.get_node("Path3D2/track1/PlayerHolder").playerInd, " player index of level")
	#racewayInstance.get_node("Path3D2/track1/PlayerHolder").playerInd = playerIndex
	self.add_child(racewayInstance)
	
	

	#racewayInstance.get_node("Path3D2/track1/PlayerHolder").get_child(0).active = true
	Actions.syncLip.emit()
	#currentRaceway.get_node("Microphone").stop()
	currentRaceway.queue_free()
	
	currentRaceway = racewayInstance
	assignRandomCharacters(currentRaceway)
	
	resetMicFunc()

	
	
	
		
	

	
