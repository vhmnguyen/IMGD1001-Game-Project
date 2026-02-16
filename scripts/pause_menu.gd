extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and get_tree().current_scene.name != "MainMenu" and get_tree().current_scene.name != "Credits" and get_tree().current_scene.name != "VersionNotes":	
		if Input.is_action_just_pressed("pause") and not get_tree().paused:
			show()
			get_tree().paused = true
		elif Input.is_action_just_pressed("pause") and get_tree().paused:
			hide()
			get_tree().paused = false


func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_restart_pressed() -> void:
	hide()
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
