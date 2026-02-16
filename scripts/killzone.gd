extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Death")
	if body is Pugalion:
		body.dead = true
	#body.get_node("CollisionShape2D").queue_free()
