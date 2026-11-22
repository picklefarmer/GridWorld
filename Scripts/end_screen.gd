extends Node3D

@export var goodEnding : AudioStream
@onready var circle : Path3D = $Path3D
@export var PlayableCharacters : Array[PackedScene] = []
@export var rotateSpeed : float = PI/16
@onready var totalTime : Label = $Control/VBoxContainer/totalTime
@onready var difficulty : Label = $Control/VBoxContainer/difficulty

var pathPoints : Array[PathFollow3D] = []
var offset : float = 0.0
var offsetCount : int = 1
func _ready() -> void:
	$Camera3D.make_current()
	offset = 1.0 / PlayableCharacters.size()
	totalTime.text = "Total Time: " + str(Global.totalTime)
	difficulty.text = "Difficulty: " + str(Global.difficulty)
	populate()
	if Global.winCondition:
		$EndMusic.stream = goodEnding
		$EndMusic.play()
func _process(delta: float) -> void:
	circle.rotate_y(rotateSpeed*delta)
func populate():
	for character in PlayableCharacters:
		var path : PathFollow3D = PathFollow3D.new()
		var instantiatedCharacter : Node3D = character.instantiate()
		pathPoints.append(path)
		circle.add_child(path)
		
		instantiatedCharacter.rotate_y(-PI/2)
		instantiatedCharacter.track = 2
		instantiatedCharacter.minimum = 0.45
		instantiatedCharacter.dance = true
		path.progress_ratio = offset * offsetCount
		path.add_child(instantiatedCharacter)
		
		offsetCount += 1
