extends Node

var item_data: Dictionary

func _ready():
	var file_path = ("res://GameData/ItemData.json")
	item_data = LoadData(file_path)
	
func LoadData(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result as Dictionary
