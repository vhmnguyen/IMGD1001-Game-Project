extends CanvasLayer


#@onready var game_manager: Node2D = $"../GameManager"
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Coins: %d" % GameManager.score
	GameManager.score_changed.connect(_on_score_changed)


func _on_score_changed(new_score: int):
	label.text = "Coins: %d" % new_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
