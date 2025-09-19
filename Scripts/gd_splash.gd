extends Node2D


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "logo_fade":
		$Node.visible = true
		$AnimationPlayer.play("studio_fade")
	elif anim_name == "studio_fade":
		get_tree().change_scene_to_file("res://Scenes/titlescreen.tscn")
