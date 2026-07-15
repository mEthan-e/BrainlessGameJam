extends Area2D

@export var next_level: PackedScene
@export var clone_size_min: int = 2
@onready var win: AudioStreamPlayer2D = $win
@onready var label: Label = $Label
@onready var icon: AnimatedSprite2D = $Sprite2D


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("players")):
		if (!body.current_split_count <= clone_size_min):
			return
		if (!win.playing):
			win.play()
		for child in get_parent().get_children():
			if (child.is_in_group("players")):
				child.queue_free()
		icon.play("default")
		await icon.animation_finished
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(next_level)

func _process(delta: float) -> void:
	match clone_size_min:
		3:
			label.text = "Requires a tiny clone"
		2:
			label.text = "Requires a small clone"
		1:
			label.text = "Requires a \n medium clone"
		0:
			label.text = "Requires a large clone"
