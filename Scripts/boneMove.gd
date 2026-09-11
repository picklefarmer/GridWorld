extends Skeleton3D

@export var bone_name: String = "1"
var bone_idx: int
var nodePath : NodePath
var current_pos: Vector3
var record_bus_index : int
#var audio_stream_player : AudioStreamPlayer
#var record_effect: AudioEffectRecord
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
@export var deltav : float = 1.0
@export var track: String = "recording"

func _ready() -> void:
	
	Actions.syncLip.connect(rebus)

	bone_idx = find_bone(bone_name)
	current_pos = get_bone_pose_position(bone_idx)

	record_bus_index = AudioServer.get_bus_index(track)

	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)

	

func _process(delta: float) -> void:
	
	
	var volume_mag = spectrum_analyzer.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)
	#print( volume_mag)
	if volume_mag > minimum:
		var new_pos = current_pos + Vector3(0, volume_mag*multiplier, 0) 
		set_bone_pose_position(bone_idx, new_pos)
		#current_pose = current_pose.rotated_local(Vector3.UP, volume_mag * multiplier)
		
		
	else:
		set_bone_pose_position(bone_idx, current_pos)
		
func rebus():
	if owner.get("active") != null:
		track = "recording"
		print("rebus")
		record_bus_index = AudioServer.get_bus_index("recording")
		spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
	
