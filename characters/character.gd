class_name Character
extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var nav = $NavigationAgent2D
@onready var training_duration = $TrainingDuration

enum States {
	IDLE,
	WALK_TO_TARGET,
	FOLLOW_NAVIGATION,
	TRAINING
}
var current_state = States.IDLE
var target : Interactable = null
var occupied_interactable : Interactable = null


func _ready():
	start_training()
	current_state = States.FOLLOW_NAVIGATION


func _process(delta):
	match current_state:
		States.IDLE:
			pass
		States.WALK_TO_TARGET:
			pass
		States.FOLLOW_NAVIGATION:
			if anim.current_animation == "RESET":
				anim.play("walk_down")
			velocity = to_local(nav.get_next_path_position()).normalized()
			update_walking_direction()
			velocity *= 30
			move_and_slide()
			if global_position.distance_to(target.global_position) < 10:
				current_state = States.TRAINING
				target.occupy(self)
				training_duration.wait_time = randi_range(10,40)
				training_duration.start()
		States.TRAINING:
			if training_duration.is_stopped():
				anim.play("RESET")
				await get_tree().create_timer(.1).timeout
				anim.play("walk_down")
				target.leave()
				start_training()
				current_state = States.FOLLOW_NAVIGATION


func play_animation(_name):
	anim.play(_name)


func start_training():
	var interactables = get_tree().get_nodes_in_group("interactables")
	if interactables.is_empty():
		return
	interactables.shuffle()
	for interactable in interactables:
		if not interactable.is_occupied:
			nav.target_position = interactable.global_position
			target = interactable
			interactable.is_occupied = true
			break


func update_walking_direction():
	match velocity.round():
		Vector2.LEFT:
			anim.play("walk_left")
		Vector2.UP:
			anim.play("walk_up")
		Vector2.DOWN:
			anim.play("walk_down")
		Vector2.RIGHT:
			anim.play("walk_right")



