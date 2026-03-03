extends Control


func _on_back_pressed() -> void:
	ButtonClickSfx.play_click()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
