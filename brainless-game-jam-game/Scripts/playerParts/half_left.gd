extends CharacterBody2D

#Position Guide for the slime splits
@onready var left_half: Marker2D = $Halves/LeftHalf
@onready var right_half: Marker2D = $Halves/RightHalf

const SPEED = 300.0
var direction


func _physics_process(delta: float) -> void:

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
		print("split not done!")
