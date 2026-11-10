extends VBoxContainer

var isActive: bool = false
var loadedPlayers : Array = []
var placing : Array[Color] = [Color(0.703, 0.646, 0.0, 0.847),Color(11.974, 11.957, 11.867, 0.749),Color(0.78, 0.286, 0.187, 0.863),Color(.8,.4,1,.75)]
func _ready() -> void:
	Actions.winnerOrder.connect(displayWinners)
	Actions.timeDisplay.connect(displayTime)
	Actions.timeDisplay.connect(createTimes)


func _process(delta: float) -> void:
	if isActive and Input.is_action_just_pressed("confirm"):
		Actions.timerStart.emit()
		owner.get_child(3).playMusic()
		isActive = false
		visible = false
		

func displayTime(winnerTimes:Array):
	print(Global.time , "Timer")
	$TimePanel/TimeContainer/Time.text = "Time : " + Global.time

func createTimes(winnerTimes:Array):
	clearTimes()
	for time in winnerTimes:
		var label : Label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		label.text = str(time)
		$PositionPanel/HBoxContainer/Times.add_child(label)
	
func displayWinners(winnerOrder:Array):
	clearWinner()
	var count : int = 0
	for player in winnerOrder:
		
		var label : Label = Label.new()
		label.add_theme_color_override("font_color",placing[count])
		
		
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		label.text = Global.loadedPlayers[player-1]
		$PositionPanel/HBoxContainer/Position/PositionLeaders.add_child(label)
		
		count += 1
func clearTimes():
	for child in $PositionPanel/HBoxContainer/Times.get_children():
		child.queue_free()
func clearWinner():
	for child in $PositionPanel/HBoxContainer/Position/PositionLeaders.get_children():
		child.queue_free()
	
		
