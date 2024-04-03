class_name StartMenu extends CanvasLayer

signal scream_played

const gameplay_scene: PackedScene = preload("res://gameplay/gameplay.tscn")

@onready var high_score: Label = %HighScore
@onready var start: Button = %Start
@onready var quit: Button = %Quit
@onready var thumper_animation: AnimationPlayer = %ThumperAnimation
@onready var scream: AudioStreamPlayer = %Scream
@onready var timer = %Timer

var speed: int = 100
var step: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var h_score: int = Global.SAVE_DATA.high_score
	high_score.text = "High Score: " + str(h_score)
	if _skip_scream:
		return
	thumper_animation.play("thumper_hit")
	
func _on_start_pressed():
	scream_played.emit()
	scream_played.connect(_skip_scream)
	scream.play()
	start.text = "Skip"

func _on_quit_pressed():
	get_tree().quit()
	
func _skip_scream():
	get_tree().change_scene_to_packed(gameplay_scene)
