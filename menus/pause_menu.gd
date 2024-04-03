class_name PauseMenu extends CanvasLayer


@onready var current_score: Label = %"Current Score"
@onready var high_score = %HighScore
@onready var screenshot: Button = %Screenshot
@onready var quit: Button = %Quit
@onready var resume: Button = %Resume
@onready var pause_drums = %PauseDrums

func _ready():
	var h_score: int = Global.SAVE_DATA.high_score
	high_score.text = "High Score: " + str(h_score)
	pause_drums.play()
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()

func set_score(n: int):
	current_score.text = "Current Score: " + str(n)

func _on_screenshot_pressed():
	# FIXME: Disable Scene visibility for screenshot
	visible = false
	var image: Image = get_viewport().get_texture().get_image()
	image.save_png(Global.find_screenshot_path())
	visible = true
	
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	# TODO: Are you sure?

func _on_quit_pressed():
	get_tree().quit()
	# TODO: Are you sure?

func _on_resume_pressed():
	queue_free()

func _on_continue_music():
	# TODO: Continue music when going from gameplay scene to pause menu
	pass



