extends Node2D

func _ready():
	scene1()
	pass



func scene1():
	$Scenes/Intros.play("intro_" + Globals.current_client_name)
	await get_tree().create_timer(1).timeout
	var dialoguebox = Globals.dialoguebox as Dialoguebox
	dialoguebox.display([
		"Hey " + Globals.current_client_name + ", ready to make a change? ", 
		"Absolutely.", 
		"Great! We'll start with your meal plan.",
		"Sure thing."
		])
	
	await GlobalEvents.ended_displaying
	$Foodplan.show()
	await $Foodplan.finished
	$Scenes/Intros.play("RESET")
	await get_tree().create_timer(.1).timeout
	$Scenes/Intros.play("finish")
