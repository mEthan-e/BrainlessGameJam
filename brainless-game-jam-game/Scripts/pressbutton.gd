extends Area2D

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "TestPlayer" or body.name == "testPlayer":
		print("Button triggered!")
		
