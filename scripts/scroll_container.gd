extends ScrollContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	scroll_vertical = get_v_scroll_bar().max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_vertical -= 250 * delta
