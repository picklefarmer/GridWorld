extends SpringBoneSimulator3D


#@onready var audio_stream_player : AudioStreamPlayer = $"../AudioStreamPlayer"

var record_bus_index : int
#var record_effect: AudioEffectRecord
var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
@export var deltav : float = 1.0
@export var stride : float = 1.0
@export var isLeg : bool = false
@export var bus : String = "recording"
@export var track : int = 0
@export var alreadyUp: float = 1.0
@export var runSpeed : float = 0.074
var canMove : bool = true
func _ready() -> void:
	Actions.syncLip.connect(rebus)
	if !owner.active:
		record_bus_index = AudioServer.get_bus_index(bus)
		spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
	
	

func _process(delta: float) -> void:
	
	
	var volume_mag = spectrum_analyzer.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)

	
	if volume_mag > minimum :
		if canMove:
			#if volume_mag >= alreadyUp:
				#canMove = true
				#external_force = Vector3.ZERO
				#alreadyUp = 0.0
				#pass
			stride *= -1.0
			var global_force_vector : Vector3 = Vector3(0,0,volume_mag *multiplier*stride)
			var skeleton: Skeleton3D = get_parent() as Skeleton3D
			var rotVector : Transform3D = skeleton.global_transform * skeleton.get_bone_global_pose(0)
			var localForce : Vector3 = rotVector.basis.inverse() * global_force_vector
			external_force = localForce
			alreadyUp = volume_mag
			if isLeg : 
				Actions.goForward.emit(volume_mag*runSpeed,track)
			canMove = false
	else:
		canMove = true
		external_force = Vector3(0,0,0)
		alreadyUp = 0.0		

	
func rebus():
	if owner.active:
		track = 1
		print("rebus")
		record_bus_index = AudioServer.get_bus_index("recording")
		spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index,0)
		print(spectrum_analyzer)
