extends VBoxContainer

@export var characterTextures : Array[Texture2D] = []
@onready var characterPreview : Array[TextureRect] = [ $CharacterOne2,$CharacterOne, $CharacterOne4,$CharacterOne3]
func _ready() -> void:
	Actions.updatePreview.connect(updatePreview)


func updatePreview():
	var count:int = 0
	for character in characterPreview:
		character.texture = characterTextures[Global.characterNames.find(Global.loadedPlayers[count])]
		print(character,character.texture,count,Global.loadedPlayers[count])
		count+=1
