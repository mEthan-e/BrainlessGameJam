extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var line_2d: Line2D = $Line2D

func disable_laser() -> void:
	area_2d.monitoring = false
	line_2d.width = 0.0

func _process(delta: float) -> void:
	area_2d.monitoring = true
	line_2d.width = 4.0
