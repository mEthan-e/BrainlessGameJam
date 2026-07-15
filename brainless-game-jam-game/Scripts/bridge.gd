extends StaticBody2D

@export var extention_length: float = 5.0
@onready var open: AudioStreamPlayer2D = $open
@onready var close: AudioStreamPlayer2D = $close
var extending: bool = false
@onready var original_length: float = scale.x
var last_scale: float
var bodys_on_bridge: Array

func extend(time: int) -> void:
	var open_sound_count = 0 
	if(scale.x == extention_length):
		return
	scale.x = lerp(scale.x, extention_length, time * get_process_delta_time())
	open_sound_count += 1
	if(!open.playing && open_sound_count == 0):
		open.play()

func _process(delta: float) -> void:
	if(scale.x != last_scale):
		extending = true
	elif(scale.x != extention_length):
		extending = false
	else:
		extending = true
	if (!extending && scale.x != extention_length):
		scale.x = lerp(scale.x, original_length, 5 * get_process_delta_time())
		if (!close.playing && scale.x < extention_length - 0.0001):
			close.play()
	
	last_scale = scale.x
