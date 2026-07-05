extends Area2D

func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.is_in_group("players")):
			if(!body.on_bridge):
				body.queue_free()
