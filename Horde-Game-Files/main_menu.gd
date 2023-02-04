extends Control
	


func _on_exit_game_pressed():
	get_tree().quit()


func _on_load_test_level_pressed():
	get_tree().change_scene_to_file("res://test_plane.tscn")
