class_name Interactable
extends Node2D

@export var character_animation_name : String = ""
@export var bind_object : Node2D = null

@onready var body_marker = $BodyMarker

enum Devicename {
	TREADMILL,
	CROSSTRAINER,
	BOXSACK,
	SODA_DISPENSER,
	DUMBBELLS
}
var is_occupied : bool = false


func occupy(character : Character):
	print(character.name, " is occupying ", name)
	character.global_position = body_marker.global_position
	character.play_animation(character_animation_name)
	is_occupied = true
	if bind_object:
		bind_object.visible = false
	


func leave():
	print("leaving ", name)
	is_occupied = false
	if bind_object:
		bind_object.visible = true
