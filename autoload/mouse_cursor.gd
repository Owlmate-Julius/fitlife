extends Node

var mouse_arrow = preload("res://assets/textures/hud/mouse_arrow.png")
var mouse_click = preload("res://assets/textures/hud/mouse_click.png")

func _ready():
	Input.set_custom_mouse_cursor(mouse_arrow, Input.CURSOR_ARROW)


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			Input.set_custom_mouse_cursor(mouse_click, Input.CURSOR_ARROW)
		else:
			Input.set_custom_mouse_cursor(mouse_arrow, Input.CURSOR_ARROW)
