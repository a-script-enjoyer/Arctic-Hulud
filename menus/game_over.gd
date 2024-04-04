class_name GameOver extends CanvasLayer

@onready var panel: Panel = %Panel
@onready var game_over: Label = %GameOver
@onready var score: Label = %Score
@onready var high_score: Label = %HighScore
@onready var new_score: Label = %NewScore
@onready var restart: Button = %Restart
@onready var quit: Button = %Quit
@onready var screenshot = %Screenshot
@onready var death_scream = %DeathScream
@onready var margin_container: MarginContainer = %MarginContainer
@onready var clean_view_port = %CleanViewPort
@onready var thumper_sound_over = %ThumperSoundOver

func _ready():
	var h_score: int = Global.SAVE_DATA.high_score
	high_score.text = "High Score: " + str(h_score)
	death_scream.finished.connect(_on_death_scream_finished)
	thumper_sound_over.finished.connect(_on_thumper_over_finished)
	death_scream.play()

func set_score(n: int):
	score.text = "Final Score: " + str(n)
	if n > Global.SAVE_DATA.high_score:
		Global.SAVE_DATA.high_score = n
		Global.SAVE_DATA.save()
		# TODO: Add animation to change high score
		high_score.text = "High Score: " + str(n)
		new_score.visible = true
	else:
		new_score.visible = false
	
func _on_screenshot_pressed():
	# FIXME: Doesn't remove overlay
	var boolean_visibility: Array = [panel.visible, high_score.visible,
									margin_container.visible]
	for i in range(len(boolean_visibility)):
		boolean_visibility[i] = false
	var image: Image = get_viewport().get_texture().get_image()
	image.save_png(Global.find_screenshot_path())
	for i in range(len(boolean_visibility)):
		boolean_visibility[i] = true

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
	
func _on_death_scream_finished():
	thumper_sound_over.play()
	
func _on_thumper_over_finished():
	print("thumper restarts")
	thumper_sound_over.play()
	
	
func _notification(what):
	# FIXME: I should fix this like I fixed pause
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false



