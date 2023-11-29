extends Area2D

@export var enable_camera : Camera2D = null
@export var disable_camera : Camera2D = null


func _ready():
	pass

func _on_body_entered(body):
	body.global_position = get_node("Marker2D").global_position
	if enable_camera: enable_camera.enabled = true
	if disable_camera: disable_camera.enabled = false
