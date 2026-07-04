extends StaticBody2D

@export var extention_length: float = 5.0
var extending: bool = false
@onready var original_length: float = scale.x
var last_scale: float
var bodys_on_bridge: Array

func extend(time: int) -> void:
	if(scale.x == extention_length):
		return
	scale.x = lerp(scale.x, extention_length, time * get_process_delta_time())

func _process(delta: float) -> void:
	if(scale.x != last_scale):
		extending = true
	elif(scale.x != extention_length):
		extending = false
	else:
		extending = true
	if (!extending && scale.x != extention_length):
		scale.x = lerp(scale.x, original_length, 2 * get_process_delta_time())
	
	last_scale = scale.x
