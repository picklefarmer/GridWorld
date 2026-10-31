extends Node3D
var tween : Tween
var tween2: Tween
@onready var characters : Array = [
	$GrapeMan,
	$Orangeman,
	$Bananaman,
	$Strawberry,
	$Blueberryman,
	$Pearman,
	$Cherryman,
	$Lemonman,
	$Appleman,
	$Peachman,
	$Watermelonman,
	$Starfruitman	
	]

func _ready() -> void:
	$Camera3D/AreaLight3D.light_energy = 0.0
func _process(delta: float) -> void:
	if $"../Lore".introDone and !$"../Lore".gameStart:
		if Input.is_action_just_pressed("trackLeft"):
			switchCharacter(-1)
		if Input.is_action_just_pressed("trackRight"):
			switchCharacter(1)
		
func switchCharacter(direction:int):

	Global.globalPlayerIndex = posmod(Global.globalPlayerIndex+direction, characters.size())
	print(Global.globalPlayerIndex)
	$Camera3D/AreaLight3D.light_energy = 0.0
	centerCamera()
	
	
func centerCamera():
	tween = create_tween()
	tween2 = create_tween()
	
	var cameraTarget : Node3D = characters[Global.globalPlayerIndex]
	
	tween.tween_property($Camera3D,"global_position:x",cameraTarget.global_position.x,0.5)
	tween2.tween_property($Camera3D/AreaLight3D,"light_energy", 2.669,1.55)
	$"../Lore".charSelect = true
