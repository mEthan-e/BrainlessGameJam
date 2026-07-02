extends Node

var current_controlling: int = 2
var slime_part: int
var max_next: int

var split_type: String

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next"):
		current_controlling += 1
		if current_controlling > max_next:
			current_controlling = 2
	
	print(current_controlling)
