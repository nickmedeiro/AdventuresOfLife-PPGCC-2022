extends KinematicBody2D
class_name Player

export (PackedScene) var Bullet
onready var Gun = $Direction/Gun
onready var Direction = $Direction
onready var AnimatedSprite  = $Direction/AnimatedSprite
onready var Health = $Health
onready var CameraShake  = $Camera2D/CameraShake
onready var Dash = $Dash

export (int) var max_speed = 200
export (int) var friction = 500
export (int) var acceleration = 500

var is_dead = false
var velocity = Vector2.ZERO

func _physics_process(delta):
	if is_dead:
		return
		
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
		AnimatedSprite.play("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		AnimatedSprite.play("idle")

	flip()

	var mouse_position = get_global_mouse_position()
	Gun.look_at(mouse_position)

	# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		CameraShake.start(0.1, 10, 4)
		Gun.shoot()
	if event.is_action_pressed("dash"):
		Dash.start()

func flip():
	var direction = sign(get_global_mouse_position().x - global_position.x);
	Direction.scale.x = -1 if direction <= 0 else 1

func on_hit(attacker):
	CameraShake.start()
	Health.health -= 10
	
	if Health.health <= 0:
		is_dead = true
		Gun.hide()
		AnimatedSprite.set_deferred("disabled", true)
		AnimatedSprite.play("death")
		yield(AnimatedSprite, "animation_finished")
		hide()
		get_tree().reload_current_scene()
