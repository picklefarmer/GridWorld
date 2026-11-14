extends Node3D

var tracks : Array = [0,0,0,0]
var trackEnds : Array = [false,false,false,false]
var timer : int = 0
var colorCount : int = 0
var winColors: Array[Color] = [Color(17.131, 15.793, 0.0, 0.847),Color(0.735, 0.735, 0.728, 0.765),Color(0.804, 0.296, 0.194, 0.863),Color(1.141, 0.582, 1.421, 0.749)]
#var winners : Array[int] = []
#var raceTime : Timer = $RaceTime
@export var lapCap : int = 2

func _ready() -> void:
	Actions.meter_Progress.connect(meter_length)
	Actions.meter_Progress.connect(changeColor)
	Actions.timerStart.connect(startTimer)
	Actions.timerStop.connect(stopTimer)

	$RaceTime.timeout.connect(countTime)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ProgressMeter"):
		visible = !visible

func startTimer():
	print("time of start")
	$RaceTime.start()	
	
func stopTimer():
	print("time of stop")
	$RaceTime.stop()		

func meter_length(length:float,trackInd:int):

	match trackInd:
		1: $progress_meter_bar_player/Plane.scale.x = length
		2: $progress_meter_bar2/Plane.scale.x = length
		3: $progress_meter_bar3/Plane.scale.x = length
		4: $progress_meter_bar4/Plane.scale.x = length

func changeColor(length:float,trackInd:int):
	if trackEnds[trackInd-1] == true and length >= 0 and length < 0.98:
		trackEnds[trackInd-1] = false
	elif trackEnds[trackInd -1 ] == false and length >= 0.98 :
		trackEnds[trackInd - 1] = true
		if tracks[trackInd-1] < lapCap:
			Actions.meterColor.emit(tracks[trackInd-1],trackInd)
			tracks[trackInd-1] = tracks[trackInd-1] +1
		else:
			
			if !Global.winners.has(trackInd):
				Global.winners.append(trackInd)
				if colorCount <4:
					Actions.showStanding.emit(trackInd-1,winColors[colorCount])
					colorCount += 1
				Global.winnerTime.append(timer)
				Global.isFinished[trackInd-1] = true
				
				print(trackInd, " Won ")	
		
			if trackInd == 1:
				Actions.revolveCamera.emit()
				
				if Global.globalRacewayIndex+1 == Global.globalRacewaySize:
					thanksForPlaying()
				else:
					
					#Global.winners.clear()
					print("timer in progress meter",Global.time,timer)
					Global.time = str(timer)
					timer = 0
					Actions.changeLevel.emit(1)
					
					
			
		

func thanksForPlaying():
	Actions.endGame.emit()
	print("game over")
func countTime():
	#print(timer)
	timer = timer + 1		
	Global.time = str(timer)
