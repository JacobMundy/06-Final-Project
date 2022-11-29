extends Control



func _ready():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Levels/Level_1.tscn")
