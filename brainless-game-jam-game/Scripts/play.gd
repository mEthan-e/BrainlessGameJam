extends Button

@export var initial_scene: PackedScene

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(initial_scene)
