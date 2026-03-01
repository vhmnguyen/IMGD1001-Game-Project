extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var next_level_path

func _on_body_entered(body: Node2D) -> void:
	if body is Pugalion:
		animated_sprite.play("blaze")
		animated_sprite.z_index = 10
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		
		next_level_path = "res://scenes/level_" + str(next_level_number) + ".tscn"


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "blaze":
		get_tree().change_scene_to_file(next_level_path)
