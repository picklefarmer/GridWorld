extends RigidBody3D

@onready var audio_stream_player : AudioStreamPlayer = $"../AudioStreamPlayer"

var record_bus_index : int
#var record_effect: AudioEffectRecord
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
@export var deltav : float = 1.0
func _ready() -> void:
	
	#print(AudioServer.get_input_device_list())
	record_bus_index = AudioServer.get_bus_index("recording")
	#record_effect = AudioServer.get_bus_effect(record_bus_index,0)
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
	#record_effect.set_recording_active(true)
	

func _process(delta: float) -> void:
	
	var volume_mag = spectrum_analyzer.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)
	#print( volume_mag)
	if volume_mag > minimum:
		position.x = volume_mag * multiplier
		#print(position.x , "position")
	else:
		position.x = 0


func _on_timer_timeout() -> void:
	audio_stream_player.playing = false
	await get_tree().create_timer(0.1).timeout
	audio_stream_player.playing = true
	
