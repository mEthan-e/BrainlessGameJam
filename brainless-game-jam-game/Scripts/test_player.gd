extends CharacterBody2D

@export var split_count: int = 2
@export var max_splits: int = 2
var player := load("res://Scenes/Essentials/testPlayer.tscn")
var current_split_count
var is_controlling: bool
var id: int = 0
var id_to_assign: int = 0
var prev_id: int
var on_bridge: bool = false

const SPEED = 400.0
var direction

func _ready() -> void:
	id_to_assign = id
	add_to_group("players")
	add_to_group(str(id))

func _init() -> void:
	current_split_count = 0
	is_controlling = true  # false unless this is the main player and no other clones are spawned, plesae implement

func _physics_process(delta: float) -> void:
	check_movement(direction)
	
func check_movement(direction) -> void:
	if (!is_controlling):
		return
	direction = Input.get_vector(
		"left",
		"right",
		"up",
		"down"
		)
		
	velocity = direction * SPEED

	move_and_slide()
	
func manage_split() -> void:
	if(Input.is_action_just_pressed("split")):
		if(!is_controlling):
			return
		if(current_split_count >= max_splits):
				return
		current_split_count += 1
		id_to_assign += 1
		
		for clone in get_parent().get_children():
			if (clone.is_in_group("players")):
				if (id_to_assign == clone.id):
					id_to_assign += 3
		for i in range(0, split_count):
			var new_player = player.instantiate()
			new_player.scale = self.scale / split_count
			new_player.position = self.position + Vector2(randi_range(-30, 30), randi_range(-30, 30))
			new_player.current_split_count = current_split_count
			new_player.id = id_to_assign
			new_player.max_splits = max_splits
			new_player.prev_id = id
			new_player.add_to_group(str(id))
			if (i != 0):
				new_player.is_controlling = false
			else:
				new_player.is_controlling = true
			get_parent().add_child(new_player) # why use get_parent().add_child() instead of add_sibling()?
			print("new clone!")
		queue_free()
		
func manage_merge() -> void:
	if(Input.is_action_just_pressed("merge")):
		
		var id_to_merge: int = -1
		if (current_split_count <= 0):
			print(current_split_count)
			return
		if (is_controlling):
			id_to_merge = id
		if (id <= 0):
			return
		var mergeable: bool = false
		var mean_pos: Vector2 = Vector2.ZERO
		
		
		for clone in get_parent().get_children():
			if (clone.is_in_group("players") && clone.is_in_group(str(id_to_merge))):
				mergeable = true
				mean_pos += clone.position
				print("clone of id %s deleted" % [clone.id])
				clone.queue_free()
		
		if (mergeable):
			current_split_count -= 1
			var new_player = player.instantiate()
			new_player.scale = self.scale * split_count
			new_player.current_split_count = current_split_count
			id_to_assign = prev_id
			new_player.id = id_to_assign
			new_player.position = position
			new_player.is_controlling = true
			if (!is_controlling):
				return

			get_parent().add_child(new_player)
			print("merged")
			
func manage_regroup() -> void:
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

		get_parent().add_child(merged_player) # why use get_parent().add_child() instead of add_sibling()?

func _process(delta: float) -> void:
	manage_split()
	manage_merge()


func _on_button_pressed() -> void:
	is_controlling = !is_controlling
	for clone in get_parent().get_children():
		if clone.is_in_group("players") && clone != self:
			clone.is_controlling = false
	# disable other clones control.
