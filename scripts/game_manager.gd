extends Node2D

signal score_changed(new_score)

var score: int = 0


func add_point():
	score += 1
	emit_signal("score_changed", score)
