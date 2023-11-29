class_name Dialoguebox
extends CanvasLayer

signal pressed_action

@onready var label = $DialogueRect/Label
@onready var writing_delay = $WritingDelay

var is_visible = false
var is_writing = false


func _input(event):
	if event.is_action_pressed("interact") or event.is_action_pressed("left_mouse"):
		emit_signal("pressed_action")


func _ready():
	# Make the Textbox globally available 
	Globals.dialoguebox = self


func _process(delta):
	if is_writing and writing_delay.is_stopped():
		writing_delay.start()
		$WritingSFX.play()
	pass


func display(text_arr : Array):
	visible = true
	GlobalEvents.emit_signal("started_displaying")
	label.text = ""
	label.visible_ratio = 0.0
	for text in text_arr:
		label.text = text
		label.visible_ratio = 0.0
		
		var tween = create_tween()
		var duration = text.length() / 22.0
		is_writing = true
		tween.tween_property(label, "visible_ratio", 1.0, duration)
		tween.connect("finished", func(): emit_signal("pressed_action"))
		await pressed_action
		is_writing = false
		tween.stop()
		label.visible_ratio = 1.0
		
		await pressed_action
	await get_tree().process_frame
	#await get_tree().create_timer(.1).timeout
	GlobalEvents.emit_signal("ended_displaying")
	visible = false


func _on_button_pressed():
	visible = false
