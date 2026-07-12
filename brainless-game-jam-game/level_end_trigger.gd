extends Area2D

@export var next_level: PackedScene
@export var clone_size_min: int = 2
@onready var win: AudioStreamPlayer2D = $win
@onready var label: Label = $Label


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("players")):
		if (!body.current_split_count >= clone_size_min):
			return
		if (!win.playing):
			win.play()
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_packed(next_level)

func _process(delta: float) -> void:
	match clone_size_min:
		2:
			label.text = "Requires a small clone"
		1:
			label.text = "Requires a \n medium clone"
		0:
			label.text = "Requires a large clone"
