extends Node

signal and_triggered

var input_a: bool
var input_b: bool

func _process(delta: float) -> void:
	if (input_a && input_b):
		emit_signal("and_triggered")
	input_a = false
	input_b = false
	

func input_a_trigger():
	input_a = true

func input_b_trigger():
	input_b = true
