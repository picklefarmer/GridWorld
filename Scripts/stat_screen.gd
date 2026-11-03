extends VBoxContainer

var isActive: bool = false
var loadedPlayers : Array = []
func _ready() -> void:
	Actions.winnerOrder.connect(displayWinners)




func _process(delta: float) -> void:
	if isActive and Input.is_action_just_pressed("confirm"):
		owner.get_child(2).playMusic()
		isActive = false
		visible = false
		
func displayWinners(winnerOrder:Array):
	clearWinner()
	for player in winnerOrder:
		var label : Label = Label.new()
		label.text = Global.loadedPlayers[player-1]
		$Panel/Label.add_child(label)

func clearWinner():
	for child in $Panel/Label.get_children():
		child.queue_free()
	
		
