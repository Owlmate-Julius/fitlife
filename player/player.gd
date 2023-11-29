class_name Player
extends "res://characters/character.gd"

@onready var footstep_delay = $FootstepDelay


func _process(delta):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	velocity = direction.normalized()
	if velocity == Vector2.ZERO:
		update_idle_direction()
		$FootstepsPlayer.stop()
	else:
		update_walking_direction()
		if footstep_delay.is_stopped():
			footstep_delay.start()
			$FootstepsPlayer.play()
	velocity *= 100
	move_and_slide()


func update_idle_direction():
	match anim.current_animation:
		"walk_left":
			anim.play("idle_left")
		"walk_right":
			anim.play("idle_right")
		"walk_up":
			anim.play("idle_up")
		"walk_down":
			anim.play("idle_down")


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
