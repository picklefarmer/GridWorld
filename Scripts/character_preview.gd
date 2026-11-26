extends VBoxContainer
@export var isWinner : bool = false
@export var characterTextures : Array[Texture2D] = []
@onready var characterPreview : Array[TextureRect] = [ $CharacterOne2,$CharacterOne4, $CharacterOne,$CharacterOne3]
@onready var characterStanding: Array[TextureRect] = [ $CharacterOne,$CharacterOne2, $CharacterOne3,$CharacterOne4]
@onready var characterMedal: Array[TextureRect] = [ $CharacterOne2,$CharacterOne4, $CharacterOne,$CharacterOne3]
var winnerColors :Array[Color] = [Color(17.131, 15.793, 0.0, 0.847),Color(0.735, 0.735, 0.728, 0.765),Color(0.804, 0.296, 0.194, 0.863),Color(1.141, 0.582, 1.421, 0.749)]
func _ready() -> void:
	
	Actions.showStanding.connect(showStanding)
	Actions.resetColors.connect(resetPreviewColor)
	if !isWinner:
		Actions.previewOff.connect(previewOff)
		Actions.previewOn.connect(previewOn)
		Actions.updatePreview.connect(updatePreview)
		
	else:
		Actions.toggleWinLabel.connect(togglePreview)
		#Actions.winnerOrder.connect(updateStanding)
		
		Actions.updateStanding.connect(updateStanding)

func togglePreview():
	visible = !visible
func showStanding(character:int,color:Color):
	characterMedal[character].material.set("shader_parameter/line_color",color)
	
func previewOff():
	visible = false
func previewOn():
	visible = true	
	
func updatePreview():
	var count:int = 0
	
	for character in characterPreview:
		character.texture = characterTextures[Global.characterNames.find(Global.loadedPlayers[count])]
		print(count," ",Global.loadedPlayers[count])
		count+=1
		
func updateStanding(winnerOrder: Array):
	var count : int = 0
	clearStanding()
	if winnerOrder:
		for character in winnerOrder:
			var winner = Global.loadedPlayers[character-1]
			characterStanding[count].texture = characterTextures[Global.characterNames.find(winner)]
			characterStanding[count].visible = true
			characterStanding[count].material.set("shader_parameter/line_color",winnerColors[count])
			count += 1
	else:
		for character in characterStanding:
			character.texture = null
	

func resetPreviewColor():
	
	for character in characterPreview:
		character.material.set("shader_parameter/line_color",Color.AQUA)
		
func clearStanding():
	for character in characterStanding:
		character.visible = false
