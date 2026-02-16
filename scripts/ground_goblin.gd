class_name GroundGoblin
extends CharacterBody2D

const SPEED = 20

var dead = false
var idling = true
var target: Node2D = null

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D


func _physics_process(_delta: float) -> void:
	if dead:
		velocity = Vector2.ZERO
		collision_shape_2d.disabled = true
		animated_sprite_2d.play("death")
		return
	
	if not idling and target:
		var direction = (target.global_position - global_position).normalized()
		animated_sprite_2d.flip_h = (direction.x > 0)
		velocity = direction * SPEED
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()


func _on_detection_box_body_entered(body: Node2D) -> void:
	if body is Pugalion:
		target = body
		idling = false


func _on_detection_box_body_exited(body: Node2D) -> void:
	if body is Pugalion:
		target = null
		idling = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Pugalion:
		body.dead = true
		body.sfx_pugalion_death.play()
