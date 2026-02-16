class_name Pugalion
extends CharacterBody2D


var SPEED = 100.0
const JUMP_VELOCITY = -225.0
var dead = false
var isAttacking = false
var isDashing = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var collision_area: Area2D = $Hitbox
@onready var sfx_jump: AudioStreamPlayer2D = $sfx_jump
@onready var sfx_attack: AudioStreamPlayer2D = $sfx_attack
@onready var sfx_pugalion_death: AudioStreamPlayer2D = $sfx_pugalion_death
@onready var dash_timer: Timer = $dash_timer


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
		#Idle
		if direction == 0 && isAttacking == false && isDashing == false:
			animated_sprite.play("idle")
		#Idle + Attack
		elif direction == 0 && isAttacking == true && isDashing == false:
			animated_sprite.play("attack")
		#Run
		elif direction != 0 && isAttacking == false && isDashing == false:
			animated_sprite.play("run")
		#Run + Attack
		elif direction != 0 && isAttacking == true && isDashing == false:
			direction = 0
			animated_sprite.play("attack")
		#Idle + Dash
		elif direction == 0 && isDashing == true:
			animated_sprite.play("dash")
		#Run + Dash
		elif direction != 0 && isDashing == true:
			animated_sprite.play("dash")
	else:
		if isDashing:
			animated_sprite.play("dash")
		else:
			animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#Attacking
	if Input.is_action_just_pressed("attack") && is_on_floor():
		isAttacking = true
		isDashing = false
		collision_shape.disabled = false
		sfx_attack.play()
	#Dashing	
	if Input.is_action_just_pressed("dash"):
		dash_timer.start()
		SPEED *= 3
		velocity.x = direction * SPEED
		isDashing = true
		isAttacking = true
		collision_shape.disabled = false

	move_and_slide()


# Handles when certain animations are done playing (attack, death)
func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		isAttacking = false
		collision_shape.disabled = true
		
	if animated_sprite.animation == "dash":
		isDashing = false
		isAttacking = false
		collision_shape.disabled = true
		
	if animated_sprite.animation == "death":
		queue_free()
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")


# Interaction with Ground Goblin
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is GroundGoblin:
		body.dead = true


func _on_dash_timer_timeout() -> void:
	#reset speed after dash
	SPEED = 100.0
