class_name Pugalion
extends CharacterBody2D


const SPEED = 100.0
const DASH_SPEED = 300.0
const JUMP_VELOCITY = -225.0
var dead = false
var isAttacking = false
var isDashing = false
var canDash = true
var facingDirection = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var collision_area: Area2D = $Hitbox
@onready var sfx_jump: AudioStreamPlayer2D = $sfx_jump
@onready var sfx_attack: AudioStreamPlayer2D = $sfx_attack
@onready var sfx_pugalion_death: AudioStreamPlayer2D = $sfx_pugalion_death
@onready var sfx_dash: AudioStreamPlayer2D = $sfx_dash
@onready var dash_timer: Timer = $dash_timer
@onready var dash_again_timer: Timer = $dash_again_timer

# This function will run first to check if character's dead 
func _process(delta: float) -> void:
	if not dead:
		physics_process(delta)
	else:
		animated_sprite.play("death")
		animated_sprite.z_index = 10


func physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if isDashing:
			velocity.y = 0
		else:
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
		facingDirection = 1
		
	elif direction < 0:
		animated_sprite.flip_h = true
		collision_shape.position.x = -24
		facingDirection = -1
		
	#Attacking
	if Input.is_action_just_pressed("attack") and is_on_floor():
		isAttacking = true
		collision_shape.disabled = false
		sfx_attack.play()
	#Dashing
	if Input.is_action_just_pressed("dash") and canDash:
		dash_timer.start()
		dash_again_timer.start()
		isDashing = true
		canDash = false
		collision_shape.disabled = false
		sfx_dash.play()

	# Play animations
	if is_on_floor():
		#Dash
		if isDashing:
			animated_sprite.play("dash")
		elif isAttacking:
			animated_sprite.play("attack")
		#Idle
		elif direction == 0:
		#elif direction == 0 and isAttacking == false and isDashing == false:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if isDashing:
			animated_sprite.play("dash")
		else:
			animated_sprite.play("jump")

	# Apply movement
	if isDashing:
		velocity.x = facingDirection * DASH_SPEED
	else:
		velocity.x = direction * SPEED
	
	move_and_slide()


# Handles when certain animations are done playing (attack, death)
func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		isAttacking = false
		collision_shape.disabled = true
		
	elif animated_sprite.animation == "death":
		queue_free()
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")

# Interaction with Ground Goblin
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is GroundGoblin:
		body.dead = true

func _on_dash_timer_timeout() -> void:
	#stop dashing
	isDashing = false
	collision_shape.disabled = true

func _on_dash_again_timer_timeout() -> void:
	#can dash again
	canDash = true
