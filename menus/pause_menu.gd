class_name PauseMenu extends CanvasLayer

@onready var current_score: Label = %"Current Score"
@onready var high_score = %"High Score"
@onready var screenshot: Button = %Screenshot
@onready var quit: Button = %Quit
@onready var resume: Button = %Resume

func _ready():
	var h_score: int = Global.SAVE_DATA.high_score
	high_score.text = "High Score: " + str(h_score)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()

func set_score(n: int):
	current_score.text = "Current Score: " + str(n)

func _on_screenshot_pressed():
	queue_free()

func _on_restart_pressed():
	get_tree().reload_current_scene()
	# TODO: Are you sure?

func _on_quit_pressed():
	get_tree().quit()
	# TODO: Are you sure?

func _on_resume_pressed():
	pass # Replace with function body.
	
func _notification(what):
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false


