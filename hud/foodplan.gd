extends CanvasLayer

signal finished

@onready var food_item_container = $FoodplanContainer/ScrollContainer/FoodItemContainer
@onready var kcal_progress = $InfoContainer/CaloriesInfo/KcalProgress
var kcal_value = 0


func _ready():
	#hide()
	for food_item in food_item_container.get_children():
		food_item.connect("enabled", increase_progressbar)
		food_item.connect("disabled", decrease_progressbar)


func _process(delta):
	if not (kcal_progress.value < kcal_value+50 and kcal_progress.value > kcal_value-50):
		if kcal_value > kcal_progress.value:
			print("inc val")
			kcal_progress.value = kcal_progress.value + 50
		else:
			print("dec val")
			kcal_progress.value -= 50


func increase_progressbar(_value):
	$CheckboxSFX.play()
	kcal_value += _value


func decrease_progressbar(_value):
	$CheckboxSFX.play()
	kcal_value -= _value


func _on_button_pressed():
	$ReadyButtonSFX.play()
	await get_tree().create_timer(1).timeout
	hide()
	emit_signal("finished")
