extends Camera2D

@onready var death: AudioStreamPlayer2D = $death

var is_players: bool = true
var controllable_players: bool = false

func _process(delta: float) -> void:
	is_players = false
	controllable_players = false
	for sibling in get_parent().get_children():
		if (sibling.is_in_group("players")):
			is_players = true
			if(sibling.is_controlling):
				controllable_players = true
				position = sibling.position
	if (!is_players):
		if (!death.playing):
			death.play()
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
	if (!controllable_players):
		for sibling in get_parent().get_children():
			if (sibling.is_in_group("players") && !sibling.is_controlling):
				sibling.is_controlling = true
				break
