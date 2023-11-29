extends Node2D

@export var characters : Array[Resource] = []

var can_select_with_mouse_entered = true
var current_character_name


func _ready():
	Globals.current_client_name = "tina"
	Globals.character_stats = characters
	$Lenny/Button.connect("mouse_entered", _on_mouse_entered.bind("lenny"))
	$Mike/Button2.connect("mouse_entered", _on_mouse_entered.bind("mike"))
	$Tina/Button3.connect("mouse_entered", _on_mouse_entered.bind("tina"))
	
	$Lenny/Button.connect("pressed", _on_mouse_pressed.bind("lenny"))
	$Mike/Button2.connect("pressed", _on_mouse_pressed.bind("mike"))
	$Tina/Button3.connect("pressed", _on_mouse_pressed.bind("tina"))
	

func _on_mouse_entered(name):
	if can_select_with_mouse_entered:
		highlight_character(name)


func _on_mouse_pressed(name):
	can_select_with_mouse_entered = false
	highlight_character(name)


func highlight_character(name):
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play(name)
	$SelectCharacterSFX.play()
	load_stats(name)


func load_stats(name : String):
	Globals.current_client_name = name
	current_character_name = name
	var character : CharacterStats
	for c in Globals.character_stats:
		if c.name.to_lower() == name:
			character = c
	if not character:
		print("Couldn't find ", name)
		return
	$Stats/NinePatchRect/StatsRect/NameRect/Name.text = character.name
	$Stats/NinePatchRect/StatsRect/AvatarRect/Avatar.texture = character.image
	$Stats/NinePatchRect/StatsRect/CurrentWeight.text = "Weight : " + str(character.weight) + " Kg"
	$Stats/NinePatchRect/StatsRect/FitnessExp.value = character.fitness_experience - (character.fitness_experience % 6) + 2
	$Stats/NinePatchRect/NinePatchRect/target_weight.text = "Loose : " + str(character.target_weight) + " Kg"
	match character.motivation:
		character.Motivation.NONE:
			$Stats/NinePatchRect/StatsRect/Label2/Motivation.texture.region.position.x = 48
		character.Motivation.LITTLE:
			$Stats/NinePatchRect/StatsRect/Label2/Motivation.texture.region.position.x = 16
		character.Motivation.MUCH:
			$Stats/NinePatchRect/StatsRect/Label2/Motivation.texture.region.position.x = 0


func _on_button_pressed():
	$MenuClickSFX.play()
	await get_tree().create_timer(.3).timeout
	$Shader/AnimationPlayer.play("fade_out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/gym/gym.tscn")
	
