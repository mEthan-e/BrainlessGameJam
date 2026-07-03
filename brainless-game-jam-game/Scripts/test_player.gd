extends CharacterBody2D

@export var split_count: int = 2
@export var max_splits: int = 2 
var player := load("res://Scenes/playerParts/testPlayer.tscn")
var current_split_count
var is_controlling: bool = true # false unless this is the main player and no other clones are spawned, plesae implement

const SPEED = 300.0
var direction

func _ready() -> void:
	add_to_group("players")
func _init() -> void:
	current_split_count = 0

func _physics_process(delta: float) -> void:
	check_movement(direction)
	
func check_movement(direction) -> void:
	direction = Input.get_vector(
		"left",
		"right",
		"up",
		"down"
		)
		
	velocity = direction * SPEED

	move_and_slide()

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
			get_parent().add_child(new_player)
			print("new clone!")
		queue_free()
	
	if(Input.is_action_just_pressed("Regroup")):
		if(!is_controlling):
			return
		
		var players = []
		
		for child in get_parent().get_children():
			if child.is_in_group("players"):
				players.append(child)
		
		if(current_split_count <= 0):
				return
		current_split_count -= 1
		
		var center = Vector2.ZERO
		
		for p in players:
			center += p.position
			
			
		center /= self.scale
		
		for p in players:
			p.queue_free()
		
		var merged_player = player.instantiate()
		merged_player.position = center
		merged_player.scale = Vector2.ONE
		merged_player.current_split_count = 0

		get_parent().add_child(merged_player)
		
		
	
	if (is_controlling):
		pass # control this player


func _on_button_pressed() -> void:
	is_controlling = !is_controlling
	# disable other clones control.
