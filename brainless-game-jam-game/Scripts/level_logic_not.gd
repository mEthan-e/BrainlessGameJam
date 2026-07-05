extends Node

signal not_triggered

var input_a: bool
var input_b: bool

func _process(delta: float) -> void:
	if (!input_a):
		emit_signal("not_triggered")
	input_a = false
	input_b = false
	

func input_a_trigger():
	input_a = true
