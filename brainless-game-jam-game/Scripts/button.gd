extends Node2D

@onready var button: Sprite2D = $Area2D/Button
@export var basic_texture: Texture
@export var pressed_texture: Texture
var current_body
signal button_pressed

var pressed: bool = false

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("players") && !pressed):
		current_body = body
		button.texture = pressed_texture
		pressed = true


func _on_body_exited(body: Node2D) -> void:
	if (body.is_in_group("players") && body == current_body):
		button.texture = basic_texture
		pressed = false

func _process(delta: float) -> void:
	if (pressed):
		emit_signal("button_pressed")
