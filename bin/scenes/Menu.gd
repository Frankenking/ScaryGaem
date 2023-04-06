extends Control

func _ready():
	pass

func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://bin/scenes/scene1.tscn")

func _on_options_button_pressed():
	$Options.show()
	$MainMenu.hide()



func _on_back_pressed():
	$MainMenu.show()
	$Options.hide()
