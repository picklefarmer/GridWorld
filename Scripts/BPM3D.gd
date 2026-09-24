extends AudioStreamPlayer3D
var mic_input_index : int
var mic_spectrum : AudioEffectInstance


@export var bpm: float = 100.0
var seconds_per_beat: float = 60.0
var song_position: float = 0.0
var song_position_in_beats: int = 0
var currentMeasure : int = 0
var currentStep : int = 0
var last_reported_beat: int = 0
var beatCount : int = 0
var section : int = 0
var beatToggle : bool = true
@export var MIN_DB: int = 82
@export var minimum = 0.05
@export var multiplier : float = 0.25
var beatWhole: float = 64.0
var beatHalf: float = 32.0
var offbeat : float = 6.0
var off : float  = 0.0
var beatReturn : float = 52.0
var time: float = 4.25

var audioLatency :float = 0.0

func _ready() -> void:
	seconds_per_beat = 60.0 / bpm
	mic_input_index = AudioServer.get_bus_index("recording")
	mic_spectrum = AudioServer.get_bus_effect_instance(mic_input_index,0)
	audioLatency = AudioServer.get_output_latency()
	
func _physics_process(delta: float) -> void:

	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= audioLatency
		song_position_in_beats = int(floor(song_position / (seconds_per_beat/4)))
		currentStep= song_position_in_beats%4
		currentMeasure =  (song_position_in_beats/4)%4
		#print(currentMeasure," : ",currentStep)
		if currentStep == section:
			
			#print(song_position_in_beats,"return")
			return
		else:
			section = currentStep	
			match currentMeasure:
				0:
					if currentStep == 0 or currentStep == 3:
						compare(beatWhole,delta )
					else:
						compare(off,delta)
						#section = currentMeasure
					#beatToggle = false
				1:
					if currentStep == 0 or currentStep == 3:	
						compare(offbeat,delta)	
					else:
						compare(off,delta)
						#section = currentMeasure
						#beatToggle = false
				2:
					if currentStep == 0 or currentStep == 3:
						compare(beatHalf,delta)
					else:
						compare(off,delta)
						#section = currentMeasure
						#beatToggle = false
				3:
					if currentStep == 0 or currentStep == 3:
						compare(offbeat,delta)
					else:
						compare(off,delta)
						#section = currentMeasure
						#beatToggle = false
		
			
				#beatToggle = !beatToggle

		#if song_position_in_beats > last_reported_beat:
			#last_reported_beat = song_position_in_beats
			##compare(last_reported_beat)
			#compare(beatReturn, delta)
		#beatCount = (beatCount +1)%4
		
func compare(beatIndex,delta):
	
	var volume_mag = mic_spectrum.get_magnitude_for_frequency_range(350.0,3000.0,AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length()
	volume_mag = clamp((MIN_DB + linear_to_db(volume_mag))/MIN_DB,0,1)
	#print("fired",beatIndex,volume_mag)
	if volume_mag > minimum:
		#print("beat ","section: ",section," : ",beatIndex," : ", currentMeasure)
		Actions.beatOff.emit(beatIndex,delta,time)
		
		
	
	
