extends Area2D

@export var death_sfx: AudioStream
var is_dying: bool = false

func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.is_in_group("players")):
			if(body.on_bridge <= 0):
				
				var player = AudioStreamPlayer2D.new() 
				player.stream = death_sfx
				player.attenuation = 0.0
				add_child(player)
				player.play()
				body.queue_free()
				if (!is_dying):
					is_dying = true
					await get_tree().create_timer(0.5).timeout
					is_dying = false
				
				get_tree().reload_current_scene()
