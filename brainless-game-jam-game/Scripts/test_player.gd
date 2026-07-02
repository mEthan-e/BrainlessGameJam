extends CharacterBody2D

@export var split_count: int = 2
@export var max_splits: int = 2 
var player := load("res://Scenes/playerParts/testPlayer.tscn")
var current_split_count
var is_controlling: bool = true # false unless this is the main player and no other clones are spawned, plesae implement

func _ready() -> void:
	pass # Replace with function body.
func _init() -> void:
	current_split_count = 0

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("split")):
		if(!is_controlling):
			return
		if(current_split_count >= max_splits):
				return
		current_split_count += 1
		for i in range(0, split_count):
			var new_player = player.instantiate()
			new_player.scale = self.scale / split_count
			new_player.position = self.position + Vector2(randi_range(-30, 30), randi_range(-30, 30))
			new_player.current_split_count = current_split_count
			add_sibling(new_player)
			print("new clone!")
		queue_free()
		
	
	if (is_controlling):
		pass # control this player


func _on_button_pressed() -> void:
	is_controlling = !is_controlling
	# disable other clones control.
