extends Camera2D

var is_players: bool = true
var clone_count: int = 0
var controllable_players: bool = false
var current_controlled: int

func _process(delta: float) -> void:
	clone_count = 0
	is_players = false
	controllable_players = false
	for sibling in get_parent().get_children():
		if (sibling.is_in_group("players")):
			is_players = true
			clone_count += 1
			if(sibling.is_controlling):
				controllable_players = true
				position = sibling.position
	if (!controllable_players):
		for sibling in get_parent().get_children():
			if (sibling.is_in_group("players") && !sibling.is_controlling):
				sibling.is_controlling = true
				break
	if (Input.is_action_just_pressed("reload")):
		get_tree().reload_current_scene()
	if (Input.is_action_just_pressed("next_clone")):
		var i = 0
		current_controlled += 1
		for clone in get_parent().get_children():
			if (clone.is_in_group("players")):
				
				clone.is_controlling = false
				if (clone_count - 1 != 0):
					current_controlled %= clone_count
				if (current_controlled == i):
					clone.is_controlling = true
				i += 1
			
