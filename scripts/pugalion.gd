class_name Pugalion
extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -225.0
var dead = false
var isAttacking = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var collision_area: Area2D = $Hitbox
@onready var sfx_jump: AudioStreamPlayer2D = $sfx_jump
@onready var sfx_attack: AudioStreamPlayer2D = $sfx_attack


# This function will run first to check if character's dead 
func _process(delta: float) -> void:
	if not dead:
		physics_process(delta)
	else:
		animated_sprite.play("death")


func physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sfx_jump.play()

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
		collision_shape.position.x = -12
		
	elif direction < 0:
		animated_sprite.flip_h = true
		collision_shape.position.x = -24

	# Play animations
	if is_on_floor():
		if direction == 0 && isAttacking == false:
			animated_sprite.play("idle")
		elif direction == 0 && isAttacking == true:
			animated_sprite.play("attack")
		elif direction != 0 && isAttacking == false:
			animated_sprite.play("run")
		else:
			direction = 0
			animated_sprite.play("attack")
	else:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("attack") && is_on_floor():
		isAttacking = true
		collision_shape.disabled = false
		sfx_attack.play()

	move_and_slide()


# Handles when certain animations are done playing (attack, death)
func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		isAttacking = false
		collision_shape.disabled = true
		
	if animated_sprite.animation == "death":
		queue_free()
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")


# Interaction with Ground Goblin
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is GroundGoblin:
		body.dead = true
