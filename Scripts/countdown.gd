extends Control
var count : int = 3

func _ready() -> void:
	countdownBegin()
	
	
func countdownBegin():
	Global.countdown = true
	$Timer.timeout.connect(updateLabel)
	
	
func updateLabel():
	if count > 0:
		$Label.text = str(count)
		count -= 1
	else:
		$Timer.stop()
		Actions.countdown.emit()
		Global.countdown = false
		queue_free()
