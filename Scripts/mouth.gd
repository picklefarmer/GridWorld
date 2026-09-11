extends SpringBoneSimulator3D


#@onready var audio_stream_player : AudioStreamPlayer = $"../AudioStreamPlayer"

var record_bus_index : int
#var record_effect: AudioEffectRecord
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
@export var deltav : float = 1.0
@export var speaking : bool = false
@export var bus : String = "recording"

func _ready() -> void:
	
	Actions.syncLip.connect(rebus)
	#print(AudioServer.get_input_device_list())
	record_bus_index = AudioServer.get_bus_index(bus)
	#record_effect = AudioServer.get_bus_effect(record_bus_index,0)
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
	#record_effect.set_recording_active(true)
	

func _process(delta: float) -> void:
	
	
	var volume_mag = spectrum_analyzer.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)
	#print( volume_mag)
	if volume_mag > minimum:
		var global_force_vector : Vector3 = Vector3(0,0,volume_mag *multiplier)
		var skeleton: Skeleton3D = get_parent() as Skeleton3D
		var rotVector : Transform3D = skeleton.global_transform * skeleton.get_bone_global_pose(0)
		var localForce : Vector3 = rotVector.basis * global_force_vector
		external_force = localForce
		#external_force.y = -volume_mag * multiplier
		#position.x = -volume_mag * multiplier
		
	else:
		external_force = Vector3.ZERO


func rebus():
	if owner.active:
		print("rebus")
		bus = "recording"
		record_bus_index = AudioServer.get_bus_index("recording")
		spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
		print(spectrum_analyzer)	
