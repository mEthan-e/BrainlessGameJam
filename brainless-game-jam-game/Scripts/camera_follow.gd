extends Camera2D

var is_players: bool = true

func _process(delta: float) -> void:
	is_players = false
	for sibling in get_parent().get_children():
		if (sibling.is_in_group("players")):
			is_players = true
			if(sibling.is_controlling):
				position = sibling.position
	if (!is_players):
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
