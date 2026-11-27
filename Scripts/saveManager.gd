extends Node


const SAVE_PATH := "user://cfgGame.tres"
var data: SaveData = SaveData.new()

func _ready() -> void:
	loadCfg()
	
func save_game() -> void:
	var error := ResourceSaver.save(data, SAVE_PATH)
	if error != OK:
		push_error("Failed to save game: " + str(error))

func loadCfg():
	if not ResourceLoader.exists(SAVE_PATH):
		data = SaveData.new()
		return
	var loaded_data := ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	if loaded_data is SaveData:
		data = loaded_data
	else:
		push_warning("Save file corrupted or invalid. Creating new save.")
		data = SaveData.new()
