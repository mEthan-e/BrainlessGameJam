extends Area2D

@export var death_sfx: AudioStream

func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.is_in_group("players")):
			if(!body.on_bridge):
				body.queue_free()
				var player = AudioStreamPlayer2D.new() 
				player.stream = death_sfx
				player.attenuation = 0.0
				add_child(player)
				player.play()
				await get_tree().create_timer(1.0).timeout
				get_tree().reload_current_scene()
