extends CanvasLayer



func _ready():
	$MenuRect.visible = false



func _input(event):
	if Input.is_action_just_pressed("esc"):
		$MenuRect.visible = not $MenuRect.visible


func _on_open_menu_button_pressed():
	$MenuRect.visible = not $MenuRect.visible


func _on_music_slider_drag_ended(value_changed):
	var volume = $MenuRect/NinePatchRect/MusicSlider.value
	AudioServer.set_bus_volume_db(1, linear_to_db(volume))


func _on_sfx_slider_drag_ended(value_changed):
	var volume = $MenuRect/NinePatchRect/SFXSlider.value
	AudioServer.set_bus_volume_db(2, linear_to_db(volume))




func _on_button_pressed():
	get_tree().change_scene_to_file("res://characters/character_selector.tscn")
