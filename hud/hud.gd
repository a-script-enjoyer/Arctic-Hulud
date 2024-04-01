class_name HUD extends CanvasLayer

@onready var current_score = %Score
@onready var high_score = %HighScore

# Called when the node enters the scene tree for the first time.
func _ready():
	high_score.text = "High Score: " + str(Global.SAVE_DATA.high_score)
	
func update_score(score):
	current_score.text = "Score: " + str(score)
