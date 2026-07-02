extends CharacterBody2D

#Position Guide for the slime splits
@onready var left_half: Marker2D = $Halves/LeftHalf
@onready var right_half: Marker2D = $Halves/RightHalf

var left_body_scene = preload("res://Scenes/playerParts/half_body_left.tscn")
var right_body_scene = preload("res://Scenes/playerParts/half_body_right.tscn")

@export var slime_part: int

const SPEED = 300.0
var direction


func _physics_process(delta: float) -> void:
	print("running ", name)
	
	check_movement(direction)
	
	check_split()
	
	
func check_movement(direction) -> void:
	direction = Input.get_vector(
		"left",
		"right",
		"up",
		"down"
		)
		
	velocity = direction * SPEED

	move_and_slide()
	

func check_split() -> void:
	if Input.is_action_just_pressed("split"):
		var left_body = left_body_scene.instantiate()
		var right_body = right_body_scene.instantiate()
		
		left_body.global_position = left_half.global_position
		right_body.global_position = right_half.global_position
		
		add_sibling(left_body)
		add_sibling(right_body)
		queue_free()
