extends Control


func _on_neues_spiel_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")


func _on_optionen_pressed():
	pass # Replace with function body.


func _on_beenden_pressed():
	get_tree().quit()
