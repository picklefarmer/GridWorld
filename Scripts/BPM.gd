extends AudioStreamPlayer
var mic_input_index : int
var mic_spectrum : AudioEffectInstance


@export var bpm: float = 120.0
var seconds_per_beat: float = 60.0
var song_position: float = 0.0
var song_position_in_beats: int = 0
var last_reported_beat: int = 0
var beatCount : int = 0
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
@export var beatWhole: float = 4.0
@export var beatHalf: float = 2.0
@export var beatReturn : float = 52.0
@export var time: float = 5.0

func _ready() -> void:
	seconds_per_beat = 60.0 / bpm
	mic_input_index = AudioServer.get_bus_index("recording")
	mic_spectrum = AudioServer.get_bus_effect_instance(mic_input_index,0)
	
func _physics_process(delta: float) -> void:

	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / seconds_per_beat))
		#print(song_position_in_beats%4,beatCount)
		
		
		match beatCount:
			0:compare(0.0,delta )
			1:compare(beatWhole,delta)	
			2:compare(0.0,delta)
			3:compare(beatHalf,delta)
		beatCount = (beatCount +1)%4
		#print(beatCount)
		#if song_position_in_beats%
		if song_position_in_beats > last_reported_beat:
			last_reported_beat = song_position_in_beats
			#compare(last_reported_beat)
			compare(beatReturn, delta)
func compare(beatIndex,delta):
	
	var volume_mag = mic_spectrum.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)
	
	if volume_mag > minimum:
		#print("beat",beatIndex)
		Actions.beatOff.emit(beatIndex,delta,time)
