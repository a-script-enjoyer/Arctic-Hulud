class_name StartMenu extends CanvasLayer

const gameplay_scene: PackedScene = preload("res://gameplay/gameplay.tscn")

@onready var high_score: Label = %HighScore
@onready var start: Button = %Start
@onready var quit: Button = %Quit
#@onready var thumper_bot = %ThumperBot
#@onready var thumper_top: Thumper = %ThumperTop as Thumper

var speed: int = 100
var step: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var h_score: int = Global.SAVE_DATA.high_score
	high_score.text = "High Score: " + str(h_score)

func _on_start_pressed():
	get_tree().change_scene_to_packed(gameplay_scene)
	
func _on_quit_pressed():
	get_tree().quit()
