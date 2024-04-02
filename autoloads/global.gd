extends Node

var GRID_SIZE: int = 32
var STEP_SIZE = 5

var SAVE_DATA: SaveData

func _ready():
	SAVE_DATA = SaveData.load_or_create()
