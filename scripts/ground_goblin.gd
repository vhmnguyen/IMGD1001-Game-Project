extends Node2D

const SPEED = 80

var direction = -1
var dead = false
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



#func _process(delta: float) -> void:
	#if ray_cast_left.is_colliding():
		#direction = 1
		#animated_sprite_2d.flip_h = true
	#if ray_cast_right.is_colliding():
		#direction = -1
		#animated_sprite_2d.flip_h = false
	#
	#position.x += direction * SPEED * delta

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Headbutt"):
		dead = true
		animated_sprite_2d.play("death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		queue_free()
