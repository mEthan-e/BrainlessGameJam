extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@export var on_col: Color
@export var off_col: Color
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

func disable_laser() -> void:
	area_2d.monitoring = false
	animated.modulate = off_col

func _process(delta: float) -> void:
	area_2d.monitoring = true
	animated.modulate = on_col
