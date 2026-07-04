extends Camera2D


func _process(delta: float) -> void:
	for sibling in get_parent().get_children():
		if (sibling.is_in_group("players")):
			if(sibling.is_controlling):
				position = sibling.position
