extends Node

var GRID_SIZE: int = 32
var STEP_SIZE = 5
var SAVE_DATA: SaveData

func _ready():
	SAVE_DATA = SaveData.load_or_create()

func find_screenshot_path():
	var _screenshot_date_str = Time.get_datetime_string_from_system().replace(":", "_")
	var exe_dir = OS.get_executable_path().get_base_dir()
	var SCREENSHOT_PATH = exe_dir + "dune" + _screenshot_date_str + ".png"
	return SCREENSHOT_PATH
