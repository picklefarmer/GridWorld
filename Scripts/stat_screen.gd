extends VBoxContainer

var isActive: bool = false
var loadedPlayers : Array = []
func _ready() -> void:
	Actions.winnerOrder.connect(displayWinners)
	Actions.timeDisplay.connect(displayTime)



func _process(delta: float) -> void:
	if isActive and Input.is_action_just_pressed("confirm"):
		Actions.timerStart.emit()
		owner.get_child(2).playMusic()
		isActive = false
		visible = false
		

func displayTime():
	print(Global.time , "Timer")
	
	$Panel/VBoxContainer/Label2.text = "Time : " + Global.time
func displayWinners(winnerOrder:Array):
	clearWinner()
	for player in winnerOrder:
		var label : Label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.text = Global.loadedPlayers[player-1]
		
		$Panel/VBoxContainer/Label.add_child(label)
func clearWinner():
	for child in $Panel/VBoxContainer/Label.get_children():
		child.queue_free()
	
		
