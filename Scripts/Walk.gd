extends Node3D
@export var modelPath : NodePath


@onready var audio_stream_player : AudioStreamPlayer = $"../AudioStreamPlayer"

var record_bus_index : int
#var record_effect: AudioEffectRecord
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
@export var deltav : float = 1.0
var record_effect
var model
func _ready() -> void:
	model = get_node(modelPath)
	AudioServer.set_input_device("Microphone (fifine Microphone)")
	
	#AudioServer.set_input_device_active(0)

	record_bus_index = AudioServer.get_bus_index("recording")
	#record_effect = AudioServer.get_bus_effect(record_bus_index,0)
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
	#record_effect.set_recording_active(true)
	

func _process(delta: float) -> void:
	
	

# Get the currently active input device
	
	var volume_mag = spectrum_analyzer.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)
	
	if volume_mag > minimum:
		
		model.position.y = volume_mag * multiplier
		#$peach/Armature/Skeleton3D.position.y = volume_mag * multiplier
	else:
		#$peach/Armature/Skeleton3D.position.y = 0
		model.position.y = 0


func _on_timer_timeout() -> void:
	audio_stream_player.playing = false
	await get_tree().create_timer(0.1).timeout
	audio_stream_player.playing = true
	
