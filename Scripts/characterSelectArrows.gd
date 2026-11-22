extends Label

var arrowToggle : bool = false
@onready var timer : Timer = $"../Timer"


func _ready() -> void:
	Actions.characterStart.connect(animateArrowsInit)
	Actions.characterSelectInput.connect(animateArrowsEnd)
	timer.timeout.connect(animateArrows)
	
	
	


func animateArrowsInit():
	visible = true
	timer.start()
	
func animateArrowsEnd():
	visible = false
	timer.stop()

func animateArrows():
	
	if arrowToggle:
		text = "←   →"
	else:
		text = "←  →"
		
	arrowToggle = !arrowToggle
