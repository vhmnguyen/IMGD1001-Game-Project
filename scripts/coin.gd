extends Area2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Pugalion:
		GameManager.add_point()
		animation_player.play("pickup")
