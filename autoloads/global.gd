extends Node

var GRID_SIZE: int = 32
var STEP_SIZE = 5
var SAVE_DATA: SaveData

func _ready():
	SAVE_DATA = SaveData.load_or_create()

func find_screenshot_path():
	var _screenshot_date_str = Time.get_datetime_string_from_system().replace(":", "_")
	var SCREENSHOT_PATH = "user://screenshots/" + _screenshot_date_str + ".png"
	return SCREENSHOT_PATH
