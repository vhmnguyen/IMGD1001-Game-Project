extends Area2D
@onready var sfx_killzone: AudioStreamPlayer2D = $sfx_killzone

func _on_body_entered(body: Node2D) -> void:
	print("Death")
	if body is Pugalion:
		body.dead = true
		sfx_killzone.play()
