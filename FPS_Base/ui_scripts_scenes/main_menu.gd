extends Control
	


func _on_exit_game_pressed():
	get_tree().quit()


func _on_load_test_level_pressed():
	get_tree().change_scene_to_file("res://environment_scripts_scenes/test_plane.tscn")
