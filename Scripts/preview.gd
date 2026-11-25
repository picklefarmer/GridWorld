extends Node3D
class_name previewScript

@onready var music : Array[AudioStreamPlayer] = [$Microphone,$"Track 2 streamer", $"Track 3 streamer", $"Track 4 streamer"]
@onready var players : Array[PathFollow3D] = [$Path3D2/track1,$Path3D2/track2,$Path3D2/track3,$Path3D2/track4]



func _ready() -> void:
	Global.preview = true
	pauseProcess()
	removePlayers()
	playMusic()

func removePlayers():
	for player in players:
		for child in player.get_children():
			child.queue_free()
	

func pauseProcess():
	process_mode = Node.PROCESS_MODE_DISABLED
	
func playMusic():
	for instrument in music:
		instrument.play()
