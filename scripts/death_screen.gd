extends Control


func _on_restart_pressed() -> void:
	ButtonClickSfx.play()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_main_menu_pressed() -> void:
	ButtonClickSfx.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
