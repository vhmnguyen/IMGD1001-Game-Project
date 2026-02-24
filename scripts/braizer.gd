extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if body is Pugalion:
		animated_sprite.play("blaze")
		animated_sprite.z_index = 10
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		
		var next_level_path = "res://scenes/level_" + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
