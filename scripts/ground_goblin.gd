class_name GroundGoblin
extends CharacterBody2D


const SPEED = 80


var direction = -1
var dead = false
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D


# TODO: implement tracking and following players instead of this simple
# 		collision detection --> change direction logic

#func _process(delta: float) -> void:
	#if ray_cast_left.is_colliding():
		#direction = 1
		#animated_sprite_2d.flip_h = true
	#if ray_cast_right.is_colliding():
		#direction = -1
		#animated_sprite_2d.flip_h = false
	#
	#position.x += direction * SPEED * delta


# Handles when certain animations are done playing (death)
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		queue_free()


# Interaction with character (Pugalion)
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Pugalion:
		body.dead = true
