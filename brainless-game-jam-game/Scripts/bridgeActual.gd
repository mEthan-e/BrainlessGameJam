extends Area2D

@export var extention_length: float = 5.0
@export var colour: Color
var extending: bool = false
@onready var original_length: float = scale.x
@onready var open: AudioStreamPlayer2D = $open
@onready var color_rect: ColorRect = $ColorRect
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
	color_rect.color = colour
	if(scale.x != last_scale):
		extending = true
	elif(scale.x != extention_length):
		extending = false
	else:
		extending = true
	if (!extending && scale.x != extention_length):
		scale.x = lerp(scale.x, original_length, 2 * get_process_delta_time())
	
	last_scale = scale.x

func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("players")):
		bodys_on_bridge.erase(body)
		body.on_bridge = false


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("players")):
		body.on_bridge = true
		bodys_on_bridge.append(body)
