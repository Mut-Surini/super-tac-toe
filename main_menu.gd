extends Node2D

var maksPlayer = 2
var area = 3

func _ready():
	Audio.playMusic()
	Global.maksPlayer = maksPlayer
	$CanvasLayer/Control/Button3.text = str(maksPlayer) + " Player"
	$CanvasLayer/Control/area.text = str(area) + "x" + str(area)

func _on_play_pressed():
	Audio.playMusicLevel()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_up_player_pressed():
	maksPlayer += 1
	if maksPlayer > 6:
		maksPlayer = 2
	Global.maksPlayer = maksPlayer
	$CanvasLayer/Control/Button3.text = str(maksPlayer) + " Player"

func _on_exit_pressed():
	get_tree().quit()

func _on_area_button_pressed():
	area += 1
	if area > 12:
		area = 3
	Global.area = area
	$CanvasLayer/Control/area.text = str(area) + "x" + str(area)
