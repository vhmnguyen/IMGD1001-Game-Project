extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	ButtonClickSfx.play_click()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_version_notes_pressed() -> void:
	ButtonClickSfx.play_click()
	get_tree().change_scene_to_file("res://scenes/version_notes.tscn")


func _on_credits_pressed() -> void:
	ButtonClickSfx.play_click()
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
