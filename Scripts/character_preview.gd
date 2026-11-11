extends VBoxContainer
@export var isWinner : bool = false
@export var characterTextures : Array[Texture2D] = []
@onready var characterPreview : Array[TextureRect] = [ $CharacterOne2,$CharacterOne4, $CharacterOne,$CharacterOne3]
@onready var characterStanding: Array[TextureRect] = [ $CharacterOne,$CharacterOne2, $CharacterOne3,$CharacterOne4]
func _ready() -> void:
	if !isWinner:
		Actions.updatePreview.connect(updatePreview)
	else:
		#Actions.winnerOrder.connect(updateStanding)
		Actions.updateStanding.connect(updateStanding)


func updatePreview():
	var count:int = 0
	
	for character in characterPreview:
		character.texture = characterTextures[Global.characterNames.find(Global.loadedPlayers[count])]
		#print(character,character.texture,count,Global.loadedPlayers[count])
		count+=1
		
func updateStanding(winnerOrder: Array):
	var count : int = 0
	clearStanding()
	if winnerOrder:
		for character in winnerOrder:
			var winner = Global.loadedPlayers[character-1]
			characterStanding[count].texture = characterTextures[Global.characterNames.find(winner)]
			characterStanding[count].visible = true
			count += 1
	else:
		for character in characterStanding:
			character.texture = null


func clearStanding():
	for character in characterStanding:
		character.visible = false
