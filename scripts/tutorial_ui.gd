extends CanvasLayer

@onready var jumped: Label = $Jumped
@onready var attacked: Label = $Attacked

var step = 0

func _ready():
	start_tutorial()

func start_tutorial():
	step = 0
	jumped.visible = true   # TEMP TEST
	attacked.visible = false
