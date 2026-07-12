extends Area2D

@export var next_level: PackedScene
@onready var win: AudioStreamPlayer2D = $win

func _on_body_entered(body: Node2D) -> void:
	if (!win.playing):
		win.play()
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_packed(next_level)
