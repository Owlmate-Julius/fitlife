extends NinePatchRect

signal enabled(kcal : int)
signal disabled(kcal : int)

@onready var check_box = $CheckBox
@onready var kcal = $Kcal


func _ready():
	pass


func _on_check_box_toggled(button_pressed):
	if button_pressed:
		emit_signal("enabled", int(kcal.text.get_slice(" ", 0)))
	else:
		emit_signal("disabled", int(kcal.text.get_slice(" ", 0)))
